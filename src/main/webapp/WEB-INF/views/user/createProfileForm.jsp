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
    const DISPLAYID_MIN_LENGTH = 2;
    const DISPLAYID_MAX_LENGTH = 20;

    $(function () {
        // displayid 글자 수 및 영숫자 체크



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
                <div class="col"><input type="text" id="email" name="email"></div>
                <div id="email-check" class="col"></div>
                <input type="hidden" id="flag-email" class="hidden-flag" value="false">
            </div>
            <div class="row">
                <div class="col form-header">名前</div>
                <div class="col"><input type="password" id="pw" name="pw"></div>
                <div id="pw-check" class="col"></div>
                <input type="hidden" id="flag-pw" class="hidden-flag" value="false">
            </div>
            <div class="row">
                <div class="col"><input type="submit" id="submit-btn" value="作成" disabled></div>
                <div class="col"><input type="button" id="prev-btn" value="戻る"></div>
            </div>
        </form>
    </div>
</body>

</html>