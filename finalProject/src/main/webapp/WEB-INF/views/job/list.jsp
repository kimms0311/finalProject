<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>job list page</title>
<link rel="stylesheet" href="/resources/css/page.css">
<link rel="stylesheet" href="/resources/css/job/jobListPage.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">
	<!-- 메인 이벤트 페이지 -->
	<div class="jobListPart"  style="background-image: url('https://img1.daumcdn.net/thumb/R1280x0/?fname=http://t1.daumcdn.net/brunch/service/user/6H5a/image/CnQJJgE1yTpFPvPdKB0Pi5jms2A.png')">
		<h3>우리동네에서 찾는 알바카도</h3>
		<a href="/job/register" ><button type="button" class="btn btn-success">공고 올리기</button></a>
		<a href="#" ><button type="button" class="btn btn-success" >알바카도 활용법</button></a>
	</div>
   
	<!-- 인기 당근알바 출력 리스트 -->
	<c:set value="${jbdto.flist }" var="flist"></c:set>
	<h3>우리동네 인기 알바</h3>
	<div class="hotJobList">
		<c:forEach items="${list }" var="pbvo" varStatus="loopStatus">
			<c:if test="${loopStatus.index < 8}">
				<div class="hotJobListContent">
					<a href="/job/detail?proBno=${pbvo.proBno}">
						<img alt="hot job image error" src="/upload/product/${fn:replace(fvo.saveDir,'\\','/')}/${fvo.uuid}_${fvo.fileName}">
						<div class="jobInfoArea">
							<span>${pbvo.proTitle }</span>
							<span class="d-inline-block text-truncate" style="max-width: 200px;">인천시 서구 남산돈까스 갑자기 생각났동 258-71번지 원조돈까스</span>
							<span>${pbvo.proMenu}</strong>
							<fmt:formatNumber type="number" maxFractionDigits="3" value="${pbvo.proPrice}" />원</span>
						</div>
					</a>
				</div>
			</c:if>
		</c:forEach>
	</div>

	<!-- 우리동네 알바 출력 리스트 -->                                                                                                                                                                                                                                                                                                                                                                                                   
	<h3>우리동네 알바</h3>
	<div class="jobList" id="brdListArea">
		<c:forEach items="${list}" var="pbvo" begin="0" end="7">
	 		<div class="jobListContent">
				<a href="/job/detail?proBno=${pbvo.proBno}">
					<img alt="job image error" src="../resources/image/logoimage.png">
					<div class="jobInfoArea">
						<span>${pbvo.proTitle }</span>
						<span class="d-inline-block text-truncate" style="max-width: 200px;">주소</span>
						<span>${pbvo.proMenu}
							<fmt:formatNumber type="number" maxFractionDigits="3" value="${pbvo.proPrice}" />원</span>
						</div>
				</a>
			</div>
		</c:forEach>
	</div>
	<button type="button" id="moreBtn" class="btn btn-success" onclick="loadMore()">더 보기</button>
	
</div>
<jsp:include page="../common/footer.jsp" />
</body>
</html>
