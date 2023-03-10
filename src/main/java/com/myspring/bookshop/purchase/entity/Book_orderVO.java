package com.myspring.bookshop.purchase.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Book_orderVO {
	private String order_no;
	private String book_no;
	private String member_id;
	private String quantity;
	private String payment_key;
	private String worked_date;
}
