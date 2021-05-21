package com.ssafy.happyhouse.model.dto;

public class PostDto {
	int num;
	String title;
	int views;
	String id;
	String date;
	String descrip;
	
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
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
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
	
	public PostDto(int num, String title, int views, String id, String date, String descrip) {
		super();
		this.num = num;
		this.title = title;
		this.views = views;
		this.id = id;
		this.date = date;
		this.descrip = descrip;
	}
	
	
	public PostDto() {
		
	}
	
	@Override
	public String toString() {
		return "PostDto [num=" + num + ", title=" + title + ", views=" + views + ", id=" + id + ", date=" + date
				+ ", descrip=" + descrip + "]";
	}
	
	
}
