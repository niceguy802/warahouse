package com.neu.wms.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.neu.wms.domain.base.BaseDomain;

public class Stock extends BaseDomain{
	
	private Integer storeCount;
	
	private Date incomeDate;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
	private Date outcomeDate;
	
	private String productName;
	private String storeName;
	private Integer productId;
	private Integer storeId;

	public Integer getStoreCount() {
		return storeCount;
	}
	public void setStoreCount(Integer storeCount) {
		this.storeCount = storeCount;
	}
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
	public Date getIncomeDate() {
		return incomeDate;
	}
	public void setIncomeDate(Date incomeDate) {
		this.incomeDate = incomeDate;
	}
	public Date getOutcomeDate() {
		return outcomeDate;
	}
	public void setOutcomeDate(Date outcomeDate) {
		this.outcomeDate = outcomeDate;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public Integer getProductId() {
		return productId;
	}
	public void setProductId(Integer productId) {
		this.productId = productId;
	}
	public Integer getStoreId() {
		return storeId;
	}
	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
}
