<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		
	<form action="/job/register" method="post">
	<input type="hidden" class="form-control" id="proEmail" name="proEmail" value="proEmail">
	<input type="hidden" class="form-control" id="proNickName" name="proNickName" value="proNickName">
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
	    <input type="text" class="form-control" name="proPrice" id=proPrice>

		<label for="jobAddress" class="form-label">근무지역</label>
	    <input type="text" class="form-control" name="address" id="address">
		
		<label for="jobDay" class="form-label">근무요일</label>
		<div class="form-check">
			<label><input type="checkbox" name="days" value="월"> 월요일</label>
	        <label><input type="checkbox" name="days" value="화"> 화요일</label>
	        <label><input type="checkbox" name="days" value="수"> 수요일</label>
	        <label><input type="checkbox" name="days" value="목"> 목요일</label>
	        <label><input type="checkbox" name="days" value="금"> 금요일</label>
	        <label><input type="checkbox" name="days" value="토"> 토요일</label>
	        <label><input type="checkbox" name="days" value="일"> 일요일</label>
		</div>
		
		<label for="jobHour">근무시간</label><br>
		<input type="number" id="startHour" min="0" max="24"> :
		<input type="number" id="startMinute" min="0" max="59">
		~
		<input type="number" id="endHour" min="0" max="24"> :
		<input type="number" id="endMinute" min="0" max="59">
	  </div>

	  <div class="mb-3">
	    <label for="proContent" class="form-label">상세 내용</label>
		<textarea class="form-control" name="proContent" id="proContent" rows="10">자세한 근무 내용을 적어주세요.</textarea>
	  </div>
	  
	  <div class="mb-3">
	    <input type="file" class="form-control" id="files" name="files" style="display: none;" multiple="multiple">
	    <!-- input type trigger 용도의 button -->
	    <button type="button" id="trigger" class="btn btn-outline-success">사진 첨부</button>
	  </div>
	  
	  <div class="mb-3" id="fileZone">
	  <!-- 첨부파일 표시 될 영역 -->
	  </div>
  
	  <button type="submit" class="btn btn-success">작성</button>
	  <button type="reset" class="btn btn-success">취소</button>
	</form>


</div>

<script type="text/javascript">
    // JSP에서 JavaScript로 값 가져오기
    let jobAddress = '<%= request.getParameter("address") %>';
    console.log("근무지역: " + jobAddress);
    // jobAddress 변수를 필요한 곳에서 사용할 수 있습니다.
</script>
<script type="text/javascript" src="/resources/js/job/jobBoardRegister.js"></script>
<jsp:include page="../common/footer.jsp" />

</body>
</html>