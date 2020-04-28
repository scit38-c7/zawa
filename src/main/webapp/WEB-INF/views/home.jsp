<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="にぎやかなそーしゃる広場">
	<title>ログイン - ZAWA</title>

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
		function credCheck() {
			var email = $('#email').val();
			var pw = $('#pw').val();

			if (email.length == 0) {
				alert('メールアドレスを入力してください');
				return false;
			}
			if (pw.length == 0) {
				alert('パスワードを入力してください');
				return false;
			}

			$('#signin-form').submit();
		}
	</script>

	<c:if test="${requestScope.signupSuccess == true}">
		<script>
			alert('アカウント登録に成功しました');
		</script>
	</c:if>
	<c:if test="${requestScope.signinSuccess == false}">
		<script>
			alert('ログインに失敗しました\nメールアドレスやパスワードをご確認ください');
		</script>
	</c:if>
</head>

<body class="bg-gradient-primary">

	<div class="container">

		<!-- Outer Row -->
		<div class="row justify-content-center">

			<div class="col-xl-10 col-lg-12 col-md-9">

				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<div class="row">
							<div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
							<div class="col-lg-6">
								<div class="p-5">
									<div class="text-center">
										<h1 class="h4 text-gray-900 mb-4">ZAWA<br>にぎやかなそーしゃる広場</h1>
									</div>
									<form id="signin-form" class="user" action="signin" method="post">
										<div class="form-group">
											<input type="email" id="email" name="email"
												class="form-control form-control-user" aria-describedby="emailHelp"
												placeholder="メールアドレス">
										</div>
										<div class="form-group">
											<input type="password" id="pw" name="pw"
												class="form-control form-control-user" placeholder="パスワード">
										</div>
										<span class="btn btn-primary btn-user btn-block" onclick="credCheck()">
											ログイン
										</span>
									</form>
									<hr>
									<div class="text-center">
										<a class="small" href="<c:url value=" signup" />">アカウント登録</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>

		</div>

	</div>

</body>

</html>