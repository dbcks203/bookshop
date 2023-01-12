<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="/bookshop/resources/static/css/style_boardList.css">

<script src="https://code.jquery.com/jquery-2.2.4.js"
	integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI="
	crossorigin="anonymous"></script>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="book_no" value="${book.book_no}" />
<c:set var="member_id" value="${sessionScope.member.member_id}"/>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class='card'>
		<img class='card-img-top' style='width: 300'
			src='${contextPath}/fileDownload.do?book_no=${book.book_no}'>
		<div class='card-body'>
			<h2>Title: ${book.book_title}</h2>
			<p class='card-text'>
				Writer : ${book.book_writer}<br> Price : ${book.book_price}<br>
				Categorie : ${book.book_kategorie} <br> Date :
				${book.book_upload_date}<br>
			</p>

		</div>
	</div>
	<input type="button" id="cancle" value="돌아가기">
	<input type="button" id="add_cart" value="장바구니">
	<input type="button" id="purchase" value="구매하기">
	<input type="button" id="write" value="Q&A 작성">

	<h2>Q&A</h2>
	<form name="searchForm">
		검색어 <input type="text" placeholder="제목,내용,작성자를 입력" id="text"
			name="text" value="${param.text}" maxlength="130" autocomplete="off">
		<input type="button" value="검색" onclick="jsSearch()">
		<div id="suggestion_box"></div>
	</form>
	<select id="dataPerPage">
		<option value="5">5개씩보기</option>
		<option value="10">10개씩보기</option>
		<option value="15">15개씩보기</option>
	</select>

	<select id="searchKey">
		<option value="title">제목</option>
		<option value="writeid">작성자</option>
	</select>

	<select id="kategorie">
		<option value="">전체</option>
		<option value="질문글">질문</option>
		<option value="답변글">답변</option>
	</select>



	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>타입</th>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody id=dataTableBody>
		</tbody>
	</table>

	<ul id="pagingul">
	</ul>
	


</body>


<script type="text/javascript">
	let currentPageNo = 1;
	let search = "";
	let kategorie="";
	let searchKey="title";
	listSize = $("#dataPerPage").val();
	loadList();
	
	
	document.querySelector("#cancle").onclick=()=>{
		location.href= "<c:url value='/book/bookListForm.do'/>";
	};
	document.querySelector("#add_cart").onclick=()=>{
		location.href= "<c:url value='/purchase/insertCart.do?book_no=${book_no}&&member_id=${member_id}'/>";
	};
	document.querySelector("#purchase").onclick=()=>{
		location.href= "<c:url value='/purchase/bookInfo.do?book_no=${book_no}'/>";
	};
	document.querySelector("#write").onclick=()=>{
		location.href= "<c:url value='/qnaboard/articleWrite.do?book_no=${book_no}'/>";
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
            	'table' : 'qnaboard',
				'sortKey' : "writedate",
				'searchKeys' : [searchKey,"article_type"],
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
	
	function moveArticle(article_no) {
		location.href='${contextPath}/qnaboard/articleInfo.do?article_no='+article_no;
	}

	function displayData(list) {	
		let chartHtml = "";
		list.forEach(function(article) {
			chartHtml += "<tr>";
			chartHtml += "<td>" + article.article_no + "</td>";
			chartHtml += "<td>" + article.article_type + "</td>";
			chartHtml += "<td><a href='#' onclick='moveArticle("+article.article_no+")'>"+article.title+"</a></td>";
			chartHtml += "<td>" + article.writeId + "</td>";
			chartHtml += "<td>" + article.writeDate + "</td>";
			chartHtml += "<td>" + article.viewCount + "</td>";
			chartHtml += "</tr>";
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
		    	'table' : 'qnaboard',
				'sortKey' : "writedate",
				'searchKeys' : [searchKey,"article_type","book_no"],
				'searchValues' : [search, kategorie,${book_no}]
			},
			dataType : "json",
			success : function(json) {
				$("#dataTableBody").html(displayData(json.list));
				$("#pagingul").html(json.pageHtml);
			}
		});
	}
</script>


</html>