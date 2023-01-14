package com.myspring.bookshop.mybatis.mappers;

import java.util.Map;

import com.myspring.bookshop.qnaboard.entity.QnaBoardVO;

public interface QnaBoardDAO {
	
	QnaBoardVO selectView(String article_no);
	
	void deleteArticle(Map<String, String> parameterMap);

	void insertArticle(QnaBoardVO qnaBoardVO);

	void addViewCount(String article_no);

	void insertReply(QnaBoardVO qnaBoardVO);

	void updateArticle(QnaBoardVO qnaBoardVO);
}
