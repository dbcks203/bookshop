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
	public String adminMember(Locale locale, Model model) {
		return "/book/bookListForm";
	}

}
