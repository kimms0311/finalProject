//로딩화면
window.onload = function() {
    setTimeout(()=> document.getElementById('loading').style.display = 'none', 500);
};


document.addEventListener('DOMContentLoaded', function() {
    loadJobList('null'); // 초기에는 'null'로 설정하여 전체 리스트를 가져옴
});

//
async function spreadJobFromServer(type, page){
    try{
        const resp = await fetch('/job/page/'+type+'/'+page);
        const result = await resp.json();
        return result;
    }catch(err){
        console.log(err);
    }
}




// // 처음 실행시 전체 리스트 출력
// function getJobList(type=null,page=1){
//     spreadJobFromServer(type,page).then(result => {
//         console.log(result);
//         const div = document.getElementById('jobList')

//         //1page일 경우에만 기존 값 삭제 
//         if(page===1){
//             div.innerText="";
//         }
//         for(let jbdto of result.list){
            
//             let inner = `<c:forEach items="${list}" var="jbdto" varStatus="loopStatus">`;
//             inner += `<c:if test="${loopStatus.index < 8}">`;
//             inner += `<div class="jobListContent">`;
//             inner += `<a href="/job/detail?proBno=${jbdto.pbvo.proBno}">`;
//             inner += `<c:choose>`;
//             inner += `<c:when test="${not empty jbdto.flist}">`;
//             inner += `<c:forEach items="${jbdto.flist}" var="flist">`;
//             inner += `<img alt="job image error" src="/upload/product/${fn:replace(flist.saveDir,'\\','/')}/${flist.uuid}_${flist.fileName}">`;
//             inner += `</c:forEach>`;
//             inner += `</c:when>`;
//             inner += `<c:otherwise>`;
//             // 파일이 비어 있는 경우 기본 이미지 출력
//             inner += `<img alt="job image error" src="../resources/image/logoimage.png">`;
//             inner += `</c:otherwise>`;
//             inner += `</c:choose>`;
//             inner += `<div class="jobInfoArea">`;
//             inner += `<span>${jbdto.pbvo.proTitle}</span>`;
//             inner += `<span class="d-inline-block text-truncate" style="max-width: 200px;">${jbdto.pbvo.proSido} ${jbdto.pbvo.proSigg} ${jbdto.pbvo.proEmd}</span>`;
//             inner += `<span>${jbdto.pbvo.proMenu}`;
//             inner += `<strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${jbdto.pbvo.proPrice}" />원</strong>`;
//             inner += `</span>`;
//             inner += `</div></a></div>`;
//             inner += `</c:if>`;
//             inner += ` </c:forEach>`;
//             div.innerHTML = inner;
//         }

        
//     })
// }

// 처음 실행시 전체 리스트 출력
function getJobList(type = null, page = 1) {
    spreadJobFromServer(type, page).then(result => {
        console.log(result);
        const div = document.getElementById('jobList');

        // 1페이지일 경우에만 기존 값 삭제 
        if (page === 1) {
            div.innerHTML = "";
        }

        for (let jbdto of result.list) {
            if (jbdto.flist && jbdto.flist.length > 0) {
                // 이미지가 있는 경우
                let inner = `
                    <div class="jobListContent">
                        <a href="/job/detail?proBno=${jbdto.pbvo.proBno}">
                            ${jbdto.flist.map(flist => `
                                <img alt="job image error" src="/upload/product/${flist.saveDir.replace(/\\/g, '/')}/${flist.uuid}_${flist.fileName}">
                            `).join('')}
                            <div class="jobInfoArea">
                                <span>${jbdto.pbvo.proTitle}</span>
                                <span class="d-inline-block text-truncate" style="max-width: 200px;">${jbdto.pbvo.proSido} ${jbdto.pbvo.proSigg} ${jbdto.pbvo.proEmd}</span>
                                <span>${jbdto.pbvo.proMenu}
                                    <strong>${new Intl.NumberFormat('en-US').format(jbdto.pbvo.proPrice)}원</strong>
                                </span>
                            </div>
                        </a>
                    </div>`;
                div.innerHTML += inner;
            } else {
                // 이미지가 없는 경우
                let inner = `
                    <div class="jobListContent">
                        <a href="/job/detail?proBno=${jbdto.pbvo.proBno}">
                            <img alt="job image error" src="../resources/image/logoimage.png">
                            <div class="jobInfoArea">
                                <span>${jbdto.pbvo.proTitle}</span>
                                <span class="d-inline-block text-truncate" style="max-width: 200px;">${jbdto.pbvo.proSido} ${jbdto.pbvo.proSigg} ${jbdto.pbvo.proEmd}</span>
                                <span>${jbdto.pbvo.proMenu}
                                    <strong>${new Intl.NumberFormat('en-US').format(jbdto.pbvo.proPrice)}원</strong>
                                </span>
                            </div>
                        </a>
                    </div>`;
                div.innerHTML += inner;
            }
        }
    });
}

// 카테고리 버튼 클릭 이벤트 처리
document.querySelectorAll('.cateBtns').forEach(btn => {
    btn.addEventListener('click', function() {
        loadJobList(this.value);
    });
});

// 카테고리 버튼 클릭 시 호출될 함수
function loadJobList(category) {
    spreadJobFromServer(category, 1).then(result => {
        const div = document.getElementById('jobList');
        div.innerHTML = ""; // 기존 값 초기화

        for (let jbdto of result.list) {
            let inner = `
                <div class="jobListContent">
                    <a href="/job/detail?proBno=${jbdto.pbvo.proBno}">
                        ${jbdto.flist && jbdto.flist.length > 0 ? 
                            jbdto.flist.map(flist => `
                                <img alt="job image error" src="/upload/product/${flist.saveDir.replace(/\\/g, '/')}/${flist.uuid}_${flist.fileName}">
                            `).join('') :
                            `<img alt="job image error" src="../resources/image/logoimage.png">`
                        }
                        <div class="jobInfoArea">
                            <span>${jbdto.pbvo.proTitle}</span>
                            <span class="d-inline-block text-truncate" style="max-width: 200px;">${jbdto.pbvo.proSido} ${jbdto.pbvo.proSigg} ${jbdto.pbvo.proEmd}</span>
                            <span>${jbdto.pbvo.proMenu}
                                <strong>${new Intl.NumberFormat('en-US').format(jbdto.pbvo.proPrice)}원</strong>
                            </span>
                        </div>
                    </a>
                </div>`;
            div.innerHTML += inner;
        }
    });
}


// 정렬 선택 시 호출될 함수 (추가 필요)
document.getElementById('sort').addEventListener('change', function() {
    // 정렬 선택에 따라 서버에 요청을 보내거나, 현재 리스트를 정렬하는 등의 작업을 수행
});


// 더 보기 버튼 클릭 시 호출될 함수
function loadMore() {
    // 현재 페이지와 타입을 가져와서 다음 페이지 호출
    const currentPage = 2; // 예시로 현재 페이지를 2로 설정, 필요에 따라 수정
    const type = 'food'; // 예시로 타입을 'food'로 설정, 필요에 따라 수정
    getJobList(type, currentPage);
}

