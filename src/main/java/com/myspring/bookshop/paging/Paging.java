package com.myspring.bookshop.paging;

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

	
	public int getCurrentPageNo() {
		return currentPageNo;
	}

	public void setCurrentPageNo(int currentPageNo) {
		this.currentPageNo = currentPageNo;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getListSize() {
		return listSize;
	}

	public void setListSize(int listSize) {
		this.listSize = listSize;
	}

	public int getTotalPageNo() {
		return totalPageNo;
	}

	public void setTotalPageNo(int totalPageNo) {
		this.totalPageNo = totalPageNo;
	}

	public int getStartPageNo() {
		return startPageNo;
	}

	public void setStartPageNo(int startPageNo) {
		this.startPageNo = startPageNo;
	}

	public int getEndPageNo() {
		return endPageNo;
	}

	public void setEndPageNo(int endPageNo) {
		this.endPageNo = endPageNo;
	}
}
