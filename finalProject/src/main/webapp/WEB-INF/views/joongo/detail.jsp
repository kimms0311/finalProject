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
<style>
	#carouselExampleIndicators{
		margin-top: 50px;
		width: 50%;
		margin: 0 auto;
	}

	.carousel-inner img {
		width: 100%;
		height: 600px;
		object-fit: cover;
		margin: 0 auto;
	}
	.bodyContainer > .profile > img{
		width: 50px;
		height: 50px;
		border-radius: 25px;
	}
	.prodArea > .no-login{
		color: #d3d3d3;
	}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">
	<!-- 상품이미지 여러 개일 경우 슬라이더 -->
			<div id="carouselExampleIndicators" class="carousel slide">
			  <div class="carousel-indicators">
				<c:forEach items="${flist }" var="fvo" varStatus="status">
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${status.index}" class="${status.index == 0 ? 'active' : ''}" aria-label="Slide ${status.index + 1}"></button>
				</c:forEach>
			  </div>
			  <div class="carousel-inner">
				  <c:forEach items="${flist }" var="fvo" varStatus="status">
				    <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
				      <img src="/upload/product/${fn: replace(fvo.saveDir, '\\', '/')}/${fvo.uuid}_${fvo.fileName}" alt="그림 없음">
				    </div>
				  </c:forEach>
			  </div>
			  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Previous</span>
			  </button>
			  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Next</span>
			  </button>
			</div>
	<div class="profile">
		<img src="../resources/image/logoimage.png" class="card-img-top" alt="프로필 이미지">
		<p>${pbvo.proNickName }</p>
		<p>${pbvo.proSido } ${pbvo.proSigg }</p>
		<p>조회 ${pbvo.proReadCnt }</p>
		<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal.mvo.memEmail" var="authEmail"/>
			<c:if test="${pbvo.proEmail ne authEmail}">
				<!-- 글 작성자가 아닐 경우에만 띄울 버튼 -->
				<button type="button" class="btn btn-outline-warning">채팅하기</button>					
			</c:if>
		</sec:authorize>
	</div>
	<div class="prodArea">
		<sec:authorize access="isAnonymous()">
			<i class="bi bi-heart-fill no-login"></i>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
			<i class="bi bi-heart${checkLike == 1 ? '-fill' : ''}"></i>
		</sec:authorize>
		
		<h3>${pbvo.proTitle }</h3>
		<p>${pbvo.proMenu } * ${pbvo.proRegAt }</p>
		<h3>${pbvo.proPrice }</h3>
		<textarea cols="30" rows="10" readonly>${pbvo.proContent }</textarea>
	</div>
	
	<sec:authorize access="isAuthenticated()">
		<c:if test="${pbvo.proEmail eq authEmail}">
			<!-- 글 작성자에게만 띄울 버튼 -->
			<a href="/joongo/modify?proBno=${pbvo.proBno }"><button type="submit" class="btn btn-success">수정</button></a>
			<a href="/joongo/remove?proBno=${pbvo.proBno }"><button type="button" class="btn btn-danger">삭제</button></a>		
		</c:if>
	</sec:authorize>
	
</div>
<jsp:include page="../common/footer.jsp" />
<script>
const bnoVal = `<c:out value="${pbvo.proBno}" />`;
const userEmail = `<c:out value="${authEmail}" />`;
</script>
<script src="/resources/js/likeItem.js"></script>
</body>
</html>