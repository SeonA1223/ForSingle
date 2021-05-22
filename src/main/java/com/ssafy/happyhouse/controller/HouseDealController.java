package com.ssafy.happyhouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.dto.FavoriteDto;
import com.ssafy.happyhouse.model.dto.HouseDealDto;
import com.ssafy.happyhouse.model.service.FavoriteService;
import com.ssafy.happyhouse.model.service.HouseDealService;

import io.swagger.annotations.Api;

@Api("houseDeal 컨트롤러 API V1")
@CrossOrigin("*")
@RestController
public class HouseDealController {

	@Autowired
	HouseDealService houseDealService;

	@Autowired
	FavoriteService favoriteService;

	@GetMapping("/deal/fsearch")
	public ResponseEntity<List<FavoriteDto>> favoriteList() throws Exception {
		List<FavoriteDto> list = favoriteService.getList();
//		if(list != null && !list.isEmpty()) {
//			return new ResponseEntity<List<FavoriteDto>>(list, HttpStatus.OK);
//		}else {
//			return new ResponseEntity(HttpStatus.NO_CONTENT);
//		}
		return new ResponseEntity<List<FavoriteDto>>(list, HttpStatus.OK);
	}
	
	@PostMapping(value = "/deal/search/{aptName}")
	public ResponseEntity<List<HouseDealDto>> aptNameSearch(@PathVariable("aptName") String aptName) throws Exception {
		List<HouseDealDto> list = houseDealService.getAptInfoAtName(aptName);
//		if(list != null && !list.isEmpty()) {
//			return new ResponseEntity<List<HouseDealDto>>(list, HttpStatus.OK);
//		}else {
//			return new ResponseEntity(HttpStatus.NO_CONTENT);
//		}
		return new ResponseEntity<List<HouseDealDto>>(list, HttpStatus.OK);
	}
	
	@GetMapping(value = "/deal/{dong}")
	public ResponseEntity<List<HouseDealDto>> favoriteSearch(@PathVariable("dong") String dong) throws Exception {
		List<HouseDealDto> list = houseDealService.getAptInfoInDong(dong);
//		if(list != null && !list.isEmpty()) {
//			return new ResponseEntity<List<HouseDealDto>>(list, HttpStatus.OK);
//		}else {
//			return new ResponseEntity(HttpStatus.NO_CONTENT);
//		}
		return new ResponseEntity<List<HouseDealDto>>(list, HttpStatus.OK);
	}
	
	@DeleteMapping(value = "/deal/{deldong}")
	public ResponseEntity<List<FavoriteDto>> delete(@PathVariable("deldong") String deldong) throws Exception {
		favoriteService.deleteFavorite(deldong);
		List<FavoriteDto> list = favoriteService.getList();
		return new ResponseEntity<List<FavoriteDto>>(list, HttpStatus.OK);
	}
	
	@PostMapping(value = "/deal/{dong}")
	public ResponseEntity<List<FavoriteDto>> regist(@PathVariable("dong") String dong) throws Exception {
		favoriteService.insertFavorite(dong);
		List<FavoriteDto> list = favoriteService.getList();
		return new ResponseEntity<List<FavoriteDto>>(list, HttpStatus.OK);
	}
	
	
}
