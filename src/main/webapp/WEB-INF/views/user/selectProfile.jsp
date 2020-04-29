<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="にぎやかなそーしゃる広場">
	<title>マイプロフィール - ZAWA</title>

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
							str += '<div class="col-12">';
							str += '<div class="card border-left-success shadow h-100 py-2">';
							str += '<div class="card-body">';
							str += '<div class="row no-gutters align-items-center">';
							str += '<div class="col mr-2">';
							str += '<div class="text-xs font-weight-bold text-secondary text-uppercase mb-1">';
							str += '@' + item.displayid + '</div>';
							str += '<div class="h5 mb-0 font-weight-bold text-gray-800">';
							str += '<a href="profiles/set?displayid=' + item.displayid + '" class="text-success">' + item.name + '</a></div>';
							str += '</div></div></div></div></div>';
						});
					} else { // 프로필이 없음
						str += '<div class="text-center">';
						str += 'プロフィールがありません';
						str += '</div>';
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
				$('#create-profile-btn').prop('class', 'btn btn-primary btn-user btn-block');
				$('#create-profile-btn').on('click', function () {
					$(location).attr('href', '<c:url value="profiles/create" />');
				});
			}
		});
	</script>
</head>

<body class="bg-gradient-primary">

	<div class="container">

		<!-- Outer Row -->
		<div class="row justify-content-center">

			<div class="col-xl-10 col-lg-12 col-md-9">

				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<div class="p-5">
							<div class="text-center">
								<h1 class="h4 text-gray-900 mb-4">あなたのプロフィール</h1>
								<!-- 생성한 프로필 수 / 프로필 개수 제한 -->
								<p class="text-secondary"><span id="profile-count"></span> / <span
										id="profile-limit"></span></p>
							</div>
							<input type="hidden" id="account-id" value="${sessionScope.currentAccount.id}">
							<!-- 프로필 리스트 -->
							<div id="profile-selection-list" class="row"></div>
							<span id="create-profile-btn" class="btn btn-secondary btn-user btn-block">
								プロフィール作成
							</span>
						</div>
					</div>

				</div>

			</div>

		</div>

	</div>

</body>

</html>