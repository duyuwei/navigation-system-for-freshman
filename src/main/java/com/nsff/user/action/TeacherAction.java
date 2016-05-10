package com.nsff.user.action;

import java.util.List;

import javax.annotation.Resource;

import com.nsff.user.entity.Teacher;
import com.nsff.user.service.TeacherService;
import com.opensymphony.xwork2.ActionSupport;

public class TeacherAction extends ActionSupport {

	@Resource
	private TeacherService teacherService;
	
	private List<Teacher> teacherList;
	private Teacher teacher;

	// 列表页面
	public String listUI() {
		teacherList = teacherService.findObjects();
		return "listUI";
	}

	// 跳转到新增页面
	public String addUI() {
		return "addUI";
	}

	// 保存新增
	public String add() {
		if (teacher != null) {
			teacherService.save(teacher);
		}
		return "list";
	}

	// 跳转到编辑页面
	public String editUI() {
		if (teacher != null && teacher.getId() != null) {
			teacher = teacherService.findObjectById(teacher.getId());
		}
		return "editUI";
	}

	// 保存编辑
	public String edit() {
		if (teacher != null) {
			teacherService.update(teacher);
		}
		return "list";
	}

	// 删除
	public String delete() {
		if (teacher != null && teacher.getId() != null) {
			teacherService.delete(teacher.getId());
		}
		return "list";
	}

	public TeacherService getTeacherService() {
		return teacherService;
	}

	public void setTeacherService(TeacherService teacherService) {
		this.teacherService = teacherService;
	}

	public List<Teacher> getTeacherList() {
		return teacherList;
	}

	public void setTeacherList(List<Teacher> teacherList) {
		this.teacherList = teacherList;
	}

	public Teacher getTeacher() {
		return teacher;
	}

	public void setTeacher(Teacher teacher) {
		this.teacher = teacher;
	}
}
