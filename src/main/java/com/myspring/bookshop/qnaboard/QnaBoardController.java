package com.myspring.bookshop.qnaboard;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

		model.addAttribute("article", qnaBoardService.getArticle(article_no));
		return "/qnaboard/articleInfo";
	}

	@RequestMapping(value = "/qnaboard/replyForm.do")
	public String replyForm(@RequestParam(value = "article_no", required = true) String article_no, Locale locale,
			Model model) throws Exception {
		model.addAttribute("article", qnaBoardService.getArticle(article_no));
		return "/qnaboard/replyForm";
	}

	@RequestMapping(value = "/qnaboard/updateForm.do")
	public String updateForm(@RequestParam(value = "article_no", required = true) String article_no, Locale locale,
			Model model) throws Exception {
		model.addAttribute("article", qnaBoardService.getArticle(article_no));
		return "/qnaboard/updateForm";
	}
	
	@ResponseBody
	@RequestMapping(value = "/qnaboard/articleDelete.do")
	public String articleDelete(@RequestParam(value = "article_no", required = true) String article_no,
			@RequestParam(value = "book_no") String book_no, Locale locale, Model model) throws Exception {

		qnaBoardService.deleteArticle(article_no);
		return "/book/bookInfo.do?book_no=" + book_no;
	}

	@ResponseBody
	@RequestMapping(value = "/qnaboard/replyInsert.do", method = RequestMethod.POST)
	public Map<String, Object> addMember(@ModelAttribute("QnaBoardVO") QnaBoardVO qnaBoardVO, Locale locale, Model model)
			throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		qnaBoardVO.setArticle_type("답변글");
		map.put("status",qnaBoardService.InsertArticle(qnaBoardVO));
		map.put("url","/book/bookInfo.do?book_no="+qnaBoardVO.getBook_no());
		return map;
	}
}
