package com.neu.wms.service;

import com.neu.wms.domain.Book;
import com.neu.wms.query.BookItemQuery;
import com.neu.wms.query.BookQuery;
import com.neu.wms.service.base.BaseService;

public interface BookService extends BaseService<Book,BookQuery> {

	int updateStatusBySn(BookQuery bookQuery);

}
