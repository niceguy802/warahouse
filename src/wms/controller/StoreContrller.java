package com.neu.wms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neu.wms.domain.Store;
import com.neu.wms.query.StoreQuery;
import com.neu.wms.service.StoreService;
import com.neu.wms.utils.JsonModel;
import com.neu.wms.utils.RemoteModel;

@Controller
@RequestMapping("stores")
public class StoreContrller {
	
	@Autowired
	StoreService storeService;
	 
	
	/**
	 * 列表界面
	 * @return
	 */
	@RequestMapping(value="listUI",method=RequestMethod.GET)
	public String listUI() {
		return "store/list";
	}
	
	
	@RequestMapping(value="list",method=RequestMethod.GET)
	@ResponseBody
	public JsonModel list(StoreQuery storeQuery) { //StoreQuery:封装了查询参数
		JsonModel jsonModel = new JsonModel();
		 
		List<Store> stores = storeService.findByQuery(storeQuery);
		
		long count = storeService.findCount(storeQuery);
		jsonModel.setCount(count);
		jsonModel.setData(stores);
		jsonModel.setSuccess(true);
		jsonModel.setMsg("查找成功");
		return jsonModel;
	}
	
	@RequestMapping(value="add",method=RequestMethod.GET)
	public String add(Model model) {
		return "store/add";
	}
	 
	
	@RequestMapping(value="add",method=RequestMethod.POST)
	public String add(Store store) {
		//调用service
		storeService.add(store);
		return "redirect:/stores/listUI";
	}
	
	
	/**
	   *  删除
	 * @param id
	 * @return
	 */
	@RequestMapping(value="delete",method=RequestMethod.POST)
	@ResponseBody
	public JsonModel delete(int [] id) {
		storeService.delete(id);
		JsonModel jsonModel = new JsonModel();
		jsonModel.setSuccess(true);
		jsonModel.setMsg("删除成功");
		return jsonModel;
	}
	
	
	@RequestMapping(value="edit",method=RequestMethod.GET)
	public String edit(int id,Model model) {
		Store store = storeService.findById(id);
		model.addAttribute("store",store);
		return "store/edit";
	}
	
	@RequestMapping(value="edit",method=RequestMethod.POST)
	public String edit(Store store) {
		storeService.update(store);
		return "redirect:/stores/listUI";
	}
	
	@RequestMapping(value="validate/name",method=RequestMethod.GET)
	@ResponseBody
	public RemoteModel validateLoginName(String name) {
		int count = storeService.findCountByLoginName(name);
		
		RemoteModel remoteModel = new RemoteModel();
		
		remoteModel.setValid(count==0);
		return remoteModel;
	}
	
}
