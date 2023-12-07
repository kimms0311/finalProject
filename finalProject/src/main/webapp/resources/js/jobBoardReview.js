//----------------------------------------------------------------------------
// REVIEW POST SECTION

document.getElementById("rePostBtn").addEventListener('click',()=>{
    
    const reContent = document.getElementById('reContent').value;
     // 선택된 라디오 버튼을 찾기
     const selectedRating = document.querySelector('input[name="rating"]:checked');

     // 선택된 라디오 버튼의 값 가져오기 값이 없다면 
     const ratingValue = selectedRating ? selectedRating.value : undefined;
 
    if (reContent == null || reContent =='') {
        alert('댓글 내용을 입력해주세요.');
        return false;
    } else if(ratingValue == undefined){
        alert('별점을 체크해주세요.');
        return false;
    } else {
        // 객체에 전송할 값 담기
        let reData ={
            reBno : proBnoVal,
            reUserId : memEmail,
            reContent : reContent,
            reScore: ratingValue
        };
        console.log("redata  >> " , reData);

        postReviewToServer(reData).then(result => {
            console.log("result >> " ,result);
            if (parseInt(result)) {
                alert("댓글 등록 성공");
                // 댓글 등록 후 input content,rating 비워주기
                document.getElementById('reContent').value='';
                selectedRating.checked = false;
            }

            spreadReviewList(reData.proBno);
        });
    }
});

async function postReviewToServer(reData) {
    try {
        const url = '/jobReview/post';
        const config = {
            method : 'post',
            headers : {
                'Content-Type':'application/json; charset=utf-8'
            },
            body : JSON.stringify(reData)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

//----------------------------------------------------------------------------
// REVIEW LIST SECTION

console.log("proBnoVal >> " + proBnoVal);
// 서버
async function getReviewFromServer(reBno, page){
    try{
        const resp = await fetch('/jobReview/'+reBno+'/'+page);
        const result = await resp.json();
        return result;
    }catch(error){
        console.log(error);
    }
}

//리뷰 리스트 뿌리는 함수
function spreadReviewList(reBno=proBnoVal, page=1){ //시작은 1페이지로 지정
    getReviewFromServer(reBno, page).then(result =>{
        console.log("result>> " ,result); //ph 객체 pgvo, totalCount, jobReList
        console.log(result.totalCount);
        if(result.jobReList.length > 0){
            const ul = document.getElementById('reListArea');
            //1page일 경우에만 기존 값 삭제 
            if(page==1){
                ul.innerText="";
            }
            for(let rvo of result.jobReList){
                let li = `<li class="list-group-item">`;
                li+= `<div class="mb-3 reWriterInfo">`;
                li+= `<img class="frofileImg"  alt="frofile error" src="../resources/image/기본 프로필.png">`;
                li+= `<strong><span class="reUserId">${rvo.reUserId}</span></strong>`;
                
                // li+= `<p class="badge rounded-pill text-bg-dark">구월동</p>`; 멤버 주소 가져올 수 있으면 차후 추가
                li+= `<span class="badge rounded-pill text-bg-dark">${rvo.regAt}</span>`;
                li+= `</div>`;
                //별점 평가 표시
                li+= `<div class="mb-3">`;
                for(let i = 1 ; i <= 5 ; i++){
                    if(i<=rvo.reScore){
                        li += `<label for="starFill${i}">★</label>`;
                    }else{
                        li += `<label for="starEmpty${i}">★</label>`;
                    }
                }
                li+= `<input type="text" value="${rvo.reContent}" class="reContent" readonly="readonly">`;
                li+= `<input type="hidden" value="${rvo.reRno}" class="reRno">`;
                li+= `<button type="button" class="mod">수정</button>`;
                li+= `<button type="button" class="del">삭제</button>`;
                li+= `</li>`;
                ul.innerHTML+=li;
            }
				
				
            //댓글 페이징 코드
            let moreBtn = document.getElementById('moreBtn');
            console.log(moreBtn);
            //db에서 pgvo + list 같이 가져와야 값을 줄 수 있음.
            if(result.pgvo.pageNo < result.endPage){
                moreBtn.style.visibility ='visible'; //버튼 표시
                moreBtn.dataset.page = page + 1;
            }else {
                moreBtn.style.visibility = 'hidden'; //버튼 숨김
            }

        }else{
            // 임시로 적어둔 댓글내용 초기화
            const ul = document.getElementById('reListArea');
            ul.innerText="";
            let li = `<li class="list-group-item">Comment List Empty</li>`;
            ul.innerHTML = li;
        }


        //별점 평균 구하여 표시
        // 별을 표시할 div 요소 선택
        const userStarDiv = document.querySelector('.userStar');
        
        // jobReList가 있는지 확인하여 리뷰가 있는 경우 실행
        if (result.jobReList && result.jobReList.length > 0) {
            // jobReList에서 reScore의 평균 계산
            const averageRating = result.jobReList.reduce((sum, review) => sum + review.reScore, 0) / result.jobReList.length;
            // userStarDiv 초기화
            userStarDiv.innerHTML = '';

            // 평균값만큼 반복하여 별 생성
            for (let i = 1 ; i <= 5 ; i++) {
                const starLabel = document.createElement('label');
                starLabel.setAttribute('for', `averageStar${i}`);
                
                // 별의 평균값 이상인 경우 채워진 별을 추가, 아니면 빈 별을 추가
                if (i <= averageRating) {
                    starLabel.innerHTML = `<label for="starFill${i}">★</label>`;
                } else {
                    starLabel.innerHTML = `<label for="starEmpty${i}">★</label>`;
                }
                userStarDiv.appendChild(starLabel);
            }
        }else {
            // 리뷰가 없는 경우 기본 별점 표시
            userStarDiv.innerHTML = `<label for="starEmpty">★★★★★</label>`;
        }
    })
    
}


//----------------------------------------------------------------------------
// REVIEW DEL & MOD SECTION

// 리뷰 삭제 정보 서버로 보내기
async function eraseReviewAtServer(reRno, reWriter) {
    try {
        const url = '/jobReview/del/'+reRno+'/'+reWriter;
        const config = {
            method: 'delete'
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

//리뷰 삭제, 수정
document.addEventListener('click',(e)=>{
    // target의 class가 'del'일 경우 삭제
    if(e.target.classList.contains('del')){
        const rnoVal = e.target.closest('li').querySelector('.reRno').value;
        const reWriter = e.target.closest('li').querySelector('.reUserId').innerText;
        // 삭제를 시도하는 mem과 reUser의 ID 동일한지 확인
        eraseReviewAtServer(rnoVal, reWriter).then(result=>{
            if(result == 1){
                alert('댓글 삭제');
                spreadReviewList();
            }else if(result == 0){
            	alert('작성자가 일치하지 않습니다.');
            }
        })
    }else if (e.target.classList.contains('mod')) {
        console.log("Mod button clicked");
        const rnoVal = e.target.closest('li').querySelector('.reRno').value;
        const reWriter = e.target.closest('li').querySelector('.reUserId').innerText;

        // content input 태그의 readonly 속성을 제거하여 수정 가능하게 변경
        const reContent = e.target.closest('li').querySelector('.reContent');
        reContent.removeAttribute('readonly');

        // 버튼 텍스트를 "확인"으로 변경
        e.target.textContent = '확인';

        // "확인" 버튼 클릭 시 이벤트 핸들러 추가
        e.target.addEventListener('click', function handleConfirmClick() {
            // 수정 된 정보 객체에 담기
            const reDataMod = {
                reRno: rnoVal,
                reUserId: reWriter,
                reContent: reContent.value
            };

            console.log(reDataMod);

            // 서버로 수정된 내용 전송
            editReviewToServer(reDataMod).then(result => {
                spreadReviewList(proBnoVal);
            });

            // "확인" 버튼 클릭 이벤트 핸들러 제거
            e.target.removeEventListener('click', handleConfirmClick);
        });
    } else if (e.target.id == 'moreBtn') {
        spreadReviewList(proBnoVal, parseInt(e.target.dataset.page));
    }
});

async function editReviewToServer(reDataMod){
    try{
        const url = '/jobReview/'+reDataMod.rno;
        const config ={
            method: 'put',
            headers: {
                'Content-Type' : 'application/json; charset=utf-8'
            },
            body: JSON.stringify(reDataMod)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    }catch(err){
        console.log(err);
    }
}
