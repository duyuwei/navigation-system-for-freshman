package com.nsff.user.service;

import java.io.Serializable;
import java.util.List;

import com.nsff.user.entity.Teacher;

public interface TeacherService {
	// 新增
	public void save(Teacher user);

	// 更新
	public void update(Teacher user);

	// 根据id删除O
	public void delete(Serializable id);

	// 根据id查找
	public Teacher findObjectById(Serializable id);

	// 查找列表
	public List<Teacher> findObjects();
}
