package com.ssafy.happyhouse.model.service;

import java.util.Map;

import com.ssafy.happyhouse.model.dto.UserDto;

public interface UserService {

	int registerUser(UserDto user);
	UserDto login(Map<String, String> map);
	UserDto selectUser(String id);
	int updateUser(UserDto user);
	int removeUser(String id);
	
}
