<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Store Detail</title>
<link rel="stylesheet" href="../resources/css/storeBoardDetail.css">
</head>
<body class="bodyContainer">
<jsp:include page="../common/header.jsp" />
<c:set value="${sdto.pvo }" var="svo"></c:set>
<c:set value="${email }" var="email"></c:set>

<div>
	<div>${svo.proTitle}</div>
	<div>${svo.proNickName} · ${svo.proEmd} · ${svo.proMenu} · 조회수 : ${svo.proReadCnt}</div>
</div>

<!-- 사진 -->
 <c:set value="${sdto.flist }" var="flist"></c:set>
 <div>
 	<ul>
 		<c:forEach items="${flist }" var="fvo">
 			<li>
 				<c:choose>
 					<c:when test="${fvo.fileType > 0 }">
 						<div>
 							<img alt="없음." src="/upload/product/${fn:replace(fvo.saveDir,'\\','/')}/${fvo.uuid}_${fvo.fileName}">
 						</div>
 					</c:when>
 					<c:otherwise>
  					</c:otherwise>
 				</c:choose>
 			</li>
 		</c:forEach>
 	</ul>
 </div>

<div>
<h4>정보</h4>
<div style="white-space:pre;">${svo.proContent}</div>
<br>
<c:set value="${sdto.mlist }" var="mlist"></c:set>
<c:if test="${not empty mlist}">
<h4>메뉴</h4>
<div>
    <ul>
        <c:forEach items="${mlist}" var="mvo">
            <li>
               <span>메뉴 : ${mvo.strMenu}</span>
               <span>가격: ${mvo.strPrice}</span>
               <span>설명: ${mvo.strExplain}</span>
            </li>
        </c:forEach>
    </ul>
</div>
</c:if>
</div>

<div id="likeContainer">
<i id="like" class="bi bi-heart"></i>
<span id="likeCount">${svo.proLikeCnt}</span>
</div>

<c:if test="${email == svo.proEmail}">
<a href="/store/repost?bno=${svo.proBno }">끌올</a>
<a href="/store/modify?bno=${svo.proBno }">수정</a>
<a href="/store/remove?bno=${svo.proBno }" id="delBtn">삭제</a>
</c:if>

<script>
let user = `<c:out value="${email}"/>`;
let bno = `<c:out value="${svo.proBno}"/>`;
let likeCnt = `<c:out value="${svo.proLikeCnt}"/>`;
</script>
<script type="text/javascript" src="/resources/js/storeBoardDetail.js">
</script>
<script type="text/javascript">
checkLike(user, bno);
</script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>