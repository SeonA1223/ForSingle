package com.ssafy.happyhouse.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.dto.UserDto;
import com.ssafy.happyhouse.model.service.UserService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@Api("User 컨트롤러 API V1")
@CrossOrigin
@RestController
@RequestMapping("/user")
public class UserController {

	@Autowired
	UserService userService;
	
	@DeleteMapping("/mypage/list/{id}")
	private int userRemove(@PathVariable("id") String id, HttpSession session) throws Exception {
		int res = userService.removeUser(id);
		session.invalidate();
		return res;

	}

	@PutMapping("/mypage/list")
	private int userUpate(@RequestBody UserDto user) throws Exception {
		System.out.println(user.getId());
		System.out.println(user.getAddress());
		System.out.println(user.getName());
		System.out.println(user.getPhoneNum());
		int res = userService.updateUser(user);
		return res;
	}
	
	@GetMapping("/mypage/list/{id}")
	private UserDto getUserData(@PathVariable("id") String id) throws Exception {
		return userService.selectUser(id);
	}

	@PostMapping("")
	@ApiOperation(value = "로그인", notes = "isManager는 1이 true, 0이 false")
	private boolean userLogin(@RequestBody Map<String, String> map, HttpSession session,HttpServletResponse response)
			throws IOException, ServletException {

		UserDto user = userService.login(map);

		if (user != null) { // 성공
			session.setAttribute("userinfo", user);
			return true;

		} else {
			return false;
		}

	}

	//되는지 안되는지 체크
	@PostMapping("/signup")
	private int userRegister(@RequestBody UserDto userdto)
			throws Exception {
		System.out.println("com?");
		System.out.println(userdto.getId());
		int res = userService.registerUser(userdto);
		return res;

	}
	
	

}
