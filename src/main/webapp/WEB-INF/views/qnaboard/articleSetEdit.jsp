<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HTML 편집기 예제</title>
<style type="text/css">

/* 넓이 높이 조절 */
.ck.ck-editor {
	max-width: 1000px;
}

.ck-editor__editable {
	min-height: 300px;
}
</style>
<script
	src="https://cdn.ckeditor.com/ckeditor5/35.3.2/classic/ckeditor.js"></script>
<script
	src="https://cdn.ckeditor.com/ckeditor5/35.3.2/classic/translations/ko.js"></script>
</head>
<body>

	<form id="updateForm" method="post" action="<c:url value='/qnaboard/articleUpdate.do'/>">
		<input type="hidden" name="article_no" value="${article.article_no}">
		<input type="hidden" name="book_no" value="${article.book_no}">
		<label>제목</label> 
		<input type="text" name="title" value ="${article.title}" size="50"><br> 
		<label>내용</label>
		<textarea name="content" id="editor">${article.content}</textarea>
		<input type="button" id="cancle" value="돌아가기">
		<input type="submit" value="수정하기">
	</form>
	



	<script>
	document.querySelector("#cancle").onclick=()=>{
		location.href= "<c:url value='/book/bookInfo.do?book_no=${book_no}'/>";
	};
	ClassicEditor
	.create( document.querySelector( '#editor' ), {language : "ko"} )
	.catch( error => {
	    console.error( error );
	});
		
	</script>
</body>
</html>