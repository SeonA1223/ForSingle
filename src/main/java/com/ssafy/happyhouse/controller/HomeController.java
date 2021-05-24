package com.ssafy.happyhouse.controller;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
		return "user/signup";
	}
	
	@GetMapping("/user/mypage")
	public String mvMypage() {
		return "user/mypage";
	}
	
	@GetMapping("/qna")
	public String mvQnA() {
		return "qna/list";
	}
	
	@GetMapping("/qna/write")
	public String mvQnAWrite() {
		return "qna/write";
	}
	
//	잠깐 만들예정
	@GetMapping("/qna/detail")
	public String mvQnAdetail(@RequestParam(value="num") String num, @RequestParam(value="writer") String writer, Model model) {
		model.addAttribute("num", num);
		model.addAttribute("writer", writer);
		System.out.println(writer);
		return "qna/detail";
	}
	
	@RequestMapping("/logout")
	private String logout(HttpSession session, HttpServletResponse response) throws IOException {
		session.invalidate();

		// 수정하기
		return "redirect:/";

	}
	
	
	
}
