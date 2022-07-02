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
var useridx = $("#useridx").val();

function send(){
	if(write.title.value==""){
		alert("제목을 입력해주세요");
		write.title.focus();
		return false;
	}
	if(write.contents.value==""){
		alert("내용을 입력해주세요");
		write.contents.focus();
		return false;
	}
	if(write.useridx.value=="0"){
		if(write.nicname.value==""){
			alert("닉네임을 입력해주세요");
			write.nicname.focus();
			return false;
		}
		if(write.boardpassword.value==""){
			alert("비밀번호을 입력해주세요");
			write.boardpassword.focus();
			return false;
		}
	}
	return true;
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
	              <h3 class="title_01">Write</h3>
				  <!-- form 시작 -->
	              <form name="write" method="post" action="/board/boardwritepro.do" onsubmit="return send()">
				  
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
	                <input type="text" class="form-control" id="title" name="title">
	              </div>
	              
	              <!-- contents -->
	              <span class="input-group-text contents_02">Contents</span>
	              <div class="input-group has-validation">
	                <textarea rows="15" cols="100" name="contents"></textarea>
	              </div>
	              
	              <!-- 비회원일시 닉네임 입력 -->
	              <c:if test="${sessionUser.username == null}">
	               <div class="input-group has-validation title_02">
	                <span class="input-group-text input_01">Nicname</span>
	                <input type="text" class="form-control" id="nicname" name="nicname">
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
				  	<button type="submit" class="btn btn-primary">등록</button>&nbsp;&nbsp;
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