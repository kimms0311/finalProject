<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community Detail</title>
<style type="text/css">
	.top_line>*, .top_line div>*, .under_line>* {
		display: inline;
	}
	.cmCon{
		margin: 10px;
	}
	.dropdown{
		display: inline;
	}
	.boardLine{
		border: 1px solid black;
		border-radius: 3px;
		width: 900px;
		
	}
	.re-comment{
		margin-left: 30px;
	}
	.bi-heart, .bi-heart-fill{
		cursor: pointer;
		color: red;
	}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<c:set value="${bdto.bvo}" var="bvo" />

<div class="bodyContainer">

<!-- 게시판 라인 -->
<div class="boardLine">
	<div class="top_line">
		<i class="bi bi-person-circle"></i>
		<div class="u">
			<b>${bvo.cmNickName}</b>
			<p>${bvo.cmEmd }</p>
			<p>${bvo.cmRegAt }</p>
		</div>
		<div class="c">
			<!-- 만약 내가 쓴 글이면 ...이 오게 해서 누르면 수정, 삭제 선택할 수 있도록 -->
			<a href="#" class="chat">채팅</a>
			<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal.mvo.memEmail" var="authEmail" />
			<sec:authentication property="principal.mvo.memNickName" var="authNick" />
			<c:if test="${bvo.cmNickName eq authNick }">
				<div class="dropdown">
				  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
				    ...
				  </button>
					  <ul class="dropdown-menu">
					    <li><a class="dropdown-item" href="/community/modify?cmBno=${bvo.cmBno }">수정</a></li>
					    <li><a class="dropdown-item" href="/community/remove?cmBno=${bvo.cmBno }">삭제</a></li>
					  </ul>
				</div>
			</c:if>
			</sec:authorize>
		</div>
	</div>
	
	<div class="middle_line">
		<b>${bvo.cmTitle }</b> <br>
		<p>${bvo.cmContent }</p>
		<!-- 파일 -->
		<c:set value="${bdto.flist }" var="flist" />
		<c:if test="${flist.size() > 0 }">
			<c:forEach items="${flist }" var="fvo">
				<c:choose>
					<c:when test="${fvo.fileType > 0 }">
						<div>
							<img alt="그림없음" src="/upload/community/${fn:replace(fvo.saveDir,'\\','/')}/${fvo.uuid}_th_${fvo.fileName}">
						</div>					
					</c:when>
				</c:choose>
			</c:forEach>
		</c:if>
	</div>
	
	<div class="under_line">
		<i class="bi bi${checkLike > 0 ? '-heart-fill' : '-heart' }" id="likeBtn"></i>		
		<p id="cmLikeCnt">${bvo.cmLikeCnt }</p>
		<p>댓글 ${bvo.cmCmtCnt }</p>
	</div>
</div>

<!-- 댓글 라인 -->
<div class="commentLine">
	<!-- 댓글 작성 라인 -->
	<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.mvo.memEmail" var="authEmail" />
	<sec:authentication property="principal.mvo.memNickName" var="authNick" />
	<div class="input-group mb-3 commentWrite">
		<input type="hidden" id="cmtEmail" value="${authEmail }">
		<span class="input-group-text" id="cmtWriter">${authNick }</span>
		<input type="text" class="form-control" id="cmtText" placeholder="Add Comment">
		<button type="button" id="cmtPostBtn" class="btn btn-secondary">등록</button>
	</div>
	</sec:authorize>	
	<!-- 댓글 표시 라인 -->
	<ul class="list-group" id="cmtListArea">
		<li class="list-group-item">
			<div>
				<div class="fw-bold">
					<i class="bi bi-person-circle"></i>
					Writer 
					<span class="badge rounded-pill text-bg-success">2023-11-17</span>
					<div class="dropdown">
					  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
					    ...
					  </button>
					  <ul class="dropdown-menu">
					    <li><a class="dropdown-item" href="#">수정</a></li>
					    <li><a class="dropdown-item" href="#">삭제</a></li>
					  </ul>
					</div>
				</div>
				<div class="cmCon">
					Content
				</div>
				<div>
					<a href="#" id="reCmtBtn">답글쓰기</a>
				</div>
			</div>
		</li>
	</ul>
	
	<!-- 모달창 라인 -->
	<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.mvo.memEmail" var="authEmail" />
	<sec:authentication property="principal.mvo.memNickName" var="authNick" />
	<div class="modal" tabindex="-1" id="myModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <h5 class="modal-title">${authNick }</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      
	      <div class="modal-body">
	        <div class="input-group mb-3">
	        	<input type="text" class="form-control" id="cmtTextMod">
	        </div>
	      </div>
	      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" id="cmtModBtn">수정</button>
	      </div>
	      
	    </div>
	  </div>
	</div>
	</sec:authorize>
	
	<!-- 페이징 라인 -->
	<div class="more">
		<div>
			<button type="button" id="moreBtn" data-page="1"
			class="btn btn-outline-secondary moreBtn" style="visibility:hidden">MORE+</button>
		</div>		
	</div>
	
</div>




</div>
<!-- bodyContainer -->
<jsp:include page="../common/footer.jsp" />

<script type="text/javascript">
//bno 보내주기
let bnoVal = `<c:out value="${bvo.cmBno}"/>`;
console.log(bnoVal);

let userEmail = `<c:out value="${authEmail}"/>`;
let userNick = `<c:out value="${authNick}"/>`;
</script>

<!-- 좋아요 -->
<script type="text/javascript" src="/resources/js/communityBoardLike.js"></script>

<!-- 댓글 -->
<script type="text/javascript" src="/resources/js/communityComment.js"></script>
<script type="text/javascript">
spreadCommentList(bnoVal);
</script>

</body>
</html>