<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>ZAWA プロフィール</title>
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
	const MAX_PROFILES = 3;

	$(function () {
		$('#profile-limit').text(MAX_PROFILES);
		// 프로필 로드
		$.ajax({
			type: 'get',
			url: 'profiles/getMyProfiles',
			data: {
				'owner': $('#account-id').val()
			},
			success: function (data) {
				var str = '';
				var profileCount = data.length;
				$('#profile-count').text(profileCount);

				if (profileCount > 0) { // 프로필이 하나 이상 있음
					$(data).each(function (index, item) {
						str += '<div class="row">';
						str += '<div class="col">';
						str += '<a href="profiles/set?displayid=' + item.displayid + '">' + item.name + ' @' + item.displayid + '</a>';
						str += '</div></div>';
						console.log(str);
					});
				} else { // 프로필이 없음
					str += '<div class="row">';
					str += '<div class="col">';
					str += 'プロフィールがありません';
					str += '</div></div>';
				}
				$('#profile-selection-list').html(str);
				if (profileCount < MAX_PROFILES) {
					enableCreateProfileBtn();
				}
			}
		});

		
		// 프로필 생성 버튼
		function enableCreateProfileBtn() {
			var str = '<input type="button" id="create-profile-btn" value="プロフィール作成">';
			$('#profile-selection-footer').html(str);
			$('#create-profile-btn').on('click', function () {
				$(location).attr('href', '<c:url value="profiles/create" />');
			});
		}
	});
</script>
</head>

<body>
	<input type="hidden" id="account-id" value="${sessionScope.currentAccount.id}">
	<div id="profile-selection-box" class="container">
		<div id="profile-selection-header" class="container">
			あなたのプロフィール <span id="profile-count"></span> / <span id="profile-limit"></span>
		</div>
		<div id="profile-selection-list" class="container"></div>
		<div id="profile-selection-footer" class="container"></div>
	</div>
</body>

</html>