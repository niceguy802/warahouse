package com.neu.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neu.wms.dao.StoreMapper;
import com.neu.wms.domain.Store;
import com.neu.wms.query.StoreQuery;
import com.neu.wms.service.StoreService;

@Service
public class StoreServiceImpl implements StoreService {
	
	@Autowired
	StoreMapper storeMapper;
 

	@Override
	public List<Store> findByQuery(StoreQuery storeQuery) {
		return storeMapper.findByQuery(storeQuery);
	}

	@Override
	public long findCount(StoreQuery storeQuery) {
	    return storeMapper.findCount(storeQuery);
	}

	@Override
	public int add(Store store) {
	    return storeMapper.add(store);
	}

	@Override
	public int delete(int[] id) {
		return storeMapper.delete(id);
	}

	@Override
	public Store findById(int id) {
		return storeMapper.findById(id);
	}

	@Override
	public int update(Store store) {
		return storeMapper.update(store);
	}

	@Override
	public int findCountByLoginName(String name) {
		// TODO Auto-generated method stub
		return storeMapper.findCountByLoginName(name);
	}
}
