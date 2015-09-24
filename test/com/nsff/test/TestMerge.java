package com.nsff.test;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.nsff.test.entity.Person;
import com.nsff.test.service.TestService;
import com.nsff.user.service.TeacherService;

public class TestMerge {
	private ApplicationContext ctx;
	
	@Before
	public void loadCtx(){
		ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
	}
	
	@Test
	public void testSpring(){
		TestService ts = (TestService)ctx.getBean("testService");
		ts.sayHi();
	}
	
	@Test
	public void testHibernate() {
		SessionFactory sf = (SessionFactory)ctx.getBean("sessionFactory");
		
		Session session = sf.openSession();
		Transaction transaction = session.beginTransaction();
		//保存人员
		session.save(new Person("人员1"));
		transaction.commit();
		session.close();
	}
	
	@Test
	public void testServiceAndDao() {
		TestService ts = (TestService)ctx.getBean("testService");
		ts.save(new Person("人员2"));
		//System.out.println(ts.findPerson("402881e44edcfaad014edcfaaf4c0000").getName());
	}
	
	@Test
	public void testTransationReadOnly() {//只读事务，如果在只读事务中出现更新操作则回滚
		TestService ts = (TestService)ctx.getBean("testService");
		System.out.println(ts.findPerson("402881e44edcfaad014edcfaaf4c0000").getName());
	}
	
	@Test
	public void testTransationRollback() {//回滚事务，如果操作中出现有任务异常则回滚先前的操作
		TestService ts = (TestService)ctx.getBean("testService");
		ts.save(new Person("人员4"));
	}

}
