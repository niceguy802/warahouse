package com.neu.wms.query;

import com.neu.wms.query.base.BaseQuery;

public class UserQuery extends BaseQuery{
	
	//前台会提交name loginName
	private String name;
	private String loginName;
	 
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
}