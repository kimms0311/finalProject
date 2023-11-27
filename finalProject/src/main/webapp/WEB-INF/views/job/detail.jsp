<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>job register page</title>
<style type="text/css">
	#carouselExampleIndicators{
		margin-top: 50px;
	}

	.carousel-inner img {
		width: 100%;
		height: 600px;
		object-fit: cover;
		margin: 0 auto; /* 가운데 정렬을 위한 margin 설정 */
}
	
</style>
<link rel="stylesheet" href="/resources/css/page.css">
<link rel="stylesheet" href="/resources/css/job/jobDetail.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="bodyContainer">

	<!-- 첨부된 이미지 슬라이드로 뿌리기... -->
	
	<div id="carouselExampleIndicators" class="carousel slide">
	<c:set value="${jbdto.flist}" var="flist"></c:set>
		<div class="carousel-indicators">
			<c:forEach items="${flist}" var="fvo" varStatus="status">
				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${status.index}" class="${status.index == 0 ? 'active' : ''}" aria-label="Slide ${status.index + 1}"></button>
			</c:forEach>
		</div>
		<div class="carousel-inner">
			<c:forEach items="${flist}" var="fvo" varStatus="status">
				<c:choose>
					<c:when test="${fvo.fileType > 0}">
						<div class="carousel-item ${status.index == 0 ? 'active' : ''}">
							<img src="/upload/job/${fn:replace(fvo.saveDir,'\\','/')}/${fvo.uuid}_${fvo.fileName}" class="d-block" alt="Image ${status.index + 1}">
						</div>
					</c:when>
				</c:choose>
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
	
	
	<div class="profileSecction">
		<div class="userInfo">
			<span><i class="bi bi-person-circle"></i>${pbvo.proNickName}</span>
			<p>아보시 카도동</p>
		</div>
		<div class="userScore">
			별이다섯개
			<i class="bi bi-thermometer-half"></i>매너점수
		</div>
	</div>
	<hr>
	
	<div class="jobTitleSecction">
		<h1>${jbdto.pbvo.proTitle}</h1>
		<p>${jbdto.pbvo.proNickName } / ${jbdto.pbvo.proModAt }</p>
	</div>
	
	<div class="jobInfoSecction">
		<p><strong><i class="bi bi-coin"></i>${jbdto.pbvo.proMenu}
		<fmt:formatNumber type="number" maxFractionDigits="3" value="${jbdto.pbvo.proPrice}" />원</strong></p>
		<p><i class="bi bi-geo-alt">${jobAddress }</i> </p>
		<p><i class="bi bi-calendar-check"></i>근무요일</p>
		<p><i class="bi bi-clock"></i>근무시간</p>
		
		<div class="jobInfoDetail">
			<p><strong><i class="bi bi-pencil"></i>상세내용<i class="bi bi-pencil"></i></strong></p>
			<p>${jbdto.pbvo.proContent}</p>
			<p>
			조회수 ${jbdto.pbvo.proReadCnt} <a href="/job/like?pbno=${jbdto.pbvo.proBno}"><i class="bi bi-heart"></i>찜하기 ${pbvo.proLikeCnt}</a>
			</p>
		</div>
		
		<!-- 지도 넣으면 좋겠다. -->
	</div>
	

	
	
	<!--
	멤버이메일이랑 pbvo이메일 같으면 보이게하는걸로 바꿀거야 
	 -->
		<a href="/job/modify?proBno=${jbdto.pbvo.proBno}"><button class="btn btn-success">수정</button></a>
		<a href="/job/remove?proBno=${jbdto.pbvo.proBno}"><button class="btn btn-success">삭제</button></a>

	
	<!-- 후기 라인 -->
	<div class="container">
	<!-- 평가 -->
	<span><strong>후기</strong></span>
		<!-- 후기 등록 라인 -->
		<div class="rePost">
			<img alt="" src="/resources/image/logoimage.png">
			<span id="reWriter"><strong>nickName </strong></span>
			<input type="text" placeholder="후기를 작성해주세요." id="reContent">
			<button type="button" class="btn btn-success" id="rePostBtn">등록</button>
		</div>
		
		<!-- 후기 표시 라인 -->
		<ul class="list-group list-group-flush" id="reListArea">
		  <li class="list-group-item">
		  	<div class="mb-3 reWriterInfo">
			  	<img alt="" src="/resources/image/logoimage.png">
				<span><strong>reUserId </strong></span>
				<p class="badge rounded-pill text-bg-dark">구월동</p>
				<p class="badge rounded-pill text-bg-dark">regAt</p>
		  	</div>
		  	<span>여기서 일하지마세요 ㅋㅋ </span>
		  </li>
		</ul>
		<!-- 후기 페이징 라인 -->
		<div>
			<button type="button" id="moreBtn" data-page="1" 
			 class="btn btn-outline-dark" style="visibility:hidden">더보기</button>
		</div>
		
	</div>


	
	
	
</div>

<script type="text/javascript">
    let proBnoVal = `<c:out value="${jbdto.pbvo.proBno}"/>`;
    console.log(proBnoVal);
</script>

<script type="text/javascript">
    /* 이미지 클릭했을 때 원본이미지 모달창 */
    $(document).ready(function() {
        $("span img").click(function() {
            let img = new Image();
            img.src = $(this).attr("src");
            $('.modalBox').html(img);
            $(".modal").show();
        });
        
        // 모달 클릭하면 이미지 닫음
        $(".modal").click(function(e) {
            $(".modal").toggle();
        });
    });
</script>


<script type="text/javascript" src="/resources/js/jobBoardRegister.js"></script>
<script type="text/javascript" src="/resources/js/jobBoardComment.js"></script>

 <jsp:include page="../common/footer.jsp" />

</body>
</html>