package com.nsff.student.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

import com.nsff.core.Util.JsonUtil;
import com.nsff.core.constant.Constant;
import com.nsff.student.entity.Student;
import com.nsff.student.service.StudentService;
import com.nsff.user.entity.Loc;
import com.nsff.user.service.LocService;
import com.opensymphony.xwork2.ActionSupport;

public class StudentAction extends ActionSupport {

	@Resource
	private StudentService studentService;
	
	@Resource
	private LocService locService;
	
	private List<Student> students;
	private Student student;
	
	private Loc loc;

	

	/**
	 * 返回JSON结果
	 */
	protected Map<String, Object> json = new HashMap<String, Object>();

	public String listUI() {
		students = studentService.findObjects();

		return "listUI";
	}
	
	

	
	/**
	 * 异步登陆
	 */
	public void login() {
		if (student != null) {
			if (StringUtils.isNotBlank(student.getId()) && StringUtils.isNotBlank(student.getName())) {
				// 根据用户的帐号和密码查询用户列表
				List<Student> list = studentService.findUserByAccountAndPass(student.getId(), student.getName());
				if (list != null && list.size() > 0) {// 说明登录成功
					// 2.1、登录成功
					Student student = list.get(0);
					// 2.1.2、将用户信息保存到session中
					ServletActionContext.getRequest().getSession().setAttribute(Constant.USER, student);
					// 2.1.3、将用户登录记录到日志文件
					Log log = LogFactory.getLog(getClass());
					log.info("用户名称为：" + student.getName() + " 的用户登录了系统。");
					// 2.1.4、异步发送成功信息
					json.put("result", "success");
					json.put("msg", "登陆成功！");
				} else {// 登录失败
					json.put("result", "false");
					json.put("msg", "帐号或密码不正确！");
				}
			} else {
				json.put("result", "false");
				json.put("msg", "帐号或密码不能为空！");
			}
		} else {
			json.put("result", "false");
			json.put("msg", "帐号或密码不能为空！");
		}
		JsonUtil.fromMapToJson(json, ServletActionContext.getResponse());
	}
	
	public void getLocByStep(){
		//0未开始，1绿色通道，2交费处，3报到点，4宿舍，5报道导航完成
		//根据session中的studentID获取数据库中studen的信息；
		Student studentSession=(Student) ServletActionContext.getContext().getSession().get(Constant.USER);
		Student studentFromTheBD=studentService.findObjectById(studentSession.getId());
		//获得json传送过来的step（存储在student中）
		int step=student.getStep();
		String LocID=null;
		//获取位置ID
		switch (step) {
		case 0:
			
			break;
		case 1:
			//如果是绿色通道，导航到学院位置。
			LocID=studentFromTheBD.getGrade().getCollege().getLocID();
			break;

		case 2:
			//如果是交费处，导航到交费处位置。
			LocID="402880e84f83dbdd014f83f8f6910001";
			break;
			
		case 3:
			//如果是接待处
			LocID=studentFromTheBD.getGrade().getCollege().getRegisterID();
			break;
			
		case 4:
			//如果是宿舍
			LocID=studentFromTheBD.getDormID();
			break;
			
		default:
			break;
			
		
		}
		if (StringUtils.isNotBlank(LocID)) {
			Loc locFromDB = locService.findObjectById(LocID);
			json.put(Constant.LOCX, locFromDB.getLocX());
			json.put(Constant.LOCY, locFromDB.getLocY());
			JsonUtil.fromMapToJson(json, ServletActionContext.getResponse());
		}
	}
	
	public void setStep(){
		Student studentSession=(Student) ServletActionContext.getContext().getSession().get(Constant.USER);
		Student studentToSave=studentService.findObjectById(studentSession.getId());
		int step=student.getStep();
		studentToSave.setStep(step);
		studentService.update(studentToSave);
	}
	
	public void getStep(){
		Student studentSession=(Student) ServletActionContext.getContext().getSession().get(Constant.USER);
		Student studentToSave=studentService.findObjectById(studentSession.getId());
		int step=studentToSave.getStep();
		json.put(Constant.STEP, step);
		JsonUtil.fromMapToJson(json, ServletActionContext.getResponse());

	}
	
	

	public StudentService getStudentService() {
		return studentService;
	}

	public void setStudentService(StudentService studentService) {
		this.studentService = studentService;
	}

	public List<Student> getStudents() {
		return students;
	}

	public void setStudents(List<Student> students) {
		this.students = students;
	}

	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}

	public Loc getLoc() {
		return loc;
	}


	public void setLoc(Loc loc) {
		this.loc = loc;
	}
}
