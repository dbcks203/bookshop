package com.myspring.bookshop.member;

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
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/member/loginForm.do")
	public String loginForm(Locale locale, Model model) {
		return "/member/loginForm";
	}

	@RequestMapping(value = "/member/memberForm.do")
	public String memberForm(Locale locale, Model model) {
		return "/member/memberForm";
	}

	@RequestMapping(value = "/member/myPageMain.do")
	public String myPageMain(Locale locale, Model model) {
		return "/member/myPageMain";
	}

	@Autowired
	MemberService memberService;

	@RequestMapping(value = "/member/login.do")
	public String login(@RequestParam(value = "member_id", required = true) String member_id,
			@RequestParam(value = "member_pw", required = true) String member_pw, Model model, HttpSession session) {

		MemberVO memberVO = memberService.login(member_id, member_pw);
		if (memberVO != null) {
			session.setAttribute("isLogOn", true);
			session.setAttribute("member", memberVO);
		}

		return "home";
	}

	@RequestMapping(value = "/member/addMember.do", method = RequestMethod.POST)
	public ResponseEntity addMember(@ModelAttribute("memberVO") MemberVO _memberVO, Locale locale, Model model)
			throws Exception {

		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			memberService.addMember(_memberVO);
			message = "<script>";
			message += " alert('회원가입에 성공했습니다');";
			message += " location.href='/bookshop01/';";
			message += " </script>";

		} catch (Exception e) {
			message = "<script>";
			message += " alert('뭔가 잘못했습니다 다시해요');";
			message += " location.href='/bookshop01/member/memberForm.do';";
			message += " </script>";
			e.printStackTrace();
		}

		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}

	@RequestMapping(value = "/member/logout.do")
	public String logout(HttpSession session) {

		session.invalidate();

		return "redirect:/";
	}

	@RequestMapping(value = "/member/listMembers.do")
	public String listMembers(Model model) {

		// model.addAttribute("list", memberService.listMembers());

		return "/member/listMembers";
	}

	@RequestMapping(value = "/member/view.do")
	public String view(@RequestParam(value = "member_id", required = true) String member_id, Model model) {

		logger.debug("view() before ======================== ");
		model.addAttribute("member", memberService.view(member_id));
		logger.debug("view() after ======================== ");

		return "/member/view";
	}

	@RequestMapping(value = "/member/infoMember.do")
	public ModelAndView infoMember(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("memberBean", session.getAttribute("member"));
		mav.setViewName("/member/memberInfo");
		return mav;
	}
	
	@RequestMapping(value = "/member/memberDelete.do")
	public String memberDelete(@RequestParam(value = "member_id", required = true)String uid, HttpSession session) throws Exception {
		
		memberService.deleteMember(uid);
		session.setAttribute("member", null);
		session.setAttribute("isLogOn", false);
		return "home";
	
	}
	
	
	@RequestMapping(value = "/member/memberUpdateForm.do")
	public ModelAndView memberUpdateForm(Model model, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject("memberBean", session.getAttribute("member"));
		mav.setViewName("/member/memberUpdateForm");
		return mav;
	}
	
	
	@RequestMapping(value = "/member/memberUpdate.do")
	public String memberUpdate(@ModelAttribute("memberVO") MemberVO _memberVO, HttpSession session, Model model) throws Exception {
	
		model.addAttribute("memberBean", memberService.updateMember(_memberVO));
		return "/member/memberInfo";
	}

}
