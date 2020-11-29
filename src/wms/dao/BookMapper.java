package com.neu.wms.dao;

import com.neu.wms.dao.base.BaseMapper;
import com.neu.wms.domain.Book;
import com.neu.wms.query.BookItemQuery;
import com.neu.wms.query.BookQuery;

public interface BookMapper extends BaseMapper<Book,BookQuery> {

	int updateStatusBySn(BookQuery bookQuery);

}
