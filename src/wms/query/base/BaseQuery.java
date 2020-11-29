package com.neu.wms.query.base;

public class BaseQuery {
	 
	private int offset;         //跳过前面多少条 (offset=(page-1)*pageSize)
	private int pageSize=5;     //每页显示多少条
    private String name;
	 
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
}
