package com.myspring.bookshop.qnaboard.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.bookshop.mybatis.mappers.QnaBoardDAO;
import com.myspring.bookshop.qnaboard.entity.QnaBoardVO;

@Service
public class QnaBoardService {

	@Autowired
	QnaBoardDAO qnaBoardDAO;

	public QnaBoardVO getArticle(String article_no) throws Exception {
		return qnaBoardDAO.selectView(article_no);
	}
	
	
	
	public boolean deleteArticle(String article_no) {
		try {
			qnaBoardDAO.deleteArticle(article_no);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public String insertArticle(QnaBoardVO qnaBoardVO) {
		String message = "<script>";
		qnaBoardVO.setArticle_type("질문글");
		String url = "\"/bookshop/book/bookInfo.do?book_no=" + qnaBoardVO.getBook_no() + "\";";
		try {
			qnaBoardDAO.insertArticle(qnaBoardVO);
			message += " alert('성공했습니다');";
		} catch (Exception e) {
			message += " alert('뭔가 잘못했습니다 다시해요');";
			e.printStackTrace();
		}
		message += "location.href=" + url + "</script>";
		return message;
	}

	public String insertReply(QnaBoardVO qnaBoardVO) {
		String message = "<script>";
		String url = "\"/bookshop/book/bookInfo.do?book_no=" + qnaBoardVO.getBook_no() + "\";";
		qnaBoardVO.setArticle_type("답변글");
		qnaBoardVO.setTitle("[답변]" + qnaBoardVO.getTitle());
		try {
			qnaBoardDAO.insertReply(qnaBoardVO);
			message += " alert('성공했습니다');";
		} catch (Exception e) {
			message += " alert('뭔가 잘못했습니다 다시해요');";
			e.printStackTrace();
		}
		message += "location.href=" + url + "</script>";
		return message;
	}

	public void addViewCount(String article_no) {
		qnaBoardDAO.addViewCount(article_no);
	}



	public String articleUpdate(QnaBoardVO qnaBoardVO) {
		
		String message = "<script>";
		String url = "\"/bookshop/qnaboard/articleInfo.do?article_no=" + qnaBoardVO.getArticle_no() + "\";";
		try {
			qnaBoardDAO.updateArticle(qnaBoardVO);
			message += " alert('성공했습니다');";
		} catch (Exception e) {
			message += " alert('뭔가 잘못했습니다 다시해요');";
			e.printStackTrace();
		}
		message += "location.href=" + url + "</script>";
		return message;
	}
}