package com.ssafy.happyhouse.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.dto.FavoriteDto;
import com.ssafy.happyhouse.model.dto.HouseDealDto;
import com.ssafy.happyhouse.model.dto.UserDto;
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
	public ResponseEntity<List<FavoriteDto>> favoriteList(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		UserDto userDto = (UserDto)session.getAttribute("userinfo");
		List<FavoriteDto> list = null;
		if(userDto != null) {
			list = favoriteService.getList(userDto.getId());			
		}
		if(list != null && !list.isEmpty()) {
			return new ResponseEntity<List<FavoriteDto>>(list, HttpStatus.OK);
		}else {
			return new ResponseEntity(HttpStatus.NO_CONTENT);
		}
//		return new ResponseEntity<List<FavoriteDto>>(list, HttpStatus.OK);
	}
	
//	@PostMapping(value = "/deal/search/{aptName}")
//	public ResponseEntity<List<HouseDealDto>> aptNameSearch(@PathVariable("aptName") String aptName) throws Exception {
//		List<HouseDealDto> list = houseDealService.getAptInfoAtName(aptName);
////		if(list != null && !list.isEmpty()) {
////			return new ResponseEntity<List<HouseDealDto>>(list, HttpStatus.OK);
////		}else {
////			return new ResponseEntity(HttpStatus.NO_CONTENT);
////		}
//		return new ResponseEntity<List<HouseDealDto>>(list, HttpStatus.OK);
//	}
	
	// 얘는 input 뭘로 받아야하는지 체크 후 고치기.
	@GetMapping(value = "/deal/{code}")
	public ResponseEntity<List<HouseDealDto>> favoriteSearch(@PathVariable("code") String code) throws Exception {
		List<HouseDealDto> list = houseDealService.getAptInfoInDong(code);
//		if(list != null && !list.isEmpty()) {
//			return new ResponseEntity<List<HouseDealDto>>(list, HttpStatus.OK);
//		}else {
//			return new ResponseEntity(HttpStatus.NO_CONTENT);
//		}
		return new ResponseEntity<List<HouseDealDto>>(list, HttpStatus.OK);
	}
	
	// 이거 input 뭘로 받는지 확인 후 고치기.
	@DeleteMapping(value = "/deal/{code}")
	public ResponseEntity<List<FavoriteDto>> delete(@PathVariable("code") String code, HttpServletRequest request) throws Exception {
		favoriteService.deleteFavorite(code);
		HttpSession session = request.getSession();
		UserDto userDto = (UserDto)session.getAttribute("userinfo");
		List<FavoriteDto> list = favoriteService.getList(userDto.getId());
		return new ResponseEntity<List<FavoriteDto>>(list, HttpStatus.OK);
	}
	
	// 중복체크 할 것!
	@PostMapping(value = "/deal")
	public ResponseEntity<List<FavoriteDto>> regist(@RequestBody FavoriteDto dto, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		UserDto userDto = (UserDto)session.getAttribute("userinfo");
		System.out.println(dto.toString());
		List<FavoriteDto> list = favoriteService.getList(userDto.getId());
		
		boolean check = true;
		for(FavoriteDto fDto : list) {
			if(fDto.getCode().equals(dto.getCode())) {
				check = false;
				break;
			}
		}
		
		if(check) {
			favoriteService.insertFavorite(dto);
			list = favoriteService.getList(userDto.getId());
		}
		return new ResponseEntity<List<FavoriteDto>>(list, HttpStatus.OK);
	}
	
	
}
