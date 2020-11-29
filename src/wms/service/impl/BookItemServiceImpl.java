package com.neu.wms.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neu.wms.dao.BookItemMapper;
import com.neu.wms.domain.BookItem;
import com.neu.wms.query.BookItemQuery;
import com.neu.wms.service.BookItemService;

@Service
public class BookItemServiceImpl implements BookItemService {
	
	@Autowired
	BookItemMapper bookItemMapper;

	@Override
	public List<BookItem> findByQuery(BookItemQuery bookQuery) {
		return bookItemMapper.findByQuery(bookQuery);
	}

	@Override
	public long findCount(BookItemQuery bookQuery) {
	    return bookItemMapper.findCount(bookQuery);
	}

	@Override
	public int add(BookItem book) {
	    return bookItemMapper.add(book);
	}

	@Override
	public int delete(int[] id) {
		return bookItemMapper.delete(id);
	}

	@Override
	public BookItem findById(int id) {
		return bookItemMapper.findById(id);
	}

	@Override
	public int update(BookItem book) {
		//return bookMapper.update(book);
		return -1;
	}

	@Override
	public int deleteByBookId(int bookId) {
		return bookItemMapper.deleteByBookId(bookId);
	}

	@Override
	public int updateInput(int id, int input) {
		return bookItemMapper.updateInput(id,input);
	}

	@Override
	public List<BookItem> findByBookSn(BookItemQuery query) {
		return bookItemMapper.findByBookSn(query);
	}
	
	@Override
	public List<Map<String, String>> statisBook() {
		// TODO Auto-generated method stub
		return bookItemMapper.statisBook();
	}
}
