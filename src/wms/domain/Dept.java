package com.neu.wms.domain;

public class Dept {
    private Integer id;

    private String name;

    private Integer parentId;
    
    //关系在数据库中是通过主外键来表示的
    //关系在面向对象中是通过包含来表示的
    
    

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

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