<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="member_id" value="user01" />
<title>Youzan's Project</title>
</head>
<body>

	<a href="${contextPath}/member/infoMember.do">상세정보</a>
	<br> <a href="${contextPath}/">돌아가기</a>
	<br> <a href="<c:url value='/purchase/viewMemberCart.do'/>">장바구니보기</a>
	<br> <a href="<c:url value='/purchase/viewMemberPayment.do'/>">결제내역보기</a>
	<br> <a href="<c:url value='/purchase/viewMemberDelivery.do'/>">배송상태조회</a>
	
</body>
</html>