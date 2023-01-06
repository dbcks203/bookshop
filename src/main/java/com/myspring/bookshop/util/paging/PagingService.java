package com.myspring.bookshop.util.paging;

public class PagingService {
	
	
	public static String retPageService(Paging page) {

		int currentPageNo = page.getCurrentPageNo();
		int totalPageNo = page.getTotalPageNo();
		int startPageNo = page.getStartPageNo();
		int endPageNo = page.getEndPageNo();

		String pageHtml = "";

		if (currentPageNo != 1) {
			pageHtml += "<li><a href='javascript:movePage(1)'> &lt;&lt; </a></li>";
			pageHtml += "<li><a href='javascript:movePage(" + (currentPageNo - 1) + ")'> &lt; </a></li>";
		}
		for (int i = startPageNo; i <= endPageNo; i++) {
			if (currentPageNo == i)
				pageHtml += "<li class='on'><a href=javascript:movePage(" + i + ")>" + i + "</a></li>";
			else
				pageHtml += "<li><a href=javascript:movePage(" + i + ")>" + i + "</a></li>";
		}

		if (currentPageNo != totalPageNo) {
			pageHtml += "<li><a href='javascript:movePage(" + (currentPageNo + 1) + ")'> &gt; </a></li>";
			pageHtml += "<li><a href='javascript:movePage(" + totalPageNo + ")'> &gt;&gt; </a></li>";
		}

		return pageHtml;
	}
}
