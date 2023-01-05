package com.myspring.bookshop.admin;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.myspring.bookshop.member.entity.MemberVO;
import com.myspring.bookshop.member.service.MemberService;
import com.myspring.bookshop.mybatis.mappers.MemberDAO;
import com.myspring.bookshop.paging.Paging;
import com.myspring.bookshop.paging.PagingService;

@RestController
public class AdminRestController {
	
	
	@Autowired 
	MemberService memberService;

	
	@RequestMapping(value = "/admin/memberList.do")	
	public Map<String, Object> memberList(@RequestParam("text") String text,@RequestParam("pageNoStr") String pageNoStr,@RequestParam("listSizeStr") String listSizeStr){

		Map<String, Object> map = new HashMap<String, Object>();
		if ("".equals(pageNoStr) || null == pageNoStr) 
			pageNoStr = "1";
		
		int pageNo = Integer.parseInt(pageNoStr);		
		int pageSize = 10;
		int listSize = Integer.parseInt(listSizeStr);
		
		
		Paging page = new Paging(pageNo,pageSize,listSize,memberService.totalPageNo(text,listSize));
		List<MemberVO> list = memberService.listMembers(text, pageNo, listSize);
		
	
		map.put("status", true);
		map.put("list", list);
		map.put("pageHtml",PagingService.retPageService(page));
		return map;
	}
	
	@RequestMapping(value = "/admin/memberDelete.do")	
	public Map<String, Object> adminDelete(@RequestParam("member_id") String uid) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		memberService.deleteMember(uid);
		
		map.put("status", true);
		map.put("message", "회원을 삭제했습니다.");


	return map;
	}
	
	@RequestMapping(value = "/admin/updateAvailable.do")
	public Map<String, Object> updateUseYn(@RequestParam("member_id") String uid, @RequestParam("useYn") String use_yn)
			throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		memberService.updateUseYn(uid, "Y".equals(use_yn) ? "N" : "Y");
	
			map.put("status", true);
			map.put("message", "회원의 상태를 변경하였습니다.");
			
		return map;
	}
	
	
	@RequestMapping(value = "/admin/suggestMember.do")
	public Map<String, Object> suggest(@RequestParam("text") String text) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<MemberVO> list = null;

		
		int pageNo = 1;		
		int listSize = 5;
		if(!text.equals("")) {
			list = memberService.serchByTitle(text, pageNo, listSize);
		}
		
	
		map.put("status", true);
		map.put("suggestResult", list);
		
		return map;
	}

}
