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
	
	<select id="searchKey">
		<option value="member_id">아이디</option>
		<option value="member_name">이름</option>
		<option value="member_birth">생년월일</option>
		<option value="email">이메일</option>
		<option value="zipcode">우편번호</option>
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
	<input type="button" id="cancel" value="메인으로">
</body>


<script type="text/javascript">

	let currentPageNo = 1;
	let search = "";
	let searchKey= $("#searchKey").val();
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
	
	
	$("#searchKey").change(function() {
		searchKey = $("#searchKey").val();
		console.log(searchKey);
	});
	
	$("#text").keyup(function() {
        $.ajax({ 
            url: "${contextPath}/util/suggest.do",
            method: "get",
            traditional: true,
            data: { 
            	'table' : 'bs_member',
				'sortKey' : "joinDate",
				'searchKeys' : [searchKey],
				'searchValues' : [$(this).val(),"",""]
				},
            dataType : "json",
            success : function(json) {
            	suggestHtml="";
            	if(json.suggestResult!=null){
            	json.suggestResult.forEach(member=> {
   				suggestHtml += "<tr><td>" + member + "</td></tr>";
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
			chartHtml += "<td>" + new Date(member.joinDate) + "</td>";
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
	    	if (!confirm("삭제 할시겠습니까?")) return;
	    	
	    	$.ajax({
				type:"post"
				,url : "${contextPath}/member/adminDelete.do"
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
				,url : "${contextPath}/member/updateMemberAvailable.do"
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
		console.log(search);
		$.ajax({
			method : "post",
			url : "${contextPath}/util/viewList.do",
			traditional: true,
			data : {
				'listSizeStr' : listSize,
				'pageNoStr' : currentPageNo,
				'table' : 'bs_member',
				'sortKey' : "joinDate",
				'searchValues' : [search,"",""],
				'searchKeys' : [searchKey]
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