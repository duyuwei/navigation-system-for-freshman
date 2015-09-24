package com.nsff.test.service;

import java.io.Serializable;

import com.nsff.test.entity.Person;

public interface TestService {
	public void sayHi();
	
	//保存人员
	public void save(Person person);
		
		//根据id查询人员
	public Person findPerson(Serializable id);
}
