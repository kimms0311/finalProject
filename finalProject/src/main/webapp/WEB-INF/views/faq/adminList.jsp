<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 FAQ 리스트</title>
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
	
	/* 검색라인 */
	.searchLine{
		width: 80%;
		display: flex;
		justify-content: center;
		flex-wrap: wrap;
	}
	.faqT{
		width: 650px;
		margin: 20px 0;
	    font-size: 23px;
	    font-weight: 800;
	}
	.searchBox{
		display: inline-block;
	    width: 650px;
	    height: 40px;
	    border-radius: 5px;
	    background-color: #f1f4f6;
	}
	.searchIcon{
		padding: 0 3px 0 15px;
	    font-size: 13px;
	    color: gray;
	}
	.searchInput{
		width: 600px;
		border: none;
		background: none;
	    font-size: 14px;
	    line-height: 40px;
	}
	.searchBtn{
	    border: none;
	    background: none;
	    color: #a2a2a2;
	    position: absolute;
	    margin-top: 7px;
	    margin-left: -35px;
    }
	
	/* 카테고리 라인 */
	.faqCategory{
		margin: 30px 0;
		width: 80%;
		display: flex;
		justify-content: center;
	}
	.category{
		text-decoration: none;
    	color: #909090;
		border: 1px solid #d3d3d3;
	    border-radius: 100px;
	    padding: 5px 10px;
	    margin: 0 10px;
	    font-size: 15px;
	}
	.category:hover{
		background-color: #d3d3d3;
	}
	.faqActive{
		background-color: #d3d3d3;
		color: white;
	}
	
	/* faq 게시글 라인 */
	.faqBoardLine{
		width: 80%;
		display: flex;
		justify-content: center;
	}
	.faqBoards{
		margin: 0;
		padding: 0;
		width: 650px;
		font-size: 0;
	}
	.faqLi{
		font-size: 14px;
	}
	.questionBtn{
		width: 650px;
    	height: 70px;
    	display: flex;
    	justify-content: space-between;
    	border: none;
    	border-bottom: 1px solid lightgrey;
    	padding: 16px 20px;
    	align-items: center;
    	background: none;
	}
	.qLeft p{
		margin: 0;
	}
	.qTitle{
		font-size: 14px;
		text-align: left;
	}
	.qCategory{
		font-size: 13px;
	    text-align: left;
	    color: gray;
	}
	.answerArea{
		width: 650px;
	    background-color: #f1f4f6;
	    resize: none;
	    border: none;
	    padding: 20px;
	    font-size: 14px;
	}
	.answerArea:focus{
		outline: none;
	}
	
	/* 검색 결과 없을 때 */
	.noBoard{
	    font-size: 17px;
	    text-align: center;
	    height: 300px;
	    line-height: 300px;
	}
	
	/* 문의버튼 라인 */
	.csButtons{
		margin: 30px 0 30px 0;
		width: 80%;
		display: flex;
		justify-content: center;
	}
	.csBtn1, .csBtn2{
	    width: 320px;
	    height: 40px;
	    background: none;
	    border: 1px solid #d3d3d3;
	    border-radius: 5px;
	}
	.csBtn1{
		margin-right: 3px;
	}
	.csBtn2{
		margin-left: 3px;
	}
	
	/* 고정 nav */
	.faqWriteBtn{
		position: fixed;
		right: 0;
		bottom: 0;
	}
</style>
</head>
<body>
<jsp:include page="../common/header.jsp" />

<div class="bodyContainer">

<div class="topLine">
	<p class="pageName">관리자 FAQ 리스트</p>
</div>
	
<div class="faqCategory">
	<a href="/faq/adminList?faqCategory=전체" class="category faqActive">전체</a>
	<a href="/faq/adminList?faqCategory=이용문의" class="category">이용문의</a>
	<a href="/faq/adminList?faqCategory=거래문의" class="category">거래문의</a>
	<a href="/faq/adminList?faqCategory=회원/계정" class="category">회원/계정</a>
	<a href="/faq/adminList?faqCategory=운영정책" class="category">운영정책</a>
	<a href="/faq/adminList?faqCategory=기타" class="category">기타</a>
</div>
 
<div class="faqBoardLine">
	<ul class="faqBoards">
		<c:forEach items="${list }" var="bvo" varStatus="status">
			<li class="faqLi" id="${status.index }">
				<button class="questionBtn">
					<div class="qLeft">
						<p class="qTitle">${bvo.faqTitle }</p>
						<p class="qCategory">${bvo.faqCategory }</p>
					</div>
					<i class="bi bi-chevron-up qRight" id="up-${status.index }"></i>
				</button>
				<textarea class="answerArea" readonly="readonly" id="text-${status.index }">${bvo.faqContent }</textarea>
			</li>
		</c:forEach>
	</ul>
</div>

	
</div>
<!-- 여기까지 bodyContainer -->

<jsp:include page="../common/footer.jsp" />
<script type="text/javascript" src="/resources/js/faqBoardList.js"></script>
</body>
</html>