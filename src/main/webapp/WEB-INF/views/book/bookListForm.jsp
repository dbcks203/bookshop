<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<title>검색 도서 목록 페이지</title>
<head>
<script src="https://code.jquery.com/jquery-2.2.4.js"
	integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI="
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
	crossorigin="anonymous" defer>
	
</script>
<link rel="stylesheet" href="/bookshop/resources/static/css/style_boardList.css">
<style type="text/css">
#dataBody {
	display: flex;
	flex-flow: row wrap;
}

#dataBody ul {
    padding: 0px !IMPORTANT;
	margin: 1rem;
}
</style>
</head>
<body>
	<h2>BooksList</h2>

	<form name="searchForm">
		검색어 <input type="text" placeholder="제목,내용,작성자를 입력" id="text"
			name="text" value="${param.text}" maxlength="130" autocomplete="off">
		<input type="button" value="검색" onclick="jsSearch()">
		<div id="suggestion_box"></div>
	</form>

	<select id="dataPerPage">
		<option value="6">6개씩보기</option>
		<option value="12">12개씩보기</option>
		<option value="18">18개씩보기</option>
		<option value="24">24개씩보기</option>
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

	<div id="dataBody"></div>

	<ul id="pagingul"></ul>

</body>


<script type="text/javascript">

	let currentPageNo = 1;
	let search = "";
	let kategorie="";
	let searchKey="book_title";
	listSize = $("#dataPerPage").val();
	loadList();

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
			chartHtml += "<ul class='card'>";
			chartHtml += "<img src=${contextPath}/fileDownload.do?book_no="+book.book_no+" class='card-img-top' style ='width: 240'>";
			chartHtml += "<li class='card-body'>";
			chartHtml += "<h5>Title: "+ book.book_title +"</h5>";
			chartHtml += "<p class='card-text'>Writer: " + book.book_writer+"<br>price: "+book.book_price + "$</p>";
			chartHtml += "<a href=${contextPath}/book/bookInfo.do?book_no="+book.book_no+" class='btn btn-primary'>상세보기</a>";
			chartHtml += "</li>";
			chartHtml += "</ul>";
		});
		return chartHtml;
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
				$("#dataBody").html(displayData(json.list));
				$("#pagingul").html(json.pageHtml);
			}
		});
	}
</script>



</html>
