package com.myspring.bookshop.book.entity;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BookVO {
	
	private String book_no;
	private String book_title;
	private String book_kategorie;
	private String book_writer;
	private int    book_price;
	@JsonFormat(pattern = "yyyy-MM-dd:mm:ss",timezone="Asia/Seoul" )
	private Timestamp book_upload_date;
	private String use_yn;
}
