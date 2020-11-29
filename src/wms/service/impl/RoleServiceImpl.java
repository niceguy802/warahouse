package com.neu.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neu.wms.dao.RoleMapper;
import com.neu.wms.domain.Role;
import com.neu.wms.query.RoleQuery;
import com.neu.wms.service.RoleService;

@Service
public class RoleServiceImpl implements RoleService {
	
	@Autowired
	RoleMapper roleMapper;
 

	@Override
	public List<Role> findByQuery(RoleQuery roleQuery) {
		return roleMapper.findByQuery(roleQuery);
	}

	@Override
	public long findCount(RoleQuery roleQuery) {
	    return roleMapper.findCount(roleQuery);
	}

	@Override
	public int add(Role role) {
	    return roleMapper.add(role);
	}

	@Override
	public int delete(int[] id) {
		return roleMapper.delete(id);
	}

	@Override
	public Role findById(int id) {
		return roleMapper.findById(id);
	}

	@Override
	public int update(Role role) {
		return roleMapper.update(role);
	}

	@Override
	public List<Role> findRoleByUserId(int userId) {
		return roleMapper.findRoleByUserId(userId);
	}

	@Override
	public int findCountByLoginName(String name) {
		// TODO Auto-generated method stub
		return roleMapper.findCountByLoginName(name);
	}
}
