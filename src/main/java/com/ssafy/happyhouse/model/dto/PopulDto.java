package com.ssafy.happyhouse.model.dto;

public class PopulDto {

	String siname;
	int sipopul;
	public PopulDto(String siname, int sipopul) {
		super();
		this.siname = siname;
		this.sipopul = sipopul;
	}
	public PopulDto() {
		super();
	}
	public String getSiname() {
		return siname;
	}
	public void setSiname(String siname) {
		this.siname = siname;
	}
	public int getSipopul() {
		return sipopul;
	}
	public void setSipopul(int sipopul) {
		this.sipopul = sipopul;
	}
	
	
}
