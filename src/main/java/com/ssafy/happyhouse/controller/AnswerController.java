package com.ssafy.happyhouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.dto.AnswerDto;
import com.ssafy.happyhouse.model.service.AnswerService;
import com.ssafy.happyhouse.model.service.PostService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@Api("Answer 컨트롤러 API V1")
@CrossOrigin
@RestController
@RequestMapping("/answer")
public class AnswerController {
	
	@Autowired
	AnswerService answerService;
	
	@Autowired
	PostService postService;
	
	@PostMapping("/{postnum}")
	private int registAnswer(@RequestBody AnswerDto answer, @PathVariable("postnum") int postnum) throws Exception {
		int res = answerService.registAnswer(answer, postnum);
		return res;
	}
	
	@GetMapping
	private List<AnswerDto> getAnswerList() throws Exception {
		return answerService.getAnswerList();
	}
	
	@GetMapping("/{num}")
	private AnswerDto getAnswer(@PathVariable("num") int num) throws Exception{
		AnswerDto res = answerService.getAnswer(num);
		return res;
	}
	
	@PutMapping
	private int updateAnswer(@RequestBody AnswerDto answer) throws Exception {
		int res = answerService.updateAnswer(answer);
		return res;
	}
	
	@DeleteMapping("/{pnum}")
	@ApiOperation(value = "답글 삭제", notes = "넘겨주는 값은 '답글'번호가 아니라 '원래 글' 번호!!!!!!!!!")
	private int deleteAnswer(@PathVariable("pnum") int pnum) throws Exception {
		int anum = postService.getPost(pnum).getAnswernum();
		int res = answerService.removeAnswer(anum);
		return res;
	}
}
