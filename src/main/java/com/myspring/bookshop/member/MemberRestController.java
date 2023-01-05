package com.myspring.bookshop.member;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.myspring.bookshop.member.service.MemberService;

@RestController
public class MemberRestController {
	
	
	@Autowired 
	MemberService memberService;

	
	@RequestMapping(value = "/member/overlapped.do")
	public Map<String, String> overlapped(@RequestParam("id") String id, Model model) throws Exception {
		System.out.println(id);
		Map<String, String> map = new HashMap<String, String>();
		
		if( memberService.overlapped(id)) {
			map.put("message", "사용가능합니다.");
			map.put("status", "true");
		}
		else {
			map.put("message", "중복되었습니다.");
			map.put("status", "false");
			
		}
		return map;
	}
	
	
}
