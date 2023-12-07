<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<style type="text/css">
	@font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
	}
	
	.bodyContainer{
		display: flex;
		justify-content: center;
		padding: 100px 0 150px 0;
	}
	
	.siteTitle{
		text-align: center;
		font-size: 50px;
		font-weight: 800;
		display: block;
		color: #84a331;
		margin-bottom: 50px;
   		font-family: 'Fugaz One', sans-serif;
	}
	form{
		width: 400px;
	}
	.labels{
		display: block;
		font-weight: 800;
		margin-bottom: 7px;
	    font-family: 'Pretendard-Regular';
	    color: #334010;
	}
	.inputs{
		width: 400px;
		height: 40px;
		padding-left: 10px;
		border: 2px solid #84a331;
		border-radius: 5px;		
	    font-family: 'Pretendard-Regular';
	}
	.inputs::placeholder{
	    font-family: 'Pretendard-Regular';
	}
	.emailInput{
		margin-bottom: 20px;	
	}
	.bi-eye-slash, .bi-eye{
		cursor: pointer;
		position : absolute;
	    display: block;
		margin-left: 367px;
		margin-top: -33px;
		color: #84a331;
	}
	.msg{
		color: red;
		height: 30px;
		font-weight: 800;
		font-size: 13px;
		padding-top: 5px;
	}
	.loginBtn{
		margin-top: 30px;
		width: 400px;
		height: 50px;
		
		border: none;
		background-color: #84a331;
		color: white;
		border-radius: 5px;
	    font-family: 'Pretendard-Regular';
	}

</style>
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
	  <label for="p" class="labels">비밀번호</label>
	  <input type="password"name="memPw" id="pw" class="inputs">
	  <i class="bi bi-eye-slash" id="showPwBtn"></i>
	</div>
	
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

	<button type="submit" class="loginBtn">로그인</button>
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