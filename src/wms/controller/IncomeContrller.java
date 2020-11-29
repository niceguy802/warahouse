package com.neu.wms.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neu.wms.domain.Income;
import com.neu.wms.domain.IncomeItem;
import com.neu.wms.domain.Stock;
import com.neu.wms.domain.User;
import com.neu.wms.query.IncomeQuery;
import com.neu.wms.query.StockQuery;
import com.neu.wms.query.StoreQuery;
import com.neu.wms.service.IncomeItemService;
import com.neu.wms.service.IncomeService;
import com.neu.wms.service.ProductService;
import com.neu.wms.service.StockService;
import com.neu.wms.service.StoreService;
import com.neu.wms.utils.JsonModel;

@Controller
@RequestMapping("incomes")
public class IncomeContrller {
	
	@Autowired
	IncomeService incomeService;
	
	@Autowired
	StoreService storeService;
	@Autowired
	IncomeItemService incomeItemService;
	
	@Autowired
	ProductService productService;
	
	
	@Autowired
	StockService stockService;
	
	/**
	 * 列表界面
	 * @return
	 */
	@RequestMapping(value="listUI",method=RequestMethod.GET)
	public String listUI() {
		return "income/list";
	}
	
	
	@RequestMapping(value="list",method=RequestMethod.GET)
	@ResponseBody
	public JsonModel list(IncomeQuery incomeQuery) { //IncomeQuery:封装了查询参数
		JsonModel jsonModel = new JsonModel();
		 
		List<Income> incomes = incomeService.findByQuery(incomeQuery);
		
		long count = incomeService.findCount(incomeQuery);
		jsonModel.setCount(count);
		jsonModel.setData(incomes);
		jsonModel.setSuccess(true);
		jsonModel.setMsg("查找成功");
		return jsonModel;
	}
	
	@RequestMapping(value="add",method=RequestMethod.GET)
	public String add(Model model) {
		StoreQuery storeQuery = new StoreQuery();
		model.addAttribute("stores", storeService.findByQuery(storeQuery));
		return "income/add";
	}
	 
	
	@RequestMapping(value="add",method=RequestMethod.POST)
	public String add(Income income,HttpSession session) {
		User user = (User) session.getAttribute("user");
		//调用service
		income.setMakeUserId(user.getId());
		int storeId = income.getStoreId();//仓库ID
		for(IncomeItem item:income.getIncomeItems()) {
			int productId = item.getProductId();//明细中的商品ID
			int inNum=item.getNumber();//明细中的商品数量
			StockQuery stockQuery = new StockQuery();
			stockQuery.setProductId(productId);
			stockQuery.setStoreId(storeId);
			
			int count = (int) stockService.findCount(stockQuery);
			if(count==0) {
				//添加
				Stock stock = new Stock();	
				stock.setStoreCount(inNum);
				stock.setIncomeDate(new Date());
				String productName=productService.findById(item.getProductId()).getName();
				stock.setProductName(productName);//
				stock.setProductId(item.getProductId());
				stock.setStoreId(storeId);
				String storeName = storeService.findById(storeId).getName();
				stock.setStoreName(storeName);
				stockService.add(stock);
			}else {
				//更新
				Stock stock = new Stock();	
				stock.setStoreId(storeId);
				stock.setProductId(item.getProductId());
				stock.setStoreCount(item.getNumber());
				stockService.update(stock);
			}
		}
		
		incomeService.add(income);
		return "redirect:/incomes/listUI";
	}
	
	
	/**
	   *  删除
	 * @param id
	 * @return
	 */
	@RequestMapping(value="delete",method=RequestMethod.POST)
	@ResponseBody
	public JsonModel delete(int [] id) {
		
		
	
		for(int i=0;i<id.length;i++) {
			Income income =incomeService.findById(id[i]);
			List<IncomeItem> incomeItemList = incomeItemService.getBuyIncomeId(id[i]);
			for(IncomeItem item:incomeItemList) {
				Stock stock = new Stock();
				stock.setStoreId(income.getStoreId());
				stock.setProductId(item.getProductId());
				stock.setStoreCount(item.getNumber());
				stockService.updateLess(stock);
			}
			
		}
		
		incomeItemService.deleteByIncomeid(id);
		incomeService.delete(id);
		JsonModel jsonModel = new JsonModel();
		jsonModel.setSuccess(true);
		jsonModel.setMsg("删除成功");
		return jsonModel;
	}
}
