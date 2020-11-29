package com.neu.wms.domain;

import com.neu.wms.domain.base.BaseDomain;

public class Supplier  extends BaseDomain{

	private String phone;

    private String address;

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
  
}