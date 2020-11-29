package com.neu.wms.service;

import java.util.List;

import com.neu.wms.domain.User;
import com.neu.wms.query.UserQuery;

public interface UserService {
	User login(String loginName,String password);

	List<User> findByQuery(UserQuery userQuery);

	long findCount(UserQuery userQuery);

	int add(User user);

	int delete(int[] id);

	User findById(int id);

	int update(User user);

	int bind(int userId, int[] role);

	int findCountByLoginName(String loginName);
}
