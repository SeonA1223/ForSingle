package com.ssafy.happyhouse.controller;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	@GetMapping(value = "/")
	public String home(Locale locale, Model model) {
		return "main";
	}
	
	@RequestMapping(value = "/main")
	public String home2(Locale locale, Model model) {
		return "main";
	}
	
	@RequestMapping(value = "/main/map")
	public String map(Locale locale, Model model) {
		return "map";
	}
	
	@GetMapping(value = "/user/signup")
	public String mvSignup() {
		return "signup";
	}
	
	@GetMapping("/user/mypage")
	public String mvMypage() {
		return "mypage";
	}
	
	@RequestMapping("/logout")
	private String logout(HttpSession session, HttpServletResponse response) throws IOException {
		session.invalidate();

		// 수정하기
		return "redirect:/";

	}
	
	
	
}
