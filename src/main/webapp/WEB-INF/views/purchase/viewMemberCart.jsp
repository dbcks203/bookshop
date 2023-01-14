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
	<input type="button" id="cart" value="장바구니">
	<table>
		<thead>
			<tr>
				<th>카테고리</th>
				<th>제목</th>
				<th>저자</th>
				<th>가격</th>
				<th>수량</th>
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
		list.forEach(function(ele) {
			chartHtml += "<tr>";
			chartHtml += "<td>" + ele.book_kategorie + "<td>";
			chartHtml += "<td>" + ele.book_title + "</td>";
			chartHtml += "<td>" + ele.book_writer + "</td>";
			chartHtml += "<td>" + ele.book_price + "<input type='hidden' id='price"+ele.order_no+"' value="+ele.book_price+"></td>";
			chartHtml += "<td>" + ele.quantity + "</td>";
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
				else
					$("#dataTableBody").innerText = '';
			}
		});
	}
	
	document.querySelector("#purchase").onclick=()=>{
		let orderArray = [];
		let totalPrice=0;
 		document.querySelectorAll(".check").forEach(check_box=>{
			if (check_box.checked){
				totalPrice+=Number(document.querySelector("#price"+check_box.value).value);
				orderArray.push(check_box.value);
			}
		});
		$.ajax({
			method : "post",
			url : "<c:url value='/purchase/purchaseBook.do'/>",
			data : {
				"order_array":orderArray,
				"total_price":totalPrice
				},
			traditional: true,
			dataType : "json",
			success : function(json) {
				if (json.status == true){
					location.href="/bookshop"+json.url;
				}
				else
					alert("구매에 실패했습니다.");
			}
	
		
		});
		loadList();
	}

	document.querySelector("#delete").onclick=()=>{
		let count =0;
		document.querySelectorAll(".check").forEach(check_box=>{
			if (check_box.checked){
				$.ajax({
					method : "get",
					url : "<c:url value='/purchase/deleteOrder.do?order_no="+check_box.value+"'/>",
					success: function(json){
						if (json.status == true)
							count++;
						}
					});
				}
		});
		alert(count+"건 삭제했습니다.");
		loadList();
	}
	
	
	document.querySelector("#back").onclick=()=>{
		location.href= "<c:url value='/member/myPageMain.do'/>";
	};
	
</script>



</html>
