<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.bodyContainer > form > img{
	width: 500px;
}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">
	<form action="/joongo/modify" method="post">
		<input type="hidden" name="proEmail" value="joongoEmail@email">
		<input type="hidden" name="proNickName" value="joongoJY">
		<input type="hidden" name="proCategory" value="joongo">
		<input type="hidden" name="proBno" value="${pbvo.proBno }">
		
		<!-- 상품이미지 여러 개일 경우 슬라이더 -->
		<img src="../resources/image/logoimage.png" class="card-img-top" alt="...">
		
		<div class="profile">
			<img src="..." class="card-img-top" alt="프로필 이미지">
			<p>${pbvo.proNickName }</p>
			<p>${pbvo.proSido } ${pbvo.proSigg }</p>
			<!-- 글 작성자가 아닐 경우에만 띄울 버튼 -->
			<button type="button" class="btn btn-outline-warning">채팅하기</button>
		</div>
		<div class="prodArea">
			<h3><input type="text" name="proTitle" value="${pbvo.proTitle }"></h3>
			<div class="form-floating">
		      <jsp:include page="menuSelect.jsp"/>
		      <label for="menu">카테고리</label>
		    </div>
			<h3><input type="text" name="proPrice" value="${pbvo.proPrice }"></h3>
			<p><textarea name="proContent">${pbvo.proContent }</textarea></p>
		</div>
		
		<!-- 글 작성자에게만 띄울 버튼 -->
		<button type="submit" class="btn btn-success">수정</button>
	</form>
</div>
<jsp:include page="../common/footer.jsp" />
</body>
</html>