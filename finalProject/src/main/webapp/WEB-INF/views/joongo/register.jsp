<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/joongoBoard.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<sec:authentication property="principal.mvo.memEmail" var="authEmail"/>
<sec:authentication property="principal.mvo.memNickName" var="authNick"/>
<div class="banner">
</div>
<div class="bodyContainer">
	<form action="/joongo/register" method="post" enctype="multipart/form-data">
		<input type="hidden" name="proEmail" value="${authEmail}">
		<input type="hidden" name="proNickName" value="${authNick}">
		<input type="hidden" name="proCategory" value="joongo">

	    <div class="form">
	    	<label for="title">제목</label>
			<input type="text" id="title" name="proTitle" placeholder="제목을 입력해 주세요" required="required">
		</div>
		
		<div class="form">
			<label for="price">가격</label>
			<input type="number" min="0" id="price" name="proPrice" placeholder="가격을 입력해 주세요" required="required">
		</div>
	
		<div class="form">
			<label for="menu">카테고리</label>
			<jsp:include page="menuSelect.jsp"/>
		</div>
	    
		<div class="form">
			<label for="dynamicTextarea">내용</label>
			<textarea id="dynamicTextarea" name="proContent" required="required"></textarea>
		</div>
		
		<!-- 파일 -->
		<label>이미지</label>
		<div class="form fileForm" id="fileForm">
			<input type="file" class="form-control" name="files" id="files" multiple="multiple" style="display:none;">
			<input type="text" readonly="readonly" class="fileInput" placeholder="20MB 미만의 이미지를 업로드 해주세요"> 
			<button type="button" id="trigger" class="fileBtn">파일첨부</button>
		</div>
		<!-- 첨부파일 표시 영역 -->
		<div class="fileZone" id="fileZone" style="display:none">
		
		</div>
		
		<div class="proBtnArea">
			<a href="/joongo/list"><button type="button" class="cancelBtn">취소</button></a>
			<button type="submit" class="regBtn" id="regBtn">작성</button>
		</div>
	</form>
</div>
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript" src="/resources/js/productFile.js"></script>
<script type="text/javascript" src="/resources/js/abjustTextareaRows.js"></script>
<script type="text/javascript">
let title = document.getElementById('title');
let price = document.getElementById('price');
let menu = document.getElementById('menu');
let dynamicTextarea = document.getElementById('dynamicTextarea');
let form = document.querySelector('.bodyContainer form');
let regBtn = document.getElementById('regBtn');

// 글을 작성하지 않은 상태에서 버튼 막기
regBtn.disabled = true;

// form에 변경사항이 있다면 코드 실행
form.addEventListener('change',()=>{
	let selectedMenu = menu.options[menu.selectedIndex].value
	
	// 필수 요소를 작성하지 않았을 경우에만 버튼 막기
    if(title.value.trim() == "" || price.value == "" || selectedMenu == "선택" || dynamicTextarea.value.trim() == ""){
        regBtn.disabled = true;
    }else{
        regBtn.disabled = false;
    }
})
</script>
</body>
</html>