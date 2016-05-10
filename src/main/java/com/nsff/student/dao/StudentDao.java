package com.nsff.student.dao;

import java.util.List;

import com.nsff.core.dao.BaseDao;
import com.nsff.student.entity.Grade;
import com.nsff.student.entity.Student;

public interface StudentDao extends BaseDao<Student> {
	// 登陆查询
	public List<Student> findUserByAccountAndPass(String id, String name);
	
	public List<Student> findStudentByName(String name);
	
	public Grade findStudenByGrade(String gradeId);
	
	public List<Grade> findAllGrades();
}
