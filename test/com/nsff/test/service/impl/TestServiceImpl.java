package com.nsff.test.service.impl;

import java.io.Serializable;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nsff.test.dao.TestDao;
import com.nsff.test.entity.Person;
import com.nsff.test.service.TestService;

@Service("testService")
public class TestServiceImpl implements TestService{

	@Resource
	TestDao testDao;
	
	@Override
	public void sayHi() {
		System.out.println("tomecat say hello");
	}

	@Override
	public void save(Person person) {
		testDao.save(person);
		
	}

	@Override
	public Person findPerson(Serializable id) {
		//save(new Person("test"));//为了验证find*方法是在只读模式下
		return testDao.findPerson(id);
	}

}
