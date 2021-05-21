package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.dto.PostDto;

public interface PostService {

	int registPost(PostDto post);
	List<PostDto> getPostList();
	PostDto getPost(int num);
	Integer addViews(int num, int views);
	int getViews(int num);
	int updatePost(PostDto post);
	int removePost(int num);
	
}
