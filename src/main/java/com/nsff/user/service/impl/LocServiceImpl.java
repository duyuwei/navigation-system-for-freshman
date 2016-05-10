package com.nsff.user.service.impl;

import java.io.Serializable;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nsff.user.dao.LocDao;
import com.nsff.user.entity.Loc;
import com.nsff.user.service.LocService;

@Service("locService")
public class LocServiceImpl implements LocService {

	@Resource
	private LocDao locDao;

	@Override
	public void save(Loc loc) {
		locDao.save(loc);
	}

	@Override
	public void update(Loc loc) {
		locDao.update(loc);
	}

	@Override
	public void delete(Serializable id) {
		locDao.delete(id);
	}

	@Override
	public Loc findObjectById(Serializable id) {
		return locDao.findObjectById(id);
	}

	@Override
	public List<Loc> findObjects() {
		return locDao.findObjects();
	}

}
