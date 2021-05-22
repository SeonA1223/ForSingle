package com.ssafy.happyhouse.model.dto;

public class AddressDto {
	String city;
	String gugun;
	String dong;
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getGugun() {
		return gugun;
	}
	public void setGugun(String gugun) {
		this.gugun = gugun;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public AddressDto(String city, String gugun, String dong) {
		super();
		this.city = city;
		this.gugun = gugun;
		this.dong = dong;
	}
	public AddressDto() {
		super();
	}
	
	
}
