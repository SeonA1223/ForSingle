package com.ssafy.happyhouse.model.dto;

public class UserDto {

	private String id;
	private String pwd;
	private String name;
	private String address;
	private String phoneNum;
	// 1 : true, 0 : false
	private int isManager;
	
	
	
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
		this.isManager = 0;
	}

	public UserDto(String id, String pwd, String name, String address, String phoneNum, int isManager) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.address = address;
		this.phoneNum = phoneNum;
		this.isManager = isManager;
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



	public int getIsManager() {
		return isManager;
	}



	public void setIsManager(int isManager) {
		this.isManager = isManager;
	}

	@Override
	public String toString() {
		return "UserDto [id=" + id + ", pwd=" + pwd + ", name=" + name + ", address=" + address + ", phoneNum="
				+ phoneNum + ", isManager=" + isManager + "]";
	}

	

	
	
}
