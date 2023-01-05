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
<body>
	<h2>MasterPage</h2>
	<h3>관 리 자</h3>

	<form name="searchForm">
		검색어 <input type="text" placeholder="제목,내용,작성자를 입력" id="text"
			name="text" value="${param.text}" maxlength="130" autocomplete="off">
		<input type="button" value="검색" onclick="jsSearch()">
		<div id="suggestion_box"></div>
	</form>

	<select id="dataPerPage">
		<option value="10">10개씩보기</option>
		<option value="15">15개씩보기</option>
		<option value="20">20개씩보기</option>
		<option value="25">25개씩보기</option>
		<option value="30">30개씩보기</option>
	</select>

	<table>
		<thead>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>성별</th>
				<th>생년월일</th>
				<th>번호</th>
				<th>이메일</th>
				<th>우편번호</th>
				<th>주소</th>
				<th>가입일</th>
				<th>활성화</th>
			</tr>
		</thead>
		<tbody id=dataTableBody>
		</tbody>
	</table>

	<ul id="pagingul"></ul>
</body>


<script type="text/javascript">
	let currentPageNo = 1;
	let search = document.querySelector("#text").value;
	listSize = $("#dataPerPage").val();
	loadList();
	

	$("#dataPerPage").change(function() {
		listSize = $("#dataPerPage").val();
		currentPageNo = 1;
		loadList();
	});
	
	$("#text").keyup(function() {
        $.ajax({ 
            url: "${contextPath}/admin/suggestMember.do",
            data: { "text" : $(this).val() },
            dataType : "json",
            method: "get",
            success : function(json) {
            	suggestHtml="";
            	if(json.suggestResult!=null){
            	json.suggestResult.forEach(member=> {
   				suggestHtml += "<tr><td>" + member.member_id + "</td></tr>";
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
		list.forEach(function(member) {
			chartHtml += "<tr>";
			chartHtml += "<td>" + member.member_id + "</td>";
			chartHtml += "<td>" + member.member_name + "</td>";
			chartHtml += "<td>" + member.member_sex + "</td>";
			chartHtml += "<td>" + member.member_birth + "</td>";
			chartHtml += "<td>" + member.tel + "</td>";
			chartHtml += "<td>" + member.email + "</td>";
			chartHtml += "<td>" + member.zipcode + "</td>";
			chartHtml += "<td>" + member.address + "</td>";
			chartHtml += "<td>" + member.joinDate + "</td>";
			chartHtml += "<td>" + member.use_yn + "</td>";
			chartHtml += "<td><a href='#' class='deleteUids' data-uid="+member.member_id+">삭제</a></td>";
			
			var dump = member.use_yn == 'Y' ? '사용' : '미사용';
			chartHtml += "<td><a href='#' class='useYns' ><span id="+member.member_id+" data-uid="+member.member_id+" data-useyn="+member.use_yn+">"+dump+"</span></a></td>";
			chartHtml += "</tr>";
		});
		return chartHtml;
	}

	function setEvent() {
		$(".deleteUids").on("click", e => {
	    	let aLink = e.target;
	    	let member_id = aLink.getAttribute("data-uid");
			e.preventDefault();
			console.log(member_id);
	    	if (!confirm("삭제 할시겠습니까?")) return;
	    	
	    	$.ajax({
				type:"post"
				,url : "${contextPath}/admin/memberDelete.do"
				,data : {"member_id" : member_id}	
				,dataType : "JSON"
				,success : function(json) {
					alert(json.message);
					if (json.status == true) {
						loadList();    			
					}
				}
	 		});
	    });
		
		$(".useYns").on("click", e => {
			let aLink = e.target;
			e.preventDefault();
			let member_id = aLink.getAttribute("data-uid");
	    	let useYn = aLink.getAttribute("data-useyn");
			if (!confirm((useYn == 'Y' ? '미사용' : '사용') +  "으로 변경하시겠습니까?")) return;
			
	    	$.ajax({
				type:"post"
				,url : "${contextPath}/admin/updateAvailable.do"
				,data : {
					"member_id" : member_id,
					"useYn" : useYn}	
				,dataType : "JSON"
				,success : function(json) {
					alert(json.message);
		    		if (json.status == true) {
		    			let useYnSpan = document.querySelector("#"+member_id);
		    			if (useYnSpan != null) {
		    				useYnSpan.innerText = (useYn == 'Y' ? '미사용' : '사용'); 
		    				aLink.setAttribute("data-useyn", useYn == 'Y' ? 'N' : 'Y');
		    			}
		    			loadList();
		    		}
				}
	 		});
		  });
	}
	
	function loadList() {
		$.ajax({
			method : "post",
			url : "${contextPath}/admin/memberList.do",
			data : {
				"text" : search,
				"listSizeStr" : listSize,
				"pageNoStr" : currentPageNo
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