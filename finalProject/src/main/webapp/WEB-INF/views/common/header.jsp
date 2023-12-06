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
      <div class="logoSec">
         <img alt="logo" src="../resources/image/avocartLogo.png">
         <h1><a href="/">Avocart</a></h1>      
      </div>
      <div class="searchSec">
         <form action="/common/search" method="post">
            <input type="search" placeholder="검색어를 입력해 주세요.">
            <button type="button" class="openMenu">
               <i class="bi bi-search"></i>         
            </button>
            <div class="searchMenu off">
               <h2>상품검색</h2>
               <input type="search" id="keyword" name="keyword" placeholder="검색어를 입력해 주세요.">
               <button type="submit">
                  <i class="bi bi-search"></i>         
               </button>
               <h3>검색 기준</h3>
               <ul>
                  <li><input type="checkbox" name="srcCondit" id="ck_title" value="title"><label for="title">제목</label></li>
                  <li><input type="checkbox" name="srcCondit" id="ck_nickname" value="nickname"><label for="nickname">닉네임</label></li>
                  <li><input type="checkbox" name="srcCondit" id="ck_email" value="email"><label for="email">이메일</label></li>
                  <li><input type="checkbox" name="srcCondit" id="ck_content" value="content"><label for="content">내용</label></li>
               </ul>
               <!-- <h3>게시판 선택</h3>
               <ul>
                  <li><input type="checkbox" name="srcCondit" id="title" value="title"><label for="title">제목</label></li>
                  <li><input type="checkbox" name="srcCondit" id="nickname" value="nickname"><label for="nickname">닉네임</label></li>
                  <li><input type="checkbox" name="srcCondit" id="email" value="email"><label for="email">이메일</label></li>
                  <li><input type="checkbox" name="srcCondit" id="content" value="content"><label for="content">내용</label></li>
               </ul> -->
               <!-- <button type="button" id="checkCondit">확인</button> -->
            </div>
         </form>
         <i id="my" class="bi bi-person"></i>
         <!-- 로그인 후 오픈되어야 할 메뉴 -->
         <sec:authorize access="isAuthenticated()">
           <sec:authentication property="principal.mvo.memEmail" var="authEmail" />
            <div id="myMenu" class="off">
               <ul>
                  <li><a href="/hmember/detail?memEmail=${authEmail }">마이페이지</a></li>
                  <li><a href="#" id="logoutLink">로그아웃</a></li>
                  <form action="/member/logout" method="post" id="logoutForm">
                       <input type="hidden" name="memEmail" value="${authEmail }">
                    </form>
               </ul>
            </div>
         </sec:authorize>
      </div>
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