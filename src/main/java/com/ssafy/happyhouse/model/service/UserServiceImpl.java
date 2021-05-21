package com.ssafy.happyhouse.model.service;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.happyhouse.model.dao.UserDao;
import com.ssafy.happyhouse.model.dto.UserDto;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	SqlSession sqlSession;

	@Override
	public int registerUser(UserDto user) {
		return sqlSession.getMapper(UserDao.class).registerUser(user);
	}

	@Override
	public UserDto login(Map<String, String> map) {
		return sqlSession.getMapper(UserDao.class).login(map);
	}

	@Override
	public UserDto selectUser(String id) {
		return sqlSession.getMapper(UserDao.class).selectUser(id);
	}

	@Override
	@Transactional
	public int updateUser(UserDto user) {
		System.out.println(user.getPhoneNum());
		return sqlSession.getMapper(UserDao.class).updateUser(user);
	}

	@Override
	@Transactional
	public int removeUser(String id) {
		return sqlSession.getMapper(UserDao.class).removeUser(id);
	}
	


}
