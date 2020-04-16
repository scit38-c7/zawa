<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Home</title>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"
		integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
		integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
		integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
		crossorigin="anonymous"></script>
	<script>
		$(function () {
			// 계정 등록 버튼 이벤트
			$('#signup-btn').on('click', function () {
				$(location).attr('href', '<c:url value="signup" />');
			});
		});
	</script>
</head>

<body>
	<div class="container-fluid">
		<div class="row">
			<!-- 좌측 홈 배너 -->
			<div id="home-left" class="column jumbotron text-center d-none d-sm-block">
				<h1>ZAWA by Make IT Possible</h1>
			</div>
			<!-- 우측 로그인 박스 -->
			<div id="home-right" class="column text-center">
				<p>Our journey starts here.</p>
				<div id="signin-box" class="container">
					<form action="signin" method="post">
						<div class="row">
							<div class="col">メールアドレス</div>
							<div class="col">
								<input type="text" id="email">
							</div>
						</div>
						<div class="row">
							<div class="col">パスワード</div>
							<div class="col">
								<input type="password" id="password">
							</div>
						</div>
						<div class="row">
							<div class="col-2 text-center">
								<input type="submit" id="signin-btn" value="ログイン">
							</div>
						</div>
						<div class="row">
							<div class="col-2 text-center">
								<input type="button" id="signup-btn" value="アカウント登録">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>

</html>