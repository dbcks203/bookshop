<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script src="https://cdn.ckeditor.com/ckeditor5/35.3.2/classic/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/35.3.2/classic/translations/ko.js"></script>
</head>
<body>

<form method="post" action="articleedit.zan">
	<label>제목</label>
	<input type="text" name="subject" id="title" value = "${boardDTO.subject}"><br/>
	<input type="hidden" name="seq" id="seq" value = "${boardDTO.seq}">
	<label>내용</label>
	<textarea name="content" id="editor">"${boardDTO.content}"</textarea>
	<input type="submit" value="수정하기">
</form>
<button type="button" class="btn btn-default"
				onclick="location.href ='articlelist.zan';">돌아가기</button>
<script>
        ClassicEditor
            .create( document.querySelector( '#editor' ), {language : "ko"} )
            .catch( error => {
                console.error( error );
        } );
</script>
</body>
</html>