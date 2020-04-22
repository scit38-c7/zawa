<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>ZAWA アカウント登録</title>
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
</head>
<script>
	const MIN_PW_LENGTH = 8;
	const AGE_LIMIT = 13;

	$(function () {
		// 이메일 체크
		$('#email').on('focusout', function () {
			var email = $('#email').val();
			if (email.length == 0) {
				$('#flag-email').val(false);
				$('#email-check').text('');
				flagAllChecked();
				return;
			}
			$('#email-check').text('loading');
			// 이메일 형식 체크 (regex)
			var re = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/igm;
			if (!re.test(email)) {
				$('#flag-email').val(false);
				$('#email-check').text('正しいアドレスを入力してください');
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
						$('#email-check').text('すでに登録されているアドレスです');
					} else {
						// 이메일에 문제 없을 시 확인 표시
						$('#flag-email').val(true);
						$('#email-check').text('checked');
					}
					flagAllChecked();
				}
			});
		});

		// 패스워드 조건 (8자 이상) 체크 + 재입력 체크
		$('#pw').on('focusout', function () {
			var pw = $('#pw').val();
			if (pw.length == 0) {
				$('#flag-pw').val(false);
				$('#pw-check').text('');
			} else {
				$('#pw-check').text('loading');
				if (pw.length < MIN_PW_LENGTH) {
					$('#flag-pw').val(false);
					$('#pw-check').text('パスワードは半角8字以上');
				} else {
					$('#flag-pw').val(true);
					$('#pw-check').text('checked');
				}
			}
			pw2Check();
			flagAllChecked();
		});

		// 패스워드 재입력 체크
		$('#pw2').on('focusout', function () {
			pw2Check();
			flagAllChecked();
		});

		function pw2Check() {
			var pw = $('#pw').val();
			var pw2 = $('#pw2').val();
			// 패스워드 조건을 충족하지 못한 경우 재입력 체크를 초기화
			if (pw2.length == 0 || $('#flag-pw').val() == 'false') {
				$('#flag-pw2').val(false);
				$('#pw2-check').text('');
			} else {
				$('#pw2-check').text('loading');
				// 재입력 패스워드 일치 여부 확인
				if (pw != pw2) {
					$('#flag-pw2').val(false);
					$('#pw2-check').text('パスワードが一致しません');
				} else {
					$('#flag-pw2').val(true);
					$('#pw2-check').text('checked');
				}
			}
		};

		// 생년월일 체크 (만 13세 이상)
		$('#dob').on('focusout', function () {
			$('#dob-check').text('loading');
			var dob = new Date($('#dob').val());
			var today = new Date();
			today.setUTCHours(0, 0, 0, 0);
			if (isNaN(dob) || dob > today) { // 날짜가 제대로 입력되지 않은 경우, 생일이 미래인 경우
				$('#flag-dob').val(false);
				$('#dob-check').text('正しい生年月日を入力してください');
			} else {
				// 나이 제한 기준 날짜 = 오늘 날짜 - 제한 연령
				var doblimit = today;
				doblimit.setFullYear(doblimit.getFullYear() - AGE_LIMIT);
				if (dob > doblimit) {
					$('#flag-dob').val(false);
					$('#dob-check').text('13歳未満の子供はZAWAサービスを利用できません');
				} else {
					$('#flag-dob').val(true);
					$('#dob-check').text('checked');
				}
			}
			flagAllChecked();
		});

		// 모두 제대로 입력 시 가입 버튼 활성화
		function flagAllChecked() {
			var result = true;
			$(".hidden-flag").each(function (index, item) {
				if ($(item).val() != 'true') {
					result = false;
				}
			});
			if (result) {
				$('#submit-btn').prop('disabled', false);
			} else {
				$('#submit-btn').prop('disabled', true);
			}
		}
		flagAllChecked();

		$('#submit-btn').on('click', function () {
			var email = $('#email').val();
			return confirm(email + '\nこのアドレスで登録しますか？');
		});
	});
</script>
<c:if test="${requestScope.signupFailed == true}">
	<script>
		alert('アカウント登録に失敗しました');
	</script>
</c:if>
</head>

<body>
	<div id="signup-box" class="container">
		<form action="<c:url value='/signup/createAccount' />" method="post">
			<div class="row">
				<div class="col form-header">メールアドレス</div>
				<div class="col"><input type="text" id="email" name="email"></div>
				<div id="email-check" class="col"></div>
				<input type="hidden" id="flag-email" class="hidden-flag" value="false">
			</div>
			<div class="row">
				<div class="col form-header">パスワード</div>
				<div class="col"><input type="password" id="pw" name="pw"></div>
				<div id="pw-check" class="col"></div>
				<input type="hidden" id="flag-pw" class="hidden-flag" value="false">
			</div>
			<div class="row">
				<div class="col form-header">パスワード再入力</div>
				<div class="col"><input type="password" id="pw2"></div>
				<div id="pw2-check" class="col"></div>
				<input type="hidden" id="flag-pw2" class="hidden-flag" value="false">
			</div>
			<div class="row">
				<div class="col form-header">生年月日</div>
				<div class="col"><input type="date" id="dob" name="dob"></div>
				<div id="dob-check" class="col"></div>
				<input type="hidden" id="flag-dob" class="hidden-flag" value="false">
			</div>
			<div class="row">
				<div class="col"><input type="submit" id="submit-btn" value="登録" disabled></div>
				<div class="col"><input type="button" id="prev-btn" value="戻る"></div>
			</div>
		</form>
	</div>
</body>

</html>