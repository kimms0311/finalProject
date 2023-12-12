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
	
	
<%--    	<!-- 검색라인 -->
	<div class="col-sm-12 col-md-6">
		<form action="/board/list" method="get">
			<div class="input-group mb-3">
			<c:set value="${ph.pgvo.type}" var="typed"></c:set>
				<select class="form-select" name="type" id="inputGroupSelect01">
		    		<option ${typed eq null ? 'selected' : '' }>Choose...</option>
		    		<option value="t" ${typed eq 't' ? 'selected' : '' }>제목</option>
		    		<option value="w" ${typed eq 'w' ? 'selected' : '' }>작성자</option>
		    		<option value="c" ${typed eq 'c' ? 'selected' : '' }>내용</option>
		    		<option value="tw" ${typed eq 'tw' ? 'selected' : '' }>제목 + 작성자</option>
		    		<option value="tc" ${typed eq 'tc' ? 'selected' : '' }>제목 + 내용</option>
		    		<option value="cw" ${typed eq 'cw' ? 'selected' : '' }>내용 + 작성자</option>
		    		<option value="twc" ${typed eq 'twc' ? 'selected' : '' }>모두</option>
	  			</select>
	        	<input class="form-control me-2" name="keyword" type="search" value="${ph.pgvo.keyword }" placeholder="Search" aria-label="Search">
	        	<input type="hidden" name="pageNo" value="1">
	        	<input type="hidden" name="qty" value="${ph.pgvo.qty }">
	        	<button class="btn btn-outline-success" type="submit">
	        		Search
	        		<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
    					${ph.totalCount }
    				<span class="visually-hidden">unread messages</span>
  					</span>
	        	</button>
	        </div>
	      </form>
      </div> --%>
      
      
	<!-- 인기 당근알바 출력 리스트 -->
	<h3>우리동네 인기알바</h3>
	<div class="brdListArea" id="hotJobList">
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
	                        <span class="d-inline-block text-truncate" style="max-width: 200px;">${jbdto.pbvo.proSido} ${jbdto.pbvo.proSigg} ${jbdto.pbvo.proEmd}</span>
	                        <span>${jbdto.pbvo.proMenu}
	                            <strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${jbdto.pbvo.proPrice}" />원</strong>
	                        </span>
	                    </div>
	                </a>
	            </div>
	        </c:if>
	    </c:forEach>
	</div>
	
 	<div class="allBtns">
		<button type="button" class="cateBtns" id="all" value="null">전체</button>
		<button type="button" class="cateBtns" id="food" value="food">외식.음료</button>
		<button type="button" class="cateBtns" id="shop" value="shop">매장관리.판매</button>
		<button type="button" class="cateBtns" id="service" value="service">서비스</button>
		<button type="button" class="cateBtns" id="office" value="office">사무직</button>
		<button type="button" class="cateBtns" id="product" value="product">생산.건설</button>
		<button type="button" class="cateBtns" id="driver" value="driver">운전.배달</button>
		<button type="button" class="cateBtns" id="education" value="education">교육.강사</button>
		<button type="button" class="cateBtns" id="etc" value="etc">기타</button>
	</div>

	<select id="sort" class="sortSelect" name="sort">
		<option value="newest">최신순</option>
		<option value="oldest">오래된 순</option>
		<option value="hotest">인기순</option>
	</select>

	<!-- 우리동네 알바 출력 리스트 -->                                                                                                                                                                                                                                                                                                                                                                                                   
 	<h3>우리동네 알바</h3>
	<div class="brdListArea" id="jobList">
	    <!-- js로 button에 따라 list출력 -->
	</div>
	
	<button type="button" id="moreBtn" class="btn btn-success" onclick="loadMore()">더 보기</button>
	
</div>
<script src="/resources/js/jobBoardList.js"></script>
<script type="text/javascript">
getJobList();
</script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>