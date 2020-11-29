package com.neu.wms.service.base;

import java.util.List;

import com.neu.wms.domain.base.BaseDomain;
import com.neu.wms.query.base.BaseQuery;

public interface BaseService<T extends BaseDomain,E extends BaseQuery> {

	List<T> findByQuery(E query);

	long findCount(E query);

	int add(T brand);

	int delete(int[] id);

	T findById(int id);

	int update(T brand);

}
