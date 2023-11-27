<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">
	<h2>Joongo Board</h2>
	<a href="/joongo/register"><button type="button" class="btn btn-success">register</button></a>
	<div class="row row-cols-1 row-cols-md-4 g-4" id="boardArea">
		<!-- 작성된 글 출력 공간 -->
	</div>
	<div class="d-grid gap-2 col-6 mx-auto">
	  <button class="btn btn-primary" type="button" id="moreBtn" data-page="1" style="visiblity:hidden">more +</button>
	</div>
</div>
<jsp:include page="../common/footer.jsp" />
<script src="/resources/js/productBoard.js"></script>
</body>
</html>