<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/header.jsp"%>    
<style>
.logo_01{
 	padding:30px;
 	text-align: center;
}
.btn_01{
	margin-top: 30px;
}
</style>

<script>
	function logincheck(){
		//만약 form태그 안에있는 username(ID)이 입력이 안되었으면 06/30
		if(login.username.value==""){
			//alert 를 이용하여 브라우저에 경고 메세지 출력
			alert("아이디를 입력해주세요.");
			//포커스를 ID로 이동시킴
			login.username.focus();
			//return false를이용하여 스크립트 실행을 멈춘다.
			return;
		}
		if(login.password.value==""){
			alert("비밀번호를 입력해주세요");
			login.password.focus();
			return;
		}
		
		//입력한 아이디
		var username = $('#username').val();
		//입력한 비밀번호
		var password = $('#password').val();
		//JSON 전송을 위한 data
		var sendData = {"username": username, "password": password};
		
		//ajax 비동기 데이터 전송 06/30
		$.ajax({
			type: 'post',
			url: '/user/PasswordCheck.do',
			data: sendData,
			success:function(result){
				if(result==0){
					alert("존재하지않는 아이디입니다.");
					$("#username").val("");
					$("#password").val("");
					$("#username").focus();
					return;
				}else if(result==1){
					alert("비밀번호가 올바르지 않습니다.")
					$("#password").val("");
					$("#password").focus();
					return;
				}else{
					//아이디와 비밀번호가 DB에 등록된 데이터와 모두 일치 할 시 전송하여 세션을 만들어 로그인한다.
					login.submit();
				}
			}		
		})
		
	}
	
</script>
<!-- sub contents start-->
<div class="container-fluid">
	<div class="container">
		<div class="row">
			<div class="col-4"></div>
			<div class="col-4">
				<h3 class="logo_01">DC Outside</h3>
				<!-- 로그인 폼 -->
				<form name="login" method="post" action="/user/loginpro.do">
				<!-- 아이디입력창 -->
				<div class="form-floating">
     				<input type="text" class="form-control" id="username" name="username">
      				<label for="floatingInput">ID</label>
   				</div>
   				<!-- 비밀번호 입력창 -->
   				<div class="form-floating">
     				<input type="password" class="form-control" id="password" name="password">
      				<label for="floatingInput">Password</label>
   				</div>
   				<!-- 로그인버튼 -->
   				<button class="w-100 btn btn-lg btn-primary btn_01" type="button" onClick="logincheck()">Login</button>
				</form>
			</div>
			<div class="col-4"></div>
		</div>
	</div>
</div>

<%@ include file="../include/footer.jsp"%>