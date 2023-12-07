<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check Password</title>
<link rel="stylesheet" href="../resources/css/hmemberCheckPw.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">
<form action="/hmember/passOrFail" method="post">
	<p class="siteTitle">Avocart</p>
	<div class="pwInput">
	  <label for="p" class="labels">비밀번호를 다시 한번 입력해 주세요.</label>
	  <input type="password" name="inputPw" id="pw" class="inputs">
	  <i class="bi bi-eye-slash" id="showPwBtn"></i>
	</div>
	<div class="msg" id="resultZone"></div>
	<button type="submit" class="checkBtn">확인하기</button>
</form>
</div>
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript">
let isOk = `<c:out value="${isOk}"/>`;
</script>
<script type="text/javascript" src="/resources/js/hmemberCheckPw.js"></script>
</body>
</html>