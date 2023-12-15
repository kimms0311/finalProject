<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<link rel="stylesheet" href="../resources/css/memberLogin.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">

<form action="/member/login" method="post">
	<p class="siteTitle">Avocart</p>
	<div class="emailInput">
	  <label for="email" class="labels">이메일 주소</label>
	  <input type="email" name="memEmail" id="email" class="inputs">
	</div>
	<div class="pwInput">
	  <label for="pw" class="labels">비밀번호</label>
	  <input type="password" name="memPw" id="pw" class="inputs">
	  <i class="bi bi-eye-slash" id="showPwBtn"></i>
	<c:if test="${not empty param.errMsg }">
		<div class="msg">
			<c:choose>
				<c:when test="${param.errMsg eq 'Bad credentials' }">
					<c:set var="errText" value="이메일 or 비밀번호가 일치하지 않습니다." />
				</c:when>
			</c:choose>
			${errText }
		</div>
	</c:if>
	</div>
	

	<button type="submit" class="loginBtn" id="loginBtn">로그인</button>
</form>


</div>
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript" src="/resources/js/memberLogin.js"></script>
</body>
</html>