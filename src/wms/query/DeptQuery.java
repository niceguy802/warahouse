package com.neu.wms.query;

import com.neu.wms.query.base.BaseQuery;

public class DeptQuery extends BaseQuery{
	 
	private String name;
	
	private Integer parentId;   //父部门的id
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
}
