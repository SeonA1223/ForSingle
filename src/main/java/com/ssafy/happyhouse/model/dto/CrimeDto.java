package com.ssafy.happyhouse.model.dto;

public class CrimeDto {

	String siname;
	int crimecount;
	public CrimeDto(String siname, int crimecount) {
		super();
		this.siname = siname;
		this.crimecount = crimecount;
	}
	public CrimeDto() {
		super();
	}
	public String getSiname() {
		return siname;
	}
	public void setSiname(String siname) {
		this.siname = siname;
	}
	public int getCrimecount() {
		return crimecount;
	}
	public void setCrimecount(int crimecount) {
		this.crimecount = crimecount;
	}
	
	
	
}
