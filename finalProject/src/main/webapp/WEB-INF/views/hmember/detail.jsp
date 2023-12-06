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
    align-items: center; /* 세로 중앙 정렬 */
    border: 1px solid gray;
}
 
.backPro {
	border: 1px solid black;
	backdrop-filter: blur(10px);
	width: 300px;
	height: 300px;
} 
  
.aboutMember {
	margin-top: -220px;
	margin-left: 30px;
}  

.nick{
	font-size: 20px;
	margin-right: 10px;
}
</style>
</head>
<body class="bodyContainer">
<jsp:include page="../common/header.jsp" />
<c:set value="${mvo }" var="mvo"></c:set>
<form action="/hmember/checkPw" method="get">
	<div class="profileContainer">
		<img class="backPro" alt="" src="../resources/image/logoimage.png">
		<div class="aboutMember">
		<span class="bold nick">${mvo.memNickName}</span>
		<span><button type="submit">회원 정보 수정</button></span>
		<div>어쩌구</div>
		</div>
		
	</div>
</form>
<jsp:include page="../common/footer.jsp" />
</body>
</html>