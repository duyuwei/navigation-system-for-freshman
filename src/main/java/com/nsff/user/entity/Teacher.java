package com.nsff.user.entity;

import java.io.Serializable;

public class Teacher implements Serializable{
	
	private String id; // 老师代码
	private String name; // 老师名称
	private String username; // 登录名
	private String password; // 密码
	private boolean gender; // 性别
	private String telephone; // 电话
	private String weChat; // 微信
	private String QQNumber; // QQ
	
	
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
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public boolean isGender() {
		return gender;
	}
	public void setGender(boolean gender) {
		this.gender = gender;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getWeChat() {
		return weChat;
	}
	public void setWeChat(String weChat) {
		this.weChat = weChat;
	}
	public String getQQNumber() {
		return QQNumber;
	}
	public void setQQNumber(String qQNumber) {
		QQNumber = qQNumber;
	}
	

	
	
}
