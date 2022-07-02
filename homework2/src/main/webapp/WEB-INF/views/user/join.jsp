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
		alert("ID를 입력해주세요");
		user.username.focus();
		return false;
	}
	if (user.password.value=="") {
		alert("패스워드를 입력하세요");
		user.password.focus();
		return false;
	}
	if(user.email.value==""){
		alert("이메일을 입력하세요");
		user.email.focus();
		return false;
	}if(user.tel.value==""){
		alert("전화번호를 입력해주세요")
		user.tel.focus();
		return false;
	}
	if(user.tel.value==""){
		alert("전화번호를 입력하세요");
		user.tel.focus();
		return false;
	}
	if(user.nicname.value==""){
		alert("닉네임을 입력하세요");
		user.nicname.focus();
		return false;
	}
	return true;
}

$(function(){
	$("#username").on("blur",function(){
		var username = $('#username').val();
		//아이디는 4자리 부터 16자리 영어와 숫자 조합으로 생성가능하다.
		//아이디는 정규식으로 유효성 검사를 진행한다.
		var usernameExp = /^[a-z0-9_-]{4,16}$/;
		if(!usernameExp.test(username)){
			$(".id_check").css("color", "red");
			$(".id_check").html("");
			$(".id_check").html("아이디 형식이 맞지 않습니다");
			$('#username').val('');
			$('#username').focus();
			return;
		}
		//유효성 검사 통과시 ajax를 이용한 비동기 전송으로 DB에 접속하여 중복된 아이디가 있는지 확인한다.
		$.ajax({
			type:'get',
			url:'/user/usernamecheckpro.do?username=' + username,
			success:function(result){
				if(result == 0){
					$(".id_check").css("color", "green");
					$(".id_check").html("");
					$(".id_check").html("사용 가능한 아이디 입니다.");
					$('#password').focus();
				}else{
					$(".id_check").css("color", "red");
					$(".id_check").html("");
					$(".id_check").html("이미 사용중인 아이디 입니다.");
					$('#username').val('');
					$('#username').focus();
				}
			}
			
		})
	}); 
	//아이디 유효성 검사 끝
	
	//비밀번호 유효성 검사
	$("#password").on("change", function(){
		var password = $('#password').val();
		var passwordExp = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
		if(!passwordExp.test(password)){
			$(".password_check").css("color", "red");
			$(".password_check").html("");
			$(".password_check").html("비밀번호 형식이 맞지 않습니다");
			$('#password').val('');
			$('#password').focus();
			return;
		}else{
			$(".password_check").css("color", "green");
			$(".password_check").html("");
			$(".password_check").html("사용가능한 비밀번호 입니다.");
			$('#repassword').focus();
		}
	})
	
	// 비밀번호 체크 - "input[name='repassword']" 를 이용하여 name의 value값을 가져오도록 해본다.
	$("input[name='repassword']").on("change", function(){
		var password = $('#password').val();
		var repassword = $('#repassword').val();
		if(password != repassword){
			$(".repassword_check").css("color", "red");
			$(".repassword_check").html("");
			$(".repassword_check").html("비밀번호가 일치하지 않습니다.");
			$('#repassword').val('');
			$('#repassword').focus();
		}else{
			$(".repassword_check").css("color", "green");
			$(".repassword_check").html("");
			$(".repassword_check").html("비밀번호가 일치합니다.");
			$('#email').focus();
		}
	})
	//비밀번호 검사 끝
	
	//이메일 유효성 체크
	$("#email").on("change", function(){
		var email = $("#email").val();
		var emailExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-z]{2,3}$/;
		if(!emailExp.test(email)){
			$(".email_check").css("color", "red");	
			$(".email_check").html("");
			$(".email_check").html("이메일 형식이 맞지 않습니다.");
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
					$(".email_check").html("사용 가능한 이메일 입니다.");
					$("#tel").focus();
				}else{
					$(".email_check").css("color", "red");	
					$(".email_check").html("");
					$(".email_check").html("중복 등록된 이메일 입니다.");
					$('#email').focus();
				}
			}
		})
	})
	//이메일 유효성 중복 체크 끝
	
	 //전화번호 유효성 검사
	$("#tel").on("change",function(){
		 var tel = $('#tel').val();
		 var telExp = tel.split('-').join('');
		 // -를 입력할 경우 ''로 바꾼다.
		 var telEXP = /^(010[0-9]{8})$/;
		 // 정규식은 반드시 010이포함된 전화번호 11자리로 한다.
		 if(!telEXP.test(telExp)){
			 //html로 바꾸지 않고 text를 이용하여 먼저 텍스트를 바꾸고 css변경을 해주도록 해본다.
			 $(".tel_check").text("010을 포함한 8자리 입력");
			 $(".tel_check").css("color","red");
			 $("#tel").val('');			 
			 $("#tel").focus();
		 }else{
			 $(".tel_check").text("올바른 전화번호 입니다.");
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
				<h3 class="jointitle_01">회원가입</h3>
				<!-- form 시작 -->
				<!-- onsubmit의 경우 액션을 취하기 전에 먼저 지정된 스크립트를 실행 후 true값이 만족이 되면 action을 수행한다. -->
				<form name="user" method="post" action="/user/userjoinpro.do" onsubmit="return send()">
				<span><strong>ID</strong></span>
				<input type="text" name="username" class="form-control" id="username" 
				placeholder="아이디 입력해주세요" _mstplaceholder="274417" 
				style="text-align: left;">
				<p class="id_check">아이디를 입력해주세요</p>
				
				<span><strong>PASSWORD</strong></span>
				<input type="password" name="password" class="form-control" id="password" 
				placeholder="8~16자 영문,숫자,특수문자를 포함" _mstplaceholder="274417" 
				style="text-align: left;">
				<p class="password_check">비밀번호를 입력해주세요</p>
				
				<span><strong>PASSWORD CHECK</strong></span>
				<input type="password" name="repassword" class="form-control" id="repassword" 
				placeholder="비밀번호를 확인해주세요" _mstplaceholder="274417" 
				style="text-align: left;">
				<p class="repassword_check">비밀번호를 확인해주세요</p>
				
				<span><strong>EMAIL</strong></span>
				<input type="email" name="email" class="form-control" id="email" 
				placeholder="이메일을 입력해주세요" _mstplaceholder="274417" 
				style="text-align: left;">
				<p class="email_check">이메일을 확인해주세요</p>
				
				<span><strong>TEL</strong></span>
				<input type="tel" name="tel" class="form-control" id="tel" 
				placeholder="휴대폰번호를 입력해주세요" _mstplaceholder="274417" 
				style="text-align: left;">
				<p class="tel_check">휴대폰번호를 확인해주세요</p>
				
				<span><strong>NICNAME</strong></span>
				<input type="text" name="nicname" class="form-control" id="nicname" 
				placeholder="닉네임을 입력해주세요" _mstplaceholder="274417" 
				style="text-align: left;">
				<p>닉네임을 확인해주세요</p>
				
				<div class="btn_01">
				<button type="submit" class="btn btn-primary">회원가입</button>&nbsp;&nbsp;
				<button type="button" class="btn btn-primary" onClick="history.back()">취소</button>
				</div>
				
				</form>
				
			</div>
			<div class="col-4"></div>
		</div>
	</div>
</div>

<%@ include file="../include/footer.jsp"%>