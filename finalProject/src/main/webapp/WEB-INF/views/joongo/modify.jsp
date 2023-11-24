<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	<form action="/joongo/modify" method="post" enctype="multipart/form-data">
		<input type="hidden" name="proEmail" value="joongoEmail@email">
		<input type="hidden" name="proNickName" value="joongoJY">
		<input type="hidden" name="proCategory" value="joongo">
		<input type="hidden" name="proBno" value="${pbvo.proBno }">
		
		<!-- 상품이미지 여러 개일 경우 슬라이더 -->
		
		<div class="profile">
			<img src="..." class="card-img-top" alt="프로필 이미지">
			<p>${pbvo.proNickName }</p>
			<p>${pbvo.proSido } ${pbvo.proSigg }</p>
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
		<input type="file" name="files" id="files" style="display:none;" multiple="multiple">
		<button type="button" id="trigger" class="btn btn-warning">파일업로드</button>
		<div class="mb-3" id="fileZone">
			<!-- 첨부파일 표시될 구역 -->
		</div>
		file
		<ul class="list-group">
		
			<c:forEach items="${files }" var="fvo">
  			<li class="list-group-item d-flex justify-content-between align-items-center">
				<c:choose>
					<c:when test="${fvo.fileType > 0 }">
						<img alt="그림 없음" src="/upload/product/${fn: replace(fvo.saveDir, '\\', '/')}/${fvo.uuid}_th_${fvo.fileName}">
					
						<div class="ms-2 me-auto">
							<div class="fw-bold">${fvo.fileName}</div>
				    		<span class="badge bg-primary rounded-pill">${fvo.fileSize }Byte</span>
				    	</div>
					</c:when>
					<c:otherwise>
						<div>
							<!-- file 아이콘 모양 -->
						</div>
					</c:otherwise>
				</c:choose>
				<button type="button" class="btn-close" data-uuid="${fvo.uuid }"></button>
			</li>
			</c:forEach>
		</ul>
		<button type="submit" class="btn btn-success" id="regBtn">수정</button>
	</form>
</div>
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript" src="../resources/js/productFile.js"></script>
<script type="text/javascript" src="../resources/js/fileDelete.js"></script>
</body>
</html>