package com.ssafy.happyhouse.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.dto.PostDto;
import com.ssafy.happyhouse.model.dto.UserDto;
import com.ssafy.happyhouse.model.service.AnswerService;
import com.ssafy.happyhouse.model.service.PostService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@Api("Post 컨트롤러 API V1")
@CrossOrigin("*")
@RestController
@RequestMapping("/post")
public class PostController {

	@Autowired
	PostService postService;
	
	@Autowired
	AnswerService answerService;
	
	@PostMapping
	@ApiOperation(value = "QnA 등록", notes = "PostDto 받음.")
	private int registPost(@RequestBody PostDto post) throws Exception {
		int res = postService.registPost(post);
		return res;
	}
	
	@GetMapping
	@ApiOperation(value = "QnA List 반환")
	private List<PostDto> getPostList() throws Exception {
		return postService.getPostList();
	}
	
	@GetMapping("/{num}")
	@ApiOperation(value = "QnA 1개 받기", notes = "PathVariable로 num 받음.")
	private PostDto getPost(@PathVariable("num") int num, HttpServletRequest request, HttpServletResponse response) throws Exception {
		updateViews(num);
		PostDto res = postService.getPost(num);
//		HttpSession session = request.getSession();
//		UserDto user = (UserDto)session.getAttribute("userinfo");
//		
//		Cookie modifyCookie;
//		if(res.getId().equals(user.getId())) 
//			modifyCookie = new Cookie("modify", "true");
//		else 
//			modifyCookie = new Cookie("modify", "false");
//		modifyCookie.setPath("/qna/"); // 쿠키를 유지할 시간 설정(단위 : 초) 
//		modifyCookie.setMaxAge(30);
//		response.addCookie(modifyCookie);
//		
		return res;
	}
	
	@PutMapping
	@ApiOperation(value = "QnA 수정", notes = "PostDto 받음.")
	private int updatePost(@RequestBody PostDto post) throws Exception {
		int res = postService.updatePost(post);
		return res;
	}
	
	@DeleteMapping("/{num}")
	@ApiOperation(value = "QnA 삭제", notes = "PathVariable로 num 받음.")
	private int postRemove(@PathVariable("num") int num) throws Exception {
		int res = postService.removePost(num);
		return res;
	}
	
	private int updateViews(int num) {
		int res = postService.updateViews(num);
		return res;
	}
}
