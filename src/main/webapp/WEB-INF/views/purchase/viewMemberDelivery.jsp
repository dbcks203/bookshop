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
				<th>주문일</th>
				<th>카테고리</th>
				<th>제목</th>
				<th>저자</th>
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
		list.forEach(function(ele) {
			chartHtml += "<tr>";
			chartHtml += "<td>" + ele.worked_date + "</td>";
			chartHtml += "<td>" + ele.book_kategorie + "</td>";
			chartHtml += "<td>" + ele.book_title + "</td>";
			chartHtml += "<td>" + ele.book_writer + "</td>";
			chartHtml += "<td>" + ele.status + "</td>";
			if(ele.status=='배송준비중')
			chartHtml += "<td><a href='#' class='cancleDelivery' data-id="+ele.delivery_no+">배송취소</a></td>";
			chartHtml += "</tr>";
		});
		return chartHtml;
	}

	function loadList() {
		$.ajax({
			method : "POST",
			url : "<c:url value='/purchase/memberDeliveryList.do'/>",
			data : {'member_id':'${member_id}'},
			dataType : "json",
			success : function(json) {
				if (json.status == true){
					$("#dataTableBody").html(displayData(json.list));
					setEvent();
				}
				else
					$("#dataTableBody").innerText = '';
			}
		});
	}
	
	function setEvent() {
		$(".cancleDelivery").on("click", e => {
	    	let aLink = e.target;
	    	let delivery_no = aLink.getAttribute("data-id");
			e.preventDefault();
	    	if (!confirm("취소 할시겠습니까?")) return;
	    	$.ajax({
				type:"post"
				,url : "<c:url value='/purchase/cancleDelivery.do'/>"
				,data : {"delivery_no" : delivery_no}	
				,dataType : "JSON"
				,success : function(json) {
					if (json.status == true) {
						alert("취소했습니다.");
						loadList();    			
					}
					else{
						alert("실패했습니다.");
					}
				}
	 		});
	    });
	}
	document.querySelector("#back").onclick=()=>{
		location.href= "<c:url value='/member/myPageMain.do'/>";
	};
	</script>
</html>