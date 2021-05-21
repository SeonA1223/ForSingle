package com.ssafy.happyhouse.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.dto.CrimeDto;

@Mapper
public interface CrimeDao {

	List<CrimeDto> getCrimeList();
	CrimeDto getCrime(String siname);
	
}
