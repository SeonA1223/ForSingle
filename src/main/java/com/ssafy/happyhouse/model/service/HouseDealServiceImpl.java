package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dao.HouseDealDao;
import com.ssafy.happyhouse.model.dto.AddressDto;
import com.ssafy.happyhouse.model.dto.HouseDealDto;

@Service
public class HouseDealServiceImpl implements HouseDealService {
	
	@Autowired
	HouseDealDao houseDeal;

	@Override
	public List<HouseDealDto> getAptInfoAtName(String AptName) throws Exception {
		return houseDeal.getAptInfoAtName(AptName);
	}

	@Override
	public List<HouseDealDto> getAptInfoInDong(String dong) throws Exception {

		return houseDeal.getAptInfoInDong(dong);
	}

	@Override
	public AddressDto getAddress(String dongcode) throws Exception {
		return houseDeal.getAddress(dongcode);
	}
}
