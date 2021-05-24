package com.ssafy.happyhouse.model.dto;

public class CategoryCountDto {
	int pharmacy;
	int bank;
	int subway;
	int mart;
	int convenience;
	int chicken;
	int coinLaundry;
	public int getCoinLaundry() {
		return coinLaundry;
	}
	public void setCoinLaundry(int coinLaundry) {
		this.coinLaundry = coinLaundry;
	}
	public int getChicken() {
		return chicken;
	}
	public void setChicken(int chicken) {
		this.chicken = chicken;
	}
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

	public CategoryCountDto() {
		super();
	}
	
	
}
