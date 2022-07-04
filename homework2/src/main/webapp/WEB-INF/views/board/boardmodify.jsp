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

function send(){
	if(modi.title.value==""){
		alert("タイトルを入力してください。");
		modi.title.focus();
		return;
	}
	if(modi.contents.value==""){
		alert("内容を入力してください。");
		modi.contents.focus();
		return;
	}
	if(modi.useridx.value=="0"){
		if(modi.nicname.value==""){
			alert("ニックネームを入力してください。");
			modi.nicname.focus();
			return;
		}
		if(modi.boardpassword.value==""){
			alert("登録した時入力したパスワードを入力してください。");
			modi.boardpassword.focus();
			return;
		}
	}
	//パスワードを入力すると、以前登録する際に入力したパスワードと現在入力したパスワードが一致するか確認するため、
	//非同期転送で検査をする。 07/01
	
	var useridx = $("#useridx").val();
	//var 関数は同じ function{} 中でのみ適用可能地域変数概念 07/03
	alert(useridx);
	if(useridx == 0){
		var boardidx = $("#boardidx").val();
		var boardpassword = $("#boardpassword").val();
		var sendData = {"boardidx": boardidx, "boardpassword": boardpassword};
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
	                modi.submit();	        		
	        	}
	        }
		})
		
	}else{
		//非会員が登録した文でない場合、作成者とログインしたユーザーが同じ場合、すぐに修正するようにする。
		modi.submit()
	}
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
	              <h3 class="title_01">修正</h3>
				  <!-- form -->
	              <form name="modi" method="post" action="/board/boardmodifypro.do">
				  <input type="hidden" name="boardidx" id="boardidx" value="${vo.boardidx}">
				  <!-- 会員の場合　session情報を　	hiddenで 送る -->
	              <c:if test="${sessionUser.username != null}">
	              <input type="hidden" name="useridx" value="${sessionUser.useridx}" id="useridx">
	              <input type="hidden" name="nicname" value="${sessionUser.nicname}">
	              </c:if>
	              
	              <!-- 非会員の場合 hiddenで useridxを ""で 設定 -->
	              <c:if test="${sessionUser.username == null}">
	              <input type="hidden" name="useridx" value="0" id="useridx">
	              </c:if>
	              
	              <!-- title -->
	              <div class="input-group has-validation title_02">
	                <span class="input-group-text input_01">タイトル</span>
	                <input type="text" class="form-control" id="title" name="title" value="${vo.title}">
	              </div>
	              
	              <!-- contents -->
	              <span class="input-group-text contents_02">内容</span>
	              <div class="input-group has-validation">
	                <textarea rows="15" cols="100" name="contents">${vo.contents}</textarea>
	              </div>
	              
	              <!-- ログインしてない場合ニックネームを入力　 -->
	              <c:if test="${sessionUser.username == null}">
	               <div class="input-group has-validation title_02">
	                <span class="input-group-text input_01">ニックネーム</span>
	                <input type="text" class="form-control" id="nicname" name="nicname" value="${vo.nicname }">
	              </div>
	              </c:if>
	              
	               <!-- 非会員の場合パスワード入力 -->
	              <c:if test="${sessionUser.username == null}">
	              <div class="input-group has-validation title_02">
	                <span class="input-group-text input_01">パスワード</span>
	                <input type="text" class="form-control" id="boardpassword" name="boardpassword">
	              </div>
	              </c:if>
	              <!-- ボタン -->
	              <div class="btn_01">
				  	<button type="button" class="btn btn-primary" onClick="send()">修正</button>&nbsp;&nbsp;
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