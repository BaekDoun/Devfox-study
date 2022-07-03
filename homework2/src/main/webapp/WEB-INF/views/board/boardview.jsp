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

</style>

<script>
	function modify(){
		location.href='/board/boardmodify.do?boardidx=${vo.boardidx}';
	}
	
	function deletecheck(){
		//window.open을 이용하여 비밀번호를 입력할 수 있는 새창을 띄워준다.
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
			alert("내용을 입력해주세요");
			reply.replycontents.focus();
			return;
		}
		
		var useridx = $(".useridx").val();
		
		if(useridx==0){
			if(reply.nicname.value==""){
				alert("닉네임을 입력해주세요");
				reply.nicname.focus();
				return;
			}
			if(reply.replypassword.value==""){
				alert("비밀번호를 입력해주세요");
				reply.replypassword.focus();
				return;
			}
		}
		reply.submit();
	}
	
	function ondisplay(dive){
		console.log("받은 매개변수" + dive);
		$('#'+dive).show();
	}
	function offdisplay(dive){
		console.log("받은 매개변수" + dive);
		$('#'+dive).hide();
	}
	
	/* 대댓글 개발 도중 여러개의 폼이 생성되어 중복되는 input name="" 발생
	해결방법 강구중
	
	function rereplysend(){
		if(rereply.replycontents.value==""){
			alert("내용을 입력해주세요");
			rereply.replycontents.focus();
			return;
		}
		
		var useridx = $(".useridx").val();
		
		if(useridx==0){
			if(rereply.nicname.value==""){
				alert("닉네임을 입력해주세요");
				rereply.nicname.focus();
				return;
			}
			if(rereply.replypassword.value==""){
				alert("비밀번호를 입력해주세요");
				rereply.replypassword.focus();
				return;
			}
		}
		rereply.submit();
	}
	*/
	function replydelete1(replyidx, boardidx){
		location.href='/board/replysessiondelete.do?replyidx='+replyidx+'&boardidx='+boardidx;
	}
	function replydelete2(replyidx, boardidx){
		location.href='/board/replydeletecheck.do?replyidx='+replyidx+'&boardidx='+boardidx;
	}
</script>

