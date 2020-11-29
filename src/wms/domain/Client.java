package com.neu.wms.domain;

import com.neu.wms.domain.base.BaseDomain;

public class Client  extends BaseDomain{


    private String phone;

    private String sn;

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}
}