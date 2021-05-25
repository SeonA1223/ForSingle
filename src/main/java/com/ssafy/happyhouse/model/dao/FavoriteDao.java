package com.ssafy.happyhouse.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.dto.FavoriteDto;

@Mapper
public interface FavoriteDao {
	
	List<FavoriteDto> list(String id);
	boolean insert(FavoriteDto dto);
	boolean delete(String code);
	FavoriteDto get(String dong);
}
