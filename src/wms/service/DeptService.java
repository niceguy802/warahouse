package com.neu.wms.service;

import java.util.List;

import com.neu.wms.domain.Dept;
import com.neu.wms.query.DeptQuery;

public interface DeptService {
	
	List<Dept> findByQuery(DeptQuery deptQuery);

	long findCount(DeptQuery deptQuery);

	int add(Dept dept);

	int delete(int[] id);

	int update(Dept dept);

	Dept findById(int id);

	int findCountByname(String name);

	int findCountByLoginName(String name);
}
