<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>글쓰기</title>
<script src="resources/js/jquery-3.4.1.js"></script>	

<link rel="stylesheet" type="text/css" href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.no-icons.min.css">
<link rel="stylesheet" type="text/css" href="http://jakiestfu.github.com/Mention.js/recommended-styles.css">

	<style type="text/css">
		body {
			padding:20px;
			background: #EEE;
			color: #252525;
			text-shadow: 0 1px 0 white;
			}
		ul {
			text-shadow:none;
			}
		textarea {
			padding: 8px 15px;
			background: #fefefe;
			-moz-border-radius: 2px;
			-webkit-border-radius: 2px;
			-o-border-radius: 2px;
			-ms-border-radius: 2px;
			-khtml-border-radius: 2px;
			border-radius: 2px;
			border: 1px solid #999;
			-moz-box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.3);
			-webkit-box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.3);
			-o-box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.3);
			box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.3);
			overflow: auto;
			overflow-y: hidden;
			color:#444;
			width:100%;
			height:100px;
			-webkit-box-sizing: border-box;
			-moz-box-sizing: border-box;
			box-sizing: border-box;
			}
		h2{
			border-bottom: 1px solid #CCC;
			margin-bottom: 5px;
			margin-top: 30px;
			}
	</style>

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
		function writeConfirm(){
			return confirm("등록 하시겠습니까?");
		}
	</script>
	
	<!-- 글자수 제한 -->
	<script type="text/javascript">
		$(function() {
		    $('.content').keyup(function (e){
		        var content = $(this).val();
		        $('.counter').html(content.length + '/1000');
		        if(content.length >= 1000){
		        	$('.counter').html('최대 1000자 까지 작성할수 있습니다.');
			    }
		    });
		    $('.content').keyup();
		});
	</script>
	
</head>
<body>

<p>
"In this example, a full name, image, and username is shown in the resulting list. You can query by username OR full name (try typing @Jenna)"
</p>
<textarea id="full"></textarea>
<ul class="typeahead dropdown-menu" style="top: 262px; left: 20px; display: none;">
<li data-value="calisunshine" class="active">
<a href="#">
<img class="mention_image" src="http://placekitten.com/23/20">
<b class="mention_name">Jenna Talbert</b>
<span class="mention_username"> @calisunshine</span>
</a>
</li>
</ul>

<script type="text/javascript" src="resources/js/jquery-1.8.2.js"></script>
<script type="text/javascript" src="http://jakiestfu.github.io/Mention.js/javascripts/bootstrap-typeahead.js"></script>

<script type="text/javascript">
(function(e){e.fn.extend({mention:function(t){this.opts={users:[],delimiter:"@",sensitive:true,queryBy:["name","username"],typeaheadOpts:{}};var n=e.extend({},this.opts,t),r=function(){if(typeof e=="undefined"){throw new Error("jQuery is Required")}else{if(typeof e.fn.typeahead=="undefined"){throw new Error("Typeahead is Required")}}return true},i=function(e,t){var r;for(r=t;r>=0;r--){if(e[r]==n.delimiter){break}}return e.substring(r,t)},s=function(e){var t;for(t in n.queryBy){if(e[n.queryBy[t]]){var r=e[n.queryBy[t]].toLowerCase(),i=this.query.toLowerCase().match(new RegExp(n.delimiter+"\\w+","g")),s;if(!!i){for(s=0;s<i.length;s++){var o=i[s].substring(1).toLowerCase(),u=new RegExp(n.delimiter+r,"g"),a=this.query.toLowerCase().match(u);if(r.indexOf(o)!=-1&&a===null){return true}}}}}},o=function(e){var t=this.query,r=this.$element[0].selectionStart,i;for(i=r;i>=0;i--){if(t[i]==n.delimiter){break}}var s=t.substring(i,r),o=t.substring(0,i),u=t.substring(r),t=o+n.delimiter+e+u;this.tempQuery=t;return t},u=function(e){if(e.length&&n.sensitive){var t=i(this.query,this.$element[0].selectionStart).substring(1),r,s=e.length,o={highest:[],high:[],med:[],low:[]},u=[];if(t.length==1){for(r=0;r<s;r++){var a=e[r];if(a.username[0]==t){o.highest.push(a)}else if(a.username[0].toLowerCase()==t.toLowerCase()){o.high.push(a)}else if(a.username.indexOf(t)!=-1){o.med.push(a)}else{o.low.push(a)}}for(r in o){var f;for(f in o[r]){u.push(o[r][f])}}return u}}return e},a=function(t){var r=this;t=e(t).map(function(t,i){t=e(r.options.item).attr("data-value",i.username);var s=e("<div />");if(i.image){s.append('<img class="mention_image" src="'+i.image+'">')}if(i.name){s.append('<b class="mention_name">'+i.name+"</b>")}if(i.username){s.append('<span class="mention_username"> '+n.delimiter+i.username+"</span>")}t.find("a").html(r.highlighter(s.html()));return t[0]});t.first().addClass("active");this.$menu.html(t);return this};e.fn.typeahead.Constructor.prototype.render=a;return this.each(function(){var t=e(this);if(r()){t.typeahead(e.extend({source:n.users,matcher:s,updater:o,sorter:u},n.typeaheadOpts))}})}})})(jQuery)
</script>

<script type="text/javascript">
		$(document).ready(function(){
			
			$("#full").mention({
				users: [{
					name: 'Lindsay Made',
					username: 'LindsayM',
					image: 'http://placekitten.com/25/25'
				}, {
					name: 'Rob Dyrdek',
					username: 'robdyrdek',
					image: 'http://placekitten.com/25/24'
				}, {
					name: 'Rick Bahner',
					username: 'RickyBahner',
					image: 'http://placekitten.com/25/23'
				}, {
					name: 'Jacob Kelley',
					username: 'jakiestfu',
					image: 'http://placekitten.com/25/22'
				}, {
					name: 'John Doe',
					username: 'HackMurphy',
					image: 'http://placekitten.com/25/21'
				}, {
					name: 'Charlie Edmiston',
					username: 'charlie',
					image: 'http://placekitten.com/25/20'
				}, {
					name: 'Andrea Montoya',
					username: 'andream',
					image: 'http://placekitten.com/24/20'
				}, {
					name: 'Jenna Talbert',
					username: 'calisunshine',
					image: 'http://placekitten.com/23/20'
				}, {
					name: 'Street League',
					username: 'streetleague',
					image: 'http://placekitten.com/22/20'
				}, {
					name: 'Loud Mouth Burrito',
					username: 'Loudmouthfoods',
					image: 'http://placekitten.com/21/20'
				}]
			});


			$("#med").mention({
				users: [{
					name: 'Lindsay Made',
					username: 'LindsayM'
				}, {
					name: 'Rob Dyrdek',
					username: 'robdyrdek'
				}, {
					name: 'Rick Bahner',
					username: 'RickyBahner'
				}, {
					name: 'Jacob Kelley',
					username: 'jakiestfu'
				}, {
					name: 'John Doe',
					username: 'HackMurphy'
				}, {
					name: 'Charlie Edmiston',
					username: 'charlie'
				}, {
					name: 'Andrea Montoya',
					username: 'andream'
				}, {
					name: 'Jenna Talbert',
					username: 'calisunshine'
				}, {
					name: 'Street League',
					username: 'streetleague'
				}, {
					name: 'Loud Mouth Burrito',
					username: 'Loudmouthfoods'
				}]
			});

			$("#light").mention({
				users: [{
					username: 'LindsayM'
				}, {
					username: 'robdyrdek'
				}, {
					username: 'RickyBahner'
				}, {
					username: 'jakiestfu'
				}, {
					username: 'HackMurphy'
				}, {
					username: 'charlie'
				}, {
					username: 'andream'
				}, {
					username: 'calisunshine'
				}, {
					username: 'streetleague'
				}, {
					username: 'Loudmouthfoods'
				}]
			});
			
		});
	</script>

<!-- Main Content -->
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                <p style="font-style: oblique;;">게시글 작성</p>
                <!-- Contact Form - Enter your email address on line 19 of the mail/contact_me.php file to make this form work. -->
                <!-- WARNING: Some web hosts do not allow emails to be sent through forms to common mail hosts like Gmail or Yahoo. It's recommended that you use a private domain email address! -->
                <!-- NOTE: To use the contact form, your site must be on a live web host with PHP! The form will not work locally! -->
	                <form action="<c:url value='postWrite'/>" name="sentMessage" id="contactForm" enctype="multipart/form-data" method="post">
	                    <div class="row control-group">
	                        <div class="form-group col-xs-12 floating-label-form-group controls">
	                            <label>NAME</label>
	                            <input type="text" class="form-control" placeholder="Name" id="name" value="${sessionScope.user_id}">
	                            <p class="help-block text-danger"></p>
	                        </div>
	                    </div>
	                    <div class="row control-group">
	                        <div class="form-group col-xs-12 floating-label-form-group controls">
	                            <label>TITLE</label>
	                            <input type="text" class="form-control" placeholder="TITLE" id="TITLE" name="title" required data-validation-required-message="Please enter your title.">
	                            <p class="help-block text-danger"></p>
	                        </div>
	                    </div>
	                     <div class="row control-group">
	                        <div class="form-group col-xs-12 floating-label-form-group controls">
	                            <label>HASHTAG</label>
	                            <input type="text" class="form-control" placeholder="HASHTAG" id="tag_name" name="tag_name">
	                            <p class="help-block text-danger"></p>
	                        </div>
	                    </div>
	                    <div class="row control-group">
	                        <div class="form-group col-xs-12 floating-label-form-group controls">
	                            <label>FILE</label>
	                            <input type="file" class="form-control" id="file" name="uploadFile" style="padding-top: inherit;">
	                            <p class="help-block text-danger"></p>
	                        </div>
	                    </div>
	                    <div class="row control-group">
	                        <div class="form-group col-xs-12 floating-label-form-group controls">
	                            <label>CONTENT</label>
	                            <textarea rows="10" class="content form-control" name="content" maxlength="1000" placeholder="CONTENT (최대 1000자)" id="content" required data-validation-required-message="Please enter a message."></textarea>
	                            <p class="help-block text-danger"></p>
	                        </div>
	                    </div>
	                    <div style="color:#aaa;" class="counter">
	                    <script type='text/javascript' src='http://code.jquery.com/jquery-1.8.2.js'></script>
	                    </div>
	                    <br>
	                    <div id="success"></div>
	                    <div class="row">
	                        <div class="form-group col-xs-12">
	                            <button type="submit" class="btn btn-default" onclick="writeConfirm()">Write</button>
	                            <button type="reset" class="btn btn-default">Cancel</button>
	                            <a href="postlist">
	                            	<button type="button" style="margin-left: 66%;" class="btn btn-default">Return</button>
	                            </a>
	                        </div>
	                    </div>
	                </form>
            </div>
        </div>
    </div>

    <hr>

</body>
</html>
