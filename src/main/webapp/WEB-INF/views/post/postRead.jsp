<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${vo.title}</title>
<!-- <style type="text/css">
#replyinput {
	width: 514px;
}

/* 리플 폼 영역 */
#replyForm {
	width: 600px;
	height: 50px;
	text-align: center;
}

/* 리플 목록 출력 표 */
table.reply {
	border-style: none;
}

td.replyid {
	
	width: 90px;
	border-style: none;
	background-color: #eeeeee;
	
	font-weight: bold;
}
td.replytext {
	width: 370px;
	border-style: none;
	background-color: #eeeeee;
}
td.replydate {
	width: 75px;
	border-style: none;
	background-color: #eeeeee;
	font-size: 10pt;
}
td.replybutton {
	width: 70px;
	border-style: none;
	background-color: #eeeeee;
	font-size: 10pt;
	text-align: center;	
}
td.paging {
	border-style: none;
	text-align: center;
}

#navigator {
	border: none;
	text-align: center;
}

#boardSearch {
	border: none;
}
</style> -->
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
	
	<script type="text/javascript">
		function postDelete() {
			if(confirm("삭제 하시겠습니까?")) {
				location.href="<c:url value='postDelete?post_no=${vo.post_no}' />";
			}
		}

		function replyDelete(replynum) {
			if(confirm("댓글을 삭제하시겠습니까?")) {
				location.href="<c:url value='replyDelete?replynum="+ replynum +"&post_no=${vo.post_no}' />";
			}
		}
	</script>
	

</head>
<body>
	<article>
                <!-- Main Content -->
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                <!-- Contact Form - Enter your email address on line 19 of the mail/contact_me.php file to make this form work. -->
                <!-- WARNING: Some web hosts do not allow emails to be sent through forms to common mail hosts like Gmail or Yahoo. It's recommended that you use a private domain email address! -->
                <!-- NOTE: To use the contact form, your site must be on a live web host with PHP! The form will not work locally! -->
                	<table>
                		<tr>
                			<th colspan="3">
                				<h2>[인기글]</h2>
                			</th>
                		</tr>
                		<tr>
                			<th>
		                		<div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>No.</label>
			                        	<div>번호</div>
		                            	<input type="text" class="form-control" value="${vo.post_no}" readonly="readonly">
		                            	<p class="help-block text-danger"></p>
		                        	</div>
		                   		</div>
                			</th>
                			<th>
			                    <div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>NAME</label>
			                            <div>작성자</div>
			                            <input type="text" class="form-control" value="${vo.user_id}" readonly="readonly">
			                            <p class="help-block text-danger"></p>
			                        </div>
			                    </div>
                			</th>
                			<th>
			                    <div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>Date</label>
			                            <div>작성일</div>
			                            <input type="text" class="form-control" value="${vo.inputdate}" readonly="readonly">
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
			                            <input type="text" class="form-control" value="${vo.title}" readonly="readonly">
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
			                            <textarea rows="10" class="form-control" readonly="readonly" >${vo.content}</textarea>
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
				                            <c:forTokens items="${tag_name}" var="tag_name" delims=",">
					                            	<a href="<c:url value='tagSearch?tag_name=${tag_name}' />">#${tag_name}</a>
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
			                            <input type="text" class="form-control" value="${vo.hit}" readonly="readonly">
			                            <p class="help-block text-danger"></p>
			                        </div>
			                    </div>
                			</th>
                			<th colspan="2">
			                    <div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>FILE</label>
			                            <div>첨부파일</div>
			                            <input type="text" class="form-control" value="${vo.originalFilename}" readonly="readonly">
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
		                        	<c:if test="${sessionScope.user_id == vo.user_id}">
			                            <a href="<c:url value='postUpdateForm?post_no=${vo.post_no}' />">
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
                	
                	<br>
                	
                	<!-- 댓글 입력 -->
							<form action="<c:url value='replyWrite' />" method="post">
								<input type="hidden" name="post_no" value="${vo.post_no}" />
								<table id="replyinput" class="table table-hover">
									<tr>
										<td>
											<textarea rows="2" cols="100" id="replytext" name="replytext" required="required" placeholder="comment"></textarea>
											<input id="replysubmit" type="submit" value="입력" />
										</td>
									</tr>
								</table>
							</form>

						<!-- 댓글 출력 -->
						<div id="replydisplay">
						<table class="reply table table-hover" >
							<c:forEach items="${replyList}" var="reply">
								<tr>
									<td class="replytext ">
										${reply.replytext}
									</td>
									<td class="replyid">
										<span>${reply.user_id} </span>
									</td>
									<td class="replydate">
										<span>${reply.inputdate}</span>
									</td>
									<c:if test="${sessionScope.user_id == reply.user_id }">
										<td></td><td></td><td></td><td></td><td></td><td></td><td></td>
										<td></td><td></td><td></td><td></td><td></td><td></td><td></td>
										<td></td><td></td><td></td><td></td><td></td><td></td><td></td>
										<td></td><td></td><td></td><td></td><td></td><td></td><td></td>
										<td class="replybtn">
											<input type="button" class="btn btn-outline-success" value="삭제" onclick="replyDelete('${reply.replynum}')" >
										</td>
									</c:if>
								</tr>
							</c:forEach>
						</table>
						</div> 
						<!-- end #replydisplay -->
            </div>
        </div>
        </div>
    </article>

    <hr>
    
    
    
</body>
</html>