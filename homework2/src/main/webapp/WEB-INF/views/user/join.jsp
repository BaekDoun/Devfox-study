<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/header.jsp"%>    
<style>
.jointitle_01{
	text-align: center;
	margin: 20px;
}
.btn_01{
	text-align: center;
}
</style>

<script>
//미입력 확인용 스크립트 함수 send()
function send() {
	if(user.username.value==""){
		alert("IDを入力してください。");
		user.username.focus();
		return false;
	}
	if (user.password.value=="") {
		alert("パスワードを入力してください。");
		user.password.focus();
		return false;
	}
	if(user.email.value==""){
		alert("メールを入力してください。");
		user.email.focus();
		return false;
	}if(user.tel.value==""){
		alert("電話番号を入力してください。")
		user.tel.focus();
		return false;
	}
	if(user.nicname.value==""){
		alert("ニックネームを入力してください。");
		user.nicname.focus();
		return false;
	}
	return true;
}

$(function(){
	$("#username").on("blur",function(){
		var username = $('#username').val();
		//IDは4から16の英語と数字の組み合わせで生成できる。
		//IDは正規式で有効性検査を行う。
		var usernameExp = /^[a-z0-9_-]{4,16}$/;
		if(!usernameExp.test(username)){
			$(".id_check").css("color", "red");
			$(".id_check").html("");
			$(".id_check").html("ID形式が正しくありません。");
			$('#username').val('');
			$('#username').focus();
			return;
		}
		//有効性検査を通過すれば、ajaxを利用した非同期転送でDBに接続して重複したIDがあるかを確認する。
		$.ajax({
			type:'get',
			url:'/user/usernamecheckpro.do?username=' + username,
			success:function(result){
				if(result == 0){
					$(".id_check").css("color", "green");
					$(".id_check").html("");
					$(".id_check").html("利用可能なIDです。");
					$('#password').focus();
				}else{
					$(".id_check").css("color", "red");
					$(".id_check").html("");
					$(".id_check").html("既に利用中のIDです。");
					$('#username').val('');
					$('#username').focus();
				}
			}
			
		})
	}); 
	//ID有効性検査終了
	
	//パスワード有効性検査
	$("#password").on("change", function(){
		var password = $('#password').val();
		var passwordExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
		if(!passwordExp.test(password)){
			$(".password_check").css("color", "red");
			$(".password_check").html("");
			$(".password_check").html("パスワード形式が正しくありません。");
			$('#password').val('');
			$('#password').focus();
			return;
		}else{
			$(".password_check").css("color", "green");
			$(".password_check").html("");
			$(".password_check").html("使用可能なパスワードです。");
			$('#repassword').focus();
		}
	})
	
	// パスワードチェック - "input[name='repassword']" を使って nameの valueを 持ってくる。.
	$("input[name='repassword']").on("change", function(){
		var password = $('#password').val();
		var repassword = $('#repassword').val();
		if(password != repassword){
			$(".repassword_check").css("color", "red");
			$(".repassword_check").html("");
			$(".repassword_check").html("パスワードが正しくありません。");
			$('#repassword').val('');
			$('#repassword').focus();
		}else{
			$(".repassword_check").css("color", "green");
			$(".repassword_check").html("");
			$(".repassword_check").html("パスワードが正しいです。");
			$('#email').focus();
		}
	})
	//パスワード検査終了
	
	//メール有効性チェック
	$("#email").on("change", function(){
		var email = $("#email").val();
		var emailExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-z]{2,3}$/;
		if(!emailExp.test(email)){
			$(".email_check").css("color", "red");	
			$(".email_check").html("");
			$(".email_check").html("メール形式が正しくありません。");
			$('#email').val('');
			$('#email').focus();
			return;
		}
		
		$.ajax({
			type:'get',
			url:'/user/emailcheckpro.do?email='+email,
			success:function(result){
				if(result == 0){
					$(".email_check").css("color", "green");	
					$(".email_check").html("");
					$(".email_check").html("利用できるメールです。");
					$("#tel").focus();
				}else{
					$(".email_check").css("color", "red");	
					$(".email_check").html("");
					$(".email_check").html("重複登録されたメールです。");
					$('#email').focus();
				}
			}
		})
	})
	//メール有効性重複チェック終了
	
	 //電話番号有効性検査
	$("#tel").on("change",function(){
		 var tel = $('#tel').val();
		 var telExp = tel.split('-').join('');
		 // -を入力すると '　'に変える。.
		 var telEXP = /^(010[0-9]{8})$/;
		 // 正規式は必ず010が含まれた電話番号11桁とする。
		 if(!telEXP.test(telExp)){
			 //htmlに変えなくて textを利用して 先に textを 変えて cssを変える。.
			 $(".tel_check").text("010を含む8桁入力");
			 $(".tel_check").css("color","red");
			 $("#tel").val('');			 
			 $("#tel").focus();
		 }else{
			 $(".tel_check").text("正しい電話番号です。");
			 $(".tel_check").css("color","green"); 
		 }
	 });
	
	
})
</script>
<!-- sub contents start-->
<div class="container-fluid">
	<div class="container">
		<div class="row">
			<div class="col-4"></div>
			<div class="col-4">
				<h3 class="jointitle_01">会員登録</h3>
				<!-- form 시작 -->
				<!-- onsubmit의 경우 액션을 취하기 전에 먼저 지정된 스크립트를 실행 후 true값이 만족이 되면 action을 수행한다. -->
				<form name="user" method="post" action="/user/userjoinpro.do" onsubmit="return send()">
				
				<!-- 시큐리티로 인해 토큰을 보내주지 않으면 에러가 뜬다. 07/13 -->
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				
				<span><strong>ID</strong></span>
				<input type="text" name="username" class="form-control" id="username" 
				placeholder="ID" _mstplaceholder="274417" 
				style="text-align: left;">
				<p class="id_check"></p>
				
				<span><strong>PASSWORD</strong></span>
				<input type="password" name="password" class="form-control" id="password" 
				placeholder="8~16文字、英語、数字、特殊文字" _mstplaceholder="274417" 
				style="text-align: left;">
				<p class="password_check"></p>
				
				<span><strong>PASSWORD CHECK</strong></span>
				<input type="password" name="repassword" class="form-control" id="repassword" 
				placeholder="パスワード確認" _mstplaceholder="274417" 
				style="text-align: left;">
				<p class="repassword_check"></p>
				
				<span><strong>EMAIL</strong></span>
				<input type="email" name="email" class="form-control" id="email" 
				placeholder="メール" _mstplaceholder="274417" 
				style="text-align: left;">
				<p class="email_check"></p>
				
				<span><strong>TEL</strong></span>
				<input type="tel" name="tel" class="form-control" id="tel" 
				placeholder="携帯番号" _mstplaceholder="274417" 
				style="text-align: left;">
				<p class="tel_check"></p>
				
				<span><strong>NICNAME</strong></span>
				<input type="text" name="nicname" class="form-control" id="nicname" 
				placeholder="ニックネーム" _mstplaceholder="274417" 
				style="text-align: left;">
				<p></p>
				
				<div class="btn_01">
				<button type="submit" class="btn btn-primary">会員登録</button>&nbsp;&nbsp;
				<button type="button" class="btn btn-primary" onClick="history.back()">キャンセル</button>
				</div>
				
				</form>
				
			</div>
			<div class="col-4"></div>
		</div>
	</div>
</div>

<%@ include file="../include/footer.jsp"%>