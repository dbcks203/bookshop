package com.myspring.bookshop.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.myspring.bookshop.book.service.BookService;
import com.myspring.bookshop.member.service.MemberService;
import com.myspring.bookshop.util.entity.SearchInfoVO;
import com.myspring.bookshop.util.paging.Paging;
import com.myspring.bookshop.util.paging.PagingService;
import com.myspring.bookshop.util.service.UtilService;

@RestController
public class AdminRestController {

	@Autowired
	MemberService memberService;

	@Autowired
	BookService bookService;

	@Autowired
	UtilService utilService;

	@RequestMapping(value = "/admin/viewList.do")
	public Map<String, Object> viewList(@ModelAttribute SearchInfoVO searchInfo) {

		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(searchInfo);
		/*
		Map<String, Object> parameters = new HashMap<String, Object>();
		Map<String, String> searchMap = new HashMap<String, String>();
		//String pageNoStr = searchInfo.getPageNoStr();
		//System.out.println(searchInfo.getSearchKeys());
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
		*/
		return map;
		
	}
	
/*
	@RequestMapping(value = "/admin/memberDelete.do")
	public Map<String, Object> adminDelete(@RequestParam("member_id") String uid) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		memberService.deleteMember(uid);

		map.put("status", true);
		map.put("message", "회원을 삭제했습니다.");

		return map;
	}

	@RequestMapping(value = "/admin/updateMemberAvailable.do")
	public Map<String, Object> updateUseYn(@RequestParam("member_id") String uid, @RequestParam("useYn") String use_yn)
			throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		memberService.updateUseYn(uid, "Y".equals(use_yn) ? "N" : "Y");

		map.put("status", true);
		map.put("message", "회원의 상태를 변경하였습니다.");

		return map;
	}

	@RequestMapping(value = "/admin/suggestMember.do")
	public Map<String, Object> suggest(@RequestParam("searchKey") String searchKey,@RequestParam("text") String text) {

		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> parameters= new HashMap<String, Object>();
		Map<String, String> searchMap = new HashMap<String, String>();
		List<String> list =null;
		
		final int rowSize = 5;
		final int startPage = rowSize;
		
		searchMap.put(searchKey, text);
		parameters.put("table", "bs_table");
		parameters.put("sortKey", "book_no");
		parameters.put("suggestValue", searchKey);
		parameters.put("startPage", startPage);
		parameters.put("rowSize", rowSize);
		parameters.put("searchMap", searchMap);
		
		if (!text.equals("")) {
			text = text == null ? "" : text;
			list = utilService.suggestAnd(parameters);
		}

		map.put("status", true);
		map.put("suggestResult", list);

		return map;
	}

	
	
	@RequestMapping(value = "/admin/bookDelete.do")
	public Map<String, Object> bookDelete(@RequestParam("book_no") String book_no) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		bookService.deleteBook(book_no);

		map.put("status", true);
		map.put("message", "회원을 삭제했습니다.");

		return map;
	}

	@RequestMapping(value = "/admin/updateBookAvailable.do")
	public Map<String, Object> updateUseYnBook(@RequestParam("book_no") String book_no,
			@RequestParam("useYn") String use_yn) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		bookService.updateUseYn(book_no, "Y".equals(use_yn) ? "N" : "Y");

		map.put("status", true);
		map.put("message", "회원의 상태를 변경하였습니다.");

		return map;
	}

	
	@RequestMapping(value = "/admin/suggestBook.do")
	public Map<String, Object> suggestBook(@RequestParam("text") String text,
			@RequestParam("kategorie") String kategorie, @RequestParam("searchKey") String searchKey) {
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> parameters= new HashMap<String, Object>();
		Map<String, String> searchMap = new HashMap<String, String>();
		List<String> list =null;
		
		final int rowSize = 5;
		final int startPage = rowSize;
		
		searchMap.put("book_kategorie", kategorie);
		searchMap.put(searchKey, text);

		parameters.put("table", "book");
		parameters.put("suggestValue", "book_title");
		parameters.put("sortKey", "book_no");
		parameters.put("startPage", startPage);
		parameters.put("rowSize", rowSize);
		parameters.put("searchMap", searchMap);
		
		if (!text.equals("")) {
			text = text == null ? "" : text;
			list = utilService.suggestAnd(parameters);
		}

		map.put("status", true);
		map.put("suggestResult", list);

		return map;
	}

	@RequestMapping(value = "/admin/bookList.do")
	public Map<String, Object> bookList(@RequestParam("text") String text, @RequestParam("searchKey") String searchKey,
			@RequestParam("kategorie") String kategorie, @RequestParam("pageNoStr") String pageNoStr,
			@RequestParam("listSizeStr") String listSizeStr) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		Map<String, String> searchMap = new HashMap<String, String>();
		
		if ("".equals(pageNoStr) || null == pageNoStr)
			pageNoStr = "1";
		text = text == null ? "" : text;
		
		final int pageNo = Integer.parseInt(pageNoStr);
		final int pageSize = 10;
		final int rowSize = Integer.parseInt(listSizeStr);
		final int startPage = (pageNo - 1) * rowSize;
		
		searchMap.put("book_kategorie", kategorie);
		searchMap.put(searchKey, text);

		parameters.put("table", "book");
		parameters.put("sortKey", "book_no");
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
*/
}
