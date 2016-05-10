package com.nsff.student.service.impl;

import java.io.Serializable;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nsff.student.dao.StudentDao;
import com.nsff.student.entity.Grade;
import com.nsff.student.entity.Student;
import com.nsff.student.service.StudentService;

@Service("studentService")
public class StudentServiceImpl implements StudentService{

	@Resource
	private StudentDao studentDao;
	
	@Override
	public Student findObjectById(Serializable id) {
		return studentDao.findObjectById(id);
	}

	@Override
	public List<Student> findObjects() {
		List<Student> students;
		students = studentDao.findObjects();
		//已关闭懒加载，不再需要操作
		/*
		for (Student student : students) {
			student.getGrade().getName();
			student.getGrade().getCollege().getName();
		}
		*/
		return students;
		
	}

	@Override
	public List<Student> findUserByAccountAndPass(String id, String name) {
		return studentDao.findUserByAccountAndPass(id, name);
	}

	@Override
	public void update(Student student) {
		studentDao.update(student);
		
	}

	@Override
	public List<Student> findStudentByName(String name) {
		return studentDao.findStudentByName(name);
	}

	@Override
	public Grade findStudenByGrade(String gradeId) {
		return studentDao.findStudenByGrade(gradeId);
	}

	@Override
	public List<Grade> findAllGrades() {
		return studentDao.findAllGrades();
	}
	

}
