package com.neu.wms.query;

import com.neu.wms.query.base.BaseQuery;

public class BookItemQuery extends BaseQuery{
	 
	private String  bookId;
	private String bookSn;

	public String getBookId() {
		return bookId;
	}

	public void setBookId(String bookId) {
		this.bookId = bookId;
	}

	public String getBookSn() {
		return bookSn;
	}

	public void setBookSn(String bookSn) {
		this.bookSn = bookSn;
	}
	
}