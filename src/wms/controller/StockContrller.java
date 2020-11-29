package com.neu.wms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neu.wms.domain.Stock;
import com.neu.wms.query.StockQuery;
import com.neu.wms.service.StockService;
import com.neu.wms.utils.JsonModel;

@Controller
@RequestMapping("stocks")
public class StockContrller {
	
	@Autowired
	StockService stockService;
	 
	 
	@RequestMapping(value="listUI",method=RequestMethod.GET)
	public String listUI() {
		return "stock/list";
	}
	
	
	@RequestMapping(value="list",method=RequestMethod.GET)
	@ResponseBody
	public JsonModel list(StockQuery stockQuery) { 
		JsonModel jsonModel = new JsonModel();
		 
		List<Stock> stocks = stockService.findByQuery(stockQuery);
		
		long count = stockService.findCount(stockQuery);
		jsonModel.setCount(count);
		jsonModel.setData(stocks);
		jsonModel.setSuccess(true);
		return jsonModel;
	}
	
	@RequestMapping(value="statis/product",method=RequestMethod.GET)
	@ResponseBody
	public JsonModel statisProductStock() { 
		JsonModel jsonModel = new JsonModel();		 
		jsonModel.setSuccess(true);
		jsonModel.setData(stockService.statisProductStock());
		return jsonModel;
	}
}
