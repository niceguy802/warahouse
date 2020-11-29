package com.neu.wms.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neu.wms.dao.StockMapper;
import com.neu.wms.domain.Stock;
import com.neu.wms.query.StockQuery;
import com.neu.wms.service.StockService;

@Service
public class StockServiceImpl implements StockService {
	
	@Autowired
	StockMapper stockMapper;
 

	@Override
	public List<Stock> findByQuery(StockQuery stockQuery) {
		return stockMapper.findByQuery(stockQuery);
	}

	@Override
	public long findCount(StockQuery stockQuery) {
	    return stockMapper.findCount(stockQuery);
	}

	@Override
	public int add(Stock stock) {
	    return stockMapper.add(stock);
	}
	

	@Override
	public int delete(int[] id) {
	return stockMapper.delete(id);
	}

	
	@Override
	public Stock findById(int id) {
		//return stockMapper.findById(id);
		return null;
	}

	@Override
	public int update(Stock stock) {
		return stockMapper.update(stock);
	}

	@Override
	public List<Map<String, String>> statisProductStock() {
		// TODO Auto-generated method stub
		return stockMapper.statisProductStock();		
	}

	@Override
	public int updateLess(Stock stock) {
		// TODO Auto-generated method stub
		return stockMapper.updateLess(stock);		
		
	}
}

