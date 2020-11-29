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

import com.neu.wms.domain.IncomeItem;
import com.neu.wms.domain.Outcome;
import com.neu.wms.domain.OutcomeItem;
import com.neu.wms.domain.Stock;
import com.neu.wms.domain.Store;
import com.neu.wms.domain.User;
import com.neu.wms.query.ClientQuery;
import com.neu.wms.query.OutcomeQuery;
import com.neu.wms.query.StockQuery;
import com.neu.wms.query.StoreQuery;
import com.neu.wms.service.ClientService;
import com.neu.wms.service.OutcomeItemService;
import com.neu.wms.service.OutcomeService;
import com.neu.wms.service.StockService;
import com.neu.wms.service.StoreService;
import com.neu.wms.utils.JsonModel;

@Controller
@RequestMapping("outcomes")
public class OutcomeContrller {

	@Autowired
	OutcomeService outcomeService;

	@Autowired
	OutcomeItemService outcomeItemService;

	@Autowired
	ClientService clientService;

	@Autowired
	StoreService storeService;
	@Autowired
	StockService stockService;

	/**
	 * 列表界面
	 * 
	 * @return
	 */
	@RequestMapping(value = "listUI", method = RequestMethod.GET)
	public String listUI() {
		return "outcome/list";
	}

	@RequestMapping(value = "list", method = RequestMethod.GET)
	@ResponseBody
	public JsonModel list(OutcomeQuery outcomeQuery) { // OutcomeQuery:封装了查询参数
		JsonModel jsonModel = new JsonModel();

		List<Outcome> outcomes = outcomeService.findByQuery(outcomeQuery);

		long count = outcomeService.findCount(outcomeQuery);
		jsonModel.setCount(count);
		jsonModel.setData(outcomes);
		jsonModel.setSuccess(true);
		jsonModel.setMsg("查找成功");
		return jsonModel;
	}

	@RequestMapping(value = "add", method = RequestMethod.GET)
	public String add(Model model) {

		StoreQuery storeQuery = new StoreQuery();
		List<Store> stores = storeService.findByQuery(storeQuery);
		model.addAttribute("stores", stores);

		ClientQuery clientQuery = new ClientQuery();
		model.addAttribute("clients", clientService.findByQuery(clientQuery));
		return "outcome/add";
	}

	// 去到添加界面
	@RequestMapping(value = "add", method = RequestMethod.POST)
	public String add(Outcome outcome, HttpSession session) {
		User user = (User) session.getAttribute("user");
		// 调用service
		outcome.setUserId(user.getId());
		int storeId = outcome.getStoreId();
		for (OutcomeItem item : outcome.getOutcomeItems()) {
			Stock stock = new Stock();
			stock.setStoreId(storeId);
			stock.setProductId(item.getProductId());
			stock.setStoreCount(item.getNumber());
			stockService.updateLess(stock);
		}

		outcomeService.add(outcome);
		return "redirect:/outcomes/listUI";
	}

	/**
	 * 删除
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	@ResponseBody
	public JsonModel delete(int[] id) {

		String  sns= "";
		for (int i = 0; i < id.length; i++) {
		
			Outcome outCome = outcomeService.findById(id[i]);
			sns+=","+outCome.getSn();
			List<OutcomeItem> outcomeItemList = outcomeItemService.getBuyOutcomeId(outCome.getSn());
			for (OutcomeItem item : outcomeItemList) {
				Stock stock = new Stock();
				stock.setStoreId(outCome.getStoreId());
				stock.setProductId(item.getProductId());
				stock.setStoreCount(item.getNumber());
				stockService.update(stock);
			}

		}
		
		String[] snsArr = sns.split(",");
		outcomeItemService.deleteByOutcomeSn(snsArr);
		outcomeService.delete(id);
		JsonModel jsonModel = new JsonModel();
		jsonModel.setSuccess(true);
		jsonModel.setMsg("删除成功");
		return jsonModel;
	}
}