<!-- sub contents -->	
<div class="container-fluid">
	<div class="container">
		<div class="row">
			<div class="col-3"></div>
			<!-- 여백 -->
			<div class="col-6">
				<!-- 제목 -->
				<div class="view_title_01">
					<h5><strong>${vo.title}</strong></h5>
					<hr>
					<p class="view_p_01">작성자 : ${vo.nicname} &nbsp;/&nbsp; 조회수 : ${vo.readcnt} &nbsp;/&nbsp; 작성일 : ${vo.boardregdate}</p>
				</div>
				<!-- 내용 -->
				<div class="view_contents_01">
					<!-- pre태그를 이용하면 textarea에 여러번 띄워쓰기와<br>태그까지 모두 적용시켜 준다. 07/01 -->
					<pre>${vo.contents}</pre>
				</div>
				<hr>

				<div class="view_btn_01">
				  	<button type="button" class="btn btn-primary" onClick="history.back()">목록</button>&nbsp;&nbsp;
				  	
				  	<!-- 수정과 삭제는 작성한유저와 로그인한 유저가 같을 시 활성화 되게 한다. 07/01 -->
				  	<c:if test="${vo.useridx eq sessionUser.useridx}">
				  	<button type="button" class="btn btn-primary" onClick="modify()">수정</button>&nbsp;&nbsp;
				  	<button type="button" class="btn btn-primary" onClick="sessiondelete()">삭제</button>
				  	</c:if>
				  	
				  	<!-- 비회원이 작성했을 경우 useridx가0으로 저장되게 하였으므로, 로그인을 안한 유저이며 useridx가0인글은 누구나 수정가능하다 
				  	하지만 수정할때는 등록할때 입력한 비밀번호를 입력해야 수정이 가능하도록 한다.-->
				  	<c:if test="${vo.useridx == 0 and sessionUser.useridx == null}">
				  	<button type="button" class="btn btn-primary" onClick="modify()">수정</button>&nbsp;&nbsp;
				  	<button type="button" class="btn btn-primary" onClick="deletecheck()">삭제</button>
				  	</c:if>
				</div>
				<hr>
				
				<!-- 댓글  -->
				<form method="post" action="/board/boardreplypro.do" name="reply">
				<input type="hidden" name="boardidx" value="${vo.boardidx}">
				
				<c:if test="${sessionUser.username != null}">
					<input type="hidden" name="useridx" value="${sessionUser.useridx}" class="useridx">
					<input type="hidden" name="nicname" value="${sessionUser.nicname}">
				</c:if>
				
				<div class="mb-3">
 					 <label for="exampleFormControlTextarea1" class="form-label view_p_03">댓글을 써보세요!</label>
 					 <textarea class="form-control text_01" id="exampleFormControlTextarea1" rows="3" name="replycontents"></textarea>
				</div>
				
				<!-- 비회원일시 댓글도 닉네임과 비밀번호를 입력 -->
				<c:if test="${sessionUser.username == null}">
				<!-- 비회원일시 useridx 0으로 둔다.-->
				<input type="hidden" name="useridx" value="0" class="useridx">
				<div class="row">
					<div class="col-6">
						<span class="view_p_02">닉네임</span>
						<input type="text" name="nicname" id="nicname">
					</div>
					<div class="col-6">
						<span class="view_p_02">비밀번호</span>
						<input type="password" name="replypassword" id="replypassword">
					</div>
				</div>
				</c:if>
				
				<div class="view_btn_02">
					<button type="button" class="btn btn-primary" onClick="replySend()">댓글 등록</button>				
				</div>
				</form>
				
				<hr>
				<c:if test="${empty replylist}">
				<p class="view_p_03">등록된 댓글이 없습니다.</p>
				</c:if>
				<c:if test="${!empty replylist}">
				<p class="view_p_03">${cnt}개의 댓글이 있습니다.</p>
				</c:if>
				
				<c:forEach var="list" items="${replylist}">
				<div class="reply_calss_01">
					<span class="span_01"><strong>${list.nicname}</strong>&nbsp;/&nbsp;${list.replyregdate}</span>
					<pre class="span_01">${list.replycontents}</pre>
					
					<!-- 대댓글 달기 -->
					<!--  
					<c:if test="${list.parent==0}">
					<input type="button" value="답글쓰기" onClick="ondisplay(${list.replyidx})">
					</c:if>
					-->
					<c:if test="${list.useridx eq sessionUser.useridx}">
					<input type="button" value="삭제" onClick="replydelete1(${list.replyidx},${list.boardidx })">
					</c:if>
					<c:if test="${list.useridx == 0 and sessionUser.useridx == null}">
					<input type="button" value="삭제" onClick="replydelete2(${list.replyidx},${list.boardidx })">
					</c:if>		
				</div>
				
					<!-- 대댓글을 달게 해준다.-->
					<!-- 
					<div id="${list.replyidx}" class="comment_Reply" style="display: none;">
						
						
						 대댓글 폼 
						<form name="rereply" method="post" action="/board/boardrereplypro.do">
						<input type="hidden" name="boardidx" value="${vo.boardidx}">
						<input type="hidden" name="parent" value="${list.replyidx}">
						
						<c:if test="${sessionUser.username != null}">
							<input type="hidden" name="useridx" value="${sessionUser.useridx}" class="useridx">
							<input type="hidden" name="nicname" value="${sessionUser.nicname}">
						</c:if>
						
						<textarea class="form-control text_01" id="exampleFormControlTextarea1" rows="3" name="replycontents"></textarea>
						
							<c:if test="${sessionUser.username == null}">
							
							 비회원일시 useridx 0으로 둔다.
							<input type="hidden" name="useridx" value="0" class="useridx">
							<div class="row">
								<div class="col-6">
									<span class="view_p_02">닉네임</span>
									<input type="text" name="nicname" id="nicname">
								</div>
								<div class="col-6">
									<span class="view_p_02">비밀번호</span>
									<input type="password" name="replypassword" id="replypassword">
								</div>
							</div>
							</c:if>
							<input type="button" value="등록" onClick="rereplysend()">&nbsp;
							<input type="button" value="취소" onClick="offdisplay(${list.replyidx})">&nbsp;
							
						</form>
						
					</div>
					 -->
				</c:forEach>
				  
			</div>
			<!-- 여백 -->
			<div class="col-3"></div>
		</div>
	</div>
</div>
	
<%@ include file="../include/footer.jsp"%>   