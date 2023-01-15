<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:insertAttribute name="title" /></title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<style type="text/css">
.con {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	
}

.con header, .con div {
	margin: 1rem;
	
}

#userInfo {
	display: flex;
	justify-content: space-around;
	align-items: center;
}

#userInfo a {
	margin: 1rem;
}
</style>
</head>
<body>
	<div class="con">
		<header>
			<a class="navbar-brand" href="<c:url value='/'/>">살려주세요</a>
		</header>
		<div id="userInfo">
			<c:choose>
				<c:when test="${isLogOn == true  && member != null}">
				환영합니다. ${member.member_name}님!
				<a class="btn btn-primary"
						href="<c:url value='/member/myPageMain.do'/>">My Page</a>
					<a class="btn btn-primary"
						href="<c:url value='/member/logOut.do?member_id=${member.member_name}'/>">LogOut</a>
					<a class="btn btn-primary"
						href="<c:url value='/book/bookListForm.do'/>">Book List</a>
				</c:when>
				<c:otherwise>
					<a class="btn btn-primary"
						href="<c:url value='/member/loginForm.do'/>">Sign In</a>
					<a class="btn btn-primary"
						href="<c:url value='/member/memberForm.do'/>">Sign Up</a>
				</c:otherwise>
			</c:choose>
		</div>

	</div>
</body>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
	crossorigin="anonymous" defer></script>
</html>
