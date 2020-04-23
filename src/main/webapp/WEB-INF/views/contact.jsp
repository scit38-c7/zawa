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
<title>[블로그]</title>
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
	
	<!-- 메뉴 네비게이션 -->
    <nav class="navbar navbar-default navbar-custom navbar-fixed-top">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">
                    	Toggle navigation
                    </span>
                    Menu <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand" href="main">GO BLOG</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            	<%-- <div class="divnew" id="bs-example-navbar-collapse-1">
	                <c:choose>
		                <c:when test="${sessionScope.user_id != null}">
		                	<h5 class="hfive">${sessionScope.user_id}님 환영합니다 <a href="<c:url value='logout'/>" style="text-decoration: none;" class="hfive">　로그아웃</a></h5>
		                </c:when>
	                </c:choose>
            	</div> --%>
                <ul class="nav navbar-nav navbar-right">
                	<c:choose>
                		<c:when test="${sessionScope.user_id != null}">
	                	<li>
	                		<div style="margin-right: -25px;">
		                		<h5 class="hfive">${sessionScope.user_id}님 환영합니다</h5>
	                		</div>
	                	</li>
	                	<li>
	                		<a href="<c:url value='logout'/>" style="text-decoration: none;" class="hfive">　로그아웃</a>
	                	</li>
                		</c:when>
                	</c:choose>
                    <li>
                        <a href="main">Home</a>
                    </li>
                    <li>
                        <a href="about">Gallery</a>
                    </li>
                    <li>
                        <a href="postlist">Post</a>
                    </li>
                    <li>
                        <a href="contact">Contact</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Page Header -->
    <!-- Set your background image for this header on the line below. -->
    <header class="intro-header" style="background-image: url('resources/image/contact_1.jpg')">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                    <div class="page-heading">
                        <hr class="small">
                        <span class="subheading"></span>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                <p>문의사항이 있다면 언제든지 아래의 양식으로 메일로 보내 주세요.</p>
                <!-- Contact Form - Enter your email address on line 19 of the mail/contact_me.php file to make this form work. -->
                <!-- WARNING: Some web hosts do not allow emails to be sent through forms to common mail hosts like Gmail or Yahoo. It's recommended that you use a private domain email address! -->
                <!-- NOTE: To use the contact form, your site must be on a live web host with PHP! The form will not work locally! -->
                <form name="sendMessage" id="contactForm" action="mailSend.jsp" method="post">
                    <div class="row control-group">
                        <div class="form-group col-xs-12 floating-label-form-group controls">
                            <label>Name</label>
                            <input type="text" class="form-control" placeholder="Name" name="name" id="name" required data-validation-required-message="Please enter your name.">
                            <p class="help-block text-danger"></p>
                        </div>
                    </div>
                    <div class="row control-group">
                        <div class="form-group col-xs-12 floating-label-form-group controls">
                            <label>Email Address</label>
                            <input type="email" class="form-control" placeholder="Email Address" name="email" id="email" required data-validation-required-message="Please enter your email address.">
                            <p class="help-block text-danger"></p>
                        </div>
                    </div>
                    <div class="row control-group">
                        <div class="form-group col-xs-12 floating-label-form-group controls">
                            <label>Phone Number</label>
                            <input type="tel" class="form-control" placeholder="Phone Number" name="phone" id="phone" required data-validation-required-message="Please enter your phone number.">
                            <p class="help-block text-danger"></p>
                        </div>
                    </div>
                    <div class="row control-group">
                        <div class="form-group col-xs-12 floating-label-form-group controls">
                            <label>Message</label>
                            <textarea rows="5" class="form-control" placeholder="Message" name="message" id="message" required data-validation-required-message="Please enter a message."></textarea>
                            <p class="help-block text-danger"></p>
                        </div>
                    </div>
                    <input type="hidden" name="subject" value="goblogcontect">
                    <input type="hidden" name="to" value="jwhttl7097@naver.com">
                    <input type="hidden" name="from" value="jwhttl7097@naver.com">
                    <br>
                    <div id="success"></div>
                    <div class="row">
                        <div class="form-group col-xs-12">
                            <button type="submit" class="btn btn-default">Send</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <hr>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                    <p class="copyright text-muted">Copyright &copy; woohyeok jung 2020</p>
                </div>
            </div>
        </div>
    </footer>
	
	<!-- jQuery -->
    <script src="resources/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Contact Form JavaScript -->
    <script src="resources/js/jqBootstrapValidation.js"></script>
    <script src="resources/js/contact_me.js"></script>

    <!-- Theme JavaScript -->
    <script src="resources/js/clean-blog.min.js"></script>

</body>
</html>