package com.ssafy.happyhouse.controller;

import java.util.ArrayList;
import java.util.List;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.JSONObject;
import org.json.XML;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.ssafy.happyhouse.model.dto.HouseDealDto;
import com.ssafy.happyhouse.model.dto.HouseInfoDto;

import io.swagger.annotations.Api;

@Api("Api 컨트롤러 API V1")
@CrossOrigin("*")
@RestController
public class ApiController {

	@PostMapping(value = "/maps/search/{dongcode}")
	public List<HouseDealDto> search(@PathVariable("dongcode") String dongcode) throws Exception {
		
		StringBuffer result = new StringBuffer();
		String URL_api = "http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcRHRent?LAWD_CD=" + dongcode.substring(0, 5) + "&DEAL_YMD=201512&serviceKey=lqH%2Fp4Ru%2ByXvcac0j5JIwWnHxhe1jq18yzY3vJ6eXuwzvI3V0%2BBQ%2FO57L%2BIYDAKCqiBkcPrwgsoO%2BFoDfRwvZg%3D%3D";
		URL url = new URL(URL_api);
		
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		BufferedReader br;
		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		}else {
			br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		
		String line;
		
		while((line = br.readLine()) != null) {
			result.append(line + "\n");
		}
		br.close();
		conn.disconnect();
		
		String xml = result + "";
		
		JSONObject jObject = XML.toJSONObject(xml);
		ObjectMapper mapper = new ObjectMapper();
		mapper.enable(SerializationFeature.INDENT_OUTPUT);
		Object json = mapper.readValue(jObject.toString(), Object.class);
		String output = mapper.writeValueAsString(json);
		
		List<HouseDealDto> list = new ArrayList<HouseDealDto>();
		
		
		
		return list;
	}
	
}
