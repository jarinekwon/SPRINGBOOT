<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		.div_page ul{
			display: flex;
			list-style: none;
		}
	</style>
</head>
<body>
	<table width="500" border="1">
		<tr>
			<td>번호</td>
			<td>이름</td>
			<td>제목</td>
			<td>날짜</td>
			<td>히트</td>
		</tr>
<!-- 		list : 모델객체에서 보낸 이름 -->
		<c:forEach items="${list}" var="dto">
			<tr>
				<td>${dto.boardNo}</td>
				<td>${dto.boardName}</td>
<%-- 				<td>${dto.boardTitle}</td> --%>
				<td>
<!-- 			content_view : 컨트롤러단 호출 -->
					<!-- <a href="content_view?boardNo=${dto.boardNo}">${dto.boardTitle}</a> -->
					<a  class="move_link" href="${dto.boardNo}">${dto.boardTitle}</a>
				</td>
				<td>${dto.boardDate}</td>
				<td>${dto.boardHit}</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="5">
<!-- 			write_view : 컨트롤러단 호출 -->
				<a href="write_view">글작성</a>
			</td>
		</tr>
	</table>

	<h3>${pageMaker}</h3>
	
	<div class="div_page">
		<ul>
			<c:if test="${pageMaker.prev}">
				<!-- <li>[Previous]</li> -->
				<li class="paginate_button">
					<a href="${pageMaker.startpage - 1}">
						[Previous]
					</a>
				</li>
			</c:if>
			<c:forEach var="num" begin="${pageMaker.startpage}" end="${pageMaker.endpage}">
				<!-- <li>[${num}]</li> -->
				<!-- <li class="paginate_button" ${pageMaker.cri.pageNum == num ? "style='color: red;'" : ""}> -->
				<li class="paginate_button" ${pageMaker.cri.pageNum == num ? "style='background-color: yellow;'" : ""}>
					<a href="${num}">
						[${num}]
					</a>
				</li>
			</c:forEach>
			<c:if test="${pageMaker.next}">
				<!-- <li>[Next]</li> -->
				<li class="paginate_button">
					<a href="${pageMaker.endpage + 1}">
						[Next]
					</a>
				</li>
			</c:if>
		</ul>
	</div>
	
	<!-- <form id="actionForm" method="get" action="listWithPaging"> -->
	<!-- <form id="actionForm" method="get" action="list"> -->
	<form id="actionForm" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
	</form>
</body>
</html>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script>
	var actionForm = $("#actionForm");
	// 페이지 번호 처리
	$(".paginate_button a").on("click", function(e) {
		// 기본동작 막음
		e.preventDefault();

		console.log("@# click");
		console.log("@# href => " + $(this).attr("href"));
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		// actionForm.submit();
		actionForm.attr("action","list").submit();
	}); // end of paginate_burron click

	// 게시글 처리
	$(".move_link").on("click", function(e) {
		e.preventDefault();

		console.log("@# move_link click");
		console.log("@# href => " + $(this).attr("href"));

		var bno = actionForm.find("input[name='boardNo']").val();
		if(bno != "") {
			actionForm.find("input[name='boardNo']").remove();
		}
		// 게시글 클릭 후 뒤로가기 누른 후 다른 게시글 클릭할 때 &boardNo=번호 계속 누락되는 거 방지

		var targetBno = $(this).attr("href");
		// content_view?boardNo=${dto.boardNo}를 actionForm으로 처리

		var bno = actionForm.find("input[name='boardNo']").val();
		if(bno != "") {
			actionForm.find("input[name='boardNo']").remove();
		}
		// 게시글 클릭 후 뒤로가기 누른 후 다른 게시글 클릭할 때 &boardNo=번호 계속 누락되는 거 방지

		actionForm.append("<input type='hidden' name='boardNo' value='" + targetBno + "'>");
		// actionForm.submit;
		actionForm.attr("action","content_view").submit();
	}); // end of move_link click
</script>











