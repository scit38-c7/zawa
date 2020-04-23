<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${vo.title}</title>
<!-- Bootstrap Core CSS -->
    <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Theme CSS -->
    <link href="resources/css/clean-blog.min.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <script src="resources/js/jquery-3.4.1.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="resources/css/bootstrap.css" rel="stylesheet">
	
	<script>
		function updateConfirm(){
		return confirm("수정 하시겠습니까?");
		}
	</script>
	
</head>
<body>
	
	<!-- Main Content -->
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                <!-- Contact Form - Enter your email address on line 19 of the mail/contact_me.php file to make this form work. -->
                <!-- WARNING: Some web hosts do not allow emails to be sent through forms to common mail hosts like Gmail or Yahoo. It's recommended that you use a private domain email address! -->
                <!-- NOTE: To use the contact form, your site must be on a live web host with PHP! The form will not work locally! -->
                	<form action="<c:url value='postUpdate'/>" enctype="multipart/form-data" method="post">
                		<div class="row control-group">
	                        <div class="form-group col-xs-12 floating-label-form-group controls">
	                            <label>No.</label>
	                        	<div>번호</div>
	                            <input type="text" class="form-control" value="${vo.post_no}" readonly="readonly">
	                            <p class="help-block text-danger"></p>
	                        </div>
	                    </div>
                
	                    <div class="row control-group">
	                        <div class="form-group col-xs-12 floating-label-form-group controls">
	                            <label>NAME</label>
	                            <div>작성자</div>
	                            <input type="text" class="form-control" value="${vo.user_id}" readonly="readonly">
	                            <p class="help-block text-danger"></p>
	                        </div>
	                    </div>
	                    
	                    <div class="row control-group">
	                        <div class="form-group col-xs-12 floating-label-form-group controls">
	                            <label>Date</label>
	                            <div>작성일</div>
	                            <input type="text" class="form-control" value="${vo.inputdate}" readonly="readonly">
	                            <p class="help-block text-danger"></p>
	                        </div>
	                    </div>
	                    
	                    <div class="row control-group">
	                        <div class="form-group col-xs-12 floating-label-form-group controls">
	                            <label>Hit</label>
	                            <div>조회</div>
	                            <input type="text" class="form-control" value="${vo.hit}" readonly="readonly">
	                            <p class="help-block text-danger"></p>
	                        </div>
	                    </div>
	                    
	                    <div class="row control-group">
	                        <div class="form-group col-xs-12 floating-label-form-group controls">
	                            <label>TITLE</label>
	                            <div>제목</div>
	                            <input type="text" name="title" class="form-control" value="${vo.title}" required="required">
	                            <p class="help-block text-danger"></p>
	                        </div>
	                    </div>
	                    <div class="row control-group">
	                        <div class="form-group col-xs-12 floating-label-form-group controls">
	                            <label>FILE</label>
	                            <div>첨부파일</div>
	                            <input type="file" name="uploadFile" class="form-control" value="${vo.originalFilename}">
	                            <p class="help-block text-danger"></p>
	                        </div>
	                    </div>
	                    <div class="row control-group">
	                        <div class="form-group col-xs-12 floating-label-form-group controls">
	                            <label>CONTENT</label>
	                            <div>내용</div>
	                            <textarea rows="10" name="content" class="form-control" required="required">${vo.content}</textarea>
	                            <p class="help-block text-danger"></p>
	                        </div>
	                    </div>
	                    <br>
	                    <div id="success"></div>
	                    <div class="row">
	                        <div class="form-group col-xs-12">
	                            	
	                            	<button type="submit" class="btn btn-default" onclick="updateConfirm()">수정</button>
	                            	<a href="<c:url value='postRead?post_no=${vo.post_no}'/>">
										<input type="button" class="btn btn-default" value="취소">
									</a>
	                            
	                            <a href="postlist">
	                            	<button type="button" style="margin-left: 66%;" class="btn btn-default">Return</button>
	                            </a>
	                        </div>
	                    </div>
	                    <input type="hidden" name="post_no" value="${vo.post_no}">
	                 </form>
            </div>
        </div>
    </div>

    <hr>
    
</body>
</html>