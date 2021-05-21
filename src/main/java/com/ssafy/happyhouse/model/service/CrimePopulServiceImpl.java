package com.ssafy.happyhouse.model.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;


public class CrimePopulServiceImpl implements CrimePopulService {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Map<String, Integer> getCrimePopul(String gugun_code) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		
		
		return map;
	}

}
