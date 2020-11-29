package com.neu.wms.query;

import com.neu.wms.query.base.BaseQuery;

public class OutcomeItemQuery extends BaseQuery{
	 
	private String outSn;  //出库单的编号

	public String getOutSn() {
		return outSn;
	}

	public void setOutSn(String outSn) {
		this.outSn = outSn;
	}
}