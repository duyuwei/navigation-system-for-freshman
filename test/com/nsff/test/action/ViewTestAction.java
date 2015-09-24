package com.nsff.test.action;

import javax.annotation.Resource;

import com.nsff.test.service.TestService;

import com.opensymphony.xwork2.ActionSupport;

public class ViewTestAction extends ActionSupport {
	
	public String execute(){
		return "listUI";
	}

}
