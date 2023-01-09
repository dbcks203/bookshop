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

	@RequestMapping(value = "/member/adminDelete.do")
	public Map<String, Object> adminDelete(@RequestParam("member_id") String uid) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		memberService.deleteMember(uid);

		map.put("status", true);
		map.put("message", "회원을 삭제했습니다.");

		return map;
	}

	@RequestMapping(value = "/member/updateMemberAvailable.do")
	public Map<String, Object> updateUseYn(@RequestParam("member_id") String uid, @RequestParam("useYn") String use_yn)
			throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		memberService.updateUseYn(uid, "Y".equals(use_yn) ? "N" : "Y");

		map.put("status", true);
		map.put("message", "회원의 상태를 변경하였습니다.");

		return map;
	}

}
