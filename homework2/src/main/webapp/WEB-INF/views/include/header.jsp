<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 헤더에  각종 기능 추가 인클루드로 인해 모든 JSP에서 기능 사용 가능하게 함 06.28 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<!DOCTYPE html>

<html lang="UTF-8">
<head>

<style>

</style>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->

<!-- Required meta tags -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<!-- 유효성 검사 및 비동기 데이터 처리를 위한 Jquery ajax script 추가 -->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" ></script> 
<title>DC OUTSIDE</title>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid" style="text-align: center;">
    <a class="navbar-brand" href="#">DC Outside</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/">Home</a>
        </li>
		
		<!--비회원에게만 회원가입 이동 칼럼이 보이게 한다. 로그인을 하면 비활성화 06/30-->
		<!--  
		<c:if test="${sessionUser.username == null}">
     	<li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/user/join.do">Join</a>
        </li>
		</c:if>
		-->
		
		<!--시큐리티로 로그인한 유저와 비회원유저 판단 메뉴 활성화 07/13-->
		<sec:authorize access="isAnonymous()">
		<c:if test="${kakaoVO.nicname ==null}">
     	<li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/user/join.do">Join</a>
        </li>
		</c:if>
		</sec:authorize>
		
        <li class="nav-item">
        
          <!--비회원에게만 로그인  칼럼이 보이게 한다. 로그인을 하면 비활성화  06/30-->
      	  <!--  
          <c:if test="${sessionUser.username == null}">
          <a class="nav-link active" aria-current="page" href="/user/login.do">Login</a>
          </c:if>
          -->
      
          <!--시큐리티로 로그인한 유저와 비회원유저 판단 메뉴 활성화 07/13-->
          <sec:authorize access="isAnonymous()">
          <c:if test="${kakaoVO.nicname ==null}">
          <a class="nav-link active" aria-current="page" href="/user/login.do">Login</a>
          </c:if>
          </sec:authorize>
         
          <!-- 로그인을 하면 로그아웃 칼럼이 활성화 된다. 06/30 -->
          <!--  
          <c:if test="${sessionUser.username != null}">
          <a class="nav-link active" aria-current="page" href="/user/logout.do">Logout</a>
          </c:if>
          -->
          
          <!--시큐리티로 로그인한 유저와 비회원유저 판단 메뉴 활성화 07/13-->
          <sec:authorize access="isAuthenticated()">
          <form name="logout" action="/user/logout.do" method="post">
          	<!-- 시큐리티로 인해 토큰을 항상 보내주어야한다. 07/13 -->
          	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
          	<a class="nav-link active" aria-current="page" href="javascript:logout_01();">Logout</a>
          </form>
          </sec:authorize>
          <c:if test="${kakaoVO.nicname != null}">
          	<a class="nav-link active" aria-current="page" href="javascript:logout_02();">kakaoLogout</a>	
          </c:if>
          <script>
          	function logout_01(){
          		logout.submit();
          	}
        	function logout_02(){
          		location.href="/user/kakaoLogout.do";
          	}
          </script>
        </li>
      </ul>
    </div>
  </div>
</nav>