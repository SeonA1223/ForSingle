package com.ssafy.happyhouse.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.dto.DongCodeDto;
import com.ssafy.happyhouse.model.dto.HouseInfoDto;
import com.ssafy.happyhouse.model.dto.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.service.HouseMapService;

import io.swagger.annotations.Api;

@Api("HouseMap 컨트롤러 API V1")
@CrossOrigin("*")
@RestController
public class HouseMapController {
	
	@Autowired
	HouseMapService houseMapService;
	
//	@PostMapping(value = "/maps/search/{dongcode}")
//	public ResponseEntity<List<HouseInfoDto>> search(@PathVariable("dongcode") String dongcode) throws Exception {
//		List<HouseInfoDto> list = houseMapService.getAptInDong(dongcode);
//		return new ResponseEntity<List<HouseInfoDto>>(list, HttpStatus.OK);
//	}
	
	@RequestMapping("/maps")
	protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		String act = request.getParameter("act");
		if("sido".equals(act)) {
			PrintWriter out = response.getWriter();
			List<SidoGugunCodeDto> list = null;
			JSONArray arr = new JSONArray();
			try {
				list = houseMapService.getSido();
				for(SidoGugunCodeDto dto : list) {
					JSONObject obj = new JSONObject();
					obj.put("sido_code", dto.getSidoCode());
					obj.put("sido_name", dto.getSidoName());
					arr.add(obj);
				}
			} catch (Exception e) {
				arr = new JSONArray();
				JSONObject obj = new JSONObject();
				obj.put("message_code", "-1");
				arr.add(obj);
				e.printStackTrace();
			} finally {
				out.print(arr.toJSONString());
				out.close();
			}
		}//sido
		else if("gugun".equals(act)) {
			String sido = request.getParameter("sido");
			PrintWriter out = response.getWriter();
			List<SidoGugunCodeDto> list = null;
			JSONArray arr = new JSONArray();
			try {
				list = houseMapService.getGugunInSido(sido);
				for(SidoGugunCodeDto dto : list) {
					JSONObject obj = new JSONObject();
					obj.put("gugun_code", dto.getGugunCode());
					obj.put("gugun_name", dto.getGugunName());
					arr.add(obj);
				}
			} catch (Exception e) {
				arr = new JSONArray();
				JSONObject obj = new JSONObject();
				obj.put("message_code", "-1");
				arr.add(obj);
				e.printStackTrace();
			} finally {
				out.print(arr.toJSONString());
				out.close();
			}
		}//gugun
		else if("dong".equals(act)) {
			String gugun = request.getParameter("gugun");
			PrintWriter out = response.getWriter();
			List<DongCodeDto> list = null;
			JSONArray arr = new JSONArray();
			try {
				list = houseMapService.getDongInGugun(gugun);
				for(DongCodeDto dto : list) {
					JSONObject obj = new JSONObject();
					obj.put("dongcode", dto.getDongcode());
					obj.put("city", dto.getCity());
					obj.put("gugun", dto.getGugun());
					obj.put("dong", dto.getDong());
					arr.add(obj);
				}
			} catch (Exception e) {
				arr = new JSONArray();
				JSONObject obj = new JSONObject();
				obj.put("message_code", "-1");
				arr.add(obj);
				e.printStackTrace();
			} finally {
				out.print(arr.toJSONString());
				out.close();
			}
		}//dong

	}//process

}