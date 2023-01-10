<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Youzan's Project</title>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="article_no" value="${article.article_no}" />
<c:set var="book_no" value="${article.book_no}" />
</head>
<body>
	<h1>
		TITLE: [ <small>${article.title}</small> ]
	</h1>
	<h3>
		<br>작성자: ${article.writeId}<br>작성일: ${article.writeDate}<br>조회수:
		${article.viewCount}
	</h3>
	<br>
	<h4>CONTENT: ${article.content}</h4>
	<br>

	<div class="btns">
		<c:if
			test="${fn:toUpperCase(article.writeId) eq fn:toUpperCase(sessionScope.member.member_id)}">
			<input type="button" id="update" value="수정하기">
			<input type="button" id="delete" value="삭제하기">
		</c:if>
		<c:if test="${article.article_no == article.parent_no}">
			<input type="button" id="reply" value="답글쓰기">
		</c:if>
		<input type="button" id="cancle" value="돌아가기">
	</div>
</body>
<script>

document.querySelector("#cancle").onclick=()=>{
	location.href= "<c:url value='/book/bookInfo.do?book_no=${book_no}'/>";
};

///이거 함수로 줘야함!!
document.querySelector("#reply").onclick=()=>{
	location.href="<c:url value='/qnaboard/replyForm.do?article_no=${article_no}'/>";
};
document.querySelector("#update").onclick=()=>{
	location.href="<c:url value='/qnaboard/updateForm.do?article_no=${article_no}'/>";
};
document.querySelector("#delete").onclick=()=>{
	location.href="<c:url value='/qnaboard/articleDelete.do?article_no=${article_no}'/>";
};

</script>
</html>