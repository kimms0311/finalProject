<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CS List</title>
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
	
	/* 문의리스트 */
	.csBoardLine{
	    width: 80%;
	    display: flex;
	    justify-content: center;
	}
	.csBoardUl{
		margin: 0;
	    padding: 0;
	    width: 650px;
	}
	.csBoardUl a {
		color: black;
		text-decoration: none;
	}
	.csLi{
		display: flex;
		justify-content: space-between;		
		align-items: center;
		padding: 20px 10px;
	    border-bottom: 1px solid lightgray;
	}
	.firstLine{
		margin-bottom: 5px;
	}
	.csTitle{
		display: inline;
	}
	.isAns{
		background-color: lightgray;
	    font-size: 12px;
	    border-radius: 5px;
    	padding: 2px;
	}
	.ansOk{
		background-color: #c0e265;
	}
	.secondLine{
		font-size: 12px;
	}
	
	/* 문의가 없을 때 */
	.csLi-no{
		display: flex;
		justify-content: center;	
		padding: 150px;
	}
	.noBoard{
		margin: 0;
		font-size: 15px;
	}
	
	/* 버튼라인 */
	.bottonLine{
	    width: 80%;
	    display: flex;
	    justify-content: center;
	}
	.faqBtn{
		width: 650px;
	    height: 45px;
	    border: none;
	    border-radius: 5px;
	    margin: 20px;
	    color: white;
	    background-color: #5d5d5d;
	}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">

<div class="topLine">
	<p class="pageName">문의내역</p>
</div>

<div class="csBoardLine">
	<ul class="csBoardUl">
		<c:forEach items="${list }" var="bvo">
			<a href="/cs/detail?csBno=${bvo.csBno }">
				<li class="csLi">
					<div>
						<div class="firstLine">
							<p class="csTitle">${bvo.csTitle } </p>
							<c:if test="${bvo.csIsAns eq 'N' }">
								<span class="isAns">미답변</span>
							</c:if>
							<c:if test="${bvo.csIsAns eq 'Y' }">
								<span class="isAns ansOk">답변완료</span>
							</c:if>
						</div>
						<div class="secondLine">
							<span>${bvo.csCategory } | </span>
							<span>${bvo.csRegAt }</span>
						</div>
					</div>
					<i class="bi bi-chevron-right"></i>
				</li>
			</a>
		</c:forEach>
		<c:if test="${list.size() == 0 }">
			<li class="csLi-no">
				<p class="noBoard">문의내역이 없습니다.</p>
			</li>
		</c:if>
	</ul>
</div>
<div class="bottonLine">
	<a href="/faq/list">
		<button type="button" class="faqBtn">FAQ</button>
	</a>
</div>

</div>
<jsp:include page="../common/footer.jsp" />
</body>
</html>