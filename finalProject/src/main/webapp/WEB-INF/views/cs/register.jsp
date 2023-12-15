<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CS Register</title>
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
	
	.topLine2{
		width: 80%;
		display: flex;
		justify-content: center;
		font-size: 14px;
	    padding: 10px 210px 0 0;
	}
	.ment{
		display: inline;
		padding-left: 10px;
    	margin: 0;
	}

	/* 작성라인 */
	.formLine{
		width: 650px;
		display: flex;
		justify-content: center;
		margin: 40px 0;
		font-size: 0px;
	}
	form{
		width: 100%;
	}
	.titleInput, .csMenu, .fileInput{
	width: 100%;
	height: 48px;	
	padding: 10px 15px;
	border-radius: 5px;
	border: solid 1px #e5e5e5;
	font-size: 14px;
	margin-bottom: 15px;
	}
	.csMenu{
		cursor: pointer;
	}
	.csMenu:focus{
		outline: none;
	}
	.contentInput{
		width: 100%;
	    padding: 15px;
		border-radius: 5px;
	    resize: none;
		overflow:hidden;
		border: solid 1px #e5e5e5;
		font-size: 14px;
		margin-bottom: 20px;
	}
	.contentInput:focus{
		outline: none;
	}
	
	/*  */
	/* 파일 */
.fileForm{
	display: flex;
	justify-content: flex-start;
	margin: 0;
}
.fileInput {
    width: calc(100% - 120px); /* 버튼의 너비를 뺀 나머지만 차지하도록 함 */
    box-sizing: border-box; /* width와 height에 padding과 border를 포함하도록 함 */
    margin-right: -4px; /* 인라인 요소의 간격을 없애기 위해 마진을 음수로 설정 */
	border-radius: 5px 0 0 5px;
	margin-bottom: 0;
}
.fileBtn{
    width: 130px; 
	height: 48px;
	border-radius: 0 5px 5px 0;
	border: none;
	background-color: #c4c4c4;
	color: white;
    display: inline-block;
	font-size: 14px;
}
.fileZone{
	border-radius: 0 0 5px 5px;
	border-left: solid 1px #e5e5e5;
	border-right: solid 1px #e5e5e5;
	border-bottom: solid 1px #e5e5e5;
}
.imageUl{
	padding: 20px;
	margin: 0;
	font-size: 14px;
}
.imageLi{
	display: flex;
	justify-content: space-between;
	margin-bottom: 10px;	
	align-items: center;
}
.last-file{
	margin: 0;
}
.imageCancelBtn{
	border: none;
    border-radius: 5px;
    padding: 0;
    width: 30px;
    height: 30px;
    font-size: 13px;
    line-height: 30px;
	background-color: #e5e5e5;
	color: white;
}
.imageCancelBtn:hover{
	background-color: #84a331;
}
.imgOk, .imgNo{
	margin-left: 5px;
    border-radius: 10px;
    font-size: 13px;
    padding: 4px 5px;
    color: white;
}
.imgOk{
	background-color: #84a331;
}
.imgNo{
	background-color: indianred;
}

/* 취소, 등록 버튼 */
.cmButtons{
	display: flex;
	justify-content: center;
	margin-top: 40px;
}
.cancelBtn{
	width: 105px;
	height: 60px;
	padding: 18px 35px;
	font-size: 14px;
	margin-right: 13px;
	border-radius: 38px;
	border: 2px solid #999;
	background: none;
	color: #999;
}
.cancelBtn:hover{
	background-color: #999;
	color: white;
}
.regBtn{
	width: 130px;
	height: 60px;
	padding: 18px 33px;
	font-size: 14px;
	border-radius: 38px;
	border: 2px solid #84a331;
	background: none;
	color: #84a331;
}
.regBtn:hover:not(:disabled){
	background-color: #84a331;
	color: white;
}
.regBtn:disabled{
	border: 2px solid indianred;
	color: indianred;
}
	
</style>
</head>
<body>
<sec:authentication property="principal.mvo.memEmail" var="authEmail" />
<sec:authentication property="principal.mvo.memNickName" var="authNick" />
<jsp:include page="../common/header.jsp" />
<div class="bodyContainer">

<div class="topLine">
	<p class="pageName">1:1 문의</p>
</div>

<div class="topLine2">
	<i class="bi bi-megaphone"></i>
	<p class="ment"> 문의하신 사항은 확인 후 영업일 2~5일 이내 순차적으로 답변 드리겠습니다.</p>
</div>

<div class="formLine">
<form action="/cs/register" method="post" enctype="multipart/form-data">
	<input type="hidden" name="csEmail" value="${authEmail }">
	<input type="hidden" name="csNickName" value="${authNick }">
		
	<select name="csCategory" class="csMenu" required="required" id="csMenu">
		<option value="선택" selected style="display:none">문의 유형을 선택해 주세요</option>
		<option value="이용문의">이용문의</option>
		<option value="거래문의">거래문의</option>
		<option value="회원/계정">회원/계정문의</option>
		<option value="신고접수">신고접수</option>
		<option value="기타">기타</option>
	</select>
	
	<input type="text" name="csTitle" class="titleInput" id="csTitle" placeholder="제목을 입력해 주세요" required="required">
	
	<textarea name="csContent" id="dynamicTextarea" class="contentInput" placeholder="내용 입력" required="required"></textarea>
	
	<!-- 파일 -->
	<div class="form fileForm">
		<input type="file" class="form-control" name="files" id="files" multiple="multiple" style="display:none;">
		<input type="text" readonly="readonly" class="fileInput" placeholder="20MB 미만의 이미지를 업로드 해주세요"> 
		<button type="button" id="trigger" class="fileBtn">파일첨부</button>
	</div>
	<!-- 첨부파일 표시 영역 -->
	<div class="fileZone" id="fileZone" style="display:none">
	
	</div>
	
	<div class="cmButtons">
		<a href="/faq/list"><button type="button" class="cancelBtn">취소</button></a>
		<button type="submit" class="regBtn" id="regBtn" disabled="disabled">작성하기</button>
	</div>
</form>
</div>


</div>
<!-- 여기까지 bodyContainer -->
<jsp:include page="../common/footer.jsp" />

<script type="text/javascript" src="/resources/js/communityBoardRegister.js"></script>
<script type="text/javascript" src="/resources/js/abjustTextareaRows.js"></script>
</body>
</html>