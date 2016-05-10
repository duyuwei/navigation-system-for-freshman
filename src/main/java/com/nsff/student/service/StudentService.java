package com.nsff.student.service;

import java.io.Serializable;
import java.util.List;

import com.nsff.student.entity.Grade;
import com.nsff.student.entity.Student;


public interface StudentService {

		// 根据id查找
		public Student findObjectById(Serializable id);

		// 查找列表
		public List<Student> findObjects();
		
		// 登陆查询
		public List<Student> findUserByAccountAndPass(String id, String name);
		
		public void update(Student student);
		
		public List<Student> findStudentByName(String name);
		
		public Grade findStudenByGrade(String gradeId);
		
		public List<Grade> findAllGrades();
		
}
