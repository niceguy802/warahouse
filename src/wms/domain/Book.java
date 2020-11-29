package com.neu.wms.domain;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.neu.wms.domain.base.BaseDomain;

public class Book extends BaseDomain{

    private String sn;

    private Integer totalAmount;

    private Integer totalCount;

    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date createDate;

    private Integer makeUserId;

    private Integer supplierId;

    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date finishDate;

    private Byte status;  //0:未审核  1:已审核  2:已完成
    
    private List<BookItem> bookItems = new ArrayList<>();

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

	public Integer getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Integer getMakeUserId() {
		return makeUserId;
	}

	public void setMakeUserId(Integer makeUserId) {
		this.makeUserId = makeUserId;
	}

	public Integer getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
	}

	public Date getFinishDate() {
		return finishDate;
	}

	public void setFinishDate(Date finishDate) {
		this.finishDate = finishDate;
	}

	public Byte getStatus() {
		return status;
	}

	public void setStatus(Byte status) {
		this.status = status;
	}

	public List<BookItem> getBookItems() {
		return bookItems;
	}

	public void setBookItems(List<BookItem> bookItems) {
		this.bookItems = bookItems;
	}
 
    
}