package com.neu.wms.dao;

import java.util.List;

import com.neu.wms.dao.base.BaseMapper;
import com.neu.wms.domain.Dept;
import com.neu.wms.domain.IncomeItem;
import com.neu.wms.query.DeptQuery;
import com.neu.wms.query.IncomeItemQuery;

public interface IncomeItemMapper extends BaseMapper<IncomeItem,IncomeItemQuery> {
	int deleteByIncomeid(int[] id);
	List<IncomeItem> getBuyIncomeId(Integer incomeId);
}