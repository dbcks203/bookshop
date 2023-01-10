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

	public void deleteArticle(String article_no) {
		qnaBoardDAO.deleteArticle(article_no);
	}

	public boolean InsertArticle(QnaBoardVO qnaBoardVO) {
		qnaBoardDAO.insertArticle(qnaBoardVO);
		
		return true; 
	}
}