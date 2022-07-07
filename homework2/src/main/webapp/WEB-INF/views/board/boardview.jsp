<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>   

<style>
.view_title_01{
text-align: center;
margin:40px;
}
.view_p_01{
text-align: center;
margin:20px;
font-size: small;
}
.view_p_02{
text-align: left;
font-size: small;
}
.view_p_03{
text-align: left;
font-size: small;
}
.view_contents_01{
margin-top: 30px;
text-align: left;
}
.view_btn_01{
text-align: center;
margin: 50px;
}
.view_btn_02{
text-align: right;
margin-top: 10px;
}
.text_01{
height: 15px;
}
.reply_calss_01{
border: 1px solid #ccc;
}
.span_01{
font-size: small;
}
.like_button_01{
text-align: center;
}
.image_div_01{
display: flex;
justify-content: center;
align-items: center;
text-align: center;
}
.heart_01{
width: 40px;
height: 40px;
object-fit: cover;
cursor: pointer;
}
.heart_02{
width: 40px;
height: 40px;
object-fit: cover;
cursor: pointer;
}
.heart_03{
width: 40px;
height: 40px;
object-fit: cover;
cursor: pointer;
}
.heart_04{
width: 40px;
height: 40px;
object-fit: cover;
cursor: pointer;
}
.reply_01{
width: 40px;
height: 40px;
object-fit: cover;
cursor: pointer;
}


</style>

<script>
	function modify(){
		location.href='/board/boardmodify.do?boardidx=${vo.boardidx}';
	}
	
	function deletecheck(){
		//window.openを利用してパスワードを入力できる新しいウィンドウを表示する。
		/*
		window.open("/board/deletecheck.do?boardidx=${vo.boardidx}",
				 "passwordCheck", "width=800, height=700");
		*/
		location.href='/board/deletecheck.do?boardidx=${vo.boardidx}';
	}
	
	function sessiondelete(){
		location.href='/board/boardsessiondelete.do?boardidx=${vo.boardidx}';
	}
	
	function replySend(){
		if(reply.replycontents.value==""){
			alert("内容を入力してください。");
			reply.replycontents.focus();
			return;
		}
		
		var useridx = $(".useridx").val();
		
		if(useridx==0){
			if(reply.nicname.value==""){
				alert("ニックネームを入力してください。");
				reply.nicname.focus();
				return;
			}
			if(reply.replypassword.value==""){
				alert("パスワードを入力してください。");
				reply.replypassword.focus();
				return;
			}
		}
		reply.submit();
	}
	
	function ondisplay(dive){
		console.log("받은 매개변수" + dive);
		$("#"+dive).show();
	}
	function offdisplay(dive){
		console.log("받은 매개변수" + dive);
		$("#"+dive).hide();
	}
	
	// 대댓글 개발 도중 여러개의 폼이 생성되어 중복되는 input name="" 발생
	
	function rereplysend(dive){
		if(rereply[dive].replycontents.value==""){
			alert("内容を入力してください。");
			rereply[dive].replycontents.focus();
			return;
		}
		
		var useridx = $(".useridx").val();
		
		if(useridx==0){
			if(rereply[dive].nicname.value==""){
				alert("ニックネームを入力してください。");
				rereply[dive].nicname.focus();
				return;
			}
			if(rereply[dive].replypassword.value==""){
				alert("パスワードを入力してください。");
				rereply[dive].replypassword.focus();
				return;
			}
		}
		rereply[dive].submit();
	}
	
	
	function replydelete1(replyidx, boardidx){
		location.href='/board/replysessiondelete.do?replyidx='+replyidx+'&boardidx='+boardidx;
	}
	function replydelete2(replyidx, boardidx){
		location.href='/board/replydeletecheck.do?replyidx='+replyidx+'&boardidx='+boardidx;
	}
	
	//회원 좋아요 기능
	$(function(){
		$(".heart_02").on("click", function(){
			var useridx = $(".useridx").val();
			var boardidx = ${vo.boardidx};
			var sendData = {'useridx':useridx, 'boardidx':boardidx};
			
			$.ajax({
				url:'/board/heartup.do',
				data:sendData,
				type:'post',
				success:function(data){
					if(data==1){
						//class 이름을 바꿔도 같은 function을 실행하는 문제 발생 해결방법 강구
						//$('.heart_02').prop("src","/resources/image/like.jpg");
						//$('.heart_02').attr("class","heart_01");
						$('.heart_02').hide();
						$('.heart_01').show();
						
						$.ajax({
							url:'/board/getheartcnt.do',
							data: {'boardidx':boardidx},
							type:'post',
							success:function(result){
								$(".span_heart").html("");
								$(".span_heart").html(result);
							}
						})
					}
				}
			})
			//ajax 끝
		})
		
		//회원 좋아요 취소
		$(".heart_01").on("click", function(){
			var useridx = $(".useridx").val();
			var boardidx = ${vo.boardidx};
			var sendData = {'useridx':useridx, 'boardidx':boardidx};
			
			$.ajax({
				url:'/board/heartdown.do',
				data:sendData,
				type:'post',
				success:function(data){
					if(data==1){
						//class 이름을 바꿔도 같은 function을 실행하는 문제 발생 해결방법 강구
						//$('.heart_01').prop("src","/resources/image/nolike.png");
						//$('.heart_01').attr("class","heart_02");
						
						$('.heart_01').hide();
						$('.heart_02').show();
						
						$.ajax({
							url:'/board/getheartcnt.do',
							data: {'boardidx':boardidx},
							type:'post',
							success:function(result){
								$(".span_heart").html("");
								$(".span_heart").html(result);
							}
						})
					}
				}
			})
			//ajax 끝
		})
		
		$(".heart_04").on("click", function(){
			var boardidx = ${vo.boardidx};
			location.href="/board/likeinsertcheck.do?boardidx="+boardidx;
		})
		$(".heart_03").on("click", function(){
			var boardidx = ${vo.boardidx};
			var heartcookie = $(".heartcookie").val();
			location.href="/board/likedeletepasswordcheck.do?boardidx="+boardidx+"&heartcookie="+heartcookie;
		})
	//function 끝
	})
