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
		alert("비밀번호를 입력해주세요.");
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
        		alert("비밀번호가 올바르지 않습니다.");
        		$("#replypassword").val("");
        		$("#replypassword").focus();
        		return;
        	}else if(result==1){
        		//비밀번호가 일치하면 1을 반환하여 수정 form을 submit 한다.
                del.submit();	        		
        	}
        }
	})
}
</script>

<p class="delete_01">비밀번호를 입력해주세요.</p>
<form name="del" method="get" action="/board/replysessiondelete.do">
<div class="delete_01">
<input type="password" name="replypassword" id="replypassword" >
<input type="hidden" name="replyidx" id="replyidx" value="${vo.replyidx}">
<input type="hidden" name="boardidx" id="boardidx" value="${vo.boardidx}">
</div>
<div class="delete_01">
<input type="button" value="삭제하기" onClick="checkpassword()">&nbsp;&nbsp;
<input type="button" value="취소" onCLick="history.back()">
</form>
</div>

<%@ include file="../include/footer.jsp"%> 