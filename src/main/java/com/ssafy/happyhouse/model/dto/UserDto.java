package com.ssafy.happyhouse.model.dto;

public class UserDto {

	private String id;
	private String pwd;
	private String name;
	private String address;
	private String phoneNum;
	
	
	
	public UserDto() {
		super();
	}

	public UserDto(String id, String pwd, String name, String address, String phoneNum) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.address = address;
		this.phoneNum = phoneNum;
	}
	
	public UserDto(String id, String pwd) {
		super();
		this.id = id;
		this.pwd = pwd;
	}
	
	

	public UserDto(String id, String name, String address, String phoneNum) {
		super();
		this.id = id;
		this.name = name;
		this.address = address;
		this.phoneNum = phoneNum;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	
	
	
}
