package com.neu.wms.dao;

import com.neu.wms.dao.base.BaseMapper;
import com.neu.wms.domain.Store;
import com.neu.wms.query.StoreQuery;
 
public interface StoreMapper extends BaseMapper<Store, StoreQuery>{

	int findCountByLoginName(String name);

}
