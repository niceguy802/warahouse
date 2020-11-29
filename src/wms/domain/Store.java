package com.neu.wms.domain;

import com.neu.wms.domain.base.BaseDomain;

public class Store extends BaseDomain{


    private String name;
 

    private String address;
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}