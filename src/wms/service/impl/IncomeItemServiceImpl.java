package com.neu.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neu.wms.dao.IncomeItemMapper;
import com.neu.wms.domain.IncomeItem;
import com.neu.wms.query.IncomeItemQuery;
import com.neu.wms.service.IncomeItemService;

@Service
public class IncomeItemServiceImpl implements IncomeItemService {
	
	@Autowired
	IncomeItemMapper incomeMapper;
	@Override
	public List<IncomeItem> findByQuery(IncomeItemQuery incomeQuery) {
		return incomeMapper.findByQuery(incomeQuery);
	}

	@Override
	public long findCount(IncomeItemQuery incomeQuery) {
	    return incomeMapper.findCount(incomeQuery);
	}

	@Override
	public int add(IncomeItem income) {
	    return incomeMapper.add(income);
	}

	@Override
	public int delete(int[] id) {
		return incomeMapper.delete(id);
	}

	@Override
	public IncomeItem findById(int id) {
		return incomeMapper.findById(id);
	}

	@Override
	public int update(IncomeItem income) {
		//return incomeMapper.update(income);
		return -1;
	}

	@Override
	public int deleteByIncomeid(int[] id) {
		// TODO Auto-generated method stub
		return incomeMapper.deleteByIncomeid(id);
	}

	@Override
	public List<IncomeItem> getBuyIncomeId(Integer incomeId) {
		// TODO Auto-generated method stub
		return incomeMapper.getBuyIncomeId(incomeId);
	}

}
