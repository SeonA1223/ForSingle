package com.ssafy.happyhouse.model.dto;

public class CategoryCountDto {
	int pharmacy;
	int bank;
	int subway;
	int mart;
	int convenience;
	public int getPharmacy() {
		return pharmacy;
	}
	public void setPharmacy(int pharmacy) {
		this.pharmacy = pharmacy;
	}
	public int getBank() {
		return bank;
	}
	public void setBank(int bank) {
		this.bank = bank;
	}
	public int getSubway() {
		return subway;
	}
	public void setSubway(int subway) {
		this.subway = subway;
	}
	public int getMart() {
		return mart;
	}
	public void setMart(int mart) {
		this.mart = mart;
	}
	public int getConvenience() {
		return convenience;
	}
	public void setConvenience(int convenience) {
		this.convenience = convenience;
	}
	public CategoryCountDto(int pharmacy, int bank, int subway, int mart, int convenience) {
		super();
		this.pharmacy = pharmacy;
		this.bank = bank;
		this.subway = subway;
		this.mart = mart;
		this.convenience = convenience;
	}
	public CategoryCountDto() {
		super();
	}
	
	
}
