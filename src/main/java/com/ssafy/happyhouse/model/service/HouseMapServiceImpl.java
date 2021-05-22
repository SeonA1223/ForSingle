package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.dao.HouseMapDao;
import com.ssafy.happyhouse.model.dto.HouseInfoDto;
import com.ssafy.happyhouse.model.dto.SidoGugunCodeDto;

@Service
public class HouseMapServiceImpl implements HouseMapService {
	
	@Autowired
	HouseMapDao houseMap;
	
	@Override
	public List<SidoGugunCodeDto> getSido() throws Exception {
		return houseMap.getSido();
	}

	@Override
	public List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception {
		return houseMap.getGugunInSido(sido);
	}

	@Override
	public List<HouseInfoDto> getDongInGugun(String gugun) throws Exception {
		return houseMap.getDongInGugun(gugun);
	}

//	@Override
//	public List<HouseInfoDto> getAptInDong(String dong) throws Exception {
//		return houseMap.getAptInDong(dong);
//	}

}
