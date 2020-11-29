package com.neu.wms.service;

import java.util.List;

import com.neu.wms.domain.IncomeItem;
import com.neu.wms.query.IncomeItemQuery;
import com.neu.wms.service.base.BaseService;

public interface IncomeItemService extends BaseService<IncomeItem,IncomeItemQuery> {
	int deleteByIncomeid(int[] id);
	List<IncomeItem> getBuyIncomeId(Integer incomeId);

}
