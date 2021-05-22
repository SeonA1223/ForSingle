package com.ssafy.happyhouse.model.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.happyhouse.model.dao.CrimeDao;
import com.ssafy.happyhouse.model.dao.PopulDao;
import com.ssafy.happyhouse.model.dto.CrimeDto;
import com.ssafy.happyhouse.model.dto.PopulDto;

@Service
public class CrimePopulServiceImpl implements CrimePopulService {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	@Transactional
	public Map<String, String> getCrimePopul(String gugun_code) {
		Map<String, String> map = new HashMap<String, String>();
		
		String left2 = gugun_code.substring(0, 2);
		
		if(left2.equals("11") || left2.equals("26") || left2.equals("27") || 
				left2.equals("28") || left2.equals("29") || left2.equals("30") || 
				left2.equals("31") || left2.equals("36"))
			gugun_code = left2 + "11000000";
		
		// gugun_code로 popul을 먼저 가져온다.
		PopulDto popul = sqlSession.getMapper(PopulDao.class).getPopul(gugun_code);
		CrimeDto crime = sqlSession.getMapper(CrimeDao.class).getCrime(popul.getSiname());
		
		map.put("crime", Integer.toString(crime.getCrimecount()));
		map.put("popul", Integer.toString(popul.getSipopul()));
		map.put("siname", popul.getSiname());
		
		return map;
	}

}
