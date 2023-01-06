package com.myspring.bookshop.member.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.bookshop.member.entity.MemberVO;
import com.myspring.bookshop.mybatis.mappers.MemberDAO;
import com.myspring.bookshop.mybatis.mappers.UtilDAO;

@Service
public class MemberService {

	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	UtilDAO utilDAO;
	
	
	public MemberVO login(String member_id, String member_pw) {
		MemberVO memberVO = memberDAO.selectView(member_id);
		if (memberVO != null && memberVO.getMember_pw().equals(member_pw)) {
			return memberVO;
		}

		return null;
	}

	public void addMember(MemberVO memberVO) {

		memberDAO.insertMember(memberVO);
	}

	public boolean overlapped(String uid) throws Exception {
		if (memberDAO.selectView(uid) == null)
			return true;

		else
			return false;

	}

	public MemberVO getMember(String uid) throws Exception {
		return memberDAO.selectView(uid);
	}

	public MemberVO updateMember(MemberVO memberVO) throws Exception {
		memberDAO.updateMember(memberVO);

		return getMember(memberVO.getMember_id());
	}

	public void deleteMember(String uid) throws Exception {
		memberDAO.deleteMember(uid);
	}

	public void updateUseYn(String uid, String use_yn) {

		Map<String, Object> parameters = new HashMap<String, Object>();
		parameters.put("use_yn", use_yn);
		parameters.put("member_id", uid);
		memberDAO.updateAvailable(parameters);
	}

	

	
	
	
	
	
	
	
	
	
	public List<String> suggest(String text,String searchKey, int pageNo, int pageSize) {
		List<String> list = new ArrayList<String>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		Map<String, String> searchMap = new HashMap<String, String>();
		
		text = text == null ? "" : text;
		searchMap.put(searchKey, text);

		final int rowSize = pageSize;
		
		int startPage = (pageNo - 1) * rowSize;
		
		parameters.put("table", "bs_member");
		parameters.put("suggestValue", searchKey);
		parameters.put("sortKey", "joinDate");
		parameters.put("startPage", startPage);
		parameters.put("rowSize", rowSize);
		parameters.put("searchMap", searchMap);
		
		list = utilDAO.suggestAnd(parameters);

		return list;
	}
	
	public int totalPageNo(String text, int listSize) {
		Map<String, Object> parameters = new HashMap<String, Object>();

		int totalPageSize = 0;
		int rowSize = listSize;
		if (text == null)
			text = "";

		parameters.put("rowSize", rowSize);
		parameters.put("text", text);
		totalPageSize = memberDAO.totalCount(parameters);

		return totalPageSize;
	}

	public List<MemberVO> listMembers(String text, int pageNo, int pageSize) {
		List<MemberVO> list = new ArrayList<MemberVO>();
		Map<String, Object> parameters = new HashMap<String, Object>();
		final int rowSize = pageSize;
		int startPage = (pageNo - 1) * rowSize;
		text = text == null ? "" : text;

		parameters.put("text", text);
		parameters.put("startPage", startPage);
		parameters.put("rowSize", rowSize);

		list = memberDAO.listMembers(parameters);

		return list;
	}

}