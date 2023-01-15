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


	<select id="kategorie">
		<option value="">전체</option>
		<option value="comic">만화</option>
		<option value="improvement">자기계발</option>
		<option value="genreFiction">장르소설</option>
		<option value="reference">참고서</option>
		<option value="license">자격증</option>
	</select>

	<select id="searchKey">
		<option value="book_title">제목</option>
		<option value="book_writer">저자</option>
	</select>

	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>카테고리</th>
				<th>저자</th>
				<th>가격</th>
				<th>등록일</th>
				<th>활성화</th>
			</tr>
		</thead>
		<tbody id=dataTableBody>
		</tbody>
	</table>

	<ul id="pagingul"></ul>
	
	<input type="button" id="insert_book" value="책 추가하기">
</body>


<script type="text/javascript">

	let currentPageNo = 1;
	let search = "";
	let kategorie="";
	let searchKey="book_title";
	listSize = $("#dataPerPage").val();
	loadList();
	
	document.querySelector("#insert_book").onclick=()=>{
		location.href= "<c:url value='/admin/insertBook.do'/>";
	}; 

	$("#dataPerPage").change(function() {
		listSize = $("#dataPerPage").val();
		currentPageNo = 1;
		loadList();
	});
	
	$("#kategorie").change(function() {
		kategorie = $("#kategorie").val();
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
            	'table' : 'book',
				'sortKey' : "book_no",
				'searchKeys' : [searchKey,"book_kategorie"],
				'searchValues' : [$(this).val(), kategorie]
				},
            dataType : "json",
            success : function(json) {
            	suggestHtml="";
            	if(json.suggestResult!=null){
            	json.suggestResult.forEach(book=> {
   				suggestHtml += "<tr><td>" + book + "</td></tr>";
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
		list.forEach(function(book) {
			chartHtml += "<tr>";
			chartHtml += "<td>" + book.book_no + "</td>";
			chartHtml += "<td>" + book.book_title + "</td>";
			chartHtml += "<td>" + book.book_kategorie + "</td>";
			chartHtml += "<td>" + book.book_writer + "</td>";
			chartHtml += "<td>" + book.book_price + "</td>";
			chartHtml += "<td>" + book.book_upload_date + "</td>";
			chartHtml += "<td>" + book.use_yn + "</td>";
			chartHtml += "<td><a href='#' class='deleteUids' data-id="+book.book_no+">삭제</a></td>";
			
			var dump = book.use_yn == 'Y' ? '사용' : '미사용';
			chartHtml += "<td><a href='#' class='useYns' ><span id=book"+book.book_no+" data-id="+book.book_no+" data-useyn="+book.use_yn+">"+dump+"</span></a></td>";
			chartHtml += "</tr>";
		});
		return chartHtml;
	}

	function setEvent() {
		$(".deleteUids").on("click", e => {
	    	let aLink = e.target;
	    	let book_no = aLink.getAttribute("data-id");
			e.preventDefault();
	    	if (!confirm("삭제 할시겠습니까?")) return;
	    	
	    	$.ajax({
				type:"post"
				,url : "${contextPath}/book/bookDelete.do"
				,data : {"book_no" : book_no}	
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
			let book_no = aLink.getAttribute("data-id");
	    	let useYn = aLink.getAttribute("data-useyn");
			if (!confirm((useYn == 'Y' ? '미사용' : '사용') +  "으로 변경하시겠습니까?")) return;
			
	    	$.ajax({
				type:"post"
				,url : "${contextPath}/book/updateBookAvailable.do"
				,data : {
					"book_no" : book_no,
					"useYn" : useYn}
				,dataType : "JSON"
				,success : function(json) {
					alert(json.message);
		    		if (json.status == true) {
		    			let useYnSpan = document.querySelector("#book"+book_no);
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
			url : "${contextPath}/util/viewList.do",
			traditional: true,
			data : {
				'listSizeStr' : listSize,
				'pageNoStr' : currentPageNo,
				'table' : 'book',
				'sortKey' : "book_no",
				'searchKeys' : ["book_kategorie",searchKey],
				'searchValues' : [kategorie,search]
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