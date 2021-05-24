package com.ssafy.happyhouse.controller;

import java.util.ArrayList;
import java.util.List;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSession;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.apache.ibatis.type.TypeReference;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.ssafy.happyhouse.model.dto.AddressDto;
import com.ssafy.happyhouse.model.dto.CategoryCountDto;
import com.ssafy.happyhouse.model.dto.HouseDealDto;
import com.ssafy.happyhouse.model.dto.HouseInfoDto;
import com.ssafy.happyhouse.model.service.HouseDealService;

import io.swagger.annotations.Api;

@Api("Api 컨트롤러 API V1")
@CrossOrigin("*")
@RestController
public class ApiController {

	@Autowired
	HouseDealService houseDealService;

	@GetMapping(value = "/detail_info/{lat}/{lng}")
	public CategoryCountDto countCategory(@PathVariable("lat") String lat, @PathVariable("lng") String lng) throws Exception {
		
		CategoryCountDto dto = new CategoryCountDto();
		int category_size = 5;
		int[] category_count = new int[category_size];
		String[] category_code = new String[category_size];
		category_code[0] = "PM9";
		category_code[1] = "BK9";
		category_code[2] = "SW8";
		category_code[3] = "MT1";
		category_code[4] = "CS2";
		
		int keyword_size = 2;
		int[] keyword_count = new int[keyword_size];
		String[] keyword_code = new String[keyword_size];
		keyword_code[0] = "치킨";
		keyword_code[1] = "셀프빨래방";
		
		// 걸어서 10분거리로 800m
		String radius = "800";
		radius = URLEncoder.encode(radius, "UTF-8");
		
		// 이게 2차 문제 | 오타였음! (401 : KaKaoAK => KakaoAk)
		String auth = "KakaoAK " + "267c0734c220f67b6e00a6daadfffdfd";
		
		// 이게 1차 문제였음. (400 에러)
		lat = URLEncoder.encode(lat, "UTF-8");
		lng = URLEncoder.encode(lng, "UTF-8");
		
		// 주변의 약국, 은행, 지하철역, 대형마트, 편의점의 갯수를 세기 위해 카테고리 기반 검색.
		
		for(int i = 0; i < category_size; i++) {
			StringBuffer result2 = new StringBuffer();
			String URL_api2 = "https://dapi.kakao.com/v2/local/search/category.json?category_group_code="+ category_code[i] +"&y=" + lng + "&x=" + lat + "&radius=" + radius;				
			URL url2 = new URL(URL_api2);
			
			HttpURLConnection conn2 = (HttpURLConnection) url2.openConnection();
			conn2.setRequestMethod("GET");
//			conn2.setRequestProperty("User-Agent", "Java-Client");
			conn2.setRequestProperty("X-Requested-With", "curl");
			conn2.setRequestProperty("Authorization", auth);
			BufferedReader br2;
			if(conn2.getResponseCode() >= 200 && conn2.getResponseCode() <= 300) {
				br2 = new BufferedReader(new InputStreamReader(conn2.getInputStream(), "UTF-8"));
			}else {
				br2 = new BufferedReader(new InputStreamReader(conn2.getErrorStream()));
			}
			
			String line2;
			
			while((line2 = br2.readLine()) != null) {
				result2.append(line2 + "\n");
			}
			br2.close();
			conn2.disconnect();
			
			String rjson = result2.toString();
			
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(rjson);
			org.json.simple.JSONObject kakaoObject = (org.json.simple.JSONObject) obj;
			org.json.simple.JSONArray documents = (org.json.simple.JSONArray) kakaoObject.get("documents");
			// 추정 : 한번에 들어오는 값의 최대가 15개씩인 듯.
			// 항상 15개에서 멈춤. 그렇다고 값이 바뀌지 않는 것은 또 아님.
			category_count[i] = documents.size();
		}
		
		dto.setPharmacy(category_count[0]);
		dto.setBank(category_count[1]);
		dto.setSubway(category_count[2]);
		dto.setMart(category_count[3]);
		dto.setConvenience(category_count[4]);
		
		// 주변의 치킨집을 세기 위해 keyword 기반 검색
		
		for(int i = 0; i < keyword_size; i++) {
			StringBuffer result2 = new StringBuffer();
			keyword_code[i] = URLEncoder.encode(keyword_code[i], "UTF-8");
			String URL_api2 = "https://dapi.kakao.com/v2/local/search/keyword.json?query="+ keyword_code[i] +"&y=" + lng + "&x=" + lat + "&radius=" + radius;				
			URL url2 = new URL(URL_api2);
			
			HttpURLConnection conn2 = (HttpURLConnection) url2.openConnection();
			conn2.setRequestMethod("GET");
//			conn2.setRequestProperty("User-Agent", "Java-Client");
			conn2.setRequestProperty("X-Requested-With", "curl");
			conn2.setRequestProperty("Authorization", auth);
			BufferedReader br2;
			if(conn2.getResponseCode() >= 200 && conn2.getResponseCode() <= 300) {
				br2 = new BufferedReader(new InputStreamReader(conn2.getInputStream(), "UTF-8"));
			}else {
				br2 = new BufferedReader(new InputStreamReader(conn2.getErrorStream()));
			}
			
			String line2;
			
			while((line2 = br2.readLine()) != null) {
				result2.append(line2 + "\n");
			}
			br2.close();
			conn2.disconnect();
			
			String rjson = result2.toString();
			
//			System.out.println(rjson);
			
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(rjson);
			org.json.simple.JSONObject kakaoObject = (org.json.simple.JSONObject) obj;
			org.json.simple.JSONArray documents = (org.json.simple.JSONArray) kakaoObject.get("documents");
			// 추정 : 한번에 들어오는 값의 최대가 15개씩인 듯.
			// 항상 15개에서 멈춤. 그렇다고 값이 바뀌지 않는 것은 또 아님.
			keyword_count[i] = documents.size();
		}
		dto.setChicken(keyword_count[0]);
		dto.setCoinLaundry(keyword_count[1]);
		
		return dto;
	}
	
