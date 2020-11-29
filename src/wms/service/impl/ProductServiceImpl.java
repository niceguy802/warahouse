package com.neu.wms.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.neu.wms.dao.ProductMapper;
import com.neu.wms.domain.Product;
import com.neu.wms.query.ProductQuery;
import com.neu.wms.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	ProductMapper productMapper;
 
	@Override
	public List<Product> findByQuery(ProductQuery productQuery) {
		return productMapper.findByQuery(productQuery);
	}
	@Override
	public long findCount(ProductQuery productQuery) {
	    return productMapper.findCount(productQuery);
	}

	@Override
	public int add(Product product) {
	    return productMapper.add(product);
	}

	@Override
	public int delete(int[] id) {
		return productMapper.delete(id);
	}

	@Override
	public Product findById(int id) {
		return productMapper.findById(id);
	}

	@Override
	public int update(Product product) {
		return productMapper.update(product);
	}
}
