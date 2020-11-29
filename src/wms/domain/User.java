package com.neu.wms.domain;

public class User {
	
	private Integer id;
	private String name;
	private String loginName;
	private String password;
	private Byte status;
	private String header;
	
	//关系在表中是通过主外键来体现的
	//关系在面向对象是通过包含来体现的
	
	private Dept dept;

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", loginName=" + loginName + ", password=" + password + ", status="
				+ status + ", header=" + header + ", dept=" + dept + "]";
	}

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

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Byte getStatus() {
		return status;
	}

	public void setStatus(int status2) {
		this.status = (byte) status2;
	}

	public String getHeader() {
		return header;
	}

	public void setHeader(String header) {
		this.header = header;
	}

	public Dept getDept() {
		return dept;
	}

	public void setDept(Dept dept) {
		this.dept = dept;
	}
}
