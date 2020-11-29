package com.neu.wms.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.neu.wms.dao.base.BaseMapper;
import com.neu.wms.domain.BookItem;
import com.neu.wms.query.BookItemQuery;

public interface BookItemMapper extends BaseMapper<BookItem,BookItemQuery> {

	int deleteByBookId(int bookId);
	
	int updateInput(@Param("id") int id,@Param("input") int input);
	
	List<BookItem> findByBookSn(BookItemQuery query);
	
	List<Map<String, String>> statisBook();
}