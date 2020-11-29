package com.neu.wms.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.neu.wms.domain.base.BaseDomain;

public class Income extends BaseDomain{

    private String sn;

    private Integer totalAmount;

    private Integer totalNumber;

    private Integer makeUserId;

    private Integer bookId;

    private Integer storeId;
    
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date createDate;
    
    private List<IncomeItem> incomeItems = new ArrayList<IncomeItem>();

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

	public Integer getMakeUserId() {
		return makeUserId;
	}

	public void setMakeUserId(Integer makeUserId) {
		this.makeUserId = makeUserId;
	}

	public Integer getBookId() {
		return bookId;
	}

	public void setBookId(Integer bookId) {
		this.bookId = bookId;
	}

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}
	
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public List<IncomeItem> getIncomeItems() {
		return incomeItems;
	}

	public void setIncomeItems(List<IncomeItem> incomeItems) {
		this.incomeItems = incomeItems;
	}
}