</script>

<!-- sub contents -->	
<div class="container-fluid">
	<div class="container">
		<div class="row">
			<div class="col-3"></div>
			<!-- 余白 -->
			<div class="col-6">
				<!-- タイトル -->
				<div class="view_title_01">
					<h5><strong>${vo.title}</strong></h5>
					<hr>
					<p class="view_p_01">作成者 : ${vo.nicname} &nbsp;/&nbsp; 読んだ回数 : ${vo.readcnt} &nbsp;/&nbsp; 作成日 : ${vo.boardregdate}</p>
				</div>
				<!-- contents -->
				<div class="view_contents_01">
					<!-- preタグを利用すれば、textareaに何度も分かち書きと<br>タグまで全て適用させてくれる 07/01 -->
					<pre>${vo.contents}</pre>
					
					<!-- like button -->
					<div class="like_button_01">
						<div class="image_div_01">
						
						<!-- 회원의 경우 -->
						<c:if test="${sessionUser.useridx != null}">
						<input type="hidden" value="" name="cookie" class="heartcookie">
						<c:if test="${heartSwich eq 'yes'}">
							<img src="/resources/image/like.jpg" class="heart_01">
							<img src="/resources/image/nolike.png" class="heart_02" style="display: none;">
						</c:if>
						<c:if test="${heartSwich ne 'yes'}">
							<img src="/resources/image/like.jpg" class="heart_01" style="display: none;">
							<img src="/resources/image/nolike.png" class="heart_02"> 
						</c:if>
						</c:if>
						
						<!-- --------------------------------- -->
						
						<!-- 비회원인 경우 -->
						<c:if test="${sessionUser.useridx == null}">
						<input type="hidden" value="${heartcookie}" name="cookie" class="heartcookie">
						<c:if test="${heartSwich eq 'yes'}">
							<img src="/resources/image/like.jpg" class="heart_03">
							<img src="/resources/image/nolike.png" class="heart_04" style="display: none;">
						</c:if>
						<c:if test="${heartSwich ne 'yes'}">
							<img src="/resources/image/like.jpg" class="heart_03" style="display: none;">
							<img src="/resources/image/nolike.png" class="heart_04"> 
						</c:if>
						</c:if>
						
						&nbsp; <span class="span_heart">${vo.likecnt}</span>					
						</div>
						
					</div>
				</div>
				<hr>

				<div class="view_btn_01">
				  	<button type="button" class="btn btn-primary" onClick="history.back()">リスト</button>&nbsp;&nbsp;
				  	
				  	<!-- 修正と削除は作成したユーザーとログインしたユーザーが同じ時に活性化する。 07/01 -->
				  	<c:if test="${vo.useridx eq sessionUser.useridx}">
				  	<button type="button" class="btn btn-primary" onClick="modify()">修正</button>&nbsp;&nbsp;
				  	<button type="button" class="btn btn-primary" onClick="sessiondelete()">削除</button>
				  	</c:if>
				  	
				  	<!-- 非会員が作成した場合、useridxが0と保存されるようにしたため、ログインしていないユーザーであり、useridxが0の文は誰でも修正可能である。
				  	しかし、修正する時は登録する時に入力したパスワードを入力しなければ修正できないようにする。-->
				  	<c:if test="${vo.useridx == 0 and sessionUser.useridx == null}">
				  	<button type="button" class="btn btn-primary" onClick="modify()">修正</button>&nbsp;&nbsp;
				  	<button type="button" class="btn btn-primary" onClick="deletecheck()">削除</button>
				  	</c:if>
				</div>
				<hr>
				
				<!-- コメント  -->
				<form method="post" action="/board/boardreplypro.do" name="reply">
				<input type="hidden" name="boardidx" value="${vo.boardidx}">
				<input type="hidden" name="parent" value="0">
				
				<c:if test="${sessionUser.username != null}">
					<input type="hidden" name="useridx" value="${sessionUser.useridx}" class="useridx">
					<input type="hidden" name="nicname" value="${sessionUser.nicname}">
				</c:if>
				
				<div class="mb-3">
 					 <label for="exampleFormControlTextarea1" class="form-label view_p_03">コメント</label>
 					 <textarea class="form-control text_01" id="exampleFormControlTextarea1" rows="3" name="replycontents"></textarea>
				</div>
				
				<!-- 非会員の場合、コメントもニックネームとパスワードを入力 -->
				<c:if test="${sessionUser.username == null}">
				<!-- 非会員の場合 useridx 0で置いておく-->
				<input type="hidden" name="useridx" value="0" class="useridx">
				<div class="row">
					<div class="col-6">
						<span class="view_p_02">ニックネーム</span><br>
						<input type="text" name="nicname" id="nicname">
					</div>
					<div class="col-6">
						<span class="view_p_02">パスワード</span><br>
						<input type="password" name="replypassword" id="replypassword">
					</div>
				</div>
				</c:if>
				
				<div class="view_btn_02">
					<button type="button" class="btn btn-primary" onClick="replySend()">コメント 登録</button>				
				</div>
				</form>
				
				<hr>
				<c:if test="${empty replylist}">
				<p class="view_p_03">コメントがありません。</p>
				</c:if>
				<c:if test="${!empty replylist}">
				<p class="view_p_03">${cnt}のコメントがあります。</p>
				</c:if>
				
				
				<c:set var="redive" value="0"/>
				<c:forEach var="list" items="${replylist}">
				
				<div class="reply_calss_01">
					<c:if test="${list.replyidx != list.parent}">
					<img  src="/resources/image/reply.png" class="reply_01">
					</c:if>
					<span class="span_01"><strong>${list.nicname}</strong>&nbsp;/&nbsp;${list.replyregdate}</span>
					<pre class="span_01">${list.replycontents}</pre>
					
					<!-- 대댓글 달기 -->
					 
					<c:if test="${list.parent==list.replyidx}">
					<input type="button" value="答文" onClick="ondisplay(${redive})">
					</c:if>
					
					<c:if test="${list.useridx eq sessionUser.useridx}">
					<input type="button" value="削除" onClick="replydelete1(${list.replyidx},${list.boardidx })">
					</c:if>
					<c:if test="${list.useridx == 0 and sessionUser.useridx == null}">
					<input type="button" value="削除" onClick="replydelete2(${list.replyidx},${list.boardidx })">
					</c:if>		
				</div>
				
					<!-- 대댓글을 달게 해준다.-->
					
					<div id="${redive}" class="comment_Reply" style="display: none;">
						 
						<form name="rereply" method="post" action="/board/boardreplypro.do">
						<input type="hidden" name="boardidx" value="${vo.boardidx}">
						<input type="hidden" name="parent" value="${list.replyidx}">
						
						<c:if test="${sessionUser.username != null}">
							<input type="hidden" name="useridx" value="${sessionUser.useridx}" class="useridx">
							<input type="hidden" name="nicname" value="${sessionUser.nicname}">
						</c:if>
						
						<textarea class="form-control text_01" id="exampleFormControlTextarea1" rows="3" name="replycontents"></textarea>
						
							<c:if test="${sessionUser.username == null}">
							
							<input type="hidden" name="useridx" value="0" class="useridx">
							<div class="row">
								<div class="col-6">
									<span class="view_p_02">ニックネーム</span>
									<input type="text" name="nicname" id="nicname">
								</div>
								<div class="col-6">
									<span class="view_p_02">パスワード</span>
									<input type="password" name="replypassword" id="replypassword">
								</div>
							</div>
							</c:if>
							
							<input type="button" value="등록" onClick="rereplysend(${redive})">&nbsp;
							<input type="button" value="취소" onClick="offdisplay(${redive})">&nbsp;
							
						</form>
						
					</div>
					<c:set var="redive" value="${redive+1}"/>
				</c:forEach>
				  
			</div>
			<!-- 余白 -->
			<div class="col-3"></div>
		</div>
	</div>
</div>
	
<%@ include file="../include/footer.jsp"%>   