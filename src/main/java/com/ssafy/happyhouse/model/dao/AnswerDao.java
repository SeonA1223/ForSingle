package com.ssafy.happyhouse.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.dto.AnswerDto;

@Mapper
public interface AnswerDao {

	int registAnswer(AnswerDto answer);
	List<AnswerDto> getAnswerList();
	AnswerDto getAnswer(int num);
	int updateAnswer(AnswerDto answer);
	int removeAnswer(int num);
	
}
