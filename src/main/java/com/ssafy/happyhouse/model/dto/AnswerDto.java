package com.ssafy.happyhouse.model.dto;

public class AnswerDto {
	int num;
	String title;
	String id;
	String date;
	String descrip;
	
	public AnswerDto(int num, String title, String id, String date, String descrip) {
		super();
		this.num = num;
		this.title = title;
		this.id = id;
		this.date = date;
		this.descrip = descrip;
	}
	public AnswerDto() {
		super();
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getDescrip() {
		return descrip;
	}
	public void setDescrip(String descrip) {
		this.descrip = descrip;
	}
	
}
