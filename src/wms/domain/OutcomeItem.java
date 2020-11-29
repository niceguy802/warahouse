package com.neu.wms.domain;

import com.neu.wms.domain.base.BaseDomain;

public class OutcomeItem extends BaseDomain{

    private Integer salePrice;

    private Integer number;

    private Integer amount;

    private Integer productId;

    private String outSn;

	public Integer getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(Integer salePrice) {
		this.salePrice = salePrice;
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

	public String getoutSn() {
		return outSn;
	}

	public void setoutSn(String outSn) {
		this.outSn = outSn;
	}
}