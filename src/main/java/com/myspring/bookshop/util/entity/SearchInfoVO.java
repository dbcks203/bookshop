package com.myspring.bookshop.util.entity;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SearchInfoVO {
	String listSizeStr;
	String pageNoStr;
	String table;
	String sortKey; 
	String[] searchValues;
	String[] searchKeys;
}
