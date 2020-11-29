package com.neu.wms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.neu.wms.domain.User;
import com.neu.wms.query.UserQuery;

public interface UserMapper {
	
	User login(@Param("loginName") String loginName,@Param("password") String password);

	List<User> findByQuery(UserQuery userQuery);

	long findCount(UserQuery userQuery);

	int add(User user);

	int delete(int[] id);

	User findById(int id);

	int update(User user);

	//#{userId},#{roleId})
	int bind(@Param("userId") int userId,@Param("roleId")int roleId);
	
	int unbind(int userId);

	int findCountByLoginName(String loginName);

}
