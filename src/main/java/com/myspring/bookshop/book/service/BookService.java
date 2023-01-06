package com.myspring.bookshop.book.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.bookshop.book.entity.BookVO;
import com.myspring.bookshop.mybatis.mappers.BookDAO;
import com.myspring.bookshop.mybatis.mappers.UtilDAO;

@Service
public class BookService {

	@Autowired
	BookDAO bookDAO;
	
	@Autowired
	UtilDAO utilDAO;
	
	
	public void deleteBook(String bookNo) throws Exception {
		bookDAO.deleteBook(bookNo);
	}

	public void updateUseYn(String book_no, String use_yn) {

		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("use_yn", use_yn);
		parameters.put("book_no", book_no);
		bookDAO.updateAvailable(parameters);
	}

	
	public List<String> suggest(String text, String kategorie, String searchKey, int pageNo, int pageSize) {
		List<String> list = new ArrayList<String>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		Map<String, String> searchMap = new HashMap<String, String>();
		searchMap.put("book_kategorie", kategorie);
		searchMap.put(searchKey, text);

		final int rowSize = pageSize;
		text = text == null ? "" : text;
		int startPage = (pageNo - 1) * rowSize;
		
		parameters.put("table", "book");
		parameters.put("suggestValue", "book_title");
		parameters.put("sortKey", "book_no");
		parameters.put("startPage", startPage);
		parameters.put("rowSize", rowSize);
		parameters.put("searchMap", searchMap);
		
		list = utilDAO.suggestAnd(parameters);

		return list;
	}
	
	
	public int totalPageNo(String text, String kategorie, String searchKey,int rowSize) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		Map<String, String> searchMap = new HashMap<String, String>();
		searchMap.put("book_kategorie", kategorie);
		searchMap.put(searchKey, text);
		
		int totalPageSize = 0;
		if (text == null)
			text = "";

		parameters.put("table", "book");
		parameters.put("rowSize", rowSize);
		parameters.put("searchMap", searchMap);
		totalPageSize = utilDAO.totalCountAnd(parameters);

		return totalPageSize;
	}



	public List<Map<String, Object>> search(String text, String kategorie, String searchKey, int pageNo, int pageSize) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		Map<String, String> searchMap = new HashMap<String, String>();
		searchMap.put("book_kategorie", kategorie);
		searchMap.put(searchKey, text);

		final int rowSize = pageSize;
		text = text == null ? "" : text;
		int startPage = (pageNo - 1) * rowSize;
		
		parameters.put("table", "book");
		parameters.put("sortKey", "book_no");
		parameters.put("startPage", startPage);
		parameters.put("rowSize", rowSize);
		parameters.put("searchMap", searchMap);
		
		list = utilDAO.searchAnd(parameters);

		return list;
	}

}