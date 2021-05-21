package com.ssafy.happyhouse.model.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.dto.UserDto;

@Mapper
public interface UserDao {
	
	int registerUser(UserDto user);
	UserDto login(Map<String, String> map);
	UserDto selectUser(String id);
	int updateUser(UserDto user);
	int removeUser(String id);
}
