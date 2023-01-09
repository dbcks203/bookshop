package com.myspring.bookshop.mybatis.mappers;

import java.util.Map;

import com.myspring.bookshop.book.entity.BookVO;

public interface BookDAO {
	void deleteBook(String bookNo);
	void updateAvailable(Map<String, Object> parameters);
	BookVO selectView(String book_no);
}
