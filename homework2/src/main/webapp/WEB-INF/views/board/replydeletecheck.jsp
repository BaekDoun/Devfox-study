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
	if(del.replypassword.value==""){
		alert("パスワードを入力してください。");
		del.replypassword.focus();
		return;
	}
	
	var replyidx = $("#replyidx").val();
	var replypassword = $("#replypassword").val();
	var sendData = {"replyidx": replyidx, "replypassword": replypassword};
	$.ajax({
		type:'post',
        url:'/board/replypasswordcheck.do',
        data:sendData,
        success:function(result){
        	if(result==0){
        		alert("パスワードが正しくありません。");
        		$("#replypassword").val("");
        		$("#replypassword").focus();
        		return;
        	}else if(result==1){
        		//パスワードが一致すれば、1を返還して修正formをsubmitする。
                del.submit();	        		
        	}
        }
	})
}
</script>

<p class="delete_01">パスワードを入力してください。</p>
<form name="del" method="get" action="/board/replysessiondelete.do">
<div class="delete_01">
<input type="password" name="replypassword" id="replypassword" >
<input type="hidden" name="replyidx" id="replyidx" value="${vo.replyidx}">
<input type="hidden" name="boardidx" id="boardidx" value="${vo.boardidx}">
</div>
<div class="delete_01">
<input type="button" value="削除" onClick="checkpassword()">&nbsp;&nbsp;
<input type="button" value="キャンセル" onCLick="history.back()">
</form>
</div>

<%@ include file="../include/footer.jsp"%> 