<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>파일 업로드 성공</h2>

<c:forEach var="file" items="${manageFileList}">
${file.org_name}<a href="<c:url value='/fileDownload.do?f_id=${file.f_id}'/>">다운로드</a>
	<c:if test="${not empty file.thumbnail}"> 
		<img src="<c:url value='/thumbnail.do?f_id=${file.f_id}'/>">
	</c:if>
	<br/>
</c:forEach>
</body>
</html>