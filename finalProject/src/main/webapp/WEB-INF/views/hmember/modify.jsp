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
	<div class="mb-3">
	  <label for="email" class="form-label">이메일 주소</label>
	  <input type="email" class="form-control input-danger" name="memEmail" id="email" value="${mvo.memEmail}" readonly="readonly">
	</div>
	<div class="mb-3">
	  <label for="pw" class="form-label">비밀번호</label>
	  <input type="password" class="form-control" name="memPw1" id="pw1" placeholder="영문, 숫자, 특수문자 조합 8-16자">
	  <i class="bi bi-eye-slash pwEye" id="showPwBtn"></i>
	  <p class="msg" style="display:none" id="pwMsg">영문, 숫자, 특수문자를 조합하여 입력해 주세요.</p>
	  <p class="msg" style="display:none" id="pwMsg2">8-16자 사이로 입력해 주세요.</p>
	</div>
	<div class="mb-3">
	  <label for="pw" class="form-label">비밀번호 확인</label>
	  <input type="password" class="form-control" name="memPw" id="pw2" placeholder="영문, 숫자, 특수문자 조합 8-16자">
	  <i class="bi bi-eye-slash pwEye" id="showPwBtn2"></i>
	  <p class="msg" style="display:none" id="pwMsg">영문, 숫자, 특수문자를 조합하여 입력해주세요.</p>
	  <p class="msg" style="display:none" id="pwMsg2">8-16자 사이로 입력해 주세요.</p>
	  <p class="msg" style="display:none" id="pwMsg3">비밀번호가 일치하지 않습니다.</p>
	</div>
	<div class="mb-3">
	  <label for="nick" class="form-label">닉네임</label>
	  <input type="text" class="form-control" name="memNickName" id="nick" placeholder="닉네임을 입력하세요." value="${mvo.memNickName}">
	  <p class="msg" style="display:none" id="nickMsg">이미 존재하는 닉네임입니다.</p>
	</div>
	<div class="mb-3">
	  <label for="ph" class="form-label">전화번호</label>
	  <input type="text" class="form-control" name="memPhone" id="ph" placeholder="-를 제외한 전화번호를 입력하세요." value="${mvo.memPhone}">
	</div>
	<div class="mb-3">	
	  <label for="addr" class="form-label">주소</label>
	  <input type="text" class="form-control" id="addr" placeholder="주소를 검색하세요." value="${mvo.memSido} ${mvo.memSigg} ${mvo.memEmd}">
	</div>
	<!-- 주소 전송용 인풋 -->
	<input type="hidden" class="form-control" name="memSido" id="sido">
	<input type="hidden" class="form-control" name="memSigg" id="sigg">
	<input type="hidden" class="form-control" name="memEmd" id="emd">
	
	<button type="submit" class="btn btn-secondary registerBtn">수정하기</button>
</form>
</div>
<jsp:include page="../common/footer.jsp" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/hmemberModify.js"></script>
</body>
</html>