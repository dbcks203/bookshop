<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>


<head>
  <title>결제하기</title>
  <script src="https://js.tosspayments.com/v1/payment"></script>
</head>
<body>

<input type="button" id="TOSSPAY" value ="토스페이" onclick = "onLoadPayment('토스페이')">

네이버페이 / NAVERPAY
삼성페이 / SAMSUNGPAY
엘페이 / LPAY
카카오페이 / KAKAOPAY
페이코 / PAYCO
LG페이 / LGPAY
SSG페이 / SSG


  <script>
    var clientKey = 'test_ck_JQbgMGZzorzBWmyNgP2rl5E1em4d'
    var tossPayments = TossPayments(clientKey) // 클라이언트 키로 초기화하기
    
    function onLoadPayment(card){
    	tossPayments.requestPayment('카드', { 
      	  amount: "${book_order.tatalAmount}",
      	  orderId: "${book_order.order_no}",
      	  customerName: "${book_order.member_id}",
      	  successUrl: "<c:url value='/pay/paySuccess.do'/>",
        	  failUrl: "<c:url value='/pay/payFail.do'/>",
      	  flowMode: 'DIRECT',
      	  easyPay: '토스페이'
      	})
      	.catch(function (error) {
      	  if (error.code === 'USER_CANCEL') {
      	    // 결제 고객이 결제창을 닫았을 때 에러 처리
      	  } else if (error.code === 'INVALID_CARD_COMPANY') {
      	    // 유효하지 않은 카드 코드에 대한 에러 처리
      	  }
      	})
    }
    
  </script>
  
</body>


</html>