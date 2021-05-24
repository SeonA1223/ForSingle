package com.ssafy.happyhouse.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.dto.AddressDto;
import com.ssafy.happyhouse.model.dto.HouseDealDto;

@Mapper
public interface HouseDealDao {
	
	List<HouseDealDto> getAptInfoAtName(String AptName) throws Exception;
	List<HouseDealDto> getAptInfoInDong(String dong) throws Exception;
	AddressDto getAddress(String dongcode) throws Exception;
	
}
