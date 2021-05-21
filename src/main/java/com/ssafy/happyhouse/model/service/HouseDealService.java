package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.dto.HouseDealDto;

public interface HouseDealService {

	List<HouseDealDto> getAptInfoAtName(String AptName) throws Exception;
	List<HouseDealDto> getAptInfoInDong(String dong) throws Exception;
}
