<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<div class="bodyContainer">
	<form action="/joongo/modify" method="post" enctype="multipart/form-data">
		<input type="hidden" name="proEmail" value="${authEmail}">
		<input type="hidden" name="proNickName" value="${authNick}">
		<input type="hidden" name="proCategory" value="joongo">
		<input type="hidden" name="proBno" value="${pbvo.proBno }">
		
		<!-- 상품이미지 여러 개일 경우 슬라이더 -->

		<div class="form">
			<label for="title">제목</label>
			<input type="text" id="title" name="proTitle" value="${pbvo.proTitle }">
		</div>
		<div class="form">
			<label for="menu">카테고리</label>
			<jsp:include page="menuSelect.jsp"/>
		</div>
		<div class="form">
			<label for="price">가격</label>
			<input type="text" id="price" value="${pbvo.proPrice }">
			<input type="hidden" id="numPrice" name="proPrice" value="${pbvo.proPrice}">
		</div>
		<div class="form">
			<label for="dynamicTextarea">내용</label>
			<textarea id="dynamicTextarea" name="proContent">${pbvo.proContent }</textarea>
		</div>
		
		<!-- 파일 띄우고 지우기 버튼 추가 -->
		<c:set value="${files }" var="flist" />
		<c:if test="${flist.size() > 0 }">
			<div class="form uploadedImg">
				<label>등록된 이미지</label>
				<ul class="uploadedImgUl">
				<c:forEach items="${flist }" var="fvo" varStatus="loop">
					<c:choose>
						<c:when test="${fvo.fileType > 0 }">
							<li class="imageLi ${loop.last ? 'last-file' : ''}">	
								<div class="oneImg"><img alt="그림없음" class="imgs" src="/upload/product/${fn:replace(fvo.saveDir,'\\','/')}/${fvo.uuid}_th_${fvo.fileName}">${fvo.fileName }</div>
								<button type="button" class="imageCancelBtn fileDel" data-uuid="${fvo.uuid }">X</button>
							</li>
						</c:when>
					</c:choose>
				</c:forEach>
				</ul>
			</div>
		</c:if>
		
		<!-- 파일 다시 추가 -->
		<label for="fileForm">새로운 이미지</label>
		<div class="form fileForm" id="fileForm">
			<input type="file" class="form-control" name="files" id="files" multiple="multiple" style="display:none;">
			<input type="text" readonly="readonly" class="fileInput" placeholder="20MB 미만의 이미지를 업로드 해주세요"> 
			<button type="button" id="trigger" class="fileBtn">파일첨부</button>
		</div>
		<!-- 첨부파일 표시 영역 -->
		<div class="fileZone" id="fileZone" style="display:none">
	
		</div>
	
		<div class="proBtnArea">
			<a href="/joongo/detail?proBno=${pbvo.proBno }"><button type="button" class="cancelBtn">취소</button></a>
			<button type="submit" class="regBtn" id="regBtn">수정</button>
		</div>
	</form>
</div>
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript">
// 가격 input에 컴마 붙이기
const input = document.getElementById('price');
// 가격을 입력할 때마다 함수 실행
input.addEventListener('keyup', (e) => {
  let priceValue = e.target.value;
  // value값에 컴마가 붙어있다면 전부 빼서 number값으로 변경
  priceValue = Number(priceValue.replaceAll(',', ''));
  
  // 범위 외 값 처리
  if(isNaN(priceValue)){
    input.value = 0;
  }else if(priceValue < 0) {
	priceValue *= -1;
	input.value = priceValue;
  }else{
    const formatValue = priceValue.toLocaleString('ko-KR');
    input.value = formatValue;
  }
  
  // 숫자로 변경된 가격 값을 numPrice input에 세팅
  let numPrice = document.getElementById('numPrice');
  numPrice.value = priceValue;
})
</script>
<script type="text/javascript" src="../resources/js/abjustTextareaRows.js"></script>
<script type="text/javascript" src="../resources/js/productFile.js"></script>
<script type="text/javascript" src="../resources/js/fileDelete.js"></script>
<script type="text/javascript" src="../resources/js/joongoBoardModify.js"></script>
</body>
</html>