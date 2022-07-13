<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%> 
<style>
.delete_01{
text-align: center;
margin: 5px;
}
</style>
<script>
function checkpassword(){
	if(heartdelete.nicname.value==""){
		alert("nicnameを入力してください。");
		heartdelete.nicname.focus();
		return;
	}
	if(heartdelete.heartpassword.value==""){
		alert("パスワードを入力してください。");
		heartdelete.boardpassword.focus();
		return;
	}
	
	var nicname = $("#nicname").val(); 
	var heartpassword = $("#heartpassword").val(); 
	var heartcookie = $("#heartcookie").val();
	var boardidx = $("#boardidx").val();
	var sendData = {'nicname':nicname, 'heartpassword':heartpassword, 
			'heartcookie':heartcookie, 'boardidx':boardidx};
	
	//security ajax token 
	var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue = "${_csrf.token}";
    
    $(document).ajaxSend(function(e,xhr,options){
    xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
    })
	
	$.ajax({
		type:'post',
		url:'/board/heartpasscheck.do',
		data:sendData,
		success:function(result){
			if(result != 1){
				alert("닉네임과 비밀번호를 확인해주세요");
				return;
			}else{
			heartdelete.submit();
			}
		}
		
	})
	
}
</script>

<p class="delete_01">nicname, passwordを入力してください。</p>
<form name="heartdelete" method="post" action="/board/heartdeletepro.do">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
<div class="delete_01">
nicname<input type="text" name="nicname" id="nicname" >
password<input type="password" name="heartpassword" id="heartpassword" >
<input type="hidden" name="boardidx" id="boardidx" value="${vo.boardidx}">
<input type="hidden" name="heartcookie" id="heartcookie" value="${heartcookie}">
</div>
<div class="delete_01">
<input type="button" value="登録" onClick="checkpassword()">&nbsp;&nbsp;
<input type="button" value="キャンセル" onCLick="history.back()">
</div>
</form>

<%@ include file="../include/footer.jsp"%> 