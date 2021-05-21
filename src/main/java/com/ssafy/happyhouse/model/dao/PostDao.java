package com.ssafy.happyhouse.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.dto.PostDto;

@Mapper
public interface PostDao {

	int registPost(PostDto post);
	List<PostDto> getPostList();
	PostDto getPost(int num);
	int addViews(int num, int views);
	int getViews(int num);
	int updatePost(PostDto post);
	int updateAnswernum(int num, int answernum);
	int removeAnswernum(int num);
	int removePost(int num);
	
}
