<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">
<h2> 중고거래 </h2>
<p>기본 정보</p>
<form action="/joongo/register" method="post">
	<input type="hidden" name="proEmail" value="joongoEmail@email">
	<input type="hidden" name="proNickName" value="joongoJY">
	<input type="hidden" name="proCategory" value="joongo">
	<div class="form-floating">
		<input type="text" class="form-control" id="title" name="proTitle">
		<label for="title">Title</label>
	</div>
	<div class="input-group mb-3">
	  <span class="input-group-text">&#8361;</span>
	  <div class="form-floating">
	    <input type="number" class="form-control" id="price" name="proPrice" placeholder="price">
	    <label for="price">Price</label>
	  </div>
	</div>
	<div class="form-floating">
      <select class="form-select" id="menu">
        <option selected>선택</option>
        <option value="여성의류">여성의류</option>
        <option value="남성의류">남성의류</option>
        <option value="신발">신발</option>
        <option value="가구">가구</option>
        <option value="잡화">잡화</option>
      </select>
      <label for="menu">카테고리</label>
    </div>
	<div class="form-floating">
		<textarea class="form-control" id="content" name="proContent"></textarea>
		<label for="content">Content</label>
	</div>
	<button type="submit">등록</button>
</form>
</div>
<jsp:include page="../common/footer.jsp" />
</body>
</html>