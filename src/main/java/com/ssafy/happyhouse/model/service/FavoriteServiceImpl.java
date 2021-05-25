package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dao.FavoriteDao;
import com.ssafy.happyhouse.model.dao.HouseDealDao;
import com.ssafy.happyhouse.model.dto.FavoriteDto;
import com.ssafy.happyhouse.model.dto.HouseDealDto;

@Service
public class FavoriteServiceImpl implements FavoriteService {

	@Autowired
	FavoriteDao favorite;
	
	@Autowired
	HouseDealDao houseDeal;
	
	@Override
	public List<FavoriteDto> getList(String id) throws Exception {
		return favorite.list(id);
	}
	
	@Override
	public List<HouseDealDto> getAptInfoInDong(String dong) throws Exception {
		return houseDeal.getAptInfoInDong(dong);
	}

	@Override
	public boolean insertFavorite(FavoriteDto dto) throws Exception {
		return favorite.insert(dto);
	}

	@Override
	public boolean deleteFavorite(String code) throws Exception {
		return favorite.delete(code);
	}

}
