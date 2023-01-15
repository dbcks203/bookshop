package com.myspring.bookshop.file.entity;

import java.io.Serializable;
import java.math.BigInteger;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ManageFile implements Serializable {
	private static final long serialVersionUID = -6675626554487766989L;

	private int f_id;
	private int book_no;
	private long number;
	private String org_name;
	private String real_name ; ;
	private String content_type;
	private BigInteger length;
	private String thumbnail;
}
   
