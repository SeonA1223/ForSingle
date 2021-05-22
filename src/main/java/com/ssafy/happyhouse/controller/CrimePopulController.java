package com.ssafy.happyhouse.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.service.CrimePopulService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@Api("CrimePopul 컨트롤러 API V1")
@CrossOrigin("*")
@RestController
@RequestMapping("/cp")
public class CrimePopulController {

	@Autowired
	CrimePopulService crimePopulService;
	
	@GetMapping("/{gugun_code}")
	@ApiOperation(value = "gugun_code입력 후 범죄 수 및 인구수 받기", notes = "PathVariable로 gugun_code 받음.")
	private Map<String, String> getCrimePopul(@PathVariable("gugun_code") String gugun_code) throws Exception {
		Map<String, String> res = crimePopulService.getCrimePopul(gugun_code);
		if(res == null) System.out.println("CrimePopul Null 발생");
		return res;
	}
}
