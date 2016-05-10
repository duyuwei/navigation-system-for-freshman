package com.nsff.student.dao.impl;

import java.util.List;

import org.hibernate.Query;

import com.nsff.core.dao.impl.BaseDaoImpl;
import com.nsff.student.dao.StudentDao;
import com.nsff.student.entity.Grade;
import com.nsff.student.entity.Student;

public class StudentDaoImpl extends BaseDaoImpl<Student> implements StudentDao{

	@SuppressWarnings("unchecked")
	@Override
	public List<Student> findUserByAccountAndPass(String id, String name) {
		Query query = getSession().createQuery("FROM  Student WHERE id = ? AND name = ?");
		query.setParameter(0, id);
		query.setParameter(1, name);
		return query.list();
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Student> findStudentByName(String name){
		Query query = getSession().createQuery("FROM  Student WHERE name like %?%");
		query.setParameter(0, name);
		return query.list();
	}
	
	public Grade findStudenByGrade(String gradeId){
		return getHibernateTemplate().get(Grade.class, gradeId);
	}
	
	@SuppressWarnings("unchecked")
	public List<Grade> findAllGrades()
	{
		Query query = getSession().createQuery("FROM Grade");
		return query.list();
	}
	
}
