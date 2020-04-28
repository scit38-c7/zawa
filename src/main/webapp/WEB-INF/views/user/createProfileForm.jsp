<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="にぎやかなそーしゃる広場">
	<title>プロフィール作成 - ZAWA</title>

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
		const MIN_LENGTH = 2;
		const MAX_LENGTH = 20;

		$(function () {
			// displayid 유효성 검사
			$('#displayid').on('focusout', function () {
				var displayid = $('#displayid').val();

				if (displayid.length < MIN_LENGTH) {
					$('#flag-displayid').val(false);
					$('#displayid-check').html('<span class="text-danger small">短すぎます</span>');
				} else if (displayid.length > MAX_LENGTH) {
					$('#flag-displayid').val(false);
					$('#displayid-check').html('<span class="text-danger small">長すぎます</span>');
				} else {
					// 반각 영숫자, 언더바 체크
					var re = /^[a-zA-Z0-9_]{2,20}$/g
					if (!re.test(displayid)) {
						$('#flag-displayid').val(false);
						$('#displayid-check').html('<span class="text-danger small">半角英数字とアンダーバー(‗)で設定してください</span>');
					} else {
						$('#flag-displayid').val(true);
						$('#displayid-check').html('<span class="text-success small">OK</span>');
					}
				}
				flagAllChecked();
			});

			// name 유효성 검사
			$('#name').on('focusout', function () {
				var name = $('#name').val();

				if (name.length > MAX_LENGTH) {
					$('#flag-name').val(false);
					$('#name-check').html('<span class="text-danger small">長すぎます</span>');
				} else {
					if (name == '') {
						var displayid = $('#displayid').val();
						$('#name').val(displayid);
					}
					$('#flag-name').val(true);
					$('#name-check').html('<span class="text-success small">OK</span>');
				}
				flagAllChecked();
			});

			// 모두 제대로 입력 시 등록 버튼 활성화
			function flagAllChecked() {
				var $btn = $('#submit-btn');
				var result = true;

				$(".hidden-flag").each(function (index, item) {
					if ($(item).val() != 'true') {
						result = false;
					}
				});
				if (result) {
					$btn.prop('class', 'btn btn-primary btn-user btn-block');
					$btn.on('click', function () {
						submitForm();
					});
				} else {
					$btn.prop('class', 'btn btn-secondary btn-user btn-block');
					$btn.removeProp('onclick');
				}
			}
			flagAllChecked();

			function submitForm() {
				var displayid = $('#displayid').val();
				if (confirm('@' + displayid + '\nこのプロフィールを作成しますか？')) {
					$('#create-profile-form').submit();
				}
			}
		});
	</script>
	<c:if test="${requestScope.createProfileFailed == true}">
		<script>
			alert('プロフィール作成に失敗しました');
		</script>
	</c:if>
</head>

<body class="bg-gradient-primary">

	<div class="container">

		<div class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body p-0">
				<!-- Nested Row within Card Body -->
				<div class="p-5">
					<div class="text-center">
						<h1 class="h4 text-gray-900 mb-4">プロフィール作成</h1>
					</div>
					<form id="create-profile-form" class="user" action="<c:url value='/profiles/createProfile' />"
						method="post">
						<!-- displayid 입력 -->
						<div class="form-group">
							<input type="text" id="displayid" name="displayid" class="form-control form-control-user"
								placeholder="ユーザー名">
						</div>
						<div id="displayid-check" class="form-group"></div>
						<input type="hidden" id="flag-displayid" class="hidden-flag" value="false">
						<!-- 별명 입력 -->
						<div class="form-group">
							<input type="text" id="name" name="name" class="form-control form-control-user"
								placeholder="名前">
						</div>
						<div id="name-check" class="form-group"></div>
						<input type="hidden" id="flag-name" class="hidden-flag" value="false">
						<!-- 등록 버튼 -->
						<span id="submit-btn" class="btn btn-secondary btn-user btn-block">
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

</body>

</html>