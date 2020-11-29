package com.neu.wms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neu.wms.domain.Role;
import com.neu.wms.query.RoleQuery;
import com.neu.wms.service.RoleService;
import com.neu.wms.utils.JsonModel;
import com.neu.wms.utils.RemoteModel;

@Controller
@RequestMapping("roles")
public class RoleContrller {
	
	@Autowired
	RoleService roleService;
	 
	
	/**
	 * 列表界面
	 * @return
	 */
	@RequestMapping(value="listUI",method=RequestMethod.GET)
	public String listUI() {
		return "role/list";
	}
	
	
	@RequestMapping(value="list",method=RequestMethod.GET)
	@ResponseBody
	public JsonModel list(RoleQuery roleQuery) { //RoleQuery:封装了查询参数
		JsonModel jsonModel = new JsonModel();
		 
		List<Role> roles = roleService.findByQuery(roleQuery);
		
		//查询当前条件下的总的记录数
		
		long count = roleService.findCount(roleQuery);
		jsonModel.setCount(count);
		jsonModel.setData(roles);
		jsonModel.setSuccess(true);
		jsonModel.setMsg("查找角色成功");
		return jsonModel;
	}
	
	@RequestMapping(value="add",method=RequestMethod.GET)
	public String add(Model model) {
		return "role/add";
	}
	 
	
	@RequestMapping(value="add",method=RequestMethod.POST)
	public String add(Role role) {
		//调用service
		roleService.add(role);
		return "redirect:/roles/listUI";
	}
	
	
	/**
	   *  删除
	 * @param id
	 * @return
	 */
	@RequestMapping(value="delete",method=RequestMethod.POST)
	@ResponseBody
	public JsonModel delete(int [] id) {
		roleService.delete(id);
		JsonModel jsonModel = new JsonModel();
		jsonModel.setSuccess(true);
		jsonModel.setMsg("删除成功");
		return jsonModel;
	}
	
	
	@RequestMapping(value="edit",method=RequestMethod.GET)
	public String edit(int id,Model model) {
		Role role = roleService.findById(id);
		model.addAttribute("role",role);
		return "role/edit";
	}
	
	@RequestMapping(value="edit",method=RequestMethod.POST)
	public String edit(Role role) {
		roleService.update(role);
		return "redirect:/roles/listUI";
	}
	
	@RequestMapping(value="validate/name",method=RequestMethod.GET)
	@ResponseBody
	public RemoteModel validateLoginName(String name) {
		int count = roleService.findCountByLoginName(name);
		
		RemoteModel remoteModel = new RemoteModel();
		
		remoteModel.setValid(count==0);
		return remoteModel;
	}
}
