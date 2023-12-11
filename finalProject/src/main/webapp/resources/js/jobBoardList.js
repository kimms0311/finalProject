//로딩화면
window.onload = function() {
    setTimeout(()=> document.getElementById('loading').style.display = 'none', 500);
};

// select 메뉴 변경 시 이벤트 처리
const menu = null;
document.getElementById('menu').addEventListener('change', function () {
    // 선택된 메뉴 값 가져오기
    menu = document.getElementById('menu').value;
    console.log("menu >> " + menu);
    
    // 알바 리스트를 가져와서 출력하는 함수 호출
    spreadProductList(selectedMenu);
});

// 서버에서 알바 리스트 가져오기
async function getProductFromServer(menu, page) {
    try {
        const resp = await fetch('/job/list/' + menu + '/' + page);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

// 알바 리스트 출력 함수
function spreadProductList(menu, page = 1) {
    getProductFromServer(page, menu).then(result => {
        console.log("result>> ", result);
        // 가져온 알바 리스트를 페이지에 출력하는 코드를 추가
        // 예를 들어, 가져온 리스트를 반복문으로 돌면서 HTML 코드로 만들어서 brdListArea에 추가
        // result.forEach(item => {
        //     const newItemHtml = createNewItemHtml(item);
        //     document.getElementById('brdListArea').innerHTML += newItemHtml;
        // });
    });
}


//     let brdListArea = 

//     <c:forEach items="${list}" var="jbdto" varStatus="loopStatus">
// 	        <c:if test="${loopStatus.index < 8}">
// 	            <div class="jobListContent">
// 	                <a href="/job/detail?proBno=${jbdto.pbvo.proBno}">
// 	 				    <c:choose>
// 					        <c:when test="${not empty jbdto.flist}">
// 								<c:forEach items="${jbdto.flist}" var="flist">
// 						            <img alt="job image error" src="/upload/product/${fn:replace(flist.saveDir,'\\','/')}/${flist.uuid}_${flist.fileName}">
// 								</c:forEach>
// 					        </c:when>
// 					        <c:otherwise>
// 					            <!-- 비어 있는 경우 기본 이미지 출력 -->
// 					            <img alt="job image error" src="../resources/image/logoimage.png">
// 					        </c:otherwise>
// 					    </c:choose>
	
// 	                    <div class="jobInfoArea">
// 	                        <span>${jbdto.pbvo.proTitle}</span>
// 	                        <span class="d-inline-block text-truncate" style="max-width: 200px;">${jbdto.pbvo.proSido} ${jbdto.pbvo.proSigg} ${jbdto.pbvo.proEmd}</span>
// 	                        <span>${jbdto.pbvo.proMenu}
// 	                            <strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${jbdto.pbvo.proPrice}" />원</strong>
// 	                        </span>
// 	                    </div>
// 	                </a>
// 	            </div>
// 	        </c:if>
// 	    </c:forEach>

// })



// 전역 변수로 현재 페이지 번호를 설정합니다.
let currentPage = 1;

// "더 보기" 버튼 클릭 시 호출될 함수
async function loadMore() {
    // 현재 페이지를 서버로 전송하여 다음 페이지의 데이터를 가져옵니다.
    await getBoardList(proBno, currentPage);

    // 현재 페이지를 증가시킵니다.
    currentPage++;

    // "더 보기" 버튼을 갱신합니다.
    updateMoreButtonVisibility();
}

// "더 보기" 버튼을 갱신하는 함수
function updateMoreButtonVisibility() {
    let moreBtn = document.getElementById("moreBtn");

    // 더 불러올 데이터가 있는 경우 버튼을 표시하고, 없는 경우 숨깁니다.
    moreBtn.style.visibility = (currentPage <= totalPage) ? "visible" : "hidden";
}

