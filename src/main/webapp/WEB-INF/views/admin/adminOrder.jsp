<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet"
	href="/bookshop/resources/static/css/style_boardList.css">

<script src="https://code.jquery.com/jquery-2.2.4.js"
	integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI="
	crossorigin="anonymous"></script>
<title>Youzan's Project Master Page</title>
</head>
<style type="text/css">
#dataBody {
	display: flex;
	flex-flow: row wrap;
}

#dataBody ul {
	padding: 0px !IMPORTANT;
	margin: 1rem;
}

#pagingul {
	display: flex;
	justify-content: center;
	padding: 1rem;
}

#pagingul li {
	font-size: 1rem;
	margin: 0.5rem;
}

#pagingul li a {
	font-size: 1rem;
}
</style>
<body>
	<h2>BooksList</h2>

	<form name="searchForm">
		검색어 <input type="text" id="text" name="text" value="${param.text}"
			maxlength="130" autocomplete="off"> <input type="button"
			value="검색" onclick="jsSearch()">
		<div id="suggestion_box"></div>
	</form>

	<select id="dataPerPage">
		<option value="10">10개씩보기</option>
		<option value="15">15개씩보기</option>
		<option value="20">20개씩보기</option>
		<option value="25">25개씩보기</option>
		<option value="30">30개씩보기</option>
	</select>


	<select id="status">
		<option value="">전체</option>
		<option value="배송취소">배송취소</option>
		<option value="배송준비중">배송준비중</option>
		<option value="배송중">배송중</option>
		<option value="배송완료">배송완료</option>
	</select>

	<select id="searchKey">
		<option value="delivery_no">배송번호</option>
		<option value="book_no">책번호</option>
		<option value="member_id">아이디</option>
		<option value="payment_key">결제키</option>
		<option value="payment_no">결제번호</option>
	</select>

	<table>
		<thead>
			<tr>
				<th>배송번호</th>
				<th>아이디</th>
				<th>주문일</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody id=dataTableBody>
		</tbody>
	</table>

	<ul id="pagingul"></ul>
	<input type="button" id="cancel" value="메인으로">
</body>


<script type="text/javascript">

	let currentPageNo = 1;
	let search = "";
	let status = "";
	let searchKey="delivery_no";
	
	listSize = $("#dataPerPage").val();
	loadList();
	
	document.querySelector("#cancel").onclick=()=>{
		location.href= "<c:url value='/admin/adminMain.do'/>";
	};

	$("#dataPerPage").change(function() {
		listSize = $("#dataPerPage").val();
		currentPageNo = 1;
		loadList();
	});
	
	$("#status").change(function() {
		status = $("#status").val();
		currentPageNo = 1;
		loadList();
	});
	
	$("#searchKey").change(function() {
		searchKey = $("#searchKey").val();
		console.log(searchKey);
	});
	
	$("#text").keyup(function() {
        $.ajax({ 
            url: "<c:url value='/util/suggest.do'/>",
            method: "get",
            traditional: true,
            data: { 
            	'table' : 'book_delivery',
				'sortKey' : "worked_date",
				'searchKeys' : [searchKey,"status"],
				'searchValues' : [$(this).val(), status]
				},
            dataType : "json",
            success : function(json) {
            	suggestHtml="";
            	if(json.suggestResult!=null){
            	json.suggestResult.forEach(ele=> {
   				suggestHtml += "<tr><td>" + ele + "</td></tr>";
   				});
            	}
            	$("#suggestion_box").html(suggestHtml);
            }
        })       
    });

	function movePage(pageNo) {
		currentPageNo = pageNo;
		loadList();
	}
	
	function jsSearch() {
		search = document.querySelector("#text").value;
		currentPageNo = 1;
		loadList();
	}
	
	function displayData(list) {	
		let chartHtml = "";
		list.forEach(function(ele) {
			chartHtml += "<tr>";
			chartHtml += "<td>" + ele.delivery_no + "</td>";
			chartHtml += "<td>" + ele.member_id + "</td>";
			chartHtml += "<td>" + new Date(ele.worked_date) + "</td>";
			chartHtml += "<td><a href='#' class='delivery_status' data-id="+ ele.delivery_no+" data-status="+ ele.status+">"+ ele.status + "</a></td>";
			chartHtml += "</tr>";
		});
		return chartHtml;
	}

	function setEvent() {
		$(".delivery_status").on("click", e => {
			e.preventDefault();
	    	let aLink = e.target;
	    	let status = aLink.getAttribute("data-status");
	    	let delivery_no = aLink.getAttribute("data-id");
	    	if(status=='배송준비중'){
	    		if (!confirm("상태를 배송중으로 변경 할시겠습니까?")) return;
	    	}
	    	else if(status=='배송중'){
	    		if (!confirm("상태를 배송완료로 변경 할시겠습니까?")) return;
	    	}
	    	else{
	    		alert("상태를 변경할 수 없습니다."); return;
	    	}
	    	$.ajax({
				type:"post"
				,url : "<c:url value='/purchase/changeDeliveryStatus.do'/>"
				,data : {
					"delivery_no" : delivery_no,
					"status":status}
				,dataType : "JSON"
				,success : function(json) {
					if (json.status == true) {
						alert("상태를 변경 했습니다.");
						loadList();    			
					}
					else{
						alert("실패했습니다.");
					}
				}
	 		});
	    });
		
	}
	
	function loadList() {
		$.ajax({
			method : "post",
			url : "<c:url value='/util/viewList.do'/>",
			traditional: true,
			data : {
				'listSizeStr' : listSize,
				'pageNoStr' : currentPageNo,
				'table' : 'book_delivery',
				'sortKey' : "worked_date",
				'searchKeys' : ["status",searchKey],
				'searchValues' : [status,search]
			},
			dataType : "json",
			success : function(json) {
				$("#dataTableBody").html(displayData(json.list));
				$("#pagingul").html(json.pageHtml);
				setEvent();
			}
		});
	}
</script>

</body>
</html>