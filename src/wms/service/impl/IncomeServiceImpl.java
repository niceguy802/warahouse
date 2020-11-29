package com.neu.wms.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neu.wms.dao.IncomeMapper;
import com.neu.wms.domain.Income;
import com.neu.wms.domain.IncomeItem;
import com.neu.wms.domain.Product;
import com.neu.wms.query.IncomeQuery;
import com.neu.wms.service.BookItemService;
import com.neu.wms.service.IncomeItemService;
import com.neu.wms.service.IncomeService;
import com.neu.wms.service.ProductService;

@Service
public class IncomeServiceImpl implements IncomeService {
	
	@Autowired
	IncomeMapper incomeMapper;
	
	@Autowired
	ProductService productService;
	
	@Autowired
	IncomeItemService incomeItemService;
	
	@Autowired
	BookItemService bookItemService;
	 

	@Override
	public List<Income> findByQuery(IncomeQuery incomeQuery) {
		return incomeMapper.findByQuery(incomeQuery);
	}

	@Override
	public long findCount(IncomeQuery incomeQuery) {
	    return incomeMapper.findCount(incomeQuery);
	}

	@Override
	public int add(Income income) {
		
		
		int totalAmount = 0;  //总的金额
	    int totalNumber = 0;  //总的数量
		
		List<IncomeItem> incomeItems = income.getIncomeItems();
		for(IncomeItem incomeItem : incomeItems) {
			
			Product product = productService.findById(incomeItem.getProductId());
			
			incomeItem.setCostPrice(product.getCostPrice());
			incomeItem.setAmount(product.getCostPrice()*incomeItem.getNumber());
			incomeItem.setProductName(product.getName());

			totalAmount += incomeItem.getAmount();
			totalNumber += incomeItem.getNumber();
/*
		   //TODO  private Integer bookItemId;
 
*/
		}
		
		   //如何处理
		   //添加送货单明细
		   //添加送货单
		
		income.setCreateDate(new Date());
		income.setTotalAmount(totalAmount);
		income.setTotalNumber(totalNumber);
		
		incomeMapper.add(income);
		
		for(IncomeItem incomeItem : incomeItems) {
			incomeItem.setIncomeId(income.getId());
			//添加入库明细
			incomeItemService.add(incomeItem);
			bookItemService.updateInput(incomeItem.getBookItemId(), incomeItem.getNumber());
			
		}
		return 1;
	}

	@Override
	public int delete(int[] id) {
		return incomeMapper.delete(id);
	}

	@Override
	public Income findById(int id) {
		return incomeMapper.findById(id);
	}

	@Override
	public int update(Income income) {
		return incomeMapper.update(income);
	}
}
