<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="にぎやかなそーしゃる広場">
	<title>新しいポスト - ZAWA</title>

	<!-- Custom fonts -->
	<link href="<c:url value='/resources/css/fontawesome-all.min.css' />" rel="stylesheet" type="text/css">
	<link
		href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
		rel="stylesheet">

	<!-- Bootstrap core JavaScript-->
	<script src="<c:url value='/resources/js/jquery-3.4.1.min.js' />"></script>
	<script src="<c:url value='/resources/js/bootstrap.bundle.min.js' />"></script>
	<script src="<c:url value='/resources/js/jquery.easing.min.js' />"></script>

	<!-- Custom styles for all pages -->
	<link href="<c:url value='/resources/css/sb-admin-2.min.css' />" rel="stylesheet">
	<script src="<c:url value='/resources/js/sb-admin-2.min.js' />"></script>

	<script>
		// 글자수 제한
		$(function () {
			$('#content').keyup(function (e) {
				var content = $(this).val();
				$('#counter').html(content.length + '/1000');
				if (content.length >= 1000) {
					$('#counter').html('1000字まで作成できます');
				}
			});
			$('#content').keyup();

			$('#submit-btn').on('click', function () {
				if (confirm('ポストしますか？')) {
					$('#post-form').submit();
				}
			});
		});
	</script>

</head>

<body class="bg-gradient-primary">

	<div class="container">

		<div class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body p-0">
				<!-- Nested Row within Card Body -->
				<div class="p-5">
					<div class="text-center">
						<h1 class="h4 text-gray-900 mb-4">新しいポスト</h1>
					</div>
					<form id="post-form" class="user" action="<c:url value='/newpost/write' />" method="post">
						<div>@${sessionScope.currentProfile.displayid}</div>
						<!-- 내용 입력 -->
						<div class="form-group">
							<textarea id="content" name="content" rows="10" maxlength="1000" class="form-control"
								placeholder="ここに入力"></textarea>
						</div>
						<!-- 글자수 카운터 -->
						<div id="counter" class="text-secondary"></div>
						<!-- 등록 버튼 -->
						<span id="submit-btn" class="btn btn-primary btn-user btn-block">
							登録
						</span>
					</form>
					<hr>
					<div class="text-center">
						<a class="small" href="<c:url value='/profiles' />">戻る</a>
					</div>
				</div>
			</div>
		</div>

	</div>

	<hr>

</body>

</html>