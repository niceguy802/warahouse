package com.neu.wms.dao;

import java.util.List;
import java.util.Map;

import com.neu.wms.dao.base.BaseMapper;
import com.neu.wms.domain.Stock;
import com.neu.wms.query.StockQuery;

public interface StockMapper extends BaseMapper<Stock,StockQuery> {
	
	List<Map<String,String>> statisProductStock();
	int updateLess(Stock  stock);
}