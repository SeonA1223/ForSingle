package com.ssafy.happyhouse.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
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
import com.ssafy.happyhouse.model.service.PostService;

import io.swagger.annotations.Api;

@Api("Post 컨트롤러 API V1")
@CrossOrigin("*")
@RestController
@RequestMapping("/post")
public class PostController {

	@Autowired
	PostService postService;
	
	@PostMapping
	private int registPost(@RequestBody PostDto post) throws Exception {
		int res = postService.registPost(post);
		return res;
	}
	
	@GetMapping
	private List<PostDto> getPostList() throws Exception {
		return postService.getPostList();
	}
	
	@GetMapping("/{num}")
	private PostDto getPost(@PathVariable("num") int num) throws Exception {
		updateViews(num);
		PostDto res = postService.getPost(num);
		return res;
	}
	
	@PutMapping
	private int updatePost(@RequestBody PostDto post) throws Exception {
		int res = postService.updatePost(post);
		return res;
	}
	
	@DeleteMapping("/{num}")
	private int postRemove(@PathVariable("num") int num) throws Exception {
		int res = postService.removePost(num);
		return res;
	}
	
	private void updateViews(int num) {
		int views = postService.getViews(num);
		postService.addViews(num, views + 1);
	}
}
