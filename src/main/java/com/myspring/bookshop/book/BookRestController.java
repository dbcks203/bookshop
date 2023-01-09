package com.myspring.bookshop.book;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.myspring.bookshop.book.service.BookService;


@RestController
public class BookRestController {

	@Autowired
	BookService bookService;



	@RequestMapping(value = "/book/bookDelete.do")
	public Map<String, Object> bookDelete(@RequestParam("book_no") String book_no) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		bookService.deleteBook(book_no);

		map.put("status", true);
		map.put("message", "회원을 삭제했습니다.");

		return map;
	}

	@RequestMapping(value = "/book/updateBookAvailable.do")
	public Map<String, Object> updateUseYn(@RequestParam("book_no") String book_no,
			@RequestParam("useYn") String use_yn) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		bookService.updateUseYn(book_no, "Y".equals(use_yn) ? "N" : "Y");

		map.put("status", true);
		map.put("message", "회원의 상태를 변경하였습니다.");

		return map;
	}
}
