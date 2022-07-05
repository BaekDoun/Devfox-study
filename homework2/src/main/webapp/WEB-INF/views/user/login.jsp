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
	
</script>
<!-- sub contents start-->
<div class="container-fluid">
	<div class="container">
		<div class="row">
			<div class="col-4"></div>
			<div class="col-4">
				<h3 class="logo_01">DC Outside</h3>
				<!-- login　form -->
				<form name="login" method="post" action="/user/loginpro.do">
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
   				<button class="w-100 btn btn-lg btn-primary btn_01" type="button" onClick="logincheck()">Login</button>
				</form>
			</div>
			<div class="col-4"></div>
		</div>
	</div>
</div>

<%@ include file="../include/footer.jsp"%>