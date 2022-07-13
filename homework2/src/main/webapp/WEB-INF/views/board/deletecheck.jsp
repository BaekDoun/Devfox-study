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
	if(del.boardpassword.value==""){
		alert("パスワードを入力してください。");
		del.boardpassword.focus();
		return;
	}
	
	var boardidx = $("#boardidx").val();
	var boardpassword = $("#boardpassword").val();
	var sendData = {"boardidx": boardidx, "boardpassword": boardpassword};
	
	//security ajax token 
	var csrfHeaderName = "${_csrf.headerName}";
    var csrfTokenValue = "${_csrf.token}";
    
    $(document).ajaxSend(function(e,xhr,options){
    xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
    })
	
	$.ajax({
		type:'post',
        url:'/board/boardpasswordcheck.do',
        data:sendData,
        success:function(result){
        	if(result==0){
        		alert("パスワードが正しくありません。");
        		$("#boardpassword").val("");
        		$("#boardpassword").focus();
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
<form name="del" method="post" action="/board/boarddelete.do">
 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
<div class="delete_01">
<input type="password" name="boardpassword" id="boardpassword" >
<input type="hidden" name="boardidx" id="boardidx" value="${vo.boardidx}">
</div>
<div class="delete_01">
<input type="button" value="削除" onClick="checkpassword()">&nbsp;&nbsp;
<input type="button" value="キャンセル" onCLick="history.back()">
</form>
</div>

<%@ include file="../include/footer.jsp"%> 