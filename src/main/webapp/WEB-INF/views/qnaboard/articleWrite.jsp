<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
	integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
	crossorigin="anonymous"></script>

<title>����</title>

</head>
<body>

	<form name="boardForm" id="boardForm" method="post">
		<label>����</label> <input type="text" name="subject" id="subject"><br />
		<label>����</label> <input name="content" id="content" /> <label>�±�</label>
		<select name="tag" id="tag">
			<option value="N">�������</option>
			<option value="Y">������</option>
		</select>
		<table>
			<tbody>
				<tr>
					<th><label>÷������</label></th>
					<td><input type="file" name="filename1" id="filename1" /></td>
					<td><input type="button" value="�߰�" class="insertFile"></td>
				</tr>
			</tbody>
			<tfoot>
				<tr style="display: none">
					<th><label>÷������</label></th>
					<td><input type="file" name="filename1" id="filename1" /></td>
					<td><input type="button" value="�߰�" class="insertFile"></td>
					<td><input type="button" value="����" class="deleteFile"></td>
				</tr>
			</tfoot>
		</table>

		<input type="submit" id="write" name="write" value="���"> <input
			type="button" name="cancle" value="���" onClick="history.back()">

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