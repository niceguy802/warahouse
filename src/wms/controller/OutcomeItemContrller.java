package com.neu.wms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neu.wms.domain.OutcomeItem;
import com.neu.wms.query.OutcomeItemQuery;
import com.neu.wms.service.OutcomeItemService;
import com.neu.wms.utils.JsonModel;

@Controller
@RequestMapping("outcomeItems")
public class OutcomeItemContrller {
	
	@Autowired
	OutcomeItemService outcomeItemService;
	
	/**
	 * 列表界面
	 * @return
	 */
	@RequestMapping(value="listUI",method=RequestMethod.GET)
	public String listUI() {
		return "outcomeItem/list";
	}
	@RequestMapping(value="list",method=RequestMethod.GET)
	@ResponseBody
	public JsonModel list(OutcomeItemQuery outcomeItemQuery) {
		JsonModel jsonModel = new JsonModel();
		List<OutcomeItem> outcomeItems = outcomeItemService.findByQuery(outcomeItemQuery);
		long count = outcomeItemService.findCount(outcomeItemQuery);
		jsonModel.setCount(count);
		jsonModel.setData(outcomeItems);
		jsonModel.setSuccess(true);
		jsonModel.setMsg("查找明细成功");
		return jsonModel;
	}
	@RequestMapping(value="statis/product",method=RequestMethod.GET)
	@ResponseBody
	public JsonModel statisOut() { 
		JsonModel jsonModel = new JsonModel();		 
		jsonModel.setSuccess(true);
		jsonModel.setData(outcomeItemService.statisOut());
		return jsonModel;
	}
}
