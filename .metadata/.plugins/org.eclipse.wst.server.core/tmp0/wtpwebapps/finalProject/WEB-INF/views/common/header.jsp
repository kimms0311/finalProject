<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/page.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>

<div class="headerContainer">
	<header>
		<img alt="logo" src="../resources/image/logoimage.png">
		<h1><a href="/">Avocart</a></h1>
		<input type="text">
		<button id="my"><i class="bi bi-person"></i></button>
		<!-- 로그인 후 오픈되어야 할 메뉴 -->
		<sec:authorize access="isAuthenticated()">
        <sec:authentication property="principal.mvo.memEmail" var="authEmail" />
			<div style="display:none" id="myMenu" class="off">
				<ul>
					<li><a href="/member/detail?memEmail=${authEmail }">마이페이지</a></li>
					<li><a href="#" id="logoutLink">로그아웃</a></li>
					<form action="/member/logout" method="post" id="logoutForm">
		        		<input type="hidden" name="memEmail" value="${authEmail }">
		        	</form>
				</ul>
			</div>
		</sec:authorize>
	</header>
	<nav>
		<ul>
			<li><a href="/joongo/list">중고거래</a></li>
			<li><a href="/community/list">동네소식</a></li>
			<li><a href="/job/list">알바구인</a></li>
			<li><a href="/store/list">동네업체</a></li>
			<li><a href="#">공지사항</a></li>
			<li><a href="#">FAQ</a></li>
			
        	<!-- 로그인 전 오픈되어야 할 메뉴 -->
			<sec:authorize access="isAnonymous()">
				<li><a href="/member/register">회원가입</a></li>
				<li><a href="/member/login">로그인</a></li>
			</sec:authorize>
		</ul>
	</nav>
</div>

<script type="text/javascript" src="/resources/js/header.js"></script>
</body>
</html>