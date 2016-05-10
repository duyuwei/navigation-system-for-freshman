package com.nsff.student.entity;

import java.io.Serializable;

public class Student implements Serializable{
	private String id;
	private String name;
	private String telephone;
	private int step; 
	private double locX;
	private double locY;
	private String dormID;
	
	private Grade grade;
	
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
	public Grade getGrade() {
		return grade;
	}
	public void setGrade(Grade grade) {
		this.grade = grade;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
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
	public String getDormID() {
		return dormID;
	}
	public void setDormID(String dormID) {
		this.dormID = dormID;
	}
	
	
	
	
}
