package com.nsff.user.service;

import java.io.Serializable;
import java.util.List;

import com.nsff.user.entity.Loc;

public interface LocService {
	// 新增
	public void save(Loc loc);

	// 更新
	public void update(Loc loc);

	// 根据id删除O
	public void delete(Serializable id);

	// 根据id查找
	public Loc findObjectById(Serializable id);

	// 查找列表
	public List<Loc> findObjects();
}
