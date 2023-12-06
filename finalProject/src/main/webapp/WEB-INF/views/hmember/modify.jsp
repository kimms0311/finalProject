<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Modify</title>
<style type="text/css">
.bodyContainer{
	display: flex;
	justify-content: center;
}

form{
	width: 600px;
}
.registerBtn{
	width: 600px;
}
.pwEye{
	 cursor: pointer;
}
.msg{
	color: red;
}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<c:set value="${mvo }" var="mvo"></c:set>
<div class="bodyContainer">
<form action="/hmember/modify" method="post">
	<div>이메일 주소</div>
	<div>
	  <input type="email" name="memEmail" id="email" value="${mvo.memEmail }" readonly="readonly">
	</div>

	<div>
	  <div>새 비밀번호</div>
	  <input type="password" name="memPw1" id="pw1" placeholder="영문, 숫자, 특수문자 조합 8-16자">
	  <i class="bi bi-eye-slash pwEye" id="showPwBtn1"></i>
	  <p class="msg" style="display:none" id="pwMsg1_1">영문, 숫자, 특수문자를 조합하여 입력해 주세요.</p>
	  <p class="msg" style="display:none" id="pwMsg2_1">8-16자 사이로 입력해 주세요.</p>
	</div>
	
	<div>
	  <div>새 비밀번호 확인</div>
	  <input type="password" name="memPw" id="pw2" placeholder="영문, 숫자, 특수문자 조합 8-16자">
	  <i class="bi bi-eye-slash pwEye" id="showPwBtn2"></i>
	  <p class="msg" style="display:none" id="pwMsg1_2">비밀번호가 일치하지 않습니다.</p>
	  <p class="msg" style="display:none" id="pwMsg2_2">비밀번호를 입력해 주세요.</p>	  
	</div>
		
	<div>
	  <div>닉네임</div>
	  <input type="text" name="memNickName" id="nick" placeholder="닉네임을 입력하세요." value="${mvo.memNickName}">
	  <p class="msg" style="display:none" id="nickMsg">이미 존재하는 닉네임입니다.</p>
	</div>
	
	<div>	
	  <div>주소</div>
	  <input type="text" id="addr" placeholder="주소를 검색하세요." value="${mvo.memSido} ${mvo.memSigg} ${mvo.memEmd}">
	</div>
	<!-- 주소 전송용 인풋 -->
	<input type="hidden" name="memSido" id="sido" value="${mvo.memSido}">
	<input type="hidden" name="memSigg" id="sigg" value="${mvo.memSigg}">
	<input type="hidden" name="memEmd" id="emd" value="${mvo.memEmd}">
	<button type="submit" class="registerBtn" id="regiBtn" disabled="disabled">수정하기</button>
	<button type="button" id="deleteMemBtn">탈퇴하기</button>
</form>
</div>
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript">
let email = `<c:out value="${mvo.memEmail}"/>`;
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/hmemberModify.js"></script>
</body>
</html>