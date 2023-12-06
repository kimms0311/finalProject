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
<link rel="stylesheet" href="/resources/css/jobListPage.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />
   <div id="loading">
      <!-- 로딩페이지 -->
   </div>
<div class="bodyContainer">
	<!-- 메인 이벤트 페이지 -->
	<div class="jobListPart" style="background-image: url('https://img1.daumcdn.net/thumb/R1280x0/?fname=http://t1.daumcdn.net/brunch/service/user/6H5a/image/CnQJJgE1yTpFPvPdKB0Pi5jms2A.png')">
		<h3>우리동네에서 찾는 알바카도</h3>
		<a href="/job/register" ><button type="button" class="btn btn-success">공고 올리기</button></a>
		<a href="/job/about" ><button type="button" class="btn btn-success" >알바카도 활용법</button></a>
	</div>
   
	<!-- 인기 당근알바 출력 리스트 -->
	<h3>우리동네 인기알바</h3>
	<div class="hotJobList" id="brdListArea">
	    <c:forEach items="${list}" var="jbdto" varStatus="loopStatus">
	        <c:if test="${loopStatus.index < 8}">
	            <div class="hotJobListContent">
	                <a href="/job/detail?proBno=${jbdto.pbvo.proBno}">
	 				    <c:choose>
					        <c:when test="${not empty jbdto.flist}">
								<c:forEach items="${jbdto.flist}" var="flist">
						            <img alt="hot job image error" src="/upload/product/${fn:replace(flist.saveDir,'\\','/')}/${flist.uuid}_${flist.fileName}">
								</c:forEach>
					        </c:when>
					        <c:otherwise>
					            <!-- 비어 있는 경우 기본 이미지 출력 -->
					            <img alt="hot job image error" src="../resources/image/logoimage.png">
					        </c:otherwise>
					    </c:choose>
	
	                    <div class="jobInfoArea">
	                        <span>${jbdto.pbvo.proTitle}</span>
	                        <span class="d-inline-block text-truncate" style="max-width: 200px;">인천시 서구 남산돈까스 갑자기 생각났동 258-71번지 원조돈까스</span>
	                        <span>${jbdto.pbvo.proMenu}
	                            <strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${jbdto.pbvo.proPrice}" />원</strong>
	                        </span>
	                    </div>
	                </a>
	            </div>
	        </c:if>
	    </c:forEach>
	</div>


	<!-- 우리동네 알바 출력 리스트 -->                                                                                                                                                                                                                                                                                                                                                                                                   
 	<h3>우리동네 알바</h3>
	<div class="jobList" id="brdListArea">
	    <c:forEach items="${list}" var="jbdto" varStatus="loopStatus">
	        <c:if test="${loopStatus.index < 8}">
	            <div class="jobListContent">
	                <a href="/job/detail?proBno=${jbdto.pbvo.proBno}">
	 				    <c:choose>
					        <c:when test="${not empty jbdto.flist}">
								<c:forEach items="${jbdto.flist}" var="flist">
						            <img alt="job image error" src="/upload/product/${fn:replace(flist.saveDir,'\\','/')}/${flist.uuid}_${flist.fileName}">
								</c:forEach>
					        </c:when>
					        <c:otherwise>
					            <!-- 비어 있는 경우 기본 이미지 출력 -->
					            <img alt="job image error" src="../resources/image/logoimage.png">
					        </c:otherwise>
					    </c:choose>
	
	                    <div class="jobInfoArea">
	                        <span>${jbdto.pbvo.proTitle}</span>
	                        <span class="d-inline-block text-truncate" style="max-width: 200px;">인천시 서구 남산돈까스 갑자기 생각났동 258-71번지 원조돈까스</span>
	                        <span>${jbdto.pbvo.proMenu}
	                            <strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${jbdto.pbvo.proPrice}" />원</strong>
	                        </span>
	                    </div>
	                </a>
	            </div>
	        </c:if>
	    </c:forEach>
	</div>
	
	<button type="button" id="moreBtn" class="btn btn-success" onclick="loadMore()">더 보기</button>
	
</div>
<script type="text/javascript">
	window.onload = function() {
	    setTimeout(()=> document.getElementById('loading').style.display = 'none', 500);
	};
</script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>