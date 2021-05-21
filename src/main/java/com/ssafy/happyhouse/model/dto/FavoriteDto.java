package com.ssafy.happyhouse.model.dto;

public class FavoriteDto {
	private String dong;

	
	public FavoriteDto() {
		super();
	}

	public String getDong() {
		return dong;
	}

	public void setDong(String dong) {
		this.dong = dong;
	}

	public FavoriteDto(String dong) {
		super();
		this.dong = dong;
	}

	@Override
	public String toString() {
		return "FavoriteDto [dong=" + dong + "]";
	}
	
	
}
