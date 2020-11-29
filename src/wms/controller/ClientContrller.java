package com.neu.wms.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.neu.wms.domain.Client;
import com.neu.wms.query.ClientQuery;
import com.neu.wms.service.ClientService;
import com.neu.wms.utils.JsonModel;

@Controller
@RequestMapping("clients")
public class ClientContrller {
	
	@Autowired
	ClientService clientService;
	
	/**
	 * 列表界面
	 * @return
	 */
	@RequestMapping(value="listUI",method=RequestMethod.GET)
	public String listUI() {
		return "client/list";
	}

	@RequestMapping(value="list",method=RequestMethod.GET)
	@ResponseBody
	public JsonModel list(ClientQuery clientQuery) { //ClientQuery:封装了查询参数
		JsonModel jsonModel = new JsonModel();	 
		List<Client> clients = clientService.findByQuery(clientQuery);
		
		//查询当前条件下的总的记录数	
		long count = clientService.findCount(clientQuery);
		jsonModel.setCount(count);
		jsonModel.setData(clients);
		jsonModel.setSuccess(true);
		jsonModel.setMsg("查找品牌成功");
		return jsonModel;
	}
	
	@RequestMapping(value="add",method=RequestMethod.GET)
	public String add(Model model) {
		return "client/add";
	}

	@RequestMapping(value="add",method=RequestMethod.POST)
	public String add(Client client) {
		//调用service
		clientService.add(client);
		return "redirect:/clients/listUI";
	}

	/**
	   *  删除
	 * @param id
	 * @return
	 */
	@RequestMapping(value="delete",method=RequestMethod.POST)
	@ResponseBody
	public JsonModel delete(int [] id) {
		clientService.delete(id);
		JsonModel jsonModel = new JsonModel();
		jsonModel.setSuccess(true);
		jsonModel.setMsg("删除成功");
		return jsonModel;
	}
	
	
	@RequestMapping(value="edit",method=RequestMethod.GET)
	public String edit(int id,Model model) {
		Client client = clientService.findById(id);
		model.addAttribute("client",client);
		return "client/edit";
	}
	
	@RequestMapping(value="edit",method=RequestMethod.POST)
	public String edit(Client client) {
		clientService.update(client);
		return "redirect:/clients/listUI";
	}
}
