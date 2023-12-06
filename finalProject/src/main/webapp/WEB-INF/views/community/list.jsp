<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community List</title>
<style type="text/css">
	.user_profile>*, .item-info>*{
		display: inline;
	}
	.cmBoard, .CommunityCategory{
		margin: 20px 0;
		width: 80%;
	}
	.bodyContainer, .cmBoard{
		display: flex;
		justify-content: center;
		flex-wrap: wrap;
	}
	.boardMenuName{
		margin: 0;
		padding: 0;
	}
	.CommunityCategory{
		display: flex;
		justify-content: center;
		background-color: yellow;
	}
	.menu{
		margin: 0 10px;
		text-decoration: none;
		color: black;
		border: 1px solid black;
	}
	.cmBoard{
		background-color: lightgrey;
	}
	.user_profile, .communityContentLine,.communityContentLine>a , .item-info{	
		width :650px;
	}
	.oneBoard{
		height: 300px;
		margin: 20px 0;
		border: 1px solid black;
		position: relative;
	}
	.user_profile{
		background-color: yellow;
	}
	.communityContentLine{
		background-color: white;
		height: 225px;
	}
	.bodyContainer{
		position: relative;
	}
	.moreBtn{
		 position: absolute;
         bottom: 20px; 
         left: 50%;
         transform: translateX(-50%);
	}
	.commuRegiBtn{
		position: fixed;
		bottom: 0;
		right: 0;
	}
	.thumbImg{
		width: 650px;
		height: 200px;
	}
	.item-info{
	    display: flex;
	    justify-content: space-between;
	    
	    position: absolute;
	    bottom: 0;
	    background-color: green;
	}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">

<div class="CommunityCategory">
	<button class="menu">전체</button>
	<button class="menu">일상</button>
	<button class="menu">모임</button>
	<button class="menu">질문</button>
	<button class="menu">동네생활정보</button>
	<button class="menu">찾습니다</button>
	<button class="menu">해주세요</button>
	<button class="menu">동네사진전</button>
</div>

<!-- 작성된 글 출력 공간 -->
<div class="cmBoard" id="cmBoard">
	<div class="oneBoard">
		<p class="boardMenuName">${bvo.cmMenu }</p>
		
		<div class="user_profile">
			<i class="bi bi-person-circle"></i>
			<b>${bvo.cmNickName}</b>
			<p>${bvo.cmRegAt }</p>
			<p>${bvo.cmEmd }</p>
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
<div class="d-grid gap-2 col-6 mx-auto">
	<button class="btn btn-primary moreBtn" type="button" id="moreBtn" data-page="1" style="visiblity:hidden">more +</button>
</div>


</div>
<a href="/community/register">
	<button type="button" class="btn btn-success commuRegiBtn">등록</button>
</a>

<jsp:include page="../common/footer.jsp" />
<script type="text/javascript" src="/resources/js/communityBoardList.js"></script>
<script type="text/javascript">
let myMenu = "전체";
getMoreBoard(1, myMenu);
</script>
</body>
</html>