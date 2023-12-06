<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Detail</title>
<link rel="stylesheet" href="../resources/css/storeBoardDetail.css">
<style>
.bold {
  font-weight: bold;
}
 
/* 프사, 회원 정보 가로 배치 */ 
.profileContainer {
	margin-top: 30px;
    display: flex;
    align-items: center;
    border: 1px solid gray;
    height: 308px;
	overflow: hidden;
    width: 100%;  
}

.backProContainer {
	overflow: hidden;
} 
#backPro {
/*  	width: 310px;
    height: 100%;
    -webkit-filter: blur(5px);
    -moz-filter: blur(5px);
    -o-filter: blur(5px);
    -ms-filter: blur(5px);
    filter: blur(5px); */
    
    width: 250px;
    height: 250px;
    border-radius: 50%;
    margin-left: 28px;
}

#backPro:hover {
 	cursor : pointer;
}

.aboutMember {
	margin-top: -220px;
	margin-left: 30px;
}  

.nick{
	font-size: 20px;
	margin-right: 10px;
}

#editProfile {
    display: none;
    position: absolute;
    border: 1px solid #d3d3d3;
    background-color: #fff;
    box-shadow: 0 0 5px #cdcdcd;
}

#editProfile ul {
    padding: 5px 10px;
    margin: 0;
    text-align: center;
}

#editProfile ul li a {
    text-decoration: none;
    color: #333;
    font-size: 16px;
    line-height: 30px;
    padding: 0px 5px;
}

#editProfile ul li a:hover {
    font-weight: 600;
    color: #323f11;
    cursor : pointer;
}
</style>
</head>
<body class="bodyContainer">
<jsp:include page="../common/header.jsp" />
<c:set value="${mvo }" var="mvo"></c:set>
<c:set value="${src }" var="src"></c:set>
<form action="/hmember/checkPw" method="get">
	<div class="profileContainer">
		<div class="backProContainer">
		<img id="backPro" alt="" src="${src}">
		
		<div id="editProfile">
			<ul id="btnContainer">
				<li><a id="editBtn">프로필 수정</a></li>
				<li><a id="delBtn">프로필 삭제</a></li>
			</ul>
		</div>		
		</div>
		
		<div class="aboutMember">
		<span class="bold nick">${mvo.memNickName}</span>
		<span><button type="submit">회원 정보 수정</button></span><br>		
		<span><i class="bi bi-lock-fill"></i>본인인증 완료</span>
		<span id="calcDate"><i class="bi bi-calendar"></i>아보카트 가입일 일 전</span>
		<span><i class="bi bi-thermometer-half"></i>회원 온도 추후 수정</span>
		</div>		
	</div>
	
	<input type="file" name="file" id="profile" accept="image/*" style="display:none;">
</form>

<script type="text/javascript">
let regAt = `<c:out value="${mvo.memRegAt}"/>`;
let email = `<c:out value="${mvo.memEmail}"/>`;
let baseUrl = `<c:out value='/hmember/editFile/'/>`;
let src = `<c:out value="${src}"/>`;
</script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="/resources/js/hmemberDetail.js"></script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>