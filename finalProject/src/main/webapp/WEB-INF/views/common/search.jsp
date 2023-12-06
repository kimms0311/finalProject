<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<section class="bodyContainer searchArea">
	<c:choose>
		<c:when test="${fn:contains(category, 'joongo')}">
			<h2>중고거래</h2>
			<div>
				<c:forEach items="${pbvo}" var="bvo">
					<c:if test="${bvo.proCategory eq 'joongo'}">
						<p>${bvo.proTitle}</p>
					</c:if>
				</c:forEach>
			</div>
		</c:when>
		
		<c:when test="${fn:contains(category, 'job')}">
			<h2>알바구인</h2>
			<div class="job">
				<c:forEach items="${pbvo}" var="bvo">
					<c:if test="${bvo.proCategory eq 'job'}">
						<p>${bvo.proTitle}</p>
					</c:if>
				</c:forEach>
			</div>
		</c:when>
		
		<c:when test="${fn:contains(category, 'store')}">
			<h2>동네업체</h2>
			<div class="store">
				<c:forEach items="${pbvo}" var="bvo">
					<c:if test="${bvo.proCategory eq 'store'}">
						<p>${bvo.proTitle}</p>
					</c:if>
				</c:forEach>
			</div>
		</c:when>
		<c:otherwise>
			<!-- 현재 product board 검색결과만 판단. 이후 수정 -->
			<p>검색 결과가 없습니다.</p>
			<p>검색어가 올바르게 입력되었는지 확인해 주세요.</p>
		</c:otherwise>
	</c:choose>
	
	<h2>동네소식</h2>
	<div class="community">
		<p>검색 결과가 없습니다.</p>
	</div>
	
	
	<h2>공지사항</h2>
	<div class="info">
		<p>검색 결과가 없습니다.</p>
	</div>
	
</section>
<jsp:include page="../common/footer.jsp" />
</body>
</html>