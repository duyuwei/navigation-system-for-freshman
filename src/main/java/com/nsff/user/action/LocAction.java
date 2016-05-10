package com.nsff.user.action;

import java.util.List;

import javax.annotation.Resource;

import com.nsff.user.entity.Loc;
import com.nsff.user.service.LocService;
import com.opensymphony.xwork2.ActionSupport;

public class LocAction extends ActionSupport {

	@Resource
	private LocService locService;
	
	private List<Loc> locs;
	private Loc loc;

	

	// 列表页面
	public String listUI() {
		locs = locService.findObjects();
		return "listUI";
	}

	// 跳转到新增页面
	public String addUI() {
		return "addUI";
	}

	// 保存新增
	public String add() {
		if (loc != null) {
			locService.save(loc);
		}
		return "list";
	}

	// 跳转到编辑页面
	public String editUI() {
		if (loc != null && loc.getId() != null) {
			loc = locService.findObjectById(loc.getId());
		}
		return "editUI";
	}

	// 保存编辑
	public String edit() {
		if (loc != null) {
			locService.update(loc);
		}
		return "list";
	}

	// 删除
	public String delete() {
		if (loc != null && loc.getId() != null) {
			locService.delete(loc.getId());
		}
		return "list";
	}

	
	public LocService getLocService() {
		return locService;
	}

	public void setLocService(LocService locService) {
		this.locService = locService;
	}

	public List<Loc> getLocs() {
		return locs;
	}

	public void setLocs(List<Loc> locs) {
		this.locs = locs;
	}

	public Loc getLoc() {
		return loc;
	}

	public void setLoc(Loc loc) {
		this.loc = loc;
	}

}
