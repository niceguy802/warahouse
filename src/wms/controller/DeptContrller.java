package com.neu.wms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neu.wms.domain.Dept;
import com.neu.wms.query.DeptQuery;
import com.neu.wms.service.DeptService;
import com.neu.wms.utils.JsonModel;
import com.neu.wms.utils.RemoteModel;

@Controller
@RequestMapping("depts")
public class DeptContrller {
	
	@Autowired
	DeptService deptService;
	
	/**
	 * 列表界面
	 * @return
	 */
	@RequestMapping(value="listUI",method=RequestMethod.GET)
	public String listUI() {
		return "dept/list";
	}
	
	
	@RequestMapping(value="list",method=RequestMethod.GET)
	@ResponseBody
	public JsonModel list(DeptQuery deptQuery) {
		JsonModel jsonModel = new JsonModel();
		 
		List<Dept> depts = deptService.findByQuery(deptQuery);
		 
		long count = deptService.findCount(deptQuery);
		jsonModel.setCount(count);
		jsonModel.setData(depts);
		jsonModel.setSuccess(true);
		jsonModel.setMsg("查找部门成功");
		return jsonModel;
	}
	
	@RequestMapping(value="add",method=RequestMethod.GET)
	public String add() {
		return "dept/add";
	}
	
	@RequestMapping(value="add",method=RequestMethod.POST)
	public String add(Dept dept) {
		//调用service
		deptService.add(dept);
		return "redirect:/depts/listUI";
	}
	
	@RequestMapping(value="edit",method=RequestMethod.GET)
	public String edit(int id,Model model) {//Model ModelMap 他们的数据会放入到request作用域中
		
		Dept dept = deptService.findById(id);
		//作用域中用来做回显
		
		model.addAttribute("dept",dept);
		
		return "dept/edit";
	}
	
	@RequestMapping(value="edit",method=RequestMethod.POST)
	public String edit(Dept dept) {
		deptService.update(dept);
		return "redirect:/depts/listUI";
	}
	
	
	/**
	   *  删除
	 * @param id
	 * @return
	 */
	@RequestMapping(value="delete",method=RequestMethod.POST)
	@ResponseBody
	public JsonModel delete(int [] id) {
		deptService.delete(id);
		JsonModel jsonModel = new JsonModel();
		jsonModel.setSuccess(true);
		jsonModel.setMsg("删除成功");
		return jsonModel;
	}
	
	
	@RequestMapping(value="validate/name",method=RequestMethod.GET)
	@ResponseBody
	public RemoteModel validateLoginName(String name) {
		int count = deptService.findCountByLoginName(name);
		
		RemoteModel remoteModel = new RemoteModel();
		
		remoteModel.setValid(count==0);
		return remoteModel;
	}
	
	
	
}
