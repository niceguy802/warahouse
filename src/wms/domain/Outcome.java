package com.neu.wms.domain;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.neu.wms.domain.base.BaseDomain;

public class Outcome extends BaseDomain{

    private String sn;

    private Integer totalAmount;

    private Integer totalNumber;

    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    private Integer userId;

    private Integer storeId;

    private Integer clientId;

    private Byte status;   //0:未出库  1:已出库
    
    private List<OutcomeItem> outcomeItems = new ArrayList<OutcomeItem>();

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public Integer getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(Integer totalAmount) {
		this.totalAmount = totalAmount;
	}

	public Integer getTotalNumber() {
		return totalNumber;
	}

	public void setTotalNumber(Integer totalNumber) {
		this.totalNumber = totalNumber;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public Integer getClientId() {
		return clientId;
	}

	public void setClientId(Integer clientId) {
		this.clientId = clientId;
	}

	public Byte getStatus() {
		return status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

	public List<OutcomeItem> getOutcomeItems() {
		return outcomeItems;
	}

	public void setOutcomeItems(List<OutcomeItem> outcomeItems) {
		this.outcomeItems = outcomeItems;
	}
}
    