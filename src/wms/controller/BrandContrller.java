package com.neu.wms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.neu.wms.domain.Brand;
import com.neu.wms.query.BrandQuery;
import com.neu.wms.service.BrandService;
import com.neu.wms.utils.JsonModel;

@Controller
@RequestMapping("brands")
public class BrandContrller {
	
	@Autowired
	BrandService brandService;
	
	/**
	 * 列表界面
	 * @return
	 */
	@RequestMapping(value="listUI",method=RequestMethod.GET)
	public String listUI() {
		return "brand/list";
	}

	@RequestMapping(value="list",method=RequestMethod.GET)
	@ResponseBody
	public JsonModel list(BrandQuery brandQuery) { //BrandQuery:封装了查询参数
		JsonModel jsonModel = new JsonModel();	 
		List<Brand> brands = brandService.findByQuery(brandQuery);
		
		//查询当前条件下的总的记录数	
		long count = brandService.findCount(brandQuery);
		jsonModel.setCount(count);
		jsonModel.setData(brands);
		jsonModel.setSuccess(true);
		jsonModel.setMsg("查找品牌成功");
		return jsonModel;
	}
	
	@RequestMapping(value="add",method=RequestMethod.GET)
	public String add(Model model) {
		return "brand/add";
	}

	@RequestMapping(value="add",method=RequestMethod.POST)
	public String add(Brand brand) {
		//调用service
		brandService.add(brand);
		return "redirect:/brands/listUI";
	}

	/**
	   *  删除
	 * @param id
	 * @return
	 */
	@RequestMapping(value="delete",method=RequestMethod.POST)
	@ResponseBody
	public JsonModel delete(int [] id) {
		brandService.delete(id);
		JsonModel jsonModel = new JsonModel();
		jsonModel.setSuccess(true);
		jsonModel.setMsg("删除成功");
		return jsonModel;
	}
	
	
	@RequestMapping(value="edit",method=RequestMethod.GET)
	public String edit(int id,Model model) {
		Brand brand = brandService.findById(id);
		model.addAttribute("brand",brand);
		return "brand/edit";
	}
	
	@RequestMapping(value="edit",method=RequestMethod.POST)
	public String edit(Brand brand) {
		brandService.update(brand);
		return "redirect:/brands/listUI";
	}
}
