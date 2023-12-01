// list 페이지 하단에 더보기 버튼 추가
// 더보기 버튼 id="moreBtn", data-page="1"

/*
Joongo list에서 추가하는 구조

<div class="col">
	<div class="card h-100">
		<img src="../resources/image/logoimage.png" class="card-img-top" alt="...">
		<div class="card-body">
		    <h5 class="card-title"><a href="/joongo/detail?proBno=${list.proBno}">${list.proTitle }</a></h5>
		    <p class="card-text">${list.proEmail }</p>
		</div>
		<div class="card-footer">
		    <small class="text-body-secondary">${list.proRegAt }</small>
		</div>
	</div>
</div>
*/

// 현재 페이지 url을 가져와서 category 항목만 가져옵니다.
let url = window.location.pathname;
let category = url.substring(url.indexOf('/')+1,url.lastIndexOf('/'));
console.log(category);
getMoreBoard(category,1);

// 더보기 버튼을 눌렀는지 판단
document.addEventListener('click',(e)=>{
    console.log(e.target);
    if(e.target.id == 'moreBtn'){
        console.log('더보기 버튼');
        getMoreBoard(category, parseInt(e.target.dataset.page));
    }
})

// 서버에 board 데이터 요청
async function getMoreBoardForServer(category, page){
    try {
        const resp = await fetch('/'+category+'/page/'+page);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

// 특정 게시글 thumbnail 가져오는 함수
async function getThumbnailToServer(category, bno){
    try {
        let config = {
            method : "post"
        }
        const resp = await fetch('/'+category+'/thumb/'+bno, config);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

// 서버에 요청한 데이터로 board 출력
async function getMoreBoard(category, page = 1) {
    try {
        const result = await getMoreBoardForServer(category, page);
        console.log(result);

        if (result.prodList.length > 0) {
            let boardArea = document.getElementById('boardArea');

            if (page == 1) {
                boardArea.innerHTML = "";
            }

            for (let prod of result.prodList) {
                let price = prod.proPrice.toLocaleString('ko-KR');
                let li = `<div class="col"><div class="card h-100">`;

                if (prod.proFileCnt > 0) {
                    let thumb = await getThumbnailToServer(category, prod.proBno);
                    li += `<img src="/upload/product/${thumb.saveDir.replaceAll('\\','/')}/${thumb.uuid}_${thumb.fileName}" class="card-img-top" alt="...">`;
                } else {
                    li += `<img src="../resources/image/logoimage.png" class="card-img-top" alt="...">`;
                }
                
                li += `<div class="card-body">`;
                li += `<h5 class="card-title"><a href="/joongo/detail?proBno=${prod.proBno}">${prod.proTitle}</a></h5>`;
                li += `<p class="card-text">${price}</p>`;
                li += `<p class="card-text">${prod.proEmail}</p>`;
                li += `</div><div class="card-footer"><small class="text-body-secondary">${prod.proRegAt }</small>`;
                li += `</div></div></div>`;
                boardArea.innerHTML += li;
            }
            
        } else {
            let li = `<div>Empty</div>`;
            boardArea.innerHTML = li;
        }

        let moreBtn = document.getElementById('moreBtn');

        if (result.pgvo.pageNo < result.endPage) {
            moreBtn.style.visibility = 'visible';
            moreBtn.dataset.page = page + 1;
        } else {
            moreBtn.style.visibility = 'hidden';
        }
    } catch (error) {
        console.error(error);
    }
}