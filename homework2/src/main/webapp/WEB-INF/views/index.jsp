<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="./include/header.jsp"%>   
 
<style>
*{margin:0; padding:0;}
th, td {border: 1px solid #ccc; text-align: center;}
a{text-decoration: none;}
.btn_01{margin-top: 25px;}
.p_01{margin-top: 25px}
.table{margin-top: 10px;}
.search_01{text-align: right;}
</style>

<script>
	function goWrite(){
		location.href="/board/boardwrite.do";
	}
</script>

<!-- sub contents start-->
<div class="container-fluid">
	<div class="cintainer">
		<div class="row">
			<div class="col-2"></div>
			<!-- 게시판 테이블 -->
			<div class="col-8">
				<div class="row">
					<div class="col-10">
						<!-- JSTL c: 테스를 이용하여 로그인한 유저와 비회원에게 나타나는 텍스트를 설정 -->
						<c:if test="${sessionUser.username == null}">
						<p class="p_01">非会員で利用しています。</p>
						</c:if>
						
						<c:if test="${sessionUser.username != null}">
						<p class="p_01">${sessionUser.nicname}様ようこそ!</p>
						</c:if>
					</div>
					<div class="col-2">
						<button type="button" class="btn btn-primary btn_01" onCLick="goWrite()">作成</button>					
					</div>
				</div>

				<table class="table">
				<thead>
					<tr>
						<th scope="col" class="th_01">番号</th>
						<th scope="col" class="th_01">タイトル</th>
						<th scope="col" class="th_01">作成者</th>
						<th scope="col" class="th_01">読んだ回数</th>					
					</tr>
				</thead>
				<tbody>
				<!-- 글번호 셋팅 -->
				<c:set var="cnt"
				value="${page.total - ((page.cri.pageNum-1)*10)}" />
					<!-- 리스트 출력 -->
					<c:forEach var="list" items="${list}">
					<tr>
						<td>${cnt}</td>
						<td><a href="/board/boardview.do?boardidx=${list.boardidx}">${list.title}</a></td>
						<td>${list.nicname}</td>
						<td>${list.readcnt}</td>
					</tr>
					<c:set var="cnt" value="${cnt-1}" />
					</c:forEach>
				</tbody>
				</table>
				<!-- 페이지 처리와 검색 -->
				<div class="row">
					<div class="col-6">
					
						<!-- 페이지 -->
						 <div class="paging">
					         <nav aria-label="Page navigation example">
					            <ul class="pagination justify-content-center">
					               <!-- 이전페이지 처리 -->
					               <c:if test="${page.prev}">
					                  <li class="page-item">
					                     <a class="page-link b_title" href="${page.startPage-1}"
					                        aria-label="Previous"> </a>
					                  </li>
					               </c:if>
					               <!-- 번호 처리 -->
					               <c:forEach var="num" begin="${page.startPage}"
					                  end="${page.endPage}">
					                  <li class="page-item ${page.cri.pageNum == num ? 'active':''}">
					                     <a class="page-link b_title"  href="${num}">${num}</a>
					                  </li>
					               </c:forEach>
					               <!-- 다음페이지 처리 -->
					               <c:if test="${page.next}">
					                  <li class="page-item">
					                     <a class="page-link b_title" href="${page.endPage+1}"
					                        aria-label="Next"> </a>
					                  </li>
					               </c:if>
					            </ul>
					         </nav>
					         </div>
						<!-- 페이지 -->
					
					</div>
					
					<div class="col-6 search_01">
						<form id="searchForm" name="searchForm" method="get" action="/" class="searchForm_box">
							<input type="hidden" name="pageNum" value="${page.cri.pageNum }">
							<input type="hidden" name="amount" value="${page.cri.amount }">
							<select name="type" class="select_Btn">
								<option value="T" <c:if test="${page.cri.type=='T'}"> selected </c:if>>タイトル</option>
								<option value="C" <c:if test="${page.cri.type=='C'}"> selected </c:if>>内容</option>
								<option value="W" <c:if test="${page.cri.type=='W'}"> selected </c:if>>作成者</option>
							</select>
								<input type="text" name="keyword" class="search_word noticeserachbar">
							<button class="btn_search noticeserachBtn" type="submit"><i class="fa fa-search"></i><span class="sr-only">検索</span></button>
						</form>
					</div>
					
				</div>
			</div>
		<div class="col-2"></div>
		</div>
	</div>
</div>


 <!-- 페이지 선택할때 넘겨준다 -->
 <!-- 페이지 및 검색 부분 처리는 주말을 이용해 한번더 복습하도록 한다. -->
 <form id="actionForm" action="/" method="get">
   <input type="hidden" name="pageNum" value="${page.cri.pageNum}">
   <input type="hidden" name="amount" value="${page.cri.amount}">
   <input type="hidden" name="type" value="${page.cri.type}">
   <input type="hidden" name="keyword" value="${page.cri.keyword}">
</form>


<script>
   $(function(){
	   //페이지 이동할때 07/01
      var actionForm = $("#actionForm");
      $(".paging a").on("click",function(e) {
            e.preventDefault();
            console.log('click');
            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
      })
      
      //검색할때 07/01
      var searchForm =$("#searchForm");
      $(".searchbarBTn").on("click",function(e){
         if(!searchForm.find("option:selected").val()){
            alert("検索種類を選択してください。");
            return false;
         }
         if(!searchForm.find("input[name='keyword']").val()){
            alert("キーワードを入力してください。");
            return false;
         }
         searchForm.find("input[name='pageNum']").val("1");
         e.preventDefault();         
         searchForm.submit();
      });
      
   })
</script>
<%@ include file="./include/footer.jsp"%>