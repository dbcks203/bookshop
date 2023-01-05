package com.myspring.bookshop.mybatis.mappers;

import java.util.List;
import java.util.Map;

import com.myspring.bookshop.member.entity.MemberVO;

public interface MemberDAO {
	MemberVO selectView(String member_id);
	
	void insertMember(MemberVO memberVO);

	void updateMember(MemberVO memberVO);

	void deleteMember(String uid);

	int totalCount(Map<String, Object> parameters);

	List<MemberVO> listMembers(Map<String, Object> parameters);

	void updateAvailable(Map<String, Object> parameters);
}
