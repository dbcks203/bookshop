
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Landing Page - Start Bootstrap Theme</title>

</head>
<body>
	<h1>관리자입니다</h1>
	<input type="button" id="admin_member" value="회원 관리자">
	<input type="button" id="admin_book" value="상품 관리자">
	<input type="button" id="admin_order" value="주문 관리자">
</body>

<script type="text/javascript">
document.querySelector("#admin_member").onclick=()=>{
	location.href= "<c:url value='/admin/adminMember.do'/>";
};
document.querySelector("#admin_book").onclick=()=>{
	location.href= "<c:url value='/admin/adminBook.do'/>";
};
document.querySelector("#admin_order").onclick=()=>{
	location.href= "<c:url value='/admin/adminOrder.do'/>";
};

</script>

</html>
