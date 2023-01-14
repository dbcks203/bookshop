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
	<table>
		<thead>
			<tr>
				<th>카테고리</th>
				<th>제목</th>
				<th>저자</th>
				<th>개별 금액</th>
				<th>수량</th>
				<th>금액</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody id=dataTableBody>
		</tbody>
	</table>

	<input type="button" id="back" value="돌아가기">

	<script>
    
    
  </script>
</body>


<script type="text/javascript">

	loadList();
	
	function displayData(list) {
		let chartHtml = "";
		let real_price = 0;
		list.forEach(function(ele) {
			real_price = (Number(ele.book_price) * Number(ele.quantity));
			chartHtml += "<tr>";
			chartHtml += "<td>" + ele.book_kategorie + "</td>";
			chartHtml += "<td>" + ele.book_title + "</td>";
			chartHtml += "<td>" + ele.book_writer + "</td>";
			chartHtml += "<td>" + ele.book_price + "</td>";
			chartHtml += "<td>" + ele.quantity + "</td>";
			chartHtml += "<td>" + real_price + "</td>";
			chartHtml += "<td>" + ele.status + "</td>";
			chartHtml += "</tr>";
		});
		return chartHtml;
	}

	function loadList() {
		$.ajax({
			method : "POST",
			url : "<c:url value='/purchase/memberPaymentList.do'/>",
			data : {'key':'member_id','value':'${member_id}','status':'결제완료'},
			dataType : "json",
			success : function(json) {
				if (json.status == true)
					$("#dataTableBody").html(displayData(json.list));
				else
					$("#dataTableBody").innerText = '';
			}
		});
	}
	
	document.querySelector("#back").onclick=()=>{
		location.href= "<c:url value='/member/myPageMain.do'/>";
	};
	</script>
</html>