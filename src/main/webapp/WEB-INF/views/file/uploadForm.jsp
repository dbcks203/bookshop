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
<form name="uploadForm" method="post" action="<c:url value='/fileUpload.do'/>" enctype="multipart/form-data">
	아이디 : <input type="text" name="uid" id="uid" value="sun"/><br/>
	이름 : <input type="text" name="name" id="name" value="선경"/><br/>
	파일 : <input type="file" name="file0" id="file0"/><br/>
	파일 : <input type="file" name="file1" id="file1"/><br/>
	파일 : <input type="file" name="file2" id="file2"/><br/>
	<input type="submit" value="전송"/>
	<input type="reset" value="초기화"/>
</form>
</body>
</html>