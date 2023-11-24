<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>job register page</title>
<link rel="stylesheet" href="/resources/css/page.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="bodyContainer">
	<!-- 첨부된 이미지 슬라이드로 뿌리기... -->
	<div class="swiper">
		<img alt="첨부이미지영역" src="../resources/image/logoimage.png">
		<!-- 이미지 수만큼 bullet생성 -->
		
	</div>
	
	<div class="profileSecction">
		<div class="userInfo">
			<span><i class="bi bi-person-circle"></i>${pbvo.proNickName}</span>
			<p>아보시 카도동</p>
		</div>
		<div class="userScore">
			별이다섯개
			<i class="bi bi-thermometer-half"></i>매너점수
		</div>
	</div>
	<hr>
	
	<div class="jobTitleSecction">
		<h1>${pbvo.proTitle}</h1>
		<p>작성자 / 작성일</p>
	</div>
	
	<div class="jobInfoSecction">
		<p><strong><i class="bi bi-coin"></i> ${pbvo.proPrice} 원</strong></p>
		<p><i class="bi bi-geo-alt">${jobAddress }</i> </p>
		<p><i class="bi bi-calendar-check"></i>근무요일</p>
		<p><i class="bi bi-clock"></i>근무시간</p>
		
		<div class="jobInfoDetail">
			<p><strong><i class="bi bi-pencil"></i>상세내용<i class="bi bi-pencil"></i></strong></p>
			<p>${pbvo.proTitle} <br>
			돈 적게받고 많이 일 하실분 구해요.
			</p>
		</div>
		
		<!-- 지도 넣으면 좋겠다. -->
	</div>
	
	
	
	
	<h1></h1>
	
		
		
		
	 
	
	
	<!--
	멤버이메일이랑 pbvo이메일 같으면 보이게하는걸로 바꿀거야 
	<c:if test="${pbvo.proEmail eq pmvo.memEmail }">
	 -->
		<a href="/job/modify?pbno=${pbvo.proBno}"><button class="btn btn-success">수정</button></a>
		<a href="/job/remove?pbno=${pbvo.proBno}"><button class="btn btn-success">삭제</button></a>
	<!-- 
	</c:if>
	 -->
	
	<!-- 댓글라인 -->
	
	
	
	
	
</div>
<script type="text/javascript" src="/resources/js/job/jobBoardRegister.js"></script>
<jsp:include page="../common/footer.jsp" />

</body>
</html>