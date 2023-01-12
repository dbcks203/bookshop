<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-2.2.4.js"
	integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI="
	crossorigin="anonymous"></script>

<c:set var="member_id" value="${sessionScope.member.member_id}" />
<title>장바구니</title>
</head>
<body>
	<h2>cart</h2>

	<table>
		<thead>
			<tr>
				<th>카테고리</th>
				<th>제목</th>
				<th>저자</th>
				<th>가격</th>
				<th>선택</th>
			</tr>
		</thead>
		<tbody id=dataTableBody>
		</tbody>
	</table>

	<input type="button" id="purchase" value="구매하기">
	<input type="button" id="delete" value="삭제하기">
	<input type="button" id="back" value="돌아가기">

</body>


<script type="text/javascript">
	loadList();
	function displayData(list) {
		let chartHtml = "";
		list
				.forEach(function(ele) {
					chartHtml += "<tr>";
					chartHtml += "<td>" + ele.book_kategorie + "<td>";
					chartHtml += "<td>" + ele.book_title + "</td>";
					chartHtml += "<td>" + ele.book_writer + "</td>";
					chartHtml += "<td>" + ele.book_price + "</td>";
					chartHtml += "<td><input type='checkbox' class='check' value='"+ele.order_no+"'/><td>";
					chartHtml += "</tr>";
				});
		return chartHtml;
	}

	function loadList() {
		var param = {
			'table1' : 'book_order',
			'table2' : 'book',
			'member_id' : '${member_id}'
		};
		$.ajax({
			method : "POST",
			url : "<c:url value='/purchase/memberCartList.do'/>",
			data : JSON.stringify(param),
			dataType : "json",
			contentType : "application/json",
			success : function(json) {
				if (json.status == true)
					$("#dataTableBody").html(displayData(json.list));
			}
		});
	}
	
	document.querySelector("#delete").onclick=()=>{
		document.querySelectorAll(".check").forEach(check_box=>{
			if (check_box.checked){
				var param = {
						"deleteValue":check_box.value,
						"deleteKey":"order_no",
						"table":"book_order"
						}
				$.ajax({
					method : "POST",
					url : "<c:url value='/purchase/deleteOrder.do'/>",
					data : JSON.stringify(param),
					dataType : "json",
					contentType : "application/json"});
				}
		});
		loadList();
	}
	
	
	document.querySelector("#back").onclick=()=>{
		location.href= "<c:url value='/member/myPageMain.do'/>";
	};
	function getCheckboxValue(e) {
		
		if (event.target.checked) {
			result = event.target.value;
		} else {
			result = '';
		}

		
	}
</script>



</html>
