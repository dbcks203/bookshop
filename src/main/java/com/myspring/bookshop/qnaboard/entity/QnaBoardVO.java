package com.myspring.bookshop.qnaboard.entity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class QnaBoardVO {
	
	int article_no;
	int parent_no;
	int book_no;
	String article_type;
	String title;
	String content;
	String writeId;
	String writeDate;
	int viewCount;
}
