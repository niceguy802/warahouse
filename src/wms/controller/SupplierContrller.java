package com.neu.wms.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.neu.wms.domain.Supplier;
import com.neu.wms.query.SupplierQuery;
import com.neu.wms.service.SupplierService;
import com.neu.wms.utils.JsonModel;

@Controller
@RequestMapping("suppliers")
public class SupplierContrller {
	
	@Autowired
	SupplierService supplierService;
	
	/**
	 * 列表界面
	 * @return
	 */
	@RequestMapping(value="listUI",method=RequestMethod.GET)
	public String listUI() {
		return "supplier/list";
	}

	@RequestMapping(value="list",method=RequestMethod.GET)
	@ResponseBody
	public JsonModel list(SupplierQuery supplierQuery) { //SupplierQuery:封装了查询参数
		JsonModel jsonModel = new JsonModel();	 
		List<Supplier> suppliers = supplierService.findByQuery(supplierQuery);
		
		//查询当前条件下的总的记录数	
		long count = supplierService.findCount(supplierQuery);
		jsonModel.setCount(count);
		jsonModel.setData(suppliers);
		jsonModel.setSuccess(true);
		jsonModel.setMsg("查找品牌成功");
		return jsonModel;
	}
	
	@RequestMapping(value="add",method=RequestMethod.GET)
	public String add(Model model) {
		return "supplier/add";
	}

	@RequestMapping(value="add",method=RequestMethod.POST)
	public String add(Supplier supplier) {
		//调用service
		supplierService.add(supplier);
		return "redirect:/suppliers/listUI";
	}

	/**
	   *  删除
	 * @param id
	 * @return
	 */
	@RequestMapping(value="delete",method=RequestMethod.POST)
	@ResponseBody
	public JsonModel delete(int [] id) {
		supplierService.delete(id);
		JsonModel jsonModel = new JsonModel();
		jsonModel.setSuccess(true);
		jsonModel.setMsg("删除成功");
		return jsonModel;
	}
	
	
	@RequestMapping(value="edit",method=RequestMethod.GET)
	public String edit(int id,Model model) {
		Supplier supplier = supplierService.findById(id);
		model.addAttribute("supplier",supplier);
		return "supplier/edit";
	}
	
	@RequestMapping(value="edit",method=RequestMethod.POST)
	public String edit(Supplier supplier) {
		supplierService.update(supplier);
		return "redirect:/suppliers/listUI";
	}
}
