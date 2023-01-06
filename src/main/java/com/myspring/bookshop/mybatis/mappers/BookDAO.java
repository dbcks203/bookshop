package com.myspring.bookshop.mybatis.mappers;

import java.util.List;
import java.util.Map;

import com.myspring.bookshop.book.entity.BookVO;

public interface BookDAO {

	void deleteBook(String bookNo);

	void updateAvailable(Map<String, Object> parameters);

	List<BookVO> listBooks(Map<String, Object> parameters);

	int totalCount(Map<String, Object> parameters);

	List<Map<String, Object>> searchOneKey(Map<String, Object> parameters);
	
}
