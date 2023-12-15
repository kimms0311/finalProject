//로딩화면
window.onload = function() {
    setTimeout(()=> document.getElementById('loading').style.display = 'none', 500);
};

// 메뉴, 정렬값 가져오기
let menu = document.getElementById('menuSelect').value;
let sort = document.getElementById('sortSelect').value;

console.log(sort);


// select menu 변경 시 이벤트 처리
document.getElementById('menuSelect').addEventListener('change', ()=>{
    // 선택된 메뉴 값 가져오기
    menu = document.getElementById('menuSelect').value;
    console.log("menu >> " + menu);

    spreadJobFromServer(1 , menu, sort);
});

// select sort 변경 시 이벤트 처리
document.getElementById('sortSelect').addEventListener('change', ()=>{
    // 선택된 메뉴 값 가져오기
    sort = document.getElementById('sortSelect').value;
    console.log("sort >> " + sort);

    spreadJobFromServer(1 , menu, sort);
});


// more 버튼 클릭 시 호출될 함수
async function loadMore() {
    console.log("더보기 클릭");
    console.log(document.getElementById('moreBtn').dataset.page);
    const currentPage = parseInt(document.getElementById('moreBtn').dataset.page);
    console.log("currentPage >> " + currentPage);

    spreadJobFromServer(currentPage, menu, sort);

}

// 서버에서 joblist가져오기


async function getMoreJobForServer(page, menu, sort){
    try {
        const resp = await fetch('/job/list/'+page+'/'+menu+'/'+sort);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

// 썸네일 가져오는 함수
async function getThumbnailToServer(proBno){
    try {
        const url = '/job/list/thumb/'+proBno;
        const config = {
            method : 'post'
        };
        const resp = await fetch(url, config);
        const result = await resp.json();
        return result;

    } catch (error) {
        console.log(error);
    }
}
// 숫자를 통화 형식으로 변환하는 함수 (원 표시용)
function formatCurrency(amount) {
    // toLocaleString 메서드를 사용하여 숫자를 통화 형식으로 변환
    return amount.toLocaleString('ko-KR', { style: 'currency', currency: 'KRW' });
    // 통화 기호(₩) 제거
    formattedAmount = formattedAmount.replace('₩', '');
}


// 서버에서 받은 list 뿌리기
async function spreadJobFromServer(page = 1, menu, sort){
    try {
        const result = await getMoreJobForServer(page, menu, sort);
        console.log("result >> " , result);

        // ph객체의 의 리스트에 상품(job)이 있는 경우
        if(result.prodList.length > 0){
            let moreJobArea = document.getElementById('moreJobArea');
            if(page == 1) {
                // 1page에서 초기화
                moreJobArea.innerHTML = "";
            }
            
            for(let job of result.prodList){
                let inner = `<div class="jobListContent">`;
                inner += `<a href="/job/detail?proBno=${job.proBno}">`;
                if (job.proFileCnt > 0) {
                    let thumb = await getThumbnailToServer(job.proBno);
                    inner += `<img alt="job image error" src="../upload/product/${thumb.saveDir.replaceAll('\\','/')}/${thumb.uuid}_${thumb.fileName}">`;;
                }else{
                    inner += `<img alt="job image error" src="../resources/image/logoimage.png">`
                }
                inner += `<div class="jobInfoArea">`;
                inner += `<span>${job.proTitle}</span>`;
                inner += `<span class="d-inline-block text-truncate" style="max-width: 200px;">${job.proSido} ${job.proSigg} ${job.proEmd}</span>`;
                inner += `<span>${job.proPayment} `;
                inner += `<strong>${formatCurrency(job.proPrice).replace('₩', '')}원</strong>`;
                inner += `</span>`;
                inner += `</div>`;
                inner += `</a>`;
                inner += `</div>`;

                moreJobArea.innerHTML += inner;
            }

            
        

        }else {
            let inner = `비었어`;
            moreJobArea.innerHTML = inner;
        }

        let moreBtn = document.getElementById('moreBtn');

        
        if (result.pgvo.pageNo < result.endPage) {
            moreBtn.style.visibility = 'visible';
            moreBtn.dataset.page = page + 1;
        } else {
            moreBtn.style.visibility = 'hidden';
        }



        
    } catch (error) {
        console.log(error);
        
    }
}

spreadJobFromServer();