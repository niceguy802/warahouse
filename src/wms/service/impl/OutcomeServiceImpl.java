package com.neu.wms.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.neu.wms.dao.OutcomeMapper;
import com.neu.wms.domain.BookItem;
import com.neu.wms.domain.Outcome;
import com.neu.wms.domain.OutcomeItem;
import com.neu.wms.domain.Product;
import com.neu.wms.domain.Store;
import com.neu.wms.query.OutcomeQuery;
import com.neu.wms.service.BookItemService;
import com.neu.wms.service.OutcomeItemService;
import com.neu.wms.service.OutcomeService;
import com.neu.wms.service.ProductService;
import com.neu.wms.service.StockService;

@Service
public class OutcomeServiceImpl implements OutcomeService {
	
	@Autowired
	OutcomeMapper outcomeMapper;
	
	@Autowired
	ProductService productService;
	
	@Autowired
	ProductService storeService;
	
	
	@Autowired
	OutcomeItemService outcomeItemService;
	 

	@Override
	public List<Outcome> findByQuery(OutcomeQuery outcomeQuery) {
		return outcomeMapper.findByQuery(outcomeQuery);
	}

	@Override
	public long findCount(OutcomeQuery outcomeQuery) {
	    return outcomeMapper.findCount(outcomeQuery);
	}

	@Override
	public int add(Outcome outcome) {
		//TODO ....  //和入库  采购订单几乎一样
		    
		int totalAmount = 0;
		int totalNumber = 0;
		
		List<OutcomeItem> outcomeItems = outcome.getOutcomeItems();
		for(OutcomeItem outcomeItem : outcomeItems) {
			outcomeItem.setAmount(outcomeItem.getSalePrice()*outcomeItem.getNumber());
//			outcomeItem.getSalePrice();
			totalNumber += outcomeItem.getNumber();
			totalAmount += outcomeItem.getAmount();
		}
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String orderSN = simpleDateFormat.format(new Date());
		outcome.setSn(orderSN);
		outcome.setCreateTime(new Date());
		outcome.setStatus((byte)1);
		outcome.setTotalAmount(totalAmount);
		outcome.setTotalNumber(totalNumber); 
		int result = outcomeMapper.add(outcome);
		int id = outcome.getId();
		for(OutcomeItem outcomeItem : outcomeItems) {
	  	   outcomeItem.setId(id);
			outcomeItem.setoutSn(orderSN);
			outcomeItemService.add(outcomeItem);
		}
	    return result;
	}

	@Override
	public int delete(int[] id) {
		return outcomeMapper.delete(id);
	}

	@Override
	public Outcome findById(int id) {
		return outcomeMapper.findById(id);
	}

	@Override
	public int update(Outcome outcome) {
		return outcomeMapper.update(outcome);
	}
}
