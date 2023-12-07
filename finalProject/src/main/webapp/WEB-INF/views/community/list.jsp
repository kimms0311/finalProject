<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community List</title>
<link rel="stylesheet" href="../resources/css/communityBoardList.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">

<!-- <div class="userLocation">
	<p><i class="bi bi-geo-alt"></i>OO동 동네소식</p>
</div> -->

<div class="CommunityCategory">
	<a href="/community/list?cmMenu=전체" class="menu active">전체</a>
	<a href="/community/list?cmMenu=일상" class="menu">일상</a>
	<a href="/community/list?cmMenu=모임" class="menu">모임</a>
	<a href="/community/list?cmMenu=질문" class="menu">질문</a>
	<a href="/community/list?cmMenu=동네생활정보" class="menu">동네생활정보</a>
	<a href="/community/list?cmMenu=찾습니다" class="menu">찾습니다</a>
	<a href="/community/list?cmMenu=해주세요" class="menu">해주세요</a>
	<a href="/community/list?cmMenu=동네사진전" class="menu">동네사진전</a>
</div>

<!-- 로딩페이지 -->
<div id="loading"></div>

<!-- 작성된 글 출력 공간 -->
<div class="cmBoard" id="cmBoard">
	<div class="oneBoard">
		<p class="boardMenuName">${bvo.cmMenu }</p>
		
		<div class="user_profile">
			<i class="bi bi-person-circle"></i>
			<b>${bvo.cmNickName}</b>
			<p>${bvo.cmRegAt }</p>
			<p><i class="bi bi-geo-alt-fill"></i>${bvo.cmEmd }</p>
		</div>
		
		<a class="communityContentLine" href="/community/detail?cmBno=${bvo.cmBno }">
			<p>${bvo.cmTitle }</p>
			<!-- 썸네일 -->
			<img class="thumbImg" alt="그림없음" src="/upload/community/${fn:replace(fvo.saveDir,'\\','/')}/${fvo.uuid}_th_${fvo.fileName}">
		</a>
		
		<div class="item-info">
			<div class="left-item">
				<i class="bi bi-eye"></i>
				<span>${bvo.cmReadCnt }</span>
				<i class="bi bi-heart"></i>
				<span>${bvo.cmLikeCnt } </span>
			</div>
			<div class="right-item">
				<i class="bi bi-chat-right-dots"></i>
				<span class="readCount">${bvo.cmCmtCnt }</span>
			</div>
		</div>
	</div>
</div>
<div class="">
	<button class="moreBtn" type="button" id="moreBtn" data-page="1" style="visiblity:hidden">more +</button>
</div>

</div>

<div class="fixedBtn">
	<a href="/community/register">
		<button type="button">글쓰기</button>
	</a>
	<button type="button">채팅하기</button>
	<button type="button">고객센터</button>
	<button type="button">TOP</button>
</div>

<jsp:include page="../common/footer.jsp" />
<script type="text/javascript" src="/resources/js/communityBoardList.js"></script>
<script type="text/javascript">
let myMenu = `<c:out value="${cmMenu}"/>`;
getMoreBoard(1, myMenu);
</script>
</body>
</html>