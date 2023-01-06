package com.myspring.bookshop.member.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {
	private String member_id;
	private String member_pw;
	private String member_name;
	private String member_sex;
	private String member_birth;
	private String tel;
	private String email;
	private String zipcode;
	private String address;
	private String joinDate;
	private String use_yn;
}
