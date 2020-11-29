package com.neu.wms.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//是由登录了才能访问主界面
		Object data = request.getSession().getAttribute("user");
		if(data==null) {
			//没有登录
			    //如果现在是来登录,应该放行
			String requestURI = request.getRequestURI(); // /WMS/login
			
			if(requestURI.equals(request.getContextPath()+"/login")) {
				return true;
			}
			
			//去到登录界面
			//request.getContextPath() 获取上下文(/WMS)
			response.sendRedirect(request.getContextPath()+"/login");
			return false;
		}else {
			//判断是否又来登录,如果是去到主界面
            String requestURI = request.getRequestURI(); // /WMS/login
			
			if(requestURI.equals(request.getContextPath()+"/login")) {
				//去到主界面 
				response.sendRedirect(request.getContextPath());
				return false;
			}
			//有登录
			return true;
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
}
