package com.neu.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neu.wms.dao.DeptMapper;
import com.neu.wms.domain.Dept;
import com.neu.wms.query.DeptQuery;
import com.neu.wms.service.DeptService;

@Service
public class DeptServiceImpl implements DeptService {
	
	@Autowired
	DeptMapper deptMapper;

	@Override
	public List<Dept> findByQuery(DeptQuery deptQuery) {
		return deptMapper.findByQuery(deptQuery);
	}

	@Override
	public long findCount(DeptQuery deptQuery) {
	    return deptMapper.findCount(deptQuery);
	}

	@Override
	public int add(Dept dept) {
	    return deptMapper.add(dept);
	}

	@Override
	public int delete(int[] id) {
		return deptMapper.delete(id);
	}

	@Override
	public int update(Dept dept) {
		return deptMapper.update(dept);
	}

	@Override
	public Dept findById(int id) {
		return deptMapper.findById(id);
	}

	@Override
	public int findCountByname(String name) {
		// TODO Auto-generated method stub
		return deptMapper.findCountByname(name);
	}

	@Override
	public int findCountByLoginName(String name) {
		// TODO Auto-generated method stub
		return deptMapper.findCountByLoginName(name);
	}
}
