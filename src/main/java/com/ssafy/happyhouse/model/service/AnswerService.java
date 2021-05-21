package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.dto.AnswerDto;

public interface AnswerService {

	int registAnswer(AnswerDto answer, int postnum);
	List<AnswerDto> getAnswerList();
	AnswerDto getAnswer(int num);
	int updateAnswer(AnswerDto answer);
	int removeAnswer(int num);
	
}
