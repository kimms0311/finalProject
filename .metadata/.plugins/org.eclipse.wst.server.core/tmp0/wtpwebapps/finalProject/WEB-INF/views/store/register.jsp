<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Store Register</title>
<link rel="stylesheet" href="../resources/css/page.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">
<form action="/store/register" method="post" enctype="multipart/form-data">
<input type="hidden" name="proCategory" value="store">
<select name="menu">
	<option disabled="disabled" selected="selected">선택</option>
	<option value="lesson">과외/클래스</option>
	<option value="pet">반려동물</option>
	<option value="hospital">병원/약국</option>
	<option value="beauty">뷰티샵</option>
	<option value="laundry">세탁소</option>
	<option value="repair">수리</option>
	<option value="sport">운동</option>
	<option value="baby">육아</option>
	<option value="eatery">음식점</option>
	<option value="move">이사/용달</option>
	<option value="interior">인테리어 시공</option>
	<option value="clean">청소</option>
	<option value="hobby">취미</option>
	<option value="cafe">카페/디저트</option>
</select>
<input type="text" name="title" id ="t" placeholder="업체명">
<textarea placeholder="내용" class="form-control" name="content" id="c" rows="20"></textarea>

<input type="file" name="files" id="files" style="display:none;" multiple="multiple">
<button type="button" id="trigger">사진 첨부</button>
<div id="fileZone">
<!-- 첨부 파일 표시 -->
</div>
<button type="submit" id="regBtn">등록</button>
</form>
</div>
<script type="text/javascript" src="/resources/js/storeBoardRegister.js"></script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>