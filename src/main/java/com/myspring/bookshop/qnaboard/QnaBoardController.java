package com.myspring.bookshop.qnaboard;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.bookshop.qnaboard.entity.QnaBoardVO;
import com.myspring.bookshop.qnaboard.service.QnaBoardService;

@Controller
public class QnaBoardController {

	@Autowired
	QnaBoardService qnaBoardService;

	@RequestMapping(value = "/qnaboard/articleInfo.do")
	public String bookInfo(@RequestParam(value = "article_no", required = true) String article_no, Locale locale,
			Model model) throws Exception {
		qnaBoardService.addViewCount(article_no);
		model.addAttribute("article", qnaBoardService.getArticle(article_no));
		return "/qnaboard/articleInfo";
	}

	@RequestMapping(value = "/qnaboard/replyForm.do")
	public String replyForm(@RequestParam(value = "article_no", required = true) String article_no, Locale locale,
			Model model) throws Exception {
		model.addAttribute("article", qnaBoardService.getArticle(article_no));
		return "/qnaboard/replyForm";
	}
	
	
	@RequestMapping(value = "/qnaboard/articleWrite.do")
	public String articleWrite(@RequestParam(value = "book_no", required = true) String book_no, Locale locale,
			Model model) throws Exception {
		model.addAttribute("book_no", book_no);
		return "/qnaboard/articleWrite";
	}

	
	@RequestMapping(value = "/qnaboard/articleSetEdit.do")
	public String articleSetEdit(@RequestParam(value = "article_no", required = true) String article_no, Locale locale,
			Model model) throws Exception {
		model.addAttribute("article", qnaBoardService.getArticle(article_no));
		return "/qnaboard/articleSetEdit";
	}
	
	@RequestMapping(value = "/qnaboard/articleUpdate.do")
	public ResponseEntity articleUpdate(@ModelAttribute("QnaBoardVO")QnaBoardVO qnaBoardVO, Locale locale,
			Model model) throws Exception {
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		String message = qnaBoardService.articleUpdate(qnaBoardVO);
		ResponseEntity resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	@ResponseBody
	@RequestMapping(value = "/qnaboard/articleDelete.do")
	public Map<String,Object> articleDelete(@RequestParam(value = "article_no", required = true) String article_no, Model model) throws Exception {
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("status",qnaBoardService.deleteArticle(article_no));
		return returnMap;
	}


	@RequestMapping(value = "/qnaboard/articleInsert.do")
	public ResponseEntity articleInsert(@ModelAttribute("QnaBoardVO")QnaBoardVO qnaBoardVO,Locale locale, Model model)
			throws Exception {
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		String message = qnaBoardService.insertArticle(qnaBoardVO);
		ResponseEntity resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	
	}
	
	@RequestMapping(value = "/qnaboard/replyInsert.do")
	public ResponseEntity replyInsert(@ModelAttribute("QnaBoardVO")QnaBoardVO qnaBoardVO,Locale locale, Model model)
			throws Exception {
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		String message = qnaBoardService.insertReply(qnaBoardVO);
		ResponseEntity resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	
	}
	
	
}
