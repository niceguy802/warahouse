package com.neu.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.neu.wms.dao.SupplierMapper;
import com.neu.wms.domain.Supplier;
import com.neu.wms.query.SupplierQuery;
import com.neu.wms.service.SupplierService;

@Service
public class SupplierServiceImpl implements SupplierService {
	
	@Autowired
	SupplierMapper supplierMapper;

	@Override
	public List<Supplier> findByQuery(SupplierQuery supplierQuery) {
		return supplierMapper.findByQuery(supplierQuery);
	}

	@Override
	public long findCount(SupplierQuery supplierQuery) {
	    return supplierMapper.findCount(supplierQuery);
	}

	@Override
	public int add(Supplier supplier) {
	    return supplierMapper.add(supplier);
	}

	@Override
	public int delete(int[] id) {
		return supplierMapper.delete(id);
	}

	@Override
	public Supplier findById(int id) {
		return supplierMapper.findById(id);
	}

	@Override
	public int update(Supplier supplier) {
		return supplierMapper.update(supplier);
	}
}
