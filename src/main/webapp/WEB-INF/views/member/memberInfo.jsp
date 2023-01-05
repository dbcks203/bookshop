<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<title>Youzan's Project</title>
</head>
<body>
	<h1>
		ID: [ <small>${memberBean.member_id}</small> ]
	</h1>

		<h3>이름: ${memberBean.member_name}</h3><br>
		
		<h3>성별: ${memberBean.member_sex}</h3><br>
		
		<h3>생년월일: ${memberBean.member_birth}</h3><br>
		
		<h3>email: ${memberBean.email}</h3><br>

		<h3>주소: ${memberBean.address}</h3><br>

		<h3>전화번호: ${memberBean.tel}</h3><br>

		<h3>가입일: ${memberBean.joinDate}</h3><br>

	
	<a href="${contextPath}/member/memberDelete.do?member_id=${memberBean.member_id}">탈퇴</a>
	
	<a href="${contextPath}/member/memberUpdateForm.do">수정</a>
	
	<br> <a href="${contextPath}/member/myPageMain.do">돌아가기</a>
</body>
</html>