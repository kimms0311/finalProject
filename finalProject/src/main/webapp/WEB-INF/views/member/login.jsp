<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<style type="text/css">
	.bodyContainer{
		display: flex;
		justify-content: center;
	}

	form{
		width: 400px;
	}
	.loginBtn{
		width: 400px;
	}
	.pwEye{
		 cursor: pointer;
	}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">

<form action="/member/login" method="post">
	<div class="mb-3">
	  <label for="email" class="form-label">Email</label>
	  <input type="email" class="form-control" name="memEmail" id="email">
	</div>
	<div class="mb-3">
	  <label for="p" class="form-label">Password</label>
	  <input type="password" class="form-control" name="memPw" id="pw">
	  <i class="bi bi-eye-slash pwEye" id="showPwBtn"></i>
	</div>
	
	<c:if test="${not empty param.errMsg }">
		<div class="text-danger mb-3">
			<c:choose>
				<c:when test="${param.errMsg eq 'Bad credentials' }">
					<c:set var="errText" value="이메일 or 비밀번호가 일치하지 않습니다." />
				</c:when>
			</c:choose>
			<br>
			${errText }
		</div>
	</c:if>

	<button type="submit" class="btn btn-secondary loginBtn">로그인</button>
</form>

</div>
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript">
document.getElementById('showPwBtn').addEventListener('click',(e)=>{
    let pwInput = document.getElementById('pw');

    if (pwInput.type === "password") {
        pwInput.type = "text";
        let showPwBtn = document.getElementById('showPwBtn');
        showPwBtn.className = showPwBtn.className.replace('bi-eye-slash', 'bi-eye');
    } else {
        pwInput.type = "password";
        let showPwBtn = document.getElementById('showPwBtn');
        showPwBtn.className = showPwBtn.className.replace('bi-eye', 'bi-eye-slash');
    }
})
</script>
</body>
</html>