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
	public List<FavoriteDto> getList() throws Exception {
		return favorite.list();
	}
	
	@Override
	public List<HouseDealDto> getAptInfoInDong(String dong) throws Exception {
		return houseDeal.getAptInfoInDong(dong);
	}

	@Override
	public boolean insertFavorite(String dong) throws Exception {
		FavoriteDto dto = new FavoriteDto();
		dto.setDong(dong);
		return favorite.insert(dto);
	}

	@Override
	public boolean deleteFavorite(String dong) throws Exception {
		FavoriteDto dto = new FavoriteDto();
		dto.setDong(dong);
		return favorite.delete(dto);
	}

}
