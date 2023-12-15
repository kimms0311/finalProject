<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CS Detail</title>
<style type="text/css">
	@font-face {
	    font-family: 'SUIT-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
	}	
	
	.bodyContainer{
		font-family: 'SUIT-Regular';
		display: flex;
		justify-content: center;
		flex-wrap: wrap;
	}
	
	/* 젤 위에 라인 */
	.topLine{
		margin-top: 60px;
		width: 650px;
		display: flex;
		justify-content: center;
		border-bottom: 1px solid black;
	}
	.pageName{
		font-size: 23px;	    
		font-weight: 800;
	}
	
	/* detail 라인 */
	.detailLine{
		width: 80%;
	    display: flex;
	    justify-content: center;
	}
	.detailBoard{
		width: 650px;
		border-bottom: 1px solid lightgray;
	}
	.csMenu{
		display: block;
		background-color: #f1f4f6;
	    width: 70px;
	    text-align: center;
	    border-radius: 50px;
	    padding: 3px;
	    font-size: 14px;
	    margin: 30px 0 5px 0;
	    color: gray;
	}
	.Q{
		font-weight: 800;
		font-size: 25px;
	}
	.csTitle{
		display: inline;
	}
	.contentTitle{
		margin: 10px 0 5px 0;
	    font-size: 14px;
	}
	.csTextAreas{
		resize: none;
	    border: none;
	    padding: 0;
	    font-size: 14px;
	    background: none;
	    overflow: hidden;
	    width: 100%;
	}
	.csTextAreas:focus {
		outline: none;
	}
	.imgDiv{
		margin: 20px 0;
	}
	.cs_imgs{
		display: inline;
		border-radius: 5px;
	}
	.csReg{
		margin: 0 0 20px 0;
	    font-size: 12px;
	    color: gray;
	}

	/* 답변 작성 라인 */
	.commentWriteLine {
		width: 80%;
    	margin-top: 30px;
    	display: flex;
    	justify-content: center;
   	}
   	.commentWrite{
    	width: 650px;
		padding: 20px;
		border: 1px solid #e4e4e4;
		border-radius: 5px;
		position: relative;
	}
	.cmtText{
		font-size: 14px;
	    width: 100%;
		border: none;
		resize: none;    
		overflow: hidden;
	}
	.cmtText:focus{
	  	outline: none;
	}
	.cmtPostBtn{
		position: absolute;
		right: 0;
		bottom: 0;
		border: none;
	    background: none;
	    margin: 0 15px 15px 0;
		font-size: 14px;
	}
	
	/* 답변 라인 */
	.answerLine{
		margin: 30px 0;
		width: 650px;
	}
	.A{
		font-weight: 800;
		font-size: 25px;
		margin: 0;
	}
	.answerDiv{
		background-color: #f1f4f6;
		border-radius: 5px;
		padding: 20px;
	}
	.ansReg{
		margin: 10px 0 0 0;
	    font-size: 12px;
	    color: gray;
	}
	.noAnsText{
		font-size: 14px;
		margin: 0;
	}

	.bottonLine{
		width: 80%;
		display: flex;
		justify-content: center;
	}
	.OkBtn{
		width: 650px;
		border: none;
		border-radius: 5px;
		font-size: 14px;
		height: 45px;
		margin: 10px 0 20px 0;
		background-color: #3b3b3b;
		color: white;
	}
</style>
</head>
<body>
<c:set value="${bdto.bvo}" var="bvo" />
<c:set value="${bdto.flist }" var="flist" />
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">

<div class="topLine">
	<p class="pageName">문의내역 상세</p>
</div>

<div class="detailLine">
	<div class="detailBoard">
		<span class="csMenu">${bvo.csCategory }</span>
		<div>
			<span class="Q">Q. </span>
			<p class="csTitle">${bvo.csTitle }</p>
		</div>
		<p class="contentTitle">문의 내용: </p>
		<textarea class="csTextAreas" readonly="readonly">${bvo.csContent }</textarea>
		<!-- 파일 -->
		<c:if test="${flist.size() > 0 }">
			<div class="imgDiv">
				<c:forEach items="${flist }" var="fvo">
					<c:choose>
						<c:when test="${fvo.fileType > 0 }">
							<img class="cs_imgs" alt="그림없음" src="/upload/cs/${fn:replace(fvo.saveDir,'\\','/')}/${fvo.uuid}_th_${fvo.fileName}">
						</c:when>
					</c:choose>
				</c:forEach>
			</div>					
		</c:if>
		<p class="csReg">${bvo.csRegAt }</p>
	</div>
</div>

<!-- 답변 작성 라인 : ADMIN만 보이게 -->
<sec:authentication property="principal.mvo.memEmail" var="authEmail" />
<sec:authorize access="hasAuthority('ROLE_ADMIN')">
<c:if test="${bvo.csIsAns eq 'N' }">
<div class="commentWriteLine">
	<div class="commentWrite">
		<input type="hidden" id="cmtEmail" value="${authEmail }">
		<textarea class="cmtText csTextAreas" id="cmtText" placeholder="답변 작성"></textarea>
		<button type="button" id="cmtPostBtn" class="cmtPostBtn">등록</button>
	</div>
</div>
</c:if>
</sec:authorize>

<!-- 댓글 표시 라인 -->
<div class="answerLine" id="answerLine">

</div>

<div class="bottonLine">
	<a href="/cs/list?csEmail=${authEmail }">
		<button type="button" class="OkBtn">확인</button>
	</a>
</div>

</div>
<!-- 여기까지 bodyContainer -->
<jsp:include page="../common/footer.jsp" />
<script type="text/javascript">
let bnoVal = `<c:out value="${bvo.csBno}"/>`;
</script>
<script type="text/javascript" src="/resources/js/csBoardDetail.js"></script>
<script type="text/javascript">
spreadCommentList(bnoVal);
</script>
</body>
</html>