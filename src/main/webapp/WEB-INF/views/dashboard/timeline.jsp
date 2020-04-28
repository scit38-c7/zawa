<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
</head>
<script type="text/javascript">
	var currentPage = 1;
	var id = $('#profile-id').val();

	$(function () {
		// 일정 부분 이하 스크롤 시 자동 페이징
		$(window).scroll(function () {
			// 타임라인 한 "페이지"를 로드
			function loadTimelinePage() {
				$.ajax({
					url: "readTimelinePage",
					type: "get",
					data: {
						id: id,
						currentPage: currentPage
					},
					success: function (data) {
						var str = '';
						$.each(data, function (index, item) {
							str += '<div class="post container">';
							str += '<div class="author container">@';
							str += item.author;
							str += '</div>';
							str += '<div class="post-content container">';
							str += item.content;
							str += '</div>';
							str += '</div>';
						});
						// currentPage를 1 증가
						currentPage += 1;
					}
				});
			}

			// 일정 이하 스크롤 시 loadTimelinePage() 호출
			var scrollHeight = $(window).scrollTop() + $(window).height;
			var documentHeight = $(document).height();

			if (scrollHeight >= documentHeight - 200) {
				loadTimelinePage();
			}
		});
	});
</script>

<body>
	<header id="menubar">
		<table>
			<tr>
				<td>Home</td>
			</tr>
			<tr>
				<td>Search</td>
			</tr>
			<tr>
				<td>Chat</td>
			</tr>
			<tr>
				<td>Groups</td>
			</tr>
			<tr>
				<td>Settings</td>
			</tr>
			<tr>
				<td>My Profiles</td>
			</tr>
		</table>
	</header>
	<div id="profile-banner" class="container">
		<input type="hidden" id="profile-id" value="${requestScope.viewingUser}">
		<div id="portrait">(portrait image)</div>
		<div id="nameplate">(name) (@displayid)</div>
		<div id="profile">(profile text)</div>
	</div>
	<div id="timeline" class="container"></div>
	<footer>(c) 2020 Make IT Possible</footer>
</body>

</html>