package com.neu.wms.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neu.wms.domain.User;
import com.neu.wms.service.UserService;
import com.neu.wms.utils.JsonModel;

@Controller
public class HomeContrller {
	
	
	@Autowired
	UserService userSerivce;
	
	@RequestMapping(value="",method=RequestMethod.GET)
	public String main() {
		return "main";
	}
 
	
	/**
	 * 退出
	 * @return
	 */
	@RequestMapping(value="logout",method=RequestMethod.GET)
	public String logout(HttpSession session) {
		//清除session(使session过期)
		session.invalidate();
		return "redirect:/login";
	}
	
	/**
	 * 转发到登录界面
	 * @return
	 */
	@RequestMapping(value="login",method=RequestMethod.GET)
	public String login() {
		return "login";
	}
	
	 
	/**
	 *    登录
	 * @return
	 */
	@RequestMapping(value="login",method=RequestMethod.POST)
	@ResponseBody
	public JsonModel login(String loginName,String password,HttpSession session) {
		JsonModel jsonModel = new JsonModel();
		 
		User user = userSerivce.login(loginName, password);
		
		if(user==null) {
			jsonModel.setSuccess(false);
			jsonModel.setMsg("账号或密码错误");
		}else {
			session.setAttribute("user",user);  
			//登录拦截器就可以根据session中有没有user属性对应的值来判断是否登录成功
			jsonModel.setSuccess(true);
			jsonModel.setMsg("登录成功");
		}
		return jsonModel;
	}
}