	@GetMapping(value = "/maps/search/{dongcode}")
	public List<HouseDealDto> search(@PathVariable("dongcode") String dongcode) throws Exception {

		StringBuffer result = new StringBuffer();
		String URL_api = "http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcRHRent?LAWD_CD="
				+ dongcode.substring(0, 5)
				+ "&DEAL_YMD=201512&serviceKey=lqH%2Fp4Ru%2ByXvcac0j5JIwWnHxhe1jq18yzY3vJ6eXuwzvI3V0%2BBQ%2FO57L%2BIYDAKCqiBkcPrwgsoO%2BFoDfRwvZg%3D%3D";
		URL url = new URL(URL_api);

		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		BufferedReader br;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		} else {
			br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}

		String line;

		while ((line = br.readLine()) != null) {
			result.append(line + "\n");
		}
		br.close();
		conn.disconnect();

		String xml = result + "";

		JSONObject jObject = null, response = null, body = null, items = null;
		JSONArray item = null;
		jObject = XML.toJSONObject(xml);
		if (jObject != null && jObject.has("response") && !(jObject.get("response") instanceof String))
			response = jObject.getJSONObject("response");
		if (response != null && response.has("body") && !(response.get("body") instanceof String))
			body = response.getJSONObject("body");
		if (body != null && body.has("items") && !(body.get("items") instanceof String))
			items = body.getJSONObject("items");
		if (items != null && items.has("item") && !(items.get("item") instanceof String))
			item = items.getJSONArray("item");

//		ObjectMapper mapper = new ObjectMapper();
//		mapper.enable(SerializationFeature.INDENT_OUTPUT);
//		Object json = mapper.readValue(item.toString(), Object.class);
//		String output = mapper.writeValueAsString(json);
//		
//		ObjectMapper mapper = new ObjectMapper();
//		mapper.enable(SerializationFeature.INDENT_OUTPUT);
//		Object json = mapper.readValue(jObject.toString(), Object.class);
//		String output = mapper.writeValueAsString(json);

		List<HouseDealDto> list = new ArrayList<HouseDealDto>();

		// 이게 2차 문제 | 오타였음! (401 : KaKaoAK => KakaoAk)
		String auth = "KakaoAK " + "267c0734c220f67b6e00a6daadfffdfd";

		AddressDto addDto = houseDealService.getAddress(dongcode);

		String curDong = null;
		if(addDto != null)
			curDong = addDto.getDong();
		
