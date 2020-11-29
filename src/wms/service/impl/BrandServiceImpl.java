package com.neu.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.neu.wms.dao.BrandMapper;
import com.neu.wms.domain.Brand;
import com.neu.wms.query.BrandQuery;
import com.neu.wms.service.BrandService;

@Service
public class BrandServiceImpl implements BrandService {
	
	@Autowired
	BrandMapper brandMapper;

	@Override
	public List<Brand> findByQuery(BrandQuery brandQuery) {
		return brandMapper.findByQuery(brandQuery);
	}

	@Override
	public long findCount(BrandQuery brandQuery) {
	    return brandMapper.findCount(brandQuery);
	}

	@Override
	public int add(Brand brand) {
	    return brandMapper.add(brand);
	}

	@Override
	public int delete(int[] id) {
		return brandMapper.delete(id);
	}

	@Override
	public Brand findById(int id) {
		return brandMapper.findById(id);
	}

	@Override
	public int update(Brand brand) {
		return brandMapper.update(brand);
	}
}
