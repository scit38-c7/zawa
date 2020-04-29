<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="にぎやかなそーしゃる広場">
	<title>アカウント登録 - ZAWA</title>

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
		const MIN_PW_LENGTH = 8;
		const AGE_LIMIT = 13;

		$(function () {
			// 이메일 체크
			$('#email').on('focusout', function () {
				var email = $('#email').val();
				if (email.length == 0) {
					$('#flag-email').val(false);
					$('#email-check').html('');
					flagAllChecked();
					return;
				}
				$('#email-check').html('<span class="text-secondary small">確認中…</span>');
				// 이메일 형식 체크 (regex)
				var re = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/igm;
				if (!re.test(email)) {
					$('#flag-email').val(false);
					$('#email-check').html('<span class="text-danger small">正しいアドレスを入力してください</span>');
					flagAllChecked();
					return;
				}
				// 이메일 중복 체크 (Ajax)
				$.ajax({
					type: 'post',
					url: 'signup/findDuplicateEmail',
					data: {
						'email': email.toLowerCase()
					},
					success: function (result) {
						if (result) {
							$('#flag-email').val(false);
							$('#email-check').html('<span class="text-danger small">すでに登録されているアドレスです</span>');
						} else {
							// 이메일에 문제 없을 시 확인 표시
							$('#flag-email').val(true);
							$('#email-check').html('<span class="text-success small">OK</span>');
						}
						flagAllChecked();
					}
				});
			});

			// 패스워드 조건 체크 + 재입력 체크
			$('#pw').on('focusout', function () {
				pwCheck();
			});
			$('#pw2').on('focusout', function () {
				pwCheck();
			});

			function pwCheck() {
				var pw = $('#pw').val();
				var pw2 = $('#pw2').val();
				var $flag = $('#flag-pw');
				var $check = $('#pw-check');

				if (pw.length == 0) {
					$flag.val(false);
					$check.html('');
				} else if (pw.length < MIN_PW_LENGTH) {
					$flag.val(false);
					$check.html('<span class="text-danger small">パスワードは半角' + MIN_PW_LENGTH + '字以上</span>');
				} else if (pw2.length == 0) {
					$flag.val(false);
					$check.html('');
				} else if (pw != pw2) {
					$flag.val(false);
					$check.html('<span class="text-danger small">パスワードが一致しません</span>');
				} else {
					$flag.val(true);
					$check.html('<span class="text-success small">OK</span>');
				}
				flagAllChecked();
			}

			// 생년월일 체크 (만 13세 이상)
			$('#dob').on('focusout', function () {
				var dob = new Date($('#dob').val());
				var today = new Date();
				today.setUTCHours(0, 0, 0, 0);
				if (isNaN(dob) || dob > today) { // 날짜가 제대로 입력되지 않은 경우, 생일이 미래인 경우
					$('#flag-dob').val(false);
					$('#dob-check').html('<span class="text-danger small">正しい生年月日を入力してください</span>');
				} else {
					// 나이 제한 기준 날짜 = 오늘 날짜 - 제한 연령
					var doblimit = today;
					doblimit.setFullYear(doblimit.getFullYear() - AGE_LIMIT);
					if (dob > doblimit) {
						$('#flag-dob').val(false);
						$('#dob-check').html('<span class="text-danger small">' + AGE_LIMIT + '歳未満の子供はZAWAサービスを利用できません</span>');
					} else {
						$('#flag-dob').val(true);
						$('#dob-check').html('<span class="text-success small">OK</span>');
					}
				}
				flagAllChecked();
			});

			// 모두 제대로 입력 시 가입 버튼 활성화
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
				var email = $('#email').val();
				if (confirm(email + '\nこのアドレスで登録しますか？')) {
					$('#signup-form').submit();
				}
			}
		});
	</script>
	<c:if test="${requestScope.signupFailed == true}">
		<script>
			alert('アカウント登録に失敗しました');
		</script>
	</c:if>
</head>

<body class="bg-gradient-primary">

	<div class="container">

		<div class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body p-0">
				<!-- Nested Row within Card Body -->
				<div class="row">
					<div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
					<div class="col-lg-7">
						<div class="p-5">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">アカウント登録</h1>
							</div>
							<form id="signup-form" class="user" action="<c:url value='/signup/createAccount' />"
								method="post">
								<!-- 이메일 입력 -->
								<div class="form-group">
									<input type="email" id="email" name="email" class="form-control form-control-user"
										placeholder="メールアドレス">
								</div>
								<div id="email-check" class="form-group"></div>
								<input type="hidden" id="flag-email" class="hidden-flag" value="false">
								<!-- 패스워드 입력 -->
								<div class="form-group row">
									<div class="col-sm-6 mb-3 mb-sm-0">
										<input type="password" id="pw" name="pw" class="form-control form-control-user"
											placeholder="パスワード">
									</div>
									<div class="col-sm-6">
										<input type="password" id="pw2" class="form-control form-control-user"
											placeholder="パスワード再入力">
									</div>
								</div>
								<div id="pw-check" class="form-group"></div>
								<input type="hidden" id="flag-pw" class="hidden-flag" value="false">
								<!-- 생년월일 입력 -->
								<div class="form-group row">
									<div class="col-sm-3 mb-3 mb-sm-0 mt-sm-3 text-left text-sm-center">
										生年月日
									</div>
									<div class="col-sm-9">
										<input type="date" id="dob" name="dob" class="form-control form-control-user">
									</div>
								</div>
								<div id="dob-check" class="form-group"></div>
								<input type="hidden" id="flag-dob" class="hidden-flag" value="false">
								<!-- 등록 버튼 -->
								<span id="submit-btn" class="btn btn-secondary btn-user btn-block">
									登録
								</span>
							</form>
							<hr>
							<div class="text-center">
								<a class="small" href="<c:url value='/' />">戻る</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>

</body>

</html>