package com.neu.wms.service;

import java.util.List;

import com.neu.wms.domain.Role;
import com.neu.wms.query.RoleQuery;

public interface RoleService {
	 
	List<Role> findByQuery(RoleQuery roleQuery);

	long findCount(RoleQuery roleQuery);

	int add(Role role);

	int delete(int[] id);

	Role findById(int id);

	int update(Role role);

	List<Role> findRoleByUserId(int userId);

	int findCountByLoginName(String name);
}
