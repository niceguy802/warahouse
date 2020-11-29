package com.neu.wms.dao;

import java.util.List;
import java.util.Map;

import com.neu.wms.dao.base.BaseMapper;
import com.neu.wms.domain.IncomeItem;
import com.neu.wms.domain.OutcomeItem;
import com.neu.wms.query.OutcomeItemQuery;

public interface OutcomeItemMapper extends BaseMapper<OutcomeItem,OutcomeItemQuery> {
	List<Map<String,String>> statisOut();
	List<OutcomeItem> getBuyOutcomeId(String outSn);
	int deleteByOutcomeSn(String[] sn);
	
}