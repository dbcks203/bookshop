package com.myspring.bookshop.mail;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.bookshop.mail.service.MailSendService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MailController {

	@Autowired
	private MailSendService mailService;
	/**
	 * Simply selects the home view to render by returning its name.
	 */

	
	@RequestMapping("/mail/mailCheck")
	@ResponseBody
	public String mailCheck(String email) {
		System.out.println("이메일 인증 요청이 들어옴!");
		System.out.println("이메일 인증 이메일 : " + email);
		return mailService.joinEmail(email);
	}
}
