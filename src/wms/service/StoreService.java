package com.neu.wms.service;

import com.neu.wms.domain.Store;
import com.neu.wms.query.StoreQuery;
import com.neu.wms.service.base.BaseService;

public interface StoreService extends BaseService<Store,StoreQuery>{

	int findCountByLoginName(String name);
}