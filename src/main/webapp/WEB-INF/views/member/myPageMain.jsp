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

	<a href="${contextPath}/member/infoMember.do">상세정보</a>
	<br> <a href="${contextPath}/">돌아가기</a>
	
</body>
</html>