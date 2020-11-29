package com.neu.wms.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.neu.wms.domain.Product;
import com.neu.wms.query.BrandQuery;
import com.neu.wms.query.ProductQuery;
import com.neu.wms.service.BrandService;
import com.neu.wms.service.ProductService;
import com.neu.wms.utils.JsonModel;

@Controller
@RequestMapping("products")
public class ProductContrller {
	
	@Autowired
	ProductService productService;
	
	@Autowired
	BrandService brandService;
	 
	/**
	 * 列表界面
	 * @return
	 */
	@RequestMapping(value="listUI",method=RequestMethod.GET)
	public String listUI() {
		return "product/list";
	}

	@RequestMapping(value="list",method=RequestMethod.GET)
	@ResponseBody
	public JsonModel list(ProductQuery productQuery) { //ProductQuery:封装了查询参数
		JsonModel jsonModel = new JsonModel();	 
		List<Product> products = productService.findByQuery(productQuery);
		
		//查询当前条件下的总的记录数	
		long count = productService.findCount(productQuery);
		jsonModel.setCount(count);
		jsonModel.setData(products);
		jsonModel.setSuccess(true);
		jsonModel.setMsg("查找商品成功!");
		return jsonModel;
	}
	
	@RequestMapping(value="add",method=RequestMethod.GET)
	public String add(Model model) {
		BrandQuery brandQuery = new BrandQuery();
		model.addAttribute("brands", brandService.findByQuery(brandQuery));
		return "product/add";
	}

	@RequestMapping(value="add",method=RequestMethod.POST)
	public String add(@Param("productImg") MultipartFile productImg,HttpServletRequest request) {
		String name = request.getParameter("name");
		String sn = request.getParameter("sn");
		int costPrice = Integer.parseInt(request.getParameter("costPrice"));
		int salePrice = Integer.parseInt(request.getParameter("salePrice"));
		String remark = request.getParameter("remark");
		int brandId = Integer.parseInt(request.getParameter("brandId"));
		
		
		String fileName =UUID.randomUUID().toString().replace("-","")+productImg.getOriginalFilename();
		
		//获取指定文件的绝对路径,从WebContent文件夹下开始查找
		String dest = request.getServletContext().getRealPath("static/upload")+"/"+fileName;

		//文件打散方案
		   //方案一:将文件名添加前缀(时间、UUID)
		           //System.nanoTime()
		   //方案二:根据当前时间将文件放入不同的文件夹+将文件名添加前缀(时间、UUID)
 
		File file = new File(dest);
		try {
			//保存文件
			productImg.transferTo(file);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		Product product = new Product();
		product.setName(name);
		product.setSn(sn);
		product.setSalePrice(salePrice);
		product.setCostPrice(costPrice);
		product.setBrandId(brandId);
		product.setRemark(remark);
		
		product.setImg("upload/"+fileName);
		
		//调用service
		productService.add(product);
		return "redirect:/products/listUI";
	}

	/**
	   *  删除
	 * @param id
	 * @return
	 */
	@RequestMapping(value="delete",method=RequestMethod.POST)
	@ResponseBody
	public JsonModel delete(int [] id) {
		productService.delete(id);
		JsonModel jsonModel = new JsonModel();
		jsonModel.setSuccess(true);
		jsonModel.setMsg("删除成功");
		return jsonModel;
	}
	
	/**
	   * 编辑
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value="edit",method=RequestMethod.GET)
	public String edit(int id,Model model) {
		Product product = productService.findById(id);
		model.addAttribute("product",product);
		return "product/edit";
	}
	
	@RequestMapping(value="edit",method=RequestMethod.POST)
	public String edit(Product product) {
		productService.update(product);
		return "redirect:/products/listUI";
	}
}
