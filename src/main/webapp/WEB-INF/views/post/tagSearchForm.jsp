<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>[해시태그 검색결과]</title>
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

<style type="text/css">
	a.button {
  font-size: 12px;
  font-weight: 500;
  color: white;
  padding: 5px 10px 0px 10px;
  margin: 0px 10px 10px 0px;
  display: inline-block;
  float: both;
  text-decoration: none;
  width: 80px; height: 25px; 
  -webkit-border-radius: 5px; 
  -moz-border-radius: 5px; 
  border-radius: 5px; 
  background-color: rgba(150,150,150,0.8); 
  -webkit-box-shadow: 0 3px rgba(0,0,0,.75); 
  -moz-box-shadow: 0 3px rgba(58,87,175,.75); 
  box-shadow: 0 3px rgba(130,130,130,0.75);
  transition: all 0.1s linear 0s; 
  top: 0px;
  position: relative;
}

a.button:hover {
  top: 3px;
  text-decoration: none;
  background-color: rgba(150,150,150,0.8);
  -webkit-box-shadow: none; 
  -moz-box-shadow: none; 
  box-shadow: none;
  
}

.btndiv{
  clear: both;
}

.divnew{
  margin-left:550px;
  display: inline-block;
}

.hfive{
  padding: 24px 5px 0px 0px;
  margin: 0px 0px 0px 0px;
  text-decoration: none;
  color: #777777;
  font-size: 12px;
  font-weight: 900;
  letter-spacing: 1px;
}

</style>

</head>
<body>
        <!-- Main Content -->
    <div class="container">
    <c:forEach items="${requestScope.tagSearchList}" var="tagSearchList">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                <!-- Contact Form - Enter your email address on line 19 of the mail/contact_me.php file to make this form work. -->
                <!-- WARNING: Some web hosts do not allow emails to be sent through forms to common mail hosts like Gmail or Yahoo. It's recommended that you use a private domain email address! -->
                <!-- NOTE: To use the contact form, your site must be on a live web host with PHP! The form will not work locally! -->
                	<table>
                		<tr>
                			<th colspan="3">
								<h2>#${tag_name} 관련 게시글</h2>
                			</th>
                		</tr>
                		<tr>
                			<th>
		                		<div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>No.</label>
			                        	<div>번호</div>
		                            	<input type="text" class="form-control" value="${tagSearchList.post_no}" readonly="readonly">
		                            	<p class="help-block text-danger"></p>
		                        	</div>
		                   		</div>
                			</th>
                			<th>
			                    <div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>NAME</label>
			                            <div>작성자</div>
			                            <input type="text" class="form-control" value="${tagSearchList.user_id}" readonly="readonly">
			                            <p class="help-block text-danger"></p>
			                        </div>
			                    </div>
                			</th>
                			<th>
			                    <div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>Date</label>
			                            <div>작성일</div>
			                            <input type="text" class="form-control" value="${tagSearchList.inputdate}" readonly="readonly">
			                            <p class="help-block text-danger"></p>
			                        </div>
			                    </div>
                			</th>
                		</tr>
                		<tr>
                			<th colspan="3">
			                    <div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>TITLE</label>
			                            <div>제목</div>
			                            <input type="text" class="form-control" value="${tagSearchList.title}" readonly="readonly">
			                            <p class="help-block text-danger"></p>
			                        </div>
			                    </div>
                			</th>
                		</tr>
                		<tr>
                			<th colspan="3">
			                    <div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>CONTENT</label>
			                            <div>내용</div>
			                            <textarea rows="10" class="form-control" readonly="readonly">${tagSearchList.content}</textarea>
			                            <p class="help-block text-danger"></p>
			                        </div>
			                    </div>
                			</th>
                		</tr>
                		<tr>
                			<th colspan="3">
			                    <div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>HASHTAG</label>
			                            <div>HASHTAG</div>
				                            <c:forTokens items="${tag_names}" var="tag_names" delims=",">
					                            	<a href="<c:url value='tagSearch?tag_name=${tag_names}' />">#${tag_names}</a>
					                        </c:forTokens>
			                            <p class="help-block text-danger"></p>
			                        </div>
			                    </div>
                			</th>
                		</tr>
                		<tr>
                			<th>
			                    <div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>Hit</label>
			                            <div>조회</div>
			                            <input type="text" class="form-control" value="${tagSearchList.hit}" readonly="readonly">
			                            <p class="help-block text-danger"></p>
			                        </div>
			                    </div>
                			</th>
                			<th colspan="2">
			                    <div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>FILE</label>
			                            <div>첨부파일</div>
			                            <input type="text" class="form-control" value="${tagSearchList.originalFilename}" readonly="readonly">
			                            <p class="help-block text-danger"></p>
			                        </div>
			                    </div>
                			</th>
                		</tr>
                		<tr>
                			<th>
		                    <div id="success"></div>
		                    <div class="row">
		                        <div class="form-group col-xs-12">
		                        	<c:if test="${sessionScope.user_id == tagSearchList.user_id}">
			                            <a href="<c:url value='postUpdateForm?post_no=${tagSearchList.post_no}' />">
			                            	<button type="button" class="btn btn-default">수정</button>
			                            </a>
		                            	<button type="button" class="btn btn-default" onclick="postDelete()">삭제</button>
									</c:if>
		                        </div>
		                    </div>
                			</th>
                			<th></th>
                			<th>
		                            <a href="postlist">
		                            	<button type="button" style="margin-left: 66%;" class="btn btn-default">Return</button>
		                            </a>
                			</th>
                		</tr>
                	</table>
                	<hr>
            </div>
        </div>
</c:forEach>
    </div>
</body>
</html>