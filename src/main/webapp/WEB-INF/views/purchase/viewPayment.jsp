<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-2.2.4.js"
	integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI="
	crossorigin="anonymous"></script>
<script src="https://js.tosspayments.com/v1/payment"></script>
<c:set var="member_id" value="${sessionScope.member.member_id}"/>
<c:set var="pay_key" value="${payment_key}"/>
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
			</tr>
		</thead>
		<tbody id=dataTableBody>
		</tbody>
	</table>
	<div id=payment_btns>
		<input type="button" id="TOSSPAY" value="토스페이"> 
		<input type="button" id="NAVERPAY" value="네이버페이"> 
		<input type="button" id="KAKAOPAY" value="카카오페이"> 
		<input type="button" id="PAYCO" value="페이코"> 
		<input type="button" id="LGPAY" value="LG페이"> 
		<input type="button" id="SSG" value="SSG페이">
	</div>

	<input type="button" id="delete" value="삭제하기">
	<input type="button" id="back" value="돌아가기">

	<script>
    
    
  </script>
</body>


<script type="text/javascript">
	loadList();
	var clientKey = 'test_ck_JQbgMGZzorzBWmyNgP2rl5E1em4d' // 테스트용 클라이언트 키
	var tossPayments = TossPayments(clientKey);
	let total_price = 0;
	document.querySelector("#payment_btns").childNodes.forEach(btn=>{
		btn.addEventListener('click',(e)=>{
			tossPayments.requestPayment('카드', {
				  amount: (total_price*1000),
				  orderId: 'paymentID_${pay_key}',
				  orderName: 'memberID_${member_id}',
				  customerName: 'youzan',
				  successUrl: 'http://localhost:8080/bookshop/purchase/successPayment.do',
				  failUrl: 'http://localhost:8080/bookshop/purchase/failPayment.do',
				  flowMode: 'DIRECT',
				  easyPay: e.target.value
				})
				.catch(function (error) {
				  if (error.code === 'USER_CANCEL') {
				    // 결제 고객이 결제창을 닫았을 때 에러 처리
				  } else if (error.code === 'INVALID_CARD_COMPANY') {
				    // 유효하지 않은 카드 코드에 대한 에러 처리
				  }
				})

		});
	});
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
			chartHtml += "</tr>";
			total_price += real_price;
		});
		chartHtml += "<tr><td><h3>총 결제액 :"+total_price+"</h3></td></tr>";
		return chartHtml;
	}

	function loadList() {
		$.ajax({
			method : "POST",
			url : "<c:url value='/purchase/memberPaymentList.do'/>",
			data : {'key':'payment_key','value':${payment_key},'status':'결제중'},
			dataType : "json",
			success : function(json) {
				if (json.status == true)
					$("#dataTableBody").html(displayData(json.list));
				else
					$("#dataTableBody").innerText = '';
			}
		});
	}
	
	
	document.querySelector("#delete").onclick=()=>{
		let count =0;
		document.querySelectorAll(".check").forEach(check_box=>{
			if (check_box.checked){
				$.ajax({
					method : "get",
					url : "<c:url value='/purchase/deletePayment.do?order_no="+check_box.value+"'/>",
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