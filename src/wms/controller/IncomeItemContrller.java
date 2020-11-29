package com.neu.wms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neu.wms.domain.IncomeItem;
import com.neu.wms.query.IncomeItemQuery;
import com.neu.wms.service.IncomeItemService;
import com.neu.wms.utils.JsonModel;

@Controller
@RequestMapping("incomeItems")
public class IncomeItemContrller {
	
	@Autowired
	IncomeItemService incomeItemService;
	
	/**
	 * 列表界面
	 * @return
	 */
	@RequestMapping(value="listUI",method=RequestMethod.GET)
	public String listUI() {
		return "incomeItem/list";
	}
	
	
	@RequestMapping(value="list",method=RequestMethod.GET)
	@ResponseBody
	public JsonModel list(IncomeItemQuery incomeItemQuery) { //IncomeItemQuery:封装了查询参数
		JsonModel jsonModel = new JsonModel();
		 
		List<IncomeItem> incomeItems = incomeItemService.findByQuery(incomeItemQuery);
		
		long count = incomeItemService.findCount(incomeItemQuery);
		jsonModel.setCount(count);
		jsonModel.setData(incomeItems);
		jsonModel.setSuccess(true);
		jsonModel.setMsg("查找订单明细成功");
		return jsonModel;
	}
}
