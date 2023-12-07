<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Detail</title>
<link rel="stylesheet" href="../resources/css/hmemberDetail.css">
</head>
<body class="bodyContainer">
<jsp:include page="../common/header.jsp" />
<c:set value="${mvo }" var="mvo"></c:set>
<c:set value="${backSrc }" var="backSrc"></c:set>
<c:set value="${mainSrc }" var="mainSrc"></c:set>
<form action="/hmember/checkPw" method="get">
	<div class="profileContainer">
		<div class="backProOuter">
		<img id="backPro" alt="" src="${backSrc}">
			<div id="mainProOuter">
				<img id="mainPro" alt="" src="${mainSrc}">
			</div>
		</div>
		<div id="editProfile">
			<ul id="btnContainer">
				<li><a id="editBtn">프로필 수정</a></li>
				<li><a id="delBtn">프로필 삭제</a></li>
			</ul>
		</div>		
		
		<div class="aboutMember">
		<span class="bold nick">${mvo.memNickName}</span>
		<span><button class="modBtn" type="submit">회원 정보 수정</button></span><br>	
		<div class="forBorder">	
		<span class="memMsg1"><i class="bi bi-lock-fill"></i>본인인증<span class="black">완료</span></span>
		<span class="memMsg2" id="calcDate"><i class="bi bi-calendar"></i>아보카트 가입일 일 전</span>
		<span class="memMsg3"><i class="bi bi-thermometer-half"></i>회원 온도<span class="black">수정</span></span>
		</div>
		</div>		
	</div>
	
	<input type="file" name="file" id="profile" accept="image/*" style="display:none;">
</form>

<script type="text/javascript">
let regAt = `<c:out value="${mvo.memRegAt}"/>`;
let email = `<c:out value="${mvo.memEmail}"/>`;
let baseUrl = `<c:out value='/hmember/editFile/'/>`;
let backSrc = `<c:out value="${backSrc}"/>`;
let mainSrc = `<c:out value="${mainSrc}"/>`;
</script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="/resources/js/hmemberDetail.js"></script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>