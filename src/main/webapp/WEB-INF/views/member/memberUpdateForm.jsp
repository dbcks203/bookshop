<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<title>Insert title here</title>
</head>
<body>



	<form method="post" action="${contextPath}/member/memberUpdate.do">
		<input type="hidden" name="member_id" id="member_id" value="${memberBean.member_id}"> 
		<label>이름</label>
		<input type="text" name="member_name" id="member_name" value="${memberBean.member_name}"><br>
		<label>성별</label>
		<input type="text" name="member_sex" id="member_sex" value="${memberBean.member_sex}"><br>
		<label>생년월일</label>
		<input type="text" name="member_birth" id="member_birth" value="${memberBean.member_birth}"><br>
		<label>email</label>
		<input type="text" name="email" id="email" value="${memberBean.email}"><br>
		<label>주소</label>
		<input type="text" name="address" id="address" value="${memberBean.address}"><br>
		<label>전화번호</label>
		<input type="text" name="tel" id="tel" value="${memberBean.tel}"><br>
		<label>가입일</label>
		<input type="text" name="joinDate" id="joinDate" value="${memberBean.joinDate}"><br>
		
		<input type="submit" value="수정하기">
	</form>
	<button type="button" class="btn btn-default"
		onclick="location.href ='mypage.zan';">돌아가기</button>


</body>
</html>