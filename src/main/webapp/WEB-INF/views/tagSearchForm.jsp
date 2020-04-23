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

<!-- 댓글창 삭제-->
	<script type="text/javascript">

		function replyDelete(replynum) {
			if(confirm("댓글을 삭제하시겠습니까?")) {
				location.href="<c:url value='tagReplyDelete?replynum="+ replynum +"&post_no=${vo.post_no}' />";
			}
		}
	</script>
	
	<!-- 댓글창 토글-->
	<script type="text/javascript">
		function replyToggle(index) {
			$("[class='btn_comment_icon']:eq(" + index + ")").toggle();
		}
	</script>
	

<script type="text/javascript">
$(function(){
	
/* 좋아요 */
$('.like_img').on('click',function (){
//   var post_no = $('.post_no').val();
  //var //user_id = $('#user_id', frm_read).val();
  //console.log("post_no, user_id : " + post_no +","+ user_id);
  var post_no = $(this).prev().val();
//   console.log("!!!!!!!!!!!!!!!!!!!!!!!!!"+post_no);
	var $this = $(this);
  
  $.ajax({
    url: "like_to",
    type: "GET",
    cache: false,
    dataType: "json",
    data: 'post_no=' + post_no,
    success: function(data) {
        console.log("!!!!!!!!!!!!!!!!!");
    	console.log($(this));
      var like_img = '';
      
      if(data.like_check == 0){
        like_img = "resources/image/like1.png";
      } else {
        like_img = "resources/image/like2.png";
      }     
      $this.attr('src', like_img);
      $this.closest("div").next().html(data.like_cnt);
//    $('.like_check').html(data.like_check);
    },
    error: function(request, status, error){
      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
    }
  });
});
});
</script>

</head>
<body>
        <!-- Main Content -->
    <div class="container">
    <c:forEach items="${tagSearchList}" var="tagSearchList" varStatus="roop">
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
		                            	<input type="text" class="form-control post_no" value="${tagSearchList.post_no}" readonly="readonly">
		                            	<p class="help-block text-danger"></p>
		                        	</div>
		                   		</div>
                			</th>
                			<th>
			                    <div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>NAME</label>
			                            <div>작성자</div>
			                            <input type="text" class="form-control" id="user_id" value="${tagSearchList.user_id}" readonly="readonly">
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
			                            	<c:forEach items="${sList}" var="list">
			                            		<c:if test="${list.POST_NO == tagSearchList.post_no}">
			                            			<a href="<c:url value='tagSearch?tag_name=${list.TAG_NAME}' />">#${list.TAG_NAME}</a>
			                            		</c:if>
			                            	</c:forEach>
			                            <p class="help-block text-danger"></p>
			                        </div>
			                    </div>
                			</th>
                		</tr>
                		<tr>
                			<td>
                				<div class="row control-group">
                					<c:choose>
					                  	<c:when test="${sessionScope.user_id != null}">
						                  	<c:choose>
						                  		<c:when test="${like_check == 1}">
								                  <div>
								                  		<input type="hidden" value="${tagSearchList.post_no}">
									                  		<img class="like_img" src="resources/image/like2.png" width="25" height="25" style="margin-left: 15px">
								                  </div>
								                  <span style="margin-left: 23px;">${tagSearchList.like_cnt}</span>
						                          <p class="help-block text-danger"></p>
						                  		</c:when>
						                  		<c:otherwise>
							                  		<div>
								                  		<input type="hidden" value="${tagSearchList.post_no}">
								                  		<img class="like_img" src="resources/image/like1.png" width="25" height="25" style="margin-left: 15px">
													</div>
									                <span style="margin-left: 23px;">${tagSearchList.like_cnt}</span>
							                        <p class="help-block text-danger"></p>
						                  		</c:otherwise>
						                  	</c:choose>
					                  	</c:when>
					                  	<c:when test="${sessionScope.user_id == null}">
					                  		<div class="btn_like"><a><img src="resources/image/like1.png" width="25" height="25" style="margin-left: 13px" onclick="like_login()"></a></div>
					                  		<span style="margin-left: 13px;">${tagSearchList.like_cnt}</span>
				                  		</c:when>
				                  	</c:choose>
			                    </div>
                			</td>
                			<td>
                				<div class="btn_comment">
                					<a onclick="replyToggle(${roop.index});return false;">
                						<img src="resources/image/comment.png" width="30" height="30">
                					</a>
								</div>
								<c:forEach items="${tagCommentCntList}" var="tccl">
                            		<c:if test="${tccl.POST_NO == tagSearchList.post_no}">
										<span>[${tccl.COMMENT_CNT}]</span>
                            		</c:if>
                            	</c:forEach>
                			</td>
                			<th>
			                    <div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>Hit</label>
			                            <div>조회       ${tagSearchList.hit}</div>
			                            <p class="help-block text-danger"></p>
			                        </div>
			                    </div>
                			</th>
                			<th colspan="1">
			                    <div class="row control-group">
			                        <div class="form-group col-xs-12 floating-label-form-group controls">
			                            <label>FILE</label>
			                            <div>첨부파일   ${tagSearchList.originalFilename}</div>
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
                	<div class="btn_comment_icon" hidden="">
                	<!-- 댓글 입력 -->
							<form action="<c:url value='tagReplyWrite' />" method="post">
								<input type="hidden" name="post_no" value="${tagSearchList.post_no}" />
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
								<c:forEach items="${tagCommentList}" var="tcl">
									<c:if test="${tcl.POST_NO == tagSearchList.post_no}">
										<tr>
											<td class="replytext ">
												${tcl.REPLYTEXT}
											</td>
											<td class="replyid">
												<span>${tcl.USER_ID} </span>
											</td>
											<td class="replydate">
												<span>${tcl.INPUTDATE}</span>
											</td>
											<c:if test="${sessionScope.user_id == tcl.USER_ID }">
												<td></td><td></td><td></td><td></td><td></td><td></td><td></td>
												<td></td><td></td><td></td><td></td><td></td><td></td><td></td>
												<td></td><td></td><td></td><td></td><td></td><td></td><td></td>
												<td></td><td></td><td></td><td></td><td></td><td></td><td></td>
												<td class="replybtn">
													<input type="button" class="btn btn-outline-success" value="삭제" onclick="replyDelete('${tcl.REPLYNUM}')" >
												</td>
											</c:if>
										</tr>
                            		</c:if>
								</c:forEach>
							</table>
							</div> 
						<!-- end #replydisplay -->
						</div>
                	<hr>
            </div>
        </div>
</c:forEach>
    </div>
</body>
</html>