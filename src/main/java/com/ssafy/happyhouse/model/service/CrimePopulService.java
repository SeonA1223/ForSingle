package com.ssafy.happyhouse.model.service;

import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public interface CrimePopulService {

	Map<String, Integer> getCrimePopul(String gugun_code);
	
}
