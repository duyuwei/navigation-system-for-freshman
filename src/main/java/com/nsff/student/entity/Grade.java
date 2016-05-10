package com.nsff.student.entity;

import java.io.Serializable;
import java.util.Set;

@SuppressWarnings("serial")
public class Grade implements Serializable{
	
	private String id;
	private String name;
	private College college;
	private Set<Student> students;
	
	
	public Set<Student> getStudents() {
		return students;
	}
	public void setStudents(Set<Student> students) {
		this.students = students;
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
	public College getCollege() {
		return college;
	}
	public void setCollege(College college) {
		this.college = college;
	}
	
	
}
