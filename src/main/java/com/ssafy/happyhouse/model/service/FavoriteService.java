package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.dto.FavoriteDto;
import com.ssafy.happyhouse.model.dto.HouseDealDto;

public interface FavoriteService {
	
	List<FavoriteDto> getList(String id) throws Exception;
	List<HouseDealDto> getAptInfoInDong(String dong) throws Exception;
	boolean insertFavorite(FavoriteDto dto) throws Exception;
	boolean deleteFavorite(String dongcode) throws Exception;
}
