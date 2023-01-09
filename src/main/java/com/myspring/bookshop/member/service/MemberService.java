package com.myspring.bookshop.member.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.myspring.bookshop.member.entity.MemberVO;
import com.myspring.bookshop.mybatis.mappers.MemberDAO;

@Service
public class MemberService {

	@Autowired
	MemberDAO memberDAO;
	
	
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
}