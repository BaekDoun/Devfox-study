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
	if(heart.nicname.value==""){
		alert("nicnameを入力してください。");
		heart.nicname.focus();
		return;
	}
	if(heart.heartpassword.value==""){
		alert("パスワードを入力してください。");
		heart.boardpassword.focus();
		return;
	}
	heart.submit();
}
</script>

<p class="delete_01">nicname, passwordを入力してください。</p>
<form name="heart" method="post" action="/board/heartinsert.do">
<div class="delete_01">
<span>nicname</span>
<input type="text" name="nicname" id="nicname" >
<span>password</span>
<input type="password" name="heartpassword" id="heartpassword" >
<input type="hidden" name="boardidx" id="boardidx" value="${vo.boardidx}">
</div>
<div class="delete_01">
<input type="button" value="登録" onClick="checkpassword()">&nbsp;&nbsp;
<input type="button" value="キャンセル" onCLick="history.back()">
</form>
</div>

<%@ include file="../include/footer.jsp"%> 