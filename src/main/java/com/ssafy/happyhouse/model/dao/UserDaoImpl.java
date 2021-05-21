//package com.ssafy.happyhouse.model.dao;
//
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//
//import com.ssafy.happyhouse.model.dto.UserDto;
//import com.ssafy.util.DBUtil;
//
//public class UserDaoImpl implements UserDao {
//
//	private static UserDao userdao;
//
//	private UserDaoImpl() {
//	}
//
//	public static UserDao getUserDao() {
//		if (userdao == null)
//			userdao = new UserDaoImpl();
//		return userdao;
//	}
//
//	@Override
//	public boolean registerUser(UserDto user) {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		boolean check = false;
//
//		try {
//			conn = DBUtil.getConnection();
//			String sql = "insert into user (id, pwd, name, address, phoneNum) values (?,?,?,?,?)";
//			pstmt = conn.prepareStatement(sql);
//
//			pstmt.setString(1, user.getId());
//			pstmt.setString(2, user.getPwd());
//			pstmt.setString(3, user.getName());
//			pstmt.setString(4, user.getAddress());
//			pstmt.setString(5, user.getPhoneNum());
//			pstmt.executeUpdate();
//
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
//	public boolean login(String id, String pwd) {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		boolean check = false;
//		String uid = null;
//		String upwd = null;
//
//		try {
//			conn = DBUtil.getConnection();
//			String sql = "select id, pwd from user where id=?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, id);
//			rs = pstmt.executeQuery();
//
//			if (rs.next()) {
//				uid = rs.getString("id");
//				upwd = rs.getString("pwd");
//			}
//
//			if (id.equals(uid) && pwd.equals(upwd)) {
//				check = true;
//			}
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			DBUtil.close(rs);
//			DBUtil.close(pstmt);
//			DBUtil.close(conn);
//		}
//
//		return check;
//	}
//
//	@Override
//	public UserDto selectUser(String id) {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		UserDto user = null;
//
//		try {
//			conn = DBUtil.getConnection();
//			String sql = "select id, name, address, phonenum from user where id=?";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setString(1, id);
//			rs = pstmt.executeQuery();
//
//			if (rs.next()) {
//				user = new UserDto(rs.getString("id"), rs.getString("name"), rs.getString("address"),
//						rs.getString("phonenum"));
//			}
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			DBUtil.close(rs);
//			DBUtil.close(pstmt);
//			DBUtil.close(conn);
//		}
//
//		return user;
//	}
//
//	@Override
//	public boolean updateUser(UserDto user) {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		boolean check = false;
//
//		try {
//			conn = DBUtil.getConnection();
//			String sql = "update user set name =?,address=?,phonenum=? where id=?";
//			pstmt = conn.prepareStatement(sql);
//
//			pstmt.setString(1, user.getName());
//			pstmt.setString(2, user.getAddress());
//			pstmt.setString(3, user.getPhoneNum());
//			pstmt.setString(4, user.getId());
//			int t = pstmt.executeUpdate();
//
//			if (t > 0) {
//				check = true;
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
//	public void removeUser(String id) {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//
//		try {
//			conn = DBUtil.getConnection();
//			String sql = "delete from user where id=?";
//			pstmt = conn.prepareStatement(sql);
//
//			pstmt.setString(1, id);
//			pstmt.executeUpdate();
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			DBUtil.close(pstmt);
//			DBUtil.close(conn);
//
//		}
//
//	}
//
//}
