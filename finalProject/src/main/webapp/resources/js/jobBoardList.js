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
