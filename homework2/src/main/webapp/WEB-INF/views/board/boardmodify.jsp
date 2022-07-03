<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>   

<style>
.title_01{
margin : 20px;
text-align: center;
}
.contents_01{
height: 400px;
}
.contents_02{
margin-top: 10px;
text-align: center;
}
.input_01{
width: 100px;
}
.title_02{
margin-top: 20px;
}
.btn_01{
text-align: center;
margin-top: 25px;
}
</style>

<script>

function send(){
	if(modi.title.value==""){
		alert("제목을 입력해주세요");
		modi.title.focus();
		return;
	}
	if(modi.contents.value==""){
		alert("내용을 입력해주세요");
		modi.contents.focus();
		return;
	}
	if(modi.useridx.value=="0"){
		if(modi.nicname.value==""){
			alert("닉네임을 입력해주세요");
			modi.nicname.focus();
			return;
		}
		if(modi.boardpassword.value==""){
			alert("등록할때 입력한 비밀번호을 입력해주세요");
			modi.boardpassword.focus();
			return;
		}
	}
	//비밀번호를 입력하면 이전에 등록할때 입력한 비밀번호와 현재 입력한 비밀번호가 일치하는지 확인하기 위해
	//비동기 전송으로 검사산다. 07/01
	
	var useridx = $("#useridx").val();
	//var 함수는 같은 function{} 안에서만 적용가능 지역변수 개념 07/03
	alert(useridx);
	if(useridx == 0){
		var boardidx = $("#boardidx").val();
		var boardpassword = $("#boardpassword").val();
		var sendData = {"boardidx": boardidx, "boardpassword": boardpassword};
		$.ajax({
			type:'post',
	        url:'/board/boardpasswordcheck.do',
	        data:sendData,
	        success:function(result){
	        	if(result==0){
	        		alert("비밀번호가 올바르지 않습니다.");
	        		$("#boardpassword").val("");
	        		$("#boardpassword").focus();
	        		return;
	        	}else if(result==1){
	        		//비밀번호가 일치하면 1을 반환하여 수정 form을 submit 한다.
	                modi.submit();	        		
	        	}
	        }
		})
		
	}else{
		//비회원이 등록한글이 아닐경우 작성자와 로그인한 유저가 동일할 경우 바로 수정하도록 한다.
		modi.submit()
	}
}
</script>

<!-- subcontents -->	
	<div class="container-fluid">
		<div class="container">
			<div class="row">
				<div class="col-2"></div>
				<!-- 양옆 여백 -->
				<div class="col-8">
				  <!-- h3 Title -->	
	              <h3 class="title_01">Modify</h3>
				  <!-- form 시작 -->
	              <form name="modi" method="post" action="/board/boardmodifypro.do">
				  <input type="hidden" name="boardidx" id="boardidx" value="${vo.boardidx}">
				  <!-- 로그인한 유저이면 세션에 있는 정보를 히든으로 보낸다. -->
	              <c:if test="${sessionUser.username != null}">
	              <input type="hidden" name="useridx" value="${sessionUser.useridx}" id="useridx">
	              <input type="hidden" name="nicname" value="${sessionUser.nicname}">
	              </c:if>
	              
	              <!-- 비회원일 경우 판단을 위해 히든으로 useridx를 ""로 설정 -->
	              <c:if test="${sessionUser.username == null}">
	              <input type="hidden" name="useridx" value="0" id="useridx">
	              </c:if>
	              
	              <!-- title -->
	              <div class="input-group has-validation title_02">
	                <span class="input-group-text input_01">Title</span>
	                <input type="text" class="form-control" id="title" name="title" value="${vo.title}">
	              </div>
	              
	              <!-- contents -->
	              <span class="input-group-text contents_02">Contents</span>
	              <div class="input-group has-validation">
	                <textarea rows="15" cols="100" name="contents">${vo.contents}</textarea>
	              </div>
	              
	              <!-- 비회원일시 닉네임 입력 -->
	              <c:if test="${sessionUser.username == null}">
	               <div class="input-group has-validation title_02">
	                <span class="input-group-text input_01">Nicname</span>
	                <input type="text" class="form-control" id="nicname" name="nicname" value="${vo.nicname }">
	              </div>
	              </c:if>
	              
	               <!-- 비회원일시 비밀번호 입력 -->
	              <c:if test="${sessionUser.username == null}">
	              <div class="input-group has-validation title_02">
	                <span class="input-group-text input_01">PW</span>
	                <input type="text" class="form-control" id="boardpassword" name="boardpassword">
	              </div>
	              </c:if>
	              <!-- 버튼 -->
	              <div class="btn_01">
				  	<button type="button" class="btn btn-primary" onClick="send()">수정</button>&nbsp;&nbsp;
				  	<button type="button" class="btn btn-primary" onClick="history.back()">취소</button>
				  </div>
           
	              </form>
				</div>
				<!-- 양옆 여백 -->				
				<div class="col-2"></div>
			</div>
		</div>
	</div>
	
<%@ include file="../include/footer.jsp"%>   