<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<script>
	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				document.getElementById('zipcode').value = data.zonecode;
				document.getElementById('address').value = data.address;
				autoClose: true
			}
		}).open();
	}
</script>


 
</head>
<body>
	<h3>필수입력사항</h3>
	<form action="${contextPath}/member/addMember.do" method="post">
		<div id="detail_table">
			<table>
				<tbody>
					<tr class="dot_line">
						<td class="fixed_join">아이디</td>
						<td><input type="text" name="check_id" id="check_id"
							size="20" /> <input type="hidden" name="member_id"
							id="member_id" /> <input type="button" id="dupUidCheckButton"
							value="중복체크"/>
							<div id="uid_valid_msg"></div> </td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">비밀번호</td>
						<td><input name="member_pw" type="password" size="20" /></td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">이름</td>
						<td><input name="member_name" type="text" size="20" /></td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">성별</td>
						<td><input type="radio" name="member_sex" value="102" />
							여성<span style="padding-left: 120px"></span> <input type="radio"
							name="member_sex" value="101" checked />남성</td>
					</tr>
					<tr class="dot_line">
						<td class="fixed_join">생년월일</td>
						<td><input type="text" name="member_birth" size="20"></td>
					</tr>

					<tr class="dot_line">
						<td class="fixed_join">휴대폰번호</td>
						<td><input type="text" name="tel" size="20"></td>
					</tr>

					<tr class="dot_line">
						<td class="fixed_join">이메일<br>(e-mail)
						</td>
						<td><input size="20" type="text" name="email" />
					</tr>

					<tr class="dot_line">
						<td class="fixed_join">주소</td>
						<td><input type="text" id="zipcode" name="zipcode" size="10">
							<a href="javascript:execDaumPostcode()">우편번호검색</a> <br>
							<input type="text" id="address" name="address" size="50"></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="clear">
			<br>
			<br>
			<table align=center>
				<tr>
					<td><input type="submit" value="회원 가입"> <input type="reset" value="다시입력"></td>
				</tr>
			</table>
		</div>
	</form>
	<br> <a href="${contextPath}/">돌아가기</a>	   
</body>



<script type="text/javascript">

let dupUidCheckButton = document.querySelector("#dupUidCheckButton");
dupUidCheckButton.onclick = () => {
   dupUidCheck();
}

let uid = document.querySelector("#check_id");
uid.onblur = () => {
   dupUidCheck();
}



function dupUidCheck() {
	var check_id =  document.querySelector("#check_id").value;
	if (check_id == '') {
		alert("ID를 입력하세요");
		return;
	}
	fetch("<c:url value=''/>", {
		method : "post",
		headers: {
		    "Content-Type": "application/json",
		},
		body: JSON.stringify({"id":check_id.value}),
	})
	
	fetch("<c:url value='/member/overlapped.do?id="+check_id+"'/>", {
		method : "get",
		headers: {
		    "Content-Type": "application/json",
		}
	})
	.then(response => response.json())
	.then(jsonResult => {
		 if (jsonResult.status == false) {
		      alert("[" + check_id.value + "]" + jsonResult.message);
		   }
		   let uid_valid_msg = document.querySelector("#uid_valid_msg");
		   uid_valid_msg.innerHTML =  "[" + uid.value + "]" + jsonResult.message;
		   document.querySelector("#member_id").value = check_id;
	});
}

</script>
</html>