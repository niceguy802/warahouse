package com.neu.wms.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neu.wms.dao.OutcomeItemMapper;
import com.neu.wms.domain.OutcomeItem;
import com.neu.wms.query.OutcomeItemQuery;
import com.neu.wms.service.OutcomeItemService;

@Service
public class OutcomeItemServiceImpl implements OutcomeItemService {
	
	@Autowired
	OutcomeItemMapper outcomeItemMapper;

	@Override
	public List<OutcomeItem> findByQuery(OutcomeItemQuery outcomeQuery) {
		return outcomeItemMapper.findByQuery(outcomeQuery);
	}

	@Override
	public long findCount(OutcomeItemQuery outcomeQuery) {
	    return outcomeItemMapper.findCount(outcomeQuery);
	}

	@Override
	public int add(OutcomeItem outcome) {
	    return outcomeItemMapper.add(outcome);
	}

	@Override
	public int delete(int[] id) {
		return outcomeItemMapper.delete(id);
	}

	@Override
	public OutcomeItem findById(int id) {
		return outcomeItemMapper.findById(id);
	}

	@Override
	public int update(OutcomeItem outcome) {
		return -1;
	}
	@Override
	public List<Map<String, String>> statisOut() {
		// TODO Auto-generated method stub
		return outcomeItemMapper.statisOut();		
	}

	@Override
	public List<OutcomeItem> getBuyOutcomeId(String outSn) {
		// TODO Auto-generated method stub
		return outcomeItemMapper.getBuyOutcomeId(outSn);		
	}

	@Override
	public int deleteByOutcomeSn(String[] sn) {
		// TODO Auto-generated method stub
		return outcomeItemMapper.deleteByOutcomeSn(sn);		

	}

}
