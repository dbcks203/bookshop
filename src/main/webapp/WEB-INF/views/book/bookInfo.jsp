<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class='card'>
		<img class='card-img-top' style ='width : 300' src='/bookshop/fileDownload.do?book_no=${book.book_no}'>
		<div class='card-body'>
			<h5>Title: ${book.book_title}</h5>
			<p class='card-text'>
				Writer : ${book.book_writer}<br> 
				Price : ${book.book_price}<br>
				Categorie : ${book.book_kategorie}<br>
				Date : ${book.book_upload_date}<br>
			</p>
			<a href='${contextPath}/book/bookListForm.do'>돌아가기</a>
		</div>
	</div>
</body>
</html>