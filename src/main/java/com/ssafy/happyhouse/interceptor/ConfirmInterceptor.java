package com.ssafy.happyhouse.interceptor;

import javax.servlet.http.*;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ssafy.happyhouse.model.dto.UserDto;

@Component
public class ConfirmInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		UserDto userDto = (UserDto) session.getAttribute("userinfo");
		if(userDto == null) {
			response.sendRedirect(request.getContextPath());
			return false;
		}
		return true;
	}

	
	
}
