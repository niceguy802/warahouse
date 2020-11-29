package com.neu.wms.service;

import java.util.List;
import java.util.Map;

import com.neu.wms.domain.IncomeItem;
import com.neu.wms.domain.OutcomeItem;
import com.neu.wms.query.OutcomeItemQuery;
import com.neu.wms.service.base.BaseService;

public interface OutcomeItemService extends BaseService<OutcomeItem,OutcomeItemQuery> {
	List<Map<String,String>> statisOut();
	List<OutcomeItem> getBuyOutcomeId(String outSn);
	int deleteByOutcomeSn(String[] sn);

}
