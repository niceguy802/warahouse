package com.neu.wms.domain;

import com.neu.wms.domain.base.BaseDomain;

public class IncomeItem extends BaseDomain{

    private Integer costPrice;

    private Integer number;

    private Integer amount;

    private String productName;

    private Integer productId;

    private Integer bookItemId;

    private Integer incomeId;

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

	public Integer getBookItemId() {
		return bookItemId;
	}

	public void setBookItemId(Integer bookItemId) {
		this.bookItemId = bookItemId;
	}

	public Integer getIncomeId() {
		return incomeId;
	}

	public void setIncomeId(Integer incomeId) {
		this.incomeId = incomeId;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
}