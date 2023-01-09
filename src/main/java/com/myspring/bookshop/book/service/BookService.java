package com.myspring.bookshop.book.service;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.bookshop.book.entity.BookVO;
import com.myspring.bookshop.member.entity.MemberVO;
import com.myspring.bookshop.mybatis.mappers.BookDAO;

@Service
public class BookService {

	@Autowired
	BookDAO bookDAO;
	
	
	public void deleteBook(String bookNo) throws Exception {
		bookDAO.deleteBook(bookNo);
	}
	
	public BookVO getBook(String book_no) throws Exception {
		return bookDAO.selectView(book_no);
	}
	
	
	public void updateUseYn(String book_no, String use_yn) {

		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("use_yn", use_yn);
		parameters.put("book_no", book_no);
		bookDAO.updateAvailable(parameters);
	}
}