package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.dto.FavoriteDto;
import com.ssafy.happyhouse.model.dto.HouseDealDto;

public interface FavoriteService {
	
	List<FavoriteDto> getList() throws Exception;
	List<HouseDealDto> getAptInfoInDong(String dong) throws Exception;
	boolean insertFavorite(String dong) throws Exception;
	boolean deleteFavorite(String dong) throws Exception;
}
