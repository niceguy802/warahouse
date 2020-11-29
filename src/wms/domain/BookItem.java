package com.neu.wms.domain;

import com.neu.wms.domain.base.BaseDomain;

public class BookItem extends BaseDomain{

    private Integer costPrice;

    private Integer number;
    
    private Integer input;

    private Integer amount;

    private Integer productId;
    
    private String productName;

    private Integer bookId;
    
    private String bookSn;

    private String remark;

	public Integer getCostPrice() {
		return costPrice;
	}

	public void setCostPrice(Integer costPrice) {
		this.costPrice = costPrice;
	}

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Integer getBookId() {
		return bookId;
	}

	public void setBookId(Integer bookId) {
		this.bookId = bookId;
	}
	
	public String getBookSn() {
		return bookSn;
	}

	public void setBookSn(String bookSn) {
		this.bookSn = bookSn;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getInput() {
		return input;
	}

	public void setInput(Integer input) {
		this.input = input;
	}

    
}