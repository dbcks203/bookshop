<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
	integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
	crossorigin="anonymous"></script>

<title>파일</title>

</head>
<body>

	<form name="boardForm" id="boardForm" method="post">
		<label>제목</label> <input type="text" name="subject" id="subject"><br />
		<label>내용</label> <input name="content" id="content" /> <label>태그</label>
		<select name="tag" id="tag">
			<option value="N">적용안함</option>
			<option value="Y">적용함</option>
		</select>
		<table>
			<tbody>
				<tr>
					<th><label>첨부파일</label></th>
					<td><input type="file" name="filename1" id="filename1" /></td>
					<td><input type="button" value="추가" class="insertFile"></td>
				</tr>
			</tbody>
			<tfoot>
				<tr style="display: none">
					<th><label>첨부파일</label></th>
					<td><input type="file" name="filename1" id="filename1" /></td>
					<td><input type="button" value="추가" class="insertFile"></td>
					<td><input type="button" value="삭제" class="deleteFile"></td>
				</tr>
			</tfoot>
		</table>

		<input type="submit" id="write" name="write" value="등록"> <input
			type="button" name="cancle" value="취소" onClick="history.back()">

	</form>



	<script>
	let tbody = document.querySelector("tbody");
	let tr = document.querySelector("tfoot tr");
	let insertFile = document.querySelector(".insertFile");

	function insertFileEventHandler() {
	   let newTr = tr.cloneNode(true);
	   tbody.append(newTr);
	   newTr.style.display = "";
	   
	   //newTr.querySelector(".insertFile").addEventListener("click", insertFileEventHandler);
	   newTr.querySelector(".deleteFile").addEventListener("click", e => {
	      tbody.removeChild(e.target.parentNode.parentNode)
	   });
	}  

	insertFile.addEventListener("click", insertFileEventHandler);


	

        
        let boardForm = document.querySelector("#boardForm");
        boardForm.addEventListener("submit", (e) => {
        	e.preventDefault();
        	
        	fetch("articlewrite.zan", {		
        		method : 'POST',
        	    cache: 'no-cache',
        		body: new FormData(boardForm)		
        	})
        	.then(response => response.json())
        	.then(jsonResult => {
        		alert(jsonResult.message);
        		if (jsonResult.status == true) {
        			location.href = jsonResult.url;
        		}
        	});
        });
</script>
</body>
</html>