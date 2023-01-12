<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
	integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
	crossorigin="anonymous"></script>
<meta charset="UTF-8">

<style type="text/css">
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


<title>답변글</title>

</head>
<body>
	<h2>답변글</h2>

	<form id="replyInfo" method="post" action="<c:url value='/qnaboard/replyInsert.do'/>">
		<input type="hidden" name="parent_no" value="${article.article_no}">
		<input type="hidden" name="book_no" value="${article.book_no}">
		<input type="hidden" name="writeId"
			value="${sessionScope.member.member_id}"> <label>제목</label> <input
			type="text" name="title" size="50"><br> <label>내용</label>
		<textarea name="content" id="editor"></textarea>
		<input type="submit" value="답글등록"> 
		<input type="button" id="cancle" value="돌아가기">
	</form>

	<script type="text/javascript">
	
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