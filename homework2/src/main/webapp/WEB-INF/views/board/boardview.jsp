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
.view_contents_01{
margin-top: 30px;
text-align: left;
}
.view_btn_01{
text-align: center;
margin-top: 50px;
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
					<p class="view_p_01">작성자 : ${vo.nicname} &nbsp;/&nbsp; 조회수 : ${vo.readcnt} &nbsp;/&nbsp; 
					작성일 : ${vo.boardregdate}</p>
				</div>
				<!-- 내용 -->
				<div class="view_contents_01">
					<!-- pre태그를 이용하면 textarea에 여러번 띄워쓰기와<br>태그까지 모두 적용시켜 준다. 07/01 -->
					<pre>${vo.contents}</pre>
				</div>
				
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
				  
			</div>
			<!-- 여백 -->
			<div class="col-3"></div>
		</div>
	</div>
</div>
	
<%@ include file="../include/footer.jsp"%>   