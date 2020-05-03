<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="にぎやかなそーしゃる広場">
	<title>いいね - ZAWA</title>

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

	<script type="text/javascript">
		var currentPage = 1;

		$(function () {
			var currentProfile = $('#current-profile').val();
			var pageLoadLock = false;

			// 타임라인 한 "페이지"를 로드
			function loadTimelinePage() {
				$.ajax({
					url: "readLikesPage",
					type: "get",
					data: {
						id: currentProfile,
						currentPage: currentPage
					},
					success: function (data) {
						var str = '';
						$.each(data, function (index, item) {
							str += '<div class="card shadow mb-4 col-12">';
							str += '<input type="hidden" class="post-no" value="' + item.post.post_no + '">';
							str += '<div class="card-header py-3 row">';
							str += '<div class="col mr-2"><h6 class="m-0 font-weight-bold text-primary">' + item.user.name + ' @' + item.post.author + '</h6></div>';
							// 삭제 버튼
							if (item.post.author == currentProfile) {
								str += '<div class="col-auto"><a class="delete-btn">';
								str += '<i class="fas fa-trash-alt fa-sm fa-fw text-gray-400"></i></a></div>';
							}
							str += '</div>'; // header closed
							str += '<div class="card-body">' + item.post.content + '<hr>';
							str += '<div class="row">';
							// 좋아요 버튼
							str += '<div class="col"><a class="like-btn">';
							if (item.liked) {
								str += '<i class="fas fa-heart fa-sm fa-fw text-danger"></i></a>';
							} else {
								str += '<i class="far fa-heart fa-sm fa-fw text-danger"></i></a>';
							}
							str += '<span class="like-count text-danger">' + item.likes + '</span></div>';
							str += '<div class="col-auto">' + item.post.inputdate + '</div></div>';
							str += '</div></div>';
						});
						$('#posts').append(str);
						deleteFnc();
						likeFnc();
						// currentPage를 1 증가
						currentPage++;
						pageLoadLock = false;
					}
				});
			}
			loadTimelinePage();

			function likeFnc() {
				$(".like-btn").on('click', function () {
					$this = $(this);
					var post_no = $this.closest('div.card').find('input.post-no').eq(0).val();

					$.ajax({
						url: "toggleLike",
						type: "get",
						data: {
							user_id: currentProfile,
							post_no: post_no
						},
						success: function (data) {
							$this.closest('div').find('span.like-count').eq(0).text(data);
							if ($this.find('i.far').length > 0) {
								$this.find('i.far').eq(0).attr('class', 'fas fa-heart fa-sm fa-fw text-danger');
							} else {
								$this.find('i.fas').eq(0).attr('class', 'far fa-heart fa-sm fa-fw text-danger');
							}

						}
					});
				});

				$('.like-btn').hover(function () {
					$(this).css('cursor', 'pointer');
				});
			}

			function deleteFnc() {
				$('.delete-btn').on('click', function () {
					if (confirm('削除しますか？')) {
						// closest(): 선택된 대상으로부터 가장 가까운 부모를 선택하는 함수
						// find(): 선택된 대상의 후손들을 선택하는 함수
						// eq(): 지정된 순번에 해당하는 대상을 선택하는 함수
						var post_no = $(this).closest('div.card').find('input.post-no').eq(0).val();

						$.ajax({
							url: "deletePost",
							type: "get",
							data: {
								post_no: post_no
							},
							success: function () {
								location.reload();
							},
							error: function (e) {
								console.log(e);
							}
						});
					}
				});
				$('.delete-btn').hover(function () {
					$(this).css('cursor', 'pointer');
				});
			}

			// 일정 부분 이하 스크롤 시 자동 페이징
			$(window).scroll(function () {
				// 일정 이하 스크롤 시 loadTimelinePage() 호출
				var scrollHeight = $(window).scrollTop() + $(window).height;
				var documentHeight = $(document).height();

				if (scrollHeight >= documentHeight - 200 && !pageLoadLock) {
					pageLoadLock = true;
					loadTimelinePage();
				}
			});

			$('.search-btn').on('click', function () {
				$(this).closest('form.search-form').submit();
			});
		});
	</script>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<div class="sidebar-brand d-flex align-items-center justify-content-center">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-laugh-wink"></i>
				</div>
				<div class="sidebar-brand-text mx-3">ZAWA</div>
			</div>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- My timeline -->
			<li class="nav-item">
				<a class="nav-link" href="<c:url value='/user' />">
					<i class="fas fa-fw fa-home"></i>
					<span>ホーム</span></a>
			</li>

			<!-- Likes -->
			<li class="nav-item">
				<a class="nav-link" href="<c:url value='/likes' />">
					<i class="fas fa-fw fa-heart"></i>
					<span>いいね</span></a>
			</li>

			<!-- My profiles -->
			<li class="nav-item">
				<a class="nav-link" href="<c:url value='/profiles' />">
					<i class="fas fa-fw fa-user"></i>
					<span>マイプロフィール</span></a>
			</li>

			<!-- Sign out -->
			<li class="nav-item">
				<a class="nav-link" href="#" data-toggle="modal" data-target="#logoutModal">
					<i class="fas fa-fw fa-sign-out-alt"></i>
					<span>ログアウト</span></a>
			</li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- New post -->
			<li class="nav-item">
				<a class="nav-link" href="<c:url value='/newpost' />">
					<i class="fas fa-fw fa-pen"></i>
					<span>新しいポスト</span></a>
			</li>

			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Topbar Search -->
					<form
						class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search search-form"
						action="<c:url value='/search' />" method="get">
						<div class="input-group">
							<input type="text" class="form-control bg-light border-0 small" name="searchKeyword"
								placeholder="検索" aria-label="Search" aria-describedby="basic-addon2">
							<div class="input-group-append">
								<button class="btn btn-primary search-btn" type="button">
									<i class="fas fa-search fa-sm"></i>
								</button>
							</div>
						</div>
					</form>

					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">

						<!-- Nav Item - Search Dropdown (Visible Only XS) -->
						<li class="nav-item dropdown no-arrow d-sm-none">
							<a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
								data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<i class="fas fa-search fa-fw"></i>
							</a>
							<!-- Dropdown - Messages -->
							<div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
								aria-labelledby="searchDropdown">
								<form class="form-inline mr-auto w-100 navbar-search search-form"
									action="<c:url value='/search' />" method="get">
									<div class="input-group">
										<input type="text" class="form-control bg-light border-0 small"
											name="searchKeyword" placeholder="検索" aria-label="Search"
											aria-describedby="basic-addon2">
										<div class="input-group-append">
											<button class="btn btn-primary search-btn" type="button">
												<i class="fas fa-search fa-sm"></i>
											</button>
										</div>
									</div>
								</form>
							</div>
						</li>

						<div class="topbar-divider d-none d-sm-block"></div>

						<!-- Nav Item - User Information -->
						<li class="nav-item dropdown no-arrow">
							<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
								data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								<span
									class="mr-2 d-none d-lg-inline text-gray-600 small">${sessionScope.currentProfile.name}</span>
							</a>
							<!-- Dropdown - User Information -->
							<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="userDropdown">
								<a class="dropdown-item" href="<c:url value='/profiles' />">
									<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
									マイプロフィール
								</a>
								<a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
									<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
									ログアウト
								</a>
							</div>
						</li>

					</ul>

				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<input type="hidden" id="current-profile" value="${sessionScope.currentProfile.displayid}">

					<!-- Page Heading -->
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">いいね</h1>
					</div>

					<div id="posts" class="row">

					</div>

				</div>

			</div>

		</div>
		<!-- /.container-fluid -->

	</div>
	<!-- End of Main Content -->

	<!-- Footer -->
	<footer class="sticky-footer bg-white">
		<div class="container my-auto">
			<div class="copyright text-center my-auto">
				<span>Copyright &copy; 2020 Make IT Possible</span>
			</div>
		</div>
	</footer>
	<!-- End of Footer -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top">
		<i class="fas fa-angle-up"></i>
	</a>

	<!-- Logout Modal-->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">ログアウト</h5>
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">ログアウトしますか？</div>
				<div class="modal-footer">
					<button class="btn btn-primary" type="button" data-dismiss="modal">キャンセル</button>
					<a class="btn btn-secondary" href="<c:url value='/signout' />">ログアウト</a>
				</div>
			</div>
		</div>
	</div>

</body>

</html>