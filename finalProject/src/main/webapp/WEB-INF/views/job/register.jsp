<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>job register page</title>
<link rel="stylesheet" href="/resources/css/page.css">
</head>
<body>
<jsp:include page="../common/header.jsp" />


<div class="bodyContainer">
	
	<!-- 로그인한 mvo가져오기 -->
	<sec:authentication property="principal.mvo" var="authMvo"/>

	
	<form action="/job/register" method="post" enctype="multipart/form-data" >
	<input type="hidden" class="form-control" id="proEmail" name="proEmail" value="${authMvo.memEmail }">
	<input type="hidden" class="form-control" id="proNickName" name="proNickName" value="${authMvo.memNickName }">
	  <div class="mb-3">
	    <label for="proTitle" class="form-label">제목</label>
	    <input type="text" class="form-control" name="proTitle" id="proTitle">
	    
	  </div>
	  <div class="mb-3">
	  <label for="jobDetail" class="form-label">구인 정보</label>
	  <!-- 지급기준 메뉴에 담기 -->
		    <select class="form-select form-select-sm" aria-label="Small select example" name="proMenu">
			  <option selected>지급 기준</option>
			  <option value="시급">시급</option>
			  <option value="일급">일급</option>
			  <option value="월급">월급</option>
			  <option value="건별">건별</option>
			</select>
		
		<label for="jobProPrice" class="form-label">급여</label>
	    <input type="text" class="form-control" name="proPrice" id="proPrice">

		<label for="jobAddress" class="form-label">근무지역</label>
	    <input type="text" class="form-control" name="address" id="proAddress">
	    	<!-- 주소 받아오기 -->
			<input type="hidden" class="form-control" name="proSido" id="proSido">
			<input type="hidden" class="form-control" name="proSigg" id="proSigg">
			<input type="hidden" class="form-control" name="proEmd" id="proEmd">
	
	    
	    
	  </div>


	  <div class="mb-3">
	    <label for="proContent" class="form-label">상세 내용</label>
		<textarea class="form-control" name="proContent" id="proContent" rows="10" placeholder="자세한 근무 내용을 적어주세요. ex)근무요일, 근무시간, 우대사항"></textarea>
	  </div>
	  
	  <div class="mb-3">
	    <input type="file" class="form-control" id="files" name="files" style="display: none;" multiple="multiple">
	    <!-- input type trigger 용도의 button -->
	    <button type="button" id="trigger" class="btn btn-outline-success">사진 첨부</button>
	  </div>
	  
	  <div class="mb-3" id="fileZone">
	  <!-- 첨부파일 표시 될 영역 -->
	  </div>
  
	  <button type="submit" class="btn btn-success" id="regBtn">작성</button>
	  <button type="reset" class="btn btn-success">취소</button>
	</form>
	
</div>


<script type="text/javascript" src="/resources/js/jobBoardRegister.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	// 주소입력창 클릭시 카카오주소 연결
	document.getElementById('proAddress').addEventListener('click', ()=>{
	    new daum.Postcode({
	        oncomplete: function(data) { //선택시 입력값 세팅
	            console.log(data);
	        	//input에 보여질 전체주소값 설정
			    let address = data.sido + ' ' + data.sigungu + ' ' + data.bname;
	            document.getElementById('proAddress').value = address ;
	            //db에 넣을 주소값 설정
	            document.getElementById('proSido').value = data.sido;
	            document.getElementById('proSigg').value = data.sigungu;
	            document.getElementById('proEmd').value = data.bname;
	        }
	    }).open();
	})
</script>
<jsp:include page="../common/footer.jsp" />

</body>
</html>