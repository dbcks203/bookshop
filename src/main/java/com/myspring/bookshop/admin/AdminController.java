package com.myspring.bookshop.admin;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.bookshop.member.entity.MemberVO;
import com.myspring.bookshop.member.service.MemberService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class AdminController {

	@RequestMapping(value = "/admin/adminMember.do")
	public String adminMember(Locale locale, Model model) {
		return "/admin/adminMember";
	}
	@RequestMapping(value = "/admin/adminBook.do")
	public String adminBook(Locale locale, Model model) {
		return "/admin/adminBook";
	}
}
