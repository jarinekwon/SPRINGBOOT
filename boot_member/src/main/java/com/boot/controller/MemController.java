package com.boot.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.dto.MemDTO;
import com.boot.service.MemService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MemController {
	@Autowired
	private MemService service;
	
	@RequestMapping("/login")
	public String login() {
		log.info("@# login");
		
		return "login";
	}
	
	@RequestMapping("/login_yn")
	public String write(@RequestParam HashMap<String, String> param) {
		log.info("@# login_yn");
		
		ArrayList<MemDTO> dtos = service.loginYn(param);
		
		if (dtos.isEmpty()) {
			return "redirect:login";
		} else {
//			if (mPw.equals(dtos.get(0).getMem_pwd())) {
			if (param.get("mem_pwd").equals(dtos.get(0).getMem_pwd())) {
				return "redirect:login_ok";
			} else {
				return "redirect:login";
			}
		}
	}
	
	@RequestMapping("/login_ok")
	public String login_ok() {
		log.info("@# login_ok");
		
		return "login_ok";
	}
	
	@RequestMapping("/register")
	public String register() {
		log.info("@# register");
		
		return "register";
	}
	
	@RequestMapping("/registerOk")
	public String registerOk(@RequestParam HashMap<String, String> param) {
		log.info("@# registerOk");
		
		service.write(param);
		
		return "redirect:login";
	}
	
}













