package com.nsff.user.service.impl;

import java.io.Serializable;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nsff.user.dao.TeacherDao;
import com.nsff.user.entity.Teacher;
import com.nsff.user.service.TeacherService;

@Service("teacherService")
public class TeacherServiceImpl implements TeacherService {

	@Resource
	private TeacherDao teacherDao;

	@Override
	public void save(Teacher user) {
		teacherDao.save(user);
	}

	@Override
	public void update(Teacher user) {
		teacherDao.update(user);
	}

	@Override
	public void delete(Serializable id) {
		teacherDao.delete(id);
	}

	@Override
	public Teacher findObjectById(Serializable id) {
		return teacherDao.findObjectById(id);
	}

	@Override
	public List<Teacher> findObjects() {
		return teacherDao.findObjects();
	}

}
