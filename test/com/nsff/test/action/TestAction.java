package com.nsff.test.action;

import javax.annotation.Resource;

import com.nsff.test.service.TestService;

import com.opensymphony.xwork2.ActionSupport;

public class TestAction extends ActionSupport {
	
	@Resource
	private TestService testService;

	public String execute(){
		testService.sayHi();
		return SUCCESS;
	}

}
