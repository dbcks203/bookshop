package com.myspring.bookshop.book;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.myspring.bookshop.book.service.BookService;


@Controller
public class BookController {
	
	@Autowired 
	BookService bookService;
	
	@RequestMapping(value = "/book/bookListForm.do")
	public String bookListForm(Locale locale, Model model) {
		return "/book/bookListForm";
	}
	
	@RequestMapping(value = "/book/bookInfo.do")
	public String bookInfo(@RequestParam(value = "book_no", required = true)String book_no,Locale locale, Model model) throws Exception {
		
		model.addAttribute("book",bookService.getBook(book_no));
		return "/book/bookInfo";
	}

}
