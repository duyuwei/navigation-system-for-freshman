package com.nsff.user.action;

import com.opensymphony.xwork2.ActionSupport;

@SuppressWarnings("serial")
public class LoginAction extends ActionSupport {
	
	public String gotoLogin(){
		
		return "login";
	}

}