		if (item != null && curDong != null) {
			int jsonSize = item.length();
			for (int i = 0; i < jsonSize; i++) {
				JSONObject cur = item.getJSONObject(i);
				HouseDealDto dto = new HouseDealDto();
				dto.setNo(i + 1);
				
				if (cur.has("법정동"))
					dto.setDong(cur.getString("법정동"));
				
				
				if(!curDong.equals(dto.getDong())) continue;
				
				if (cur.has("건축년도")) {
					if (cur.get("건축년도") instanceof Integer)
						dto.setBuildYear(Integer.toString(cur.getInt("건축년도")));
					else
						dto.setBuildYear(cur.getString("건축년도"));
				}
				if (cur.has("년")) {
					if (cur.get("년") instanceof Integer)
						dto.setDealYear(Integer.toString(cur.getInt("년")));
					else
						dto.setDealYear(cur.getString("년"));
				}
				if (cur.has("보증금액")) {
					if (cur.get("보증금액") instanceof Integer)
						dto.setDealAmount(Integer.toString(cur.getInt("보증금액")));
					else
						dto.setDealAmount(cur.getString("보증금액"));
				}
				if (cur.has("연립다세대"))
					dto.setAptName(cur.getString("연립다세대"));
				if (cur.has("월")) {
					if (cur.get("월") instanceof Integer)
						dto.setDealMonth(Integer.toString(cur.getInt("월")));
					else
						dto.setDealMonth(cur.getString("월"));
				}
				if (cur.has("월세금액")) {
					if (cur.get("월세금액") instanceof Integer)
						dto.setRentMoney(Integer.toString(cur.getInt("월세금액")));
					else
						dto.setRentMoney(cur.getString("월세금액"));
				}
				if (cur.has("일")) {
					if (cur.get("일") instanceof Integer)
						dto.setDealDay(Integer.toString(cur.getInt("일")));
					else
						dto.setDealDay(cur.getString("일"));
				}
				if (cur.has("전용면적")) {
					if (cur.get("전용면적") instanceof Double)
						dto.setArea(Double.toString(cur.getDouble("전용면적")));
					else if(cur.get("전용면적") instanceof Integer)
						dto.setArea(Integer.toString(cur.getInt("전용면적")));
					else
						dto.setArea(cur.getString("전용면적"));
				}
				if (cur.has("지번")) {
					if (cur.get("지번") instanceof Integer)
						dto.setJibun(Integer.toString(cur.getInt("지번")));
					else
						dto.setJibun(cur.getString("지번"));
				}
				if (cur.has("지역코드")) {
					if (cur.get("지역코드") instanceof Integer)
						dto.setCode(Integer.toString(cur.getInt("지역코드")));
					else
						dto.setCode(cur.getString("지역코드"));
				}
				if (cur.has("층")) {
					if (cur.get("층") instanceof Integer)
						dto.setFloor(Integer.toString(cur.getInt("층")));
					else
						dto.setFloor(cur.getString("층"));
				}


				String address = addDto.getCity() + " " + addDto.getGugun() + " " + addDto.getDong() + " ";
				
				address += dto.getJibun();
				
				// 이게 1차 문제였음. (400 에러)
				address = URLEncoder.encode(address, "UTF-8");
				
				StringBuffer result2 = new StringBuffer();
				String URL_api2 = "https://dapi.kakao.com/v2/local/search/address.json?query=" + address;				
				URL url2 = new URL(URL_api2);
				
				HttpURLConnection conn2 = (HttpURLConnection) url2.openConnection();
				conn2.setRequestMethod("GET");
//				conn2.setRequestProperty("User-Agent", "Java-Client");
				conn2.setRequestProperty("X-Requested-With", "curl");
				conn2.setRequestProperty("Authorization", auth);
				BufferedReader br2;
				if(conn2.getResponseCode() >= 200 && conn2.getResponseCode() <= 300) {
					br2 = new BufferedReader(new InputStreamReader(conn2.getInputStream(), "UTF-8"));
				}else {
					br2 = new BufferedReader(new InputStreamReader(conn2.getErrorStream()));
				}
				
				String line2;
				
				while((line2 = br2.readLine()) != null) {
					result2.append(line2 + "\n");
				}
				br2.close();
				conn2.disconnect();
				
				String rjson = result2.toString();
//				System.out.println(rjson);
				
				JSONParser parser = new JSONParser();
				Object obj = parser.parse(rjson);
				org.json.simple.JSONObject kakaoObject = (org.json.simple.JSONObject) obj;
				org.json.simple.JSONArray documents = (org.json.simple.JSONArray) kakaoObject.get("documents");
				org.json.simple.JSONObject kakaoAddress = (org.json.simple.JSONObject) documents.get(0);
				
				// 이거 반대로 주고 있음. 우선 받는 프론트에서 반대로 적도록 해놨음.
				dto.setLat((String)kakaoAddress.get("x"));
				dto.setLng((String)kakaoAddress.get("y"));

				
				list.add(dto);
			}
		}

		return list;
	}

}
