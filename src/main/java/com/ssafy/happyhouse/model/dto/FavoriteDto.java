package com.ssafy.happyhouse.model.dto;

public class FavoriteDto {
	String fnum;
	String code;
	String dong;
	String userid;
	public String getFnum() {
		return fnum;
	}
	public void setFnum(String fnum) {
		this.fnum = fnum;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public FavoriteDto() {
		super();
	}
	public FavoriteDto(String fnum, String code, String dong, String userid) {
		super();
		this.fnum = fnum;
		this.code = code;
		this.dong = dong;
		this.userid = userid;
	}
	@Override
	public String toString() {
		return "FavoriteDto [fnum=" + fnum + ", code=" + code + ", dong=" + dong + ", userid=" + userid + "]";
	}
	
}
