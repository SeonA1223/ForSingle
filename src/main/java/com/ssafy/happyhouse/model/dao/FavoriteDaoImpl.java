//package com.ssafy.happyhouse.model.dao;
//
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//
//import com.ssafy.happyhouse.model.dao.FavoriteDao;
//import com.ssafy.happyhouse.model.dto.FavoriteDto;
//import com.ssafy.happyhouse.model.dto.HouseDealDto;
//import com.ssafy.util.DBUtil;
//
//public class FavoriteDaoImpl implements FavoriteDao {
//
//	private static FavoriteDao favoriteDao;
//	
//	private FavoriteDaoImpl() {}
//	
//	public static FavoriteDao getfavoriteDao() {
//		if(favoriteDao == null)
//			favoriteDao = new FavoriteDaoImpl();
//		return favoriteDao;
//	}
//	
//	@Override
//	public List<FavoriteDto> list(){
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		List<FavoriteDto> list = new ArrayList<FavoriteDto>();
//		try {
//			conn = DBUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("SELECT * FROM favorite \n");
//			sql.append("ORDER BY dong");
//			pstmt = conn.prepareStatement(sql.toString());
//			rs = pstmt.executeQuery();
//			while(rs.next()) {
//				FavoriteDto dto = new FavoriteDto();
//				dto.setDong(rs.getString("dong"));
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
//	public boolean insert(FavoriteDto dto) {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		boolean check = false;
//		try {
//			conn = DBUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("insert into favorite values (?) \n");
//			pstmt = conn.prepareStatement(sql.toString());
//			pstmt.setString(1, dto.getDong());
//			if(pstmt.executeUpdate() == 1) {
//				System.out.println("success");
//				check = true;
//			}else {
//				System.out.println("fail");
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			DBUtil.close(pstmt);
//			DBUtil.close(conn);
//		}
//		
//		return check;
//	}
//
//	@Override
//	public boolean delete(FavoriteDto dto) {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		boolean check = false;
//		try {
//			conn = DBUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("delete from favorite where dong = ? \n");
//			pstmt = conn.prepareStatement(sql.toString());
//			pstmt.setString(1, dto.getDong());
//			if(pstmt.executeUpdate() == 1) {
//				System.out.println("success");
//				check = true;
//			}else {
//				System.out.println("fail");
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			DBUtil.close(pstmt);
//			DBUtil.close(conn);
//			check = true;
//		}
//		
//		return check;
//	}
//
//	@Override
//	public FavoriteDto get(String dong) {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		FavoriteDto dto = new FavoriteDto();
//		try {
//			conn = DBUtil.getConnection();
//			StringBuilder sql = new StringBuilder();
//			sql.append("SELECT * FROM favorite WHERE dong = ? \n");
//			pstmt = conn.prepareStatement(sql.toString());
//			pstmt.setString(1, dong);
//			rs = pstmt.executeQuery();
//			if(rs.next()) {
//				dto.setDong(rs.getString("dong"));
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			DBUtil.close(rs);
//			DBUtil.close(pstmt);
//			DBUtil.close(conn);
//		}
//		
//		return dto;
//	}
//
//}
