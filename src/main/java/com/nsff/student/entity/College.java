package com.nsff.student.entity;

import java.io.Serializable;

public class College implements Serializable{
	
	private String id; // 学院代码
	private String name; // 学院名称
	private String registerID;  //报到点位置代码	
	private String locID;//学院位置id
	
	public String getLocID() {
		return locID;
	}
	public void setLocID(String locID) {
		this.locID = locID;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRegisterID() {
		return registerID;
	}
	public void setRegisterID(String registerID) {
		this.registerID = registerID;
	}
	

}
