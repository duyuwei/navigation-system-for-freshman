package com.nsff.test.dao.impl;

import java.io.Serializable;


import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.nsff.test.dao.TestDao;
import com.nsff.test.entity.Person;

public class TestDaoImpl extends HibernateDaoSupport implements TestDao {
	
	@Override
	public void save(Person person) {
		getHibernateTemplate().save(person);
	}

	@Override
	public Person findPerson(Serializable id) {
		return getHibernateTemplate().get(Person.class, id);
	}

}
