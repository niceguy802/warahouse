package com.neu.wms.service;

import java.util.List;
import java.util.Map;

import com.neu.wms.domain.Stock;
import com.neu.wms.query.StockQuery;
import com.neu.wms.service.base.BaseService;

public interface StockService extends BaseService<Stock,StockQuery> {
 
	List<Map<String,String>> statisProductStock();
	
	int updateLess(Stock  stock);

}