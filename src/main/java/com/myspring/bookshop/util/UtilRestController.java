package com.myspring.bookshop.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.myspring.bookshop.book.service.BookService;
import com.myspring.bookshop.member.service.MemberService;
import com.myspring.bookshop.util.entity.SearchInfoVO;
import com.myspring.bookshop.util.paging.Paging;
import com.myspring.bookshop.util.paging.PagingService;
import com.myspring.bookshop.util.service.UtilService;

@RestController
public class UtilRestController {
	
	@Autowired
	UtilService utilService;

	@RequestMapping(value = "/util/viewList.do")
	public Map<String, Object> viewList(@ModelAttribute SearchInfoVO searchInfo) {
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		Map<String, String> searchMap = new HashMap<String, String>();
		

		
		for (int i = 0; i < searchInfo.getSearchKeys().length; i++) {
			searchMap.put(searchInfo.getSearchKeys()[i], searchInfo.getSearchValues()[i]);
		}
		String pageNoStr = searchInfo.getPageNoStr();
		if ("".equals(pageNoStr) || null == pageNoStr)
			pageNoStr = "1";

		final int pageNo = Integer.parseInt(pageNoStr);
		final int pageSize = 10;
		final int rowSize = Integer.parseInt((String) searchInfo.getListSizeStr());
		final int startPage = (pageNo - 1) * rowSize;

		parameters.put("table", searchInfo.getTable());
		parameters.put("sortKey", searchInfo.getSortKey());
		parameters.put("startPage", startPage);
		parameters.put("rowSize", rowSize);
		parameters.put("searchMap", searchMap);
		
		Paging page = new Paging(pageNo, pageSize, rowSize, utilService.totalPageNoAnd(parameters));
		List<Map<String, Object>> list = utilService.searchAnd(parameters);

		map.put("status", true);
		map.put("list", list);
		
		map.put("pageHtml", PagingService.retPageService(page));

		return map;

	}

	@RequestMapping(value = "/util/suggest.do")
	public Map<String, Object> suggest(@ModelAttribute SearchInfoVO searchInfo) {
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		Map<String, String> searchMap = new HashMap<String, String>();
		List<String> list = null;

		final int rowSize = 5;
		final int startPage = 0;
		String[] searchKeys = searchInfo.getSearchKeys();
		String[] searchValues = searchInfo.getSearchValues();
		for (int i = 0; i < searchKeys.length; i++)
			searchMap.put(searchKeys[i], searchValues[i]);

		parameters.put("table", searchInfo.getTable());
		parameters.put("sortKey", searchInfo.getSortKey());
		parameters.put("suggestValue", searchKeys[0]);

		parameters.put("startPage", startPage);
		parameters.put("rowSize", rowSize);
		parameters.put("searchMap", searchMap);

		if (!searchValues[0].equals("")) {
			searchValues[0] = searchValues[0] == null ? "" : searchValues[0];
			list = utilService.suggestAnd(parameters);
		}

		map.put("status", true);
		map.put("suggestResult", list);

		return map;
	}
}
