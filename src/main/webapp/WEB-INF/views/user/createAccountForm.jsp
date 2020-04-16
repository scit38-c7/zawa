<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ZAWA アカウント登録</title>
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
	$(function() {
		var checked = false;
		$("#userid").keyup(function() {
			var userid = $("#userid").val();
			if (userid.length > 10) {
				var count = userid.substr(0, 10);
				$("#userid").val(count);
			}

			$.ajax({
				type : 'get',
				url : 'selectOne',
				data : {
					'userid' : userid
				},
				success : function(result) {
					if (result == "no") {
						checked = true;
					} else {
						checked = false;
						return;
					}
				},
				error : function(result) {
					alert("에러 발생");
				}
			})
		})

		$("#userpw").keyup(function() {
			var userpw = $("#userpw").val();
			if (userpw.length > 10) {
				var count = userpw.substr(0, 10);
				$("#userpw").val(count);
			}
		})

		$("#nickname").keyup(function() {
			var nickname = $("#nickname").val();
			if (nickname.length > 10) {
				var count = nickname.substr(0, 10);
				$("#nickname").val(count);
			}
		})

		$("#join").click(function() {
			var userid = $("#userid").val();
			if (userid.trim().length < 5) {
				alert("아이디는 5자 이상으로 하세요");
				$("#userid").focus();
				return;
			}

			if (checked == false) {
				alert("이미 있는 아이디 입니다.")
				$("#userid").select();
				return;
			}

			var userpw = $("#userpw").val();
			if (userpw.trim().length < 5) {
				alert("비밀번호는 5자 이상으로 하세요");
				$("#userpw").focus();
				return;
			}
			var userpw2 = $("#userpw2").val();
			if (userpw != userpw2) {
				alert("비밀번호 올바르게 입력하세요");
				$("#userpw2").focus();
				return;
			}
			var nickname = $("#nickname").val();
			if (nickname.trim().length < 2) {
				alert("아이디는 두자 이상으로 하세요");
				$("#nickname").focus();
				return;
			}

			var data = {
				'userid' : userid,
				'userpw' : userpw,
				'nickname' : nickname
			}

			$.ajax({
				type : 'post',
				url : 'join',
				data : data,
				success : function(result) {
					if (result == "ok") {
						alert("가입 성공");
						location.href = "main";
					} else {
						alert("가입 실패");
					}
				},
				error : function(result) {
					alert("에러 발생");
				}
			})
		})

	})
</script>

</head>
<body>
	아이디
	<input type="text" id="userid">
	<br />
	비밀번호
	<input type="password" id="userpw">
	<br />
	비밀번호 확인
	<input type="password" id="userpw2">
	<br />
	닉네임
	<input type="text" id="nickname">
	<br />
	<input type="button" value="등록" id="join">
</body>
</html>