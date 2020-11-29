package com.neu.wms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neu.wms.domain.BookItem;
import com.neu.wms.query.BookItemQuery;
import com.neu.wms.service.BookItemService;
import com.neu.wms.utils.JsonModel;

@Controller
@RequestMapping("bookItems")
public class BookItemContrller {
	
	@Autowired
	BookItemService bookItemService;
	
	/**
	 * 列表界面
	 * @return
	 */
	@RequestMapping(value="listUI",method=RequestMethod.GET)
	public String listUI() {
		
		return "bookItem/list";
	}
	
	@RequestMapping(value="list",method=RequestMethod.GET)
	@ResponseBody
	public JsonModel list(BookItemQuery bookItemQuery) { //BookItemQuery:封装了查询参数
		JsonModel jsonModel = new JsonModel();	 
		List<BookItem> bookItems = bookItemService.findByQuery(bookItemQuery);
		long count = bookItemService.findCount(bookItemQuery);
		jsonModel.setCount(count);
		jsonModel.setData(bookItems);
		jsonModel.setSuccess(true);
		jsonModel.setMsg("查找订单明细成功");
		return jsonModel;
	}
	/**
	   * 报表
	 * @return
	 */
	@RequestMapping(value="statis/product",method=RequestMethod.GET)
	@ResponseBody
	public JsonModel statisBook() { 
		JsonModel jsonModel = new JsonModel();
		
		jsonModel.setSuccess(true);
		jsonModel.setData(bookItemService.statisBook());
		return jsonModel;
		
	}
}
