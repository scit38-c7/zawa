<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>ZAWA プロフィール作成</title>
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
	const MIN_LENGTH = 2;
	const MAX_LENGTH = 20;

	$(function () {
		// displayid 유효성 검사
		$('#displayid').on('focusout', function () {
			var displayid = $('#displayid').val();

			if (displayid.length < MIN_LENGTH) {
				$('#flag-displayid').val(false);
				$('#displayid-check').text('短すぎます');
			} else if (displayid.length > MAX_LENGTH) {
				$('#flag-displayid').val(false);
				$('#displayid-check').text('長すぎます');
			} else {
				// 반각 영숫자, 언더바 체크
				var re = /^[a-zA-Z0-9_]{2,20}$/g
				if (!re.test(displayid)) {
					$('#flag-displayid').val(false);
					$('#displayid-check').text('半角英数字とアンダーバー(‗)で設定してください');
				} else {
					$('#flag-displayid').val(true);
					$('#displayid-check').text('checked');
				}
			}
			flagAllChecked();
		});

		// name 유효성 검사
		$('#name').on('focusout', function () {
			var name = $('#name').val();

			if (name.length > MAX_LENGTH) {
				$('#flag-name').val(false);
				$('#name-check').text('長すぎます');
			} else {
				if (name == '') {
					var displayid = $('#displayid').val();
					$('#name').val(displayid);
				}
				$('#flag-name').val(true);
				$('#name-check').text('checked');
			}
			flagAllChecked();
		});

		// 모두 제대로 입력 시 등록 버튼 활성화
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
			var displayid = $('#displayid').val();
			return confirm(displayid + '\nこのプロフィールを作成しますか？');
		});

		$('#prev-btn').on('click', function () {
			$(location).attr('href', '<c:url value="/profiles" />');
		});
	});
</script>
<c:if test="${requestScope.createProfileFailed == true}">
	<script>
		alert('プロフィール作成に失敗しました');
	</script>
</c:if>
</head>

<body>
	<div id="create-profile-box" class="container">
		<form action="<c:url value='/profiles/createProfile' />" method="post">
			<div class="row">
				<div class="col form-header">ユーザー名</div>
				<div class="col"><input type="text" id="displayid" name="displayid"></div>
				<div id="displayid-check" class="col"></div>
				<input type="hidden" id="flag-displayid" class="hidden-flag" value="false">
			</div>
			<div class="row">
				<div class="col form-header">名前</div>
				<div class="col"><input type="text" id="name" name="name"></div>
				<div id="name-check" class="col"></div>
				<input type="hidden" id="flag-name" class="hidden-flag" value="false">
			</div>
			<div class="row">
				<div class="col"><input type="submit" id="submit-btn" value="作成" disabled></div>
				<div class="col"><input type="button" id="prev-btn" value="戻る"></div>
			</div>
		</form>
	</div>
</body>

</html>