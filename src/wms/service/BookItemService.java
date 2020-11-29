package com.neu.wms.service;

import java.util.List;
import java.util.Map;

import com.neu.wms.domain.BookItem;
import com.neu.wms.query.BookItemQuery;
import com.neu.wms.service.base.BaseService;

public interface BookItemService extends BaseService<BookItem,BookItemQuery> {

	int deleteByBookId(int bookId);
	
	int updateInput(int id,int input);
	
	List<BookItem> findByBookSn(BookItemQuery query);
	
	List<Map<String, String>> statisBook();
}
