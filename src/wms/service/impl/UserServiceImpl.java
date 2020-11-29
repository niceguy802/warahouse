package com.neu.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neu.wms.dao.UserMapper;
import com.neu.wms.domain.User;
import com.neu.wms.query.UserQuery;
import com.neu.wms.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserMapper userMapper;

	@Override
	public User login(String loginName, String password) {
		return userMapper.login(loginName, password);
	}

	@Override
	public List<User> findByQuery(UserQuery userQuery) {
		return userMapper.findByQuery(userQuery);
	}

	@Override
	public long findCount(UserQuery userQuery) {
	    return userMapper.findCount(userQuery);
	}

	@Override
	public int add(User user) {
		//添加默认的密码
		//默认的状态
		user.setPassword("123456");
		user.setStatus((byte)1);
		System.out.println("service : " + user.getStatus());
	    return userMapper.add(user);
	}

	@Override
	public int delete(int[] id) {
		return userMapper.delete(id);
	}

	@Override
	public User findById(int id) {
		return userMapper.findById(id);
	}

	@Override
	public int update(User user) {
		return userMapper.update(user);
	}

	@Override
	public int bind(int userId, int[] role) {
		
		userMapper.unbind(userId);
		for(int tempRole : role) {
			userMapper.bind(userId,tempRole);
		}
		return 1;
	}

	@Override
	public int findCountByLoginName(String loginName) {
		return userMapper.findCountByLoginName(loginName) ;
	}
}
