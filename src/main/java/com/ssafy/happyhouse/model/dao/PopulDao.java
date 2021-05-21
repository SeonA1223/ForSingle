package com.ssafy.happyhouse.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.dto.PopulDto;

@Mapper
public interface PopulDao {

	List<PopulDto> getPopulList();
	PopulDto getPopul(String siname);
	
}
