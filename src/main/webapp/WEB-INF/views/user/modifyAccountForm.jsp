<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
</head>
<script>
$(function(){
	$("#userDel").click(function(){
		var userid = "${sessionScope.userid}";
		$.ajax({
			type : 'get'
			,url : 'userDel'
			,data : {'userid' : userid}
			,success : function(result){
					if(result=="ok"){
						alert("탈퇴하였습니다.");
						location.href="main";
					}else{
						alert("탈퇴 실패했습니다.");
						return;
					}
				}
			,error : function(result){
					alert("에러발생");
				}
		})
	})
})
$(function(){
	var pwcheck = false;
	$("#modify").click(function(){
		var userid = "${sessionScope.userid}";
		var userpw = $("#userpw").val();
		$.ajax({
			type : 'get'
			,url : 'pwcheck'
			,async : false
			,data : {'userid':userid,'userpw':userpw}
			,success : function(result){
					if(result=="ok"){
						pwcheck = true;
					}else{
						pwcheck = false;
					}
				}
			,error : function(result){
					alert("체크에러");
				}
		})
		if(pwcheck==false){
			alert("비밀번호를 다시 입력해주세요.");
			return;
		}
		var nickname = $("#nickname").val();
		$.ajax({
			type : 'post'
			,url : 'modify'
			,data : {'userid':userid,"nickname":nickname}
			,success : function(result){
					if(result=="ok"){
						alert("수정 성공!");
						location.href="board";
					}else{
						alert("수정 실패");
						return;
					}
				}
			,error : function(result){
					alert("수정에러");
				}
			})
	})
})
</script>
</head>
<body>
아이디 : <input type="text" value="${sessionScope.userid }" readonly="readonly"><br>
비밀번호 : <input type="password" id="userpw"><br>
닉네임 : <input type="text" id="nickname" value="${sessionScope.nickname }"><br>
<button id="modify">수정하기</button>
<button id="userDel">탈퇴</button>
</body>
</html>