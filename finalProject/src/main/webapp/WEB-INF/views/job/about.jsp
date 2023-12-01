<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>about page</title>
<link rel="stylesheet" href="/resources/css/page.css">
<link rel="stylesheet" href="/resources/css/jobDetail.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="bodyContainer">

	<div class="info">
		<h1>우리동네 알바카도</h1>
		<p>알바카트하듯 쉽게 동네에서 일거리를 찾고 <br>
		일할 분을 구할 수 있어요</p>
		
		<img alt="workImageError" src="https://www.daangn.com/_next/static/media/jobs_about_hero_2x.f4e0e4cd.png" style="width: 100%">
	</div>
	
	<div class="howTo">
		<h1>쉽고 빠른 당근알바 이용방법</h1>
		<a href="/job/register" ><button type="button" class="btn btn-success">공고 쓰기</button></a>
		<a href="/job/list" ><button type="button" class="btn btn-success">지원 하기</button></a>
		<div class="step1">
			<span>step1</span>
			어쩌구
		</div>
		<div class="step2">
			<span>step2
			</span>
			저쩌구
		</div>
		<div class="step3">
			<span>step3</span>
			ㅋㅋ
		</div>

	</div>
	
	<div class="famous">
		<h1>인기 알바카도</h1>

	</div>
	
	<div class="near">
		<h1>내 근처 알바카도</h1>

	</div>
</div>

 <jsp:include page="../common/footer.jsp" />

</body>
</html>