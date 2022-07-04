<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>   

<style>
.title_01{
margin : 20px;
text-align: center;
}
.contents_01{
height: 400px;
}
.contents_02{
margin-top: 10px;
text-align: center;
}
.input_01{
width: 100px;
}
.title_02{
margin-top: 20px;
}
.btn_01{
text-align: center;
margin-top: 25px;
}
</style>

<script>
var useridx = $("#useridx").val();

function send(){
	if(write.title.value==""){
		alert("タイトルを入力してください。");
		write.title.focus();
		return false;
	}
	if(write.contents.value==""){
		alert("内容を入力してください。");
		write.contents.focus();
		return false;
	}
	if(write.useridx.value=="0"){
		if(write.nicname.value==""){
			alert("ニックネームを入力してください。");
			write.nicname.focus();
			return false;
		}
		if(write.boardpassword.value==""){
			alert("パスワードを入力してください。");
			write.boardpassword.focus();
			return false;
		}
	}
	return true;
}
</script>

<!-- subcontents -->	
	<div class="container-fluid">
		<div class="container">
			<div class="row">
				<div class="col-2"></div>
				<!-- 余白 -->
				<div class="col-8">
				  <!-- h3 Title -->	
	              <h3 class="title_01">Write</h3>
				  <!-- form -->
	              <form name="write" method="post" action="/board/boardwritepro.do" onsubmit="return send()">
				  
				  <!-- ログインしたユーザーであればセッションにある情報をhiddenで送る。 -->
	              <c:if test="${sessionUser.username != null}">
	              <input type="hidden" name="useridx" value="${sessionUser.useridx}" id="useridx">
	              <input type="hidden" name="nicname" value="${sessionUser.nicname}">
	              </c:if>
	              
	              <!-- 非会員の場合 useridxを ""で設定 -->
	              <c:if test="${sessionUser.username == null}">
	              <input type="hidden" name="useridx" value="0" id="useridx">
	              </c:if>
	              
	              <!-- title -->
	              <div class="input-group has-validation title_02">
	                <span class="input-group-text input_01">タイトル</span>
	                <input type="text" class="form-control" id="title" name="title">
	              </div>
	              
	              <!-- contents -->
	              <span class="input-group-text contents_02">内容</span>
	              <div class="input-group has-validation">
	                <textarea rows="15" cols="100" name="contents"></textarea>
	              </div>
	              
	              <!-- 非会員ニックネーム-->
	              <c:if test="${sessionUser.username == null}">
	               <div class="input-group has-validation title_02">
	                <span class="input-group-text input_01">ニックネーム</span>
	                <input type="text" class="form-control" id="nicname" name="nicname">
	              </div>
	              </c:if>
	              
	               <!-- 非会員パスワード -->
	              <c:if test="${sessionUser.username == null}">
	              <div class="input-group has-validation title_02">
	                <span class="input-group-text input_01">パスワード</span>
	                <input type="text" class="form-control" id="boardpassword" name="boardpassword">
	              </div>
	              </c:if>
	              <!-- ボタン -->
	              <div class="btn_01">
				  	<button type="submit" class="btn btn-primary">登録</button>&nbsp;&nbsp;
				  	<button type="button" class="btn btn-primary" onClick="history.back()">キャンセル</button>
				  </div>
           
	              </form>
				</div>
				<!-- 余白 -->				
				<div class="col-2"></div>
			</div>
		</div>
	</div>
	
<%@ include file="../include/footer.jsp"%>   