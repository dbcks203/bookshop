<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-2.2.4.js"
	integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI="
	crossorigin="anonymous"></script>
<script src="https://js.tosspayments.com/v1/payment"></script>
<c:set var="payment_key" value="${paymentKey}" />
<c:set var="order_id" value="${orderId}" />
<c:set var="total_amount" value="${amount}" />
</head>
<body>


</body>

<script>
$.ajax({
	method : "post",
	url : "<c:url value='/purchase/completePayment.do'/>",
	data : {"order_id":"${orderId}"},
	dataType : "json",
	success : function(json) {
		if (json.status == true){
			alert("성공했습니다.");
			location.href="/bookshop"+json.url;
		}
		else
			alert("실패했습니다.");
	}
});
  </script>

</html>