<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Store List</title>
<style type="text/css">
.allBtns{
	margin: 40px 0 20px 0;
	width: 100%;
    display: flex;
    justify-content: center;
}

.clicked{
	font-weight: 800;
	background-color: #84a331;
	color: white;	
	margin-right: 10px;
	border: 2px solid #84a331;
    border-radius: 5px;
}

.regiBtn{
	margin: 0 10px;
    text-decoration: none;
    color: black;
    border: 2px solid #84a331;
    border-radius: 5px;
    padding: 3px 5px;
}

.cateBtns{
	margin-right: 10px;
	border: 2px solid #84a331;
    border-radius: 5px;
    background-color: white;
}

.regiBtn:hover {
	font-weight: 800;
	background-color: #84a331;
	color: white;	
}

.cateBtns:hover {
	font-weight: 800;
	background-color: #84a331;
	color: white;	
}
</style>
<link rel="stylesheet" href="../resources/css/storeBoardList.css">
</head>
<body class="bodyContainer">
<div id="loading">
<!-- 로딩 페이지 -->
</div>
<jsp:include page="../common/header.jsp" />

<div class="allBtns">
<a href="/store/register" class="regiBtn">작성하기</a>
<!-- 카테고리 버튼 -->
<button type="button" class="cateBtns" id="all" value="null">전체</button>
<button type="button" class="cateBtns" id="lesson" value="lesson">과외/클래스</button>
<button type="button" class="cateBtns" id="pet" value="pet">반려동물</button>
<button type="button" class="cateBtns" id="hospital" value="hospital">병원/약국</button>
<button type="button" class="cateBtns" id="beauty" value="beauty">뷰티샵</button>
<button type="button" class="cateBtns" id="laundry" value="laundry">세탁소</button>
<button type="button" class="cateBtns" id="repair" value="repair">수리</button>
<button type="button" class="cateBtns" id="sports" value="sports">운동</button>
<button type="button" class="cateBtns" id="infant" value="infant">육아</button>
<button type="button" class="cateBtns" id="eatery" value="eatery">음식점</button>
<button type="button" class="cateBtns" id="move" value="move">이사/용달</button>
<button type="button" class="cateBtns" id="interior" value="interior">인테리어 시공</button>
<button type="button" class="cateBtns" id="cleaning" value="cleaning">청소</button>
<button type="button" class="cateBtns" id="hobby" value="hobby">취미</button>
<button type="button" class="cateBtns" id="dessert" value="dessert">카페/디저트</button>
</div>

<!-- list 시작 -->
<div class="listContainer">
   <ul id="ulZone">
       <c:forEach items="${list}" var="pvo">
           <li id="liZone">
               <a href="/store/detail?bno=${pvo.proBno }">
                  <div>
                     <div>
                        <img class="thumbnail">
                     </div>
                  </div>
                  <div>
                     <div>
                         <span class="title">${pvo.proTitle }</span>
                         <span class="gray">${pvo.proEmd }</span>
                  </div>
                      <span class="content">${pvo.proContent }</span>
                      <span class="gray">${pvo.proMenu }</span>
                   </div>
               </a>
           </li>
       </c:forEach>
   </ul>
</div>

<!-- 페이징 더보기 버튼 -->
<div class="commentContainer">
   <div>
      <div>
         <button type="button" id="moreBtn" data-page="1" style="visibility:hidden;">더보기</button>
      </div>
   </div>
</div>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
	  var allBtn = document.getElementById('all');
	  allBtn.classList.remove('cateBtns');
	  allBtn.classList.add('clicked');

	  //나머지 버튼에 클릭 이벤트 추가
	  var otherBtns = document.querySelectorAll('.cateBtns');
	  otherBtns.forEach(function(btn) {
	    btn.addEventListener('click', function() {
	      //클릭된 버튼에만 clicked 클래스 추가
	      btn.classList.add('clicked');
	      btn.classList.remove('cateBtns');

 	      //#all 버튼의 clicked 클래스 제거
	      allBtn.classList.remove('clicked');
	      allBtn.classList.add('cateBtns'); 

	      //나머지 버튼들의 clicked 클래스 제거
	      otherBtns.forEach(function(other) {
	        if (other !== btn) {
	          other.classList.remove('clicked');
	          other.classList.add('cateBtns');       
	        }
	      });
	    });
	  });
	});
</script>
<script src="/resources/js/storeBoardList.js"></script>
<script type="text/javascript">
getStoreList();
</script>
<jsp:include page="../common/footer.jsp"  />
</body>
</html>