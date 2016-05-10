package com.nsff.user.entity;

import java.io.Serializable;

public class Loc implements Serializable{
	
	private String id;
	private String type;
	private String name;
	private double locX;
	private double locY;
	private String introduce;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getLocX() {
		return locX;
	}
	public void setLocX(double locX) {
		this.locX = locX;
	}
	public double getLocY() {
		return locY;
	}
	public void setLocY(double locY) {
		this.locY = locY;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	
	
	
	
	
	
	
	
	
	
}
