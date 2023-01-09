package com.myspring.bookshop.util.paging;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Paging {

	private int currentPageNo; // 현재 페이지
	private int pageSize;
	private int listSize;// 한 페이지당 글 수
	private int totalPageNo; // 총 글 갯수
	private int startPageNo; // 현재페이지의 시작번호
	private int endPageNo; // 현재페이지의 끝번호

	public Paging(int currentPageNo, int pageSize, int listSize, int totalPageNo) {
		super();

		this.currentPageNo = currentPageNo;
		this.totalPageNo = totalPageNo;
		this.pageSize = pageSize;
		this.listSize = listSize;

		this.startPageNo = ((currentPageNo - 1) / pageSize) * pageSize + 1;
		this.endPageNo = startPageNo + pageSize - 1;

		if (endPageNo > totalPageNo)
			this.endPageNo = totalPageNo;
	}
}
