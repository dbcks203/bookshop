package com.myspring.bookshop.mybatis.mappers;

import com.myspring.bookshop.qnaboard.entity.QnaBoardVO;

public interface QnaBoardDAO {
	
	QnaBoardVO selectView(String article_no);
	
	void deleteArticle(String article_no);

	void insertArticle(QnaBoardVO qnaBoardVO);
}
