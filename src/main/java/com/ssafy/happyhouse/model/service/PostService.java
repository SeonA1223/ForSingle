package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.dto.PostDto;

public interface PostService {

	int registPost(PostDto post);
	List<PostDto> getPostList();
	PostDto getPost(int num);
	int updateViews(int num);
	int updatePost(PostDto post);
	int updateAnsnwernum(int num, int answernum);
	int removeAnswernum(int num);
	int removePost(int num);
	
}
