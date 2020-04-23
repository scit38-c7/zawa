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
	

<!-- 좋아요 로그인경고 -->
<script type="text/javascript">
	$(function(){
	  $('.btn_like').click(function(){
		  $('.btn_like').html("<a href='boardlogin' style='margin-left: 13px'>로그인</a>");
	  });
	});
</script>

<!-- 댓글입력 로그인경고 -->
<script type="text/javascript">
	$(function(){
	  $('.rs_btn').click(function(){
		  $('.rs_btn').html("<a href='boardlogin'>로그인</a>");
	  });
	});
</script>

<!-- 댓글창 토글 -->
<script type="text/javascript">
	$(function(){
	  $('.btn_comment').click(function(){
		  $('.btn_comment_icon').toggle("fast");
	  });
	});
</script>

<!-- 댓글창 삭제-->
	<script type="text/javascript">

		function replyDelete(replynum) {
			if(confirm("댓글을 삭제하시겠습니까?")) {
				location.href="<c:url value='replyDelete?replynum="+ replynum +"&post_no=${vo.post_no}' />";
			}
		}
	</script>

<script type="text/javascript">
/* 좋아요 */
function like_func(){
  var post_no = $('#post_no').val();
  //var //user_id = $('#user_id', frm_read).val();
  //console.log("post_no, user_id : " + post_no +","+ user_id);
  
  $.ajax({
    url: "like_to",
    type: "GET",
    cache: false,
    dataType: "json",
    data: 'post_no=' + post_no,
    success: function(data) {
      var like_img = '';
      
      if(data.like_check == 0){
        like_img = "resources/image/like1.png";
      } else {
        like_img = "resources/image/like2.png";
      }      
      $('#like_img').attr('src', like_img);
      $('#like_cnt').html(data.like_cnt);
      $('#like_check').html(data.like_check);
    },
    error: function(request, status, error){
      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    }
  });
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
                				<h2>[작성글]</h2>
                			</th>
                		</tr>
                		<tr>
                			<th>
		                		<div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>No.</label>
			                        	<div>번호</div>
		                            	<input type="text" id="post_no" class="form-control" value="${vo.post_no}" readonly="readonly">
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
                				<!-- 좋아요 -->
                				<div class="row control-group">
                					<c:choose>
					                  	<c:when test="${sessionScope.user_id != null}">
					                  	<c:choose>
					                  		<c:when test="${like_check == 1}">
							                  <div><a href="javascript:like_func();"><img id="like_img" src="resources/image/like2.png" width="25" height="25" style="margin-left: 15px"></a></div>
							                  <span style="margin-left: 23px;" id="like_cnt">${like_cnt}</span>
					                          <p class="help-block text-danger"></p>
					                  		</c:when>
					                  		<c:otherwise>
						                  		<div><a href="javascript:like_func();"><img id="like_img" src="resources/image/like1.png" width="25" height="25" style="margin-left: 15px"></a></div>
								                <span style="margin-left: 23px;" id="like_cnt">${like_cnt}</span>
						                        <p class="help-block text-danger"></p>
					                  		</c:otherwise>
					                  	</c:choose>
						                  	</c:when>
					                  	<c:when test="${sessionScope.user_id == null}">
					                  		<div class="btn_like"><a><img src="resources/image/like1.png" width="25" height="25" style="margin-left: 13px" onclick="like_login()"></a></div>
					                  		<span style="margin-left: 13px;" id="like_cnt">${like_cnt}</span>
				                  		</c:when>
				                  	</c:choose>
			                    </div>
                			</th>
                			<td>
                				<div class="btn_comment">
                					<a>
                						<img src="resources/image/comment.png" width="30" height="30">
                					</a>
								</div>
								<span>[${replyCnt}]</span>
                			</td>
                			<th>
			                    <div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>Hit</label>
			                            <div>조회</div>
			                            ${vo.hit}
			                        </div>
			                    </div>
                			</th>
                			<th colspan="2">
			                    <div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>FILE</label>
			                            <div>첨부파일</div>
			                            ${vo.originalFilename}
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
                	<div class="btn_comment_icon">
                	<!-- 댓글 입력 -->
							<form action="<c:url value='replyWrite' />" method="post">
								<input type="hidden" name="post_no" value="${vo.post_no}" />
								<table id="replyinput" class="table table-hover">
									<tr>
										<td>
										<c:choose>
											<c:when test="${sessionScope.user_id != null}">
												<textarea rows="2" cols="100" id="replytext" name="replytext" required="required" placeholder="comment"></textarea>
												<input id="replysubmit" type="submit" value="입력" >
											</c:when>
											<c:when test="${sessionScope.user_id == null}">
												<textarea rows="2" cols="100" id="replytext" name="replytext" required="required" placeholder="comment"></textarea>
												<div class="rs_btn">
													<input type="submit" value="입력">
												</div>
				                  			</c:when>
										</c:choose>
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
        </div>
    </article>

    <hr>
    
    
    
</body>
</html>