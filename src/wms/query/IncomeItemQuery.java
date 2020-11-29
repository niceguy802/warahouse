package com.neu.wms.query;

import com.neu.wms.query.base.BaseQuery;

public class IncomeItemQuery extends BaseQuery{
	 
	private String incomeId;  //送货单的编号

	public String getIncomeSn() {
		return incomeId;
	}

	public void setIncomeId(String incomeId) {
		this.incomeId = incomeId;
	}
 
	
}