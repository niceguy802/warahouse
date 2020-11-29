package com.neu.wms.query;

import com.neu.wms.query.base.BaseQuery;

public class StockQuery extends BaseQuery{
	
	private Integer storeId;    //仓库编号
	private Integer productId;
	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}
	
	
	
}