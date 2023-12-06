<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member register</title>
<style type="text/css">
	.bodyContainer{
		display: flex;
		justify-content: center;
	}

	form{
		width: 400px;
	}
	.registerBtn{
		width: 400px;
	}
	.pwEye{
		 cursor: pointer;
	}
	.msg{
		color: red;
	}
	.bi-check-square, .bi-check-square-fill, .bi-plus-lg, .bi-dash-lg{
		font-size: 30px;
		color: gray;
		cursor: pointer;
	}
	.check, .check2{
		display: none;
	}
	.check_sub{
		display: none;
		margin-left: 40px;
	}
	span{
		cursor: pointer;	
	}
	.mailTest{
		color: blue;
	}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">

<form action="/member/register" method="post">
	<label for="email" class="form-label">이메일 주소</label> <br>
	<div class="input-group mb-3">
	  <input type="email" class="form-control" name="memEmail" id="email" placeholder="예) avocart@avocart.co.kr">
	  <button type="button" class="btn btn-outline-secondary" id="testBtn">인증하기</button>
	</div>
	  <p class="msg" style="display:none" id="emailMsg">이메일 주소를 정확히 입력해주세요.</p>
	  <p class="msg" style="display:none" id="emailMsg2">이미 존재하는 이메일입니다.</p>
	  <p class="msg" style="display:none" id="emailMsg3">이메일을 입력해주세요.</p>
	<!-- 인증번호 입력 input -->
	<div class="mb-3">
     <input type="text" class="form-control" id="testNum" placeholder="인증번호를 입력해주세요." style="display:none">
     <p class="mailTest" style="display:none" id="testO">인증 완료</p>
     <p class="msg" style="display:none" id="testX">다시 입력해주십시오.</p>
	</div>
	
	<div class="mb-3">
	  <label for="pw" class="form-label">비밀번호</label>
	  <input type="password" class="form-control" name="memPw" id="pw" placeholder="영문,숫자,특수문자 조합 8-16자">
	  <i class="bi bi-eye-slash pwEye" id="showPwBtn"></i>
	  <p class="msg" style="display:none" id="pwMsg">영문, 숫자, 특수문자를 조합하여 입력해주세요.</p>
	  <p class="msg" style="display:none" id="pwMsg2">8-16자 사이로 입력해주세요.</p>
	</div>
	
	<div class="mb-3">
	  <label for="nick" class="form-label">닉네임</label>
	  <input type="text" class="form-control" name="memNickName" id="nick" placeholder="닉네임을 입력하세요">
	  <p class="msg" style="display:none" id="nickMsg">이미 존재하는 닉네임입니다.</p>
	</div>
	
	<div class="mb-3">	
	  <label for="addr" class="form-label">주소</label>
	  <input type="text" class="form-control" id="addr" placeholder="주소를 검색하세요">
	</div>
	<!-- 주소 전송용 인풋 -->
	<input type="hidden" class="form-control" name="memSido" id="sido">
	<input type="hidden" class="form-control" name="memSigg" id="sigg">
	<input type="hidden" class="form-control" name="memEmd" id="emd">
	
	<div class="agree">
	
		<div class="essential">
			<div class="check_main">
				<div style="display:inline">
					<input type="checkbox" name="agree" id="all" class="check">
					<label for="all"><i class="bi bi-check-square emptySquare" id="allAgree"></i><span> [필수] 만 14세 이상이며 모두 동의합니다.</span></label>
				</div>
				<button type="button" id="open"><i class="bi bi-plus-lg" id="openIcon"></i></button>		    
			</div>
			<div class="check_sub" id="check_sub">
				<div>
				    <input type="checkbox" name="agree" id="service" class="check">
				    <label for="service"><i class="bi bi-check-square emptySquare" id="serviceAgree"></i><span> 이용약관 동의</span></label>
				</div>
				<div>
				    <input type="checkbox" name="agree" id="personal" class="check">
				    <label for="personal"><i class="bi bi-check-square emptySquare" id="personalAgree"></i><span> 개인정보 수집 및 이용 동의</span></label>
				</div>
			</div>
		</div>
		
		<div class="unessential">
			<div class="check_main">
				<div style="display:inline">
				    <input type="checkbox" name="agree" id="event" class="check2">
				    <label for="event"><i class="bi bi-check-square emptySquare2" id="eventAgree"></i><span> [선택] 이벤트 정보 수신에 동의합니다.</span></label>
				</div>
			    <button type="button" id="open2"><i class="bi bi-plus-lg" id="openIcon2"></i></button>
			</div>
			<div class="check_sub" id="check_sub2">
				<div>
				    <input type="checkbox" name="agree" id="app" class="check2">
				    <label for="app"><i class="bi bi-check-square emptySquare2" id="appAgree"></i><span> 앱푸시</span></label>
				</div>
				<div>
				    <input type="checkbox" name="agree" id="message" class="check2">
				    <label for="message"><i class="bi bi-check-square emptySquare2" id="messageAgree"></i><span> 문자</span></label>
				</div>
				<div>
				    <input type="checkbox" name="agree" id="agreeEmail" class="check2">
				    <label for="agreeEmail"><i class="bi bi-check-square emptySquare2" id="emailAgree"></i><span> 이메일</span></label>
				</div>
			</div>
		</div>
		
    </div>
    
	<button type="submit" class="btn btn-secondary registerBtn" id="regiBtn" disabled="disabled">가입하기</button>
</form>

</div>
<jsp:include page="../common/footer.jsp" />

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="/resources/js/memberRegister.js"></script>
</body>
</html>