package com.nsff.core.dao;

import java.io.Serializable;
import java.util.List;

public interface BaseDao<T> {
	
	public void save(T entity);
	public void delete(Serializable id);
	public void update(T entity);
	public T findObjectById(Serializable id);
	public List<T> findObjects();
	
}
