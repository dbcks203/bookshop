<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Youzan's Project</title>
<c:set var="member_id" value="${sessionScope.member.member_id}" />
<c:set var="article_no" value="${article.article_no}" />
<c:set var="parent_no" value="${article.parent_no}" />
<c:set var="book_no" value="${article.book_no}" />

<script src="https://code.jquery.com/jquery-2.2.4.js"
	integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI="
	crossorigin="anonymous"></script>


</head>
<body>
	<h1>
		TITLE: [ <small>${article.title}</small> ]
	</h1>
	<h3>
		<br>작성자: ${article.writeId} <br>작성일: ${article.writeDate} <br>조회수:
		${article.viewCount}
	</h3>
	<br>
	<h4>CONTENT: ${article.content}</h4>
	<br>

	<div class="btns">
		write: ${article.writeId}<br> member :
		${sessionScope.member.member_id}
		<c:if test="${article.writeId eq sessionScope.member.member_id}">
			<input type="button" id="update" value="수정하기">
			<input type="button" id="delete" value="삭제하기">
		</c:if>
		<c:if test="${article.article_no eq article.parent_no}">
			<input type="button" id="reply" value="답글쓰기">
		</c:if>
		<input type="button" id="cancle" value="돌아가기">
	</div>
</body>
<script>

function ycAddEventHandler(id, handler) {
	let obj = document.querySelector(id);
	if (obj) {
		obj.addEventListener("click", e => handler(e));
	}
}

ycAddEventHandler("#cancle", e => {
	location.href= "<c:url value='/book/bookInfo.do?book_no=${book_no}'/>";
});

ycAddEventHandler("#reply", e => {
	location.href="<c:url value='/qnaboard/replyForm.do?article_no=${article_no}'/>";
});

ycAddEventHandler("#update", e => {
	location.href="<c:url value='/qnaboard/articleSetEdit.do?article_no=${article_no}'/>";
});

ycAddEventHandler("#delete", e => {
	e.preventDefault();
	$.ajax({ 
        url: "<c:url value='/qnaboard/articleDelete.do'/>",
        method: "get",
        data: {
        	"article_no" : "${article_no}",
        	"parent_no" : "${parent_no}"},
        dataType : "json",
        success : function(json) {
        	if (json.status==true) {
   	         alert("삭제했습니다.");
   	         location.href= "<c:url value='/book/bookInfo.do?book_no=${book_no}'/>";
   	      }
        }
    })      
});

</script>
</html>