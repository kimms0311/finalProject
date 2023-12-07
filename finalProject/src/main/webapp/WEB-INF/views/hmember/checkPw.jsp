<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check Password</title>
<style type="text/css">
#resultZone{
	color: red;
}
</style>
</head>
<body class="bodyContainer">
<jsp:include page="../common/header.jsp" />
<form action="/hmember/passOrFail" method="post">
<div>
<div>비밀번호를 다시 한번 입력해 주세요.</div>
<input type="password" name="inputPw"> <br>
<div id="resultZone"></div>
<button type="submit">확인하기</button>
</div>
</form>
<jsp:include page="../common/footer.jsp" />
</body>
<script>
let isOk = `<c:out value="${isOk}"/>`;
let resultZone = document.getElementById('resultZone');
if (isOk == -1) {
    resultZone.innerText = '잘못된 비밀번호입니다.';
} 
</script>
</html>