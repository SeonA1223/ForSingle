//package com.ssafy.happyhouse.model.dao;
//
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//
//import com.ssafy.happyhouse.model.dto.HouseDealDto;
//import com.ssafy.util.DBUtil;
//
//public class HouseDealDaoImpl implements HouseDealDao {
//
//	private static HouseDealDao houseDealDao;
//	
//	private HouseDealDaoImpl() {}
//	
//	public static HouseDealDao getHouseDealDao() {
//		if(houseDealDao == null)
//			houseDealDao = new HouseDealDaoImpl();
//		return houseDealDao;
//	}
//	
//	@Override
//	public List<HouseDealDto> getAptInfoAtName(String AptName) throws Exception {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		List<HouseDealDto> list = new ArrayList<HouseDealDto>();
//		try {
//			conn = DBUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("SELECT * FROM housedeal WHERE AptName = ? \n");
//			sql.append("ORDER BY AptName");
//			pstmt = conn.prepareStatement(sql.toString());
//			pstmt.setString(1, AptName);
//			rs = pstmt.executeQuery();
//			while(rs.next()) {
//				HouseDealDto dto = new HouseDealDto();
//				dto.setNo(Integer.parseInt(rs.getString("no")));
//				dto.setDong(rs.getString("dong"));
//				dto.setAptName(rs.getString("AptName"));
//				dto.setCode(rs.getString("code"));
//				dto.setDealAmount(rs.getString("dealAmount"));
//				dto.setBuildYear(rs.getString("buildYear"));
//				dto.setDealYear(rs.getString("dealYear"));
//				dto.setDealMonth(rs.getString("dealMonth"));
//				dto.setDealDay(rs.getString("dealDay"));
//				dto.setArea(rs.getString("area"));
//				dto.setFloor(rs.getString("floor"));
//				dto.setJibun(rs.getString("jibun"));
//				dto.setType(rs.getString("type"));
//				dto.setRentMoney(rs.getString("rentMoney"));
//				
//				list.add(dto);
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			DBUtil.close(rs);
//			DBUtil.close(pstmt);
//			DBUtil.close(conn);
//		}
//		
//		return list;
//	}
//
//	@Override
//	public List<HouseDealDto> getAptInfoInDong(String dong) throws Exception {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		List<HouseDealDto> list = new ArrayList<HouseDealDto>();
//		try {
//			conn = DBUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("SELECT * FROM housedeal WHERE dong = ? \n");
//			sql.append("ORDER BY dong");
//			pstmt = conn.prepareStatement(sql.toString());
//			pstmt.setString(1, dong);
//			rs = pstmt.executeQuery();
//			while(rs.next()) {
//				HouseDealDto dto = new HouseDealDto();
//				dto.setNo(Integer.parseInt(rs.getString("no")));
//				dto.setDong(rs.getString("dong"));
//				dto.setAptName(rs.getString("AptName"));
//				dto.setCode(rs.getString("code"));
//				dto.setDealAmount(rs.getString("dealAmount"));
//				dto.setBuildYear(rs.getString("buildYear"));
//				dto.setDealYear(rs.getString("dealYear"));
//				dto.setDealMonth(rs.getString("dealMonth"));
//				dto.setDealDay(rs.getString("dealDay"));
//				dto.setArea(rs.getString("area"));
//				dto.setFloor(rs.getString("floor"));
//				dto.setJibun(rs.getString("jibun"));
//				dto.setType(rs.getString("type"));
//				dto.setRentMoney(rs.getString("rentMoney"));
//				
//				list.add(dto);
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			DBUtil.close(rs);
//			DBUtil.close(pstmt);
//			DBUtil.close(conn);
//		}
//		
//		return list;
//	}
//
//}
