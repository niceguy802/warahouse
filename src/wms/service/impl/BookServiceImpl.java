package com.neu.wms.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neu.wms.dao.BookMapper;
import com.neu.wms.domain.Book;
import com.neu.wms.domain.BookItem;
import com.neu.wms.domain.Product;
import com.neu.wms.query.BookItemQuery;
import com.neu.wms.query.BookQuery;
import com.neu.wms.service.BookItemService;
import com.neu.wms.service.BookService;
import com.neu.wms.service.ProductService;

@Service
public class BookServiceImpl implements BookService {
	
	@Autowired
	BookMapper bookMapper;
	
	@Autowired
	ProductService productService;
	
	@Autowired
	BookItemService bookItemService;

	@Override
	public List<Book> findByQuery(BookQuery bookQuery) {
		return bookMapper.findByQuery(bookQuery);
	}

	@Override
	public long findCount(BookQuery bookQuery) {
	    return bookMapper.findCount(bookQuery);
	}
	/**
	 * 添加订单
	 */
	@Override
	public int add(Book book) {
		
		List<BookItem> bookItems = book.getBookItems();
		
		int totalAmount=0; //总的金额
		int totalCount=0;  //总的数量
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String orderSN = simpleDateFormat.format(new Date());
 
		for(BookItem bookItem : bookItems) {
			
			Product product = productService.findById(bookItem.getProductId());
			
			bookItem.setAmount(product.getCostPrice()*bookItem.getNumber());
			bookItem.setProductName(product.getName());
			bookItem.setCostPrice(product.getCostPrice());
			bookItem.setBookSn(orderSN);//获取订单编号
			
			totalCount +=bookItem.getNumber();  
			totalAmount+=bookItem.getAmount();
		}
		
		
		book.setSn(orderSN); //时间转成订单号
		book.setCreateDate(new Date());
		book.setStatus((byte)0);
		book.setTotalAmount(totalAmount);
		book.setTotalCount(totalCount);
		
	    int result =  bookMapper.add(book);
	    int bookId = book.getId();
	    
	    for(BookItem bookItem : bookItems) {
	    	bookItem.setBookId(bookId);
	    	//保存
	    	bookItemService.add(bookItem);
	    }
	    return result;
	}

	@Override
	public int delete(int[] id) {
		
		//未审核才能删除
		for(int tempId : id) {
			Book book = bookMapper.findById(tempId);
			if(!book.getStatus().equals((byte)0)) {
				throw new RuntimeException("只能删除未审核的订单");
			}
		}
		
		//删除订单的明细
		for(int tempId:id) {
			bookItemService.deleteByBookId(tempId);
		}
		return bookMapper.delete(id);
	}

	@Override
	public Book findById(int id) {
		return bookMapper.findById(id);
	}

	@Override
	public int update(Book book) {
		return bookMapper.update(book);
	}

	@Override
	public int updateStatusBySn(BookQuery bookQuery) {
		return bookMapper.updateStatusBySn(bookQuery);
	}

}
