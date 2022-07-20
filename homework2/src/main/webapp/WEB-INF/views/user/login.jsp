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
.kakaoimg_box{
height: 40px;
margin: 10px;
}
</style>

<script>
	function logincheck(){
		//もし、 formタグの中にある username(ID)が入力できなかったら 06/30
		if(login.username.value==""){
			//alert を使って ブラウザに警告メッセージを出力
			alert("IDを入力してください。");
			//フォーカスをIDに移動させる
			login.username.focus();
			//return falseを使ってscriptを終える。
			return;
		}
		if(login.password.value==""){
			alert("パスワードを入力してください。");
			login.password.focus();
			return;
		}
		
		//ID
		var username = $('#username').val();
		//PASSWORD
		var password = $('#password').val();
		//JSON 伝送のための data
		var sendData = {"username": username, "password": password};
		
		//ajax 非同期データ伝送 06/30
		$.ajax({
			type: 'post',
			url: '/user/PasswordCheck.do',
			data: sendData,
			success:function(result){
				if(result==0){
					alert("存在しないIDです。");
					$("#username").val("");
					$("#password").val("");
					$("#username").focus();
					return;
				}else if(result==1){
					alert("パスワードが正しくありません。")
					$("#password").val("");
					$("#password").focus();
					return;
				}else{
					//IDとパスワードがDBに登録されたデータとすべて一致した場合に送信してセッションを作ってログインする。
					login.submit();
				}
			}		
		})
		
	}
	
	//script에서 form태그 속성을 지정하고 서브밋한다.
	$(function() {
		$(".btn_01").on("click", function(){
			$("#frmLogin").attr("action","/login");
			$("#frmLogin").attr("method","post");
			$("#frmLogin").submit();
		});
	});	
	
</script>
<!-- sub contents start-->
<div class="container-fluid">
	<div class="container">
		<div class="row">
			<div class="col-4"></div>
			<div class="col-4">
				<h3 class="logo_01">DC Outside</h3>
				<!-- login　form -->
				
				<!--  
				<form name="login" method="post" action="/user/loginpro.do">
				-->
				
				<!-- 스프링에서 지원하는 로그인창으로 username과 패스워드를 보낸다. -->
				<form id="frmLogin" name="login">
				
				<!-- 스프링 시큐리티를 이용하여 로그인을 하면 토큰읇 보내줘야 한다. 07/13 -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				
				<!-- ID -->
				<div class="form-floating">
     				<input type="text" class="form-control" id="username" name="username">
      				<label for="floatingInput">ID</label>
   				</div>
   				<!-- PASSWORD -->
   				<div class="form-floating">
     				<input type="password" class="form-control" id="password" name="password">
      				<label for="floatingInput">Password</label>
   				</div>
   				<!-- BOTTON -->
   				<!--  
   				<button class="w-100 btn btn-lg btn-primary btn_01" type="button" onClick="logincheck()">Login</button>
   				-->
   				<button class="w-100 btn btn-lg btn-primary btn_01" type="button" >Login</button>
				</form>
				
				<!-- 카카오로그인 아이콘 시작 -->
				<div class="kakaoimg_box">
					<a href="https://kauth.kakao.com/oauth/authorize?client_id=f7fe3cda212af37bd8432f5d4b3e64f3&redirect_uri=http://localhost:8090/kakaoLogin&response_type=code">
						<img class="img-fluid kakaoLogin_img" src="/resources/image/kakaoicon.png">
					</a>
				</div>
				<!-- 카카오로그인 아이콘 끝 -->
			</div>
			
			<div class="col-4"></div>
		</div>
	</div>
</div>

<%@ include file="../include/footer.jsp"%>