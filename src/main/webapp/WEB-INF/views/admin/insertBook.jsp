<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-2.2.4.js"
	integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI="
	crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="uploadForm">
		제목 : <input type="text" name="book_title" /><br> 저자 : <input
			type="text" name="book_writer" /><br> 가격 : <input type="text"
			name="book_price" /><br> 카테고리 : <select name="book_kategorie">
			<option value="comic">만화</option>
			<option value="improvement">자기계발</option>
			<option value="genreFiction">장르소설</option>
			<option value="reference">참고서</option>
			<option value="license">자격증</option>
		</select><br> IMAGE : <input type="file" name="file" /><br /> <input
			type="submit" value="전송" /> <input type="reset" value="초기화" />
	</form>
</body>

<script>
document.querySelector("#uploadForm").addEventListener('submit', e=>{
	 e.preventDefault();
	$.ajax({ 
        url: "<c:url value='/admin/fileUpload.do'/>",
        type : 'POST',
    	enctype: 'multipart/form-data',
    	processData: false,
    	contentType: false,
        data: new FormData(e.target),
        success : function(json) {
        	if(json.status==true){
        		alert("등록에 성공했습니다.");
        		location.href="/bookshop/"+json.url+".do";
        	}
        	else
        		alert("등록에 성공했습니다.");
        }
    })       
});

</script>
</html>

