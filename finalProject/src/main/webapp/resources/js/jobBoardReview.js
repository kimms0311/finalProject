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

            // getReviewList(reData.proBno);
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
// async function spreadReviewFromServer(proBno, page){
//     try{
//         const resp = await fetch('/review/'+proBno+'/'+page);
//         const result = await resp.json();
//         return result;
//     }catch(error){
//         console.log(error);
//     }
// }

// //무조건 첨을 뿌릴때는 첫페이지 값을 뿌려야 함.
// function getReviewList(proBno, page=1){
//     spreadReviewFromServer(proBno, page).then(result =>{
//         console.log(result); //ph 객체 pgvo, totalCount, cmtList
//         if(result.reList.length>0){
//             const ul = document.getElementById('reListArea');
//             //다시 댓글을 뿌릴때 기존 값 삭제  1page일 경우만
//             if(page==1){
//                 ul.innerText="";
//             }
//             for(let rvo of result.reList){
//                 let li = `<li class="list-group-item" data-cno="${rvo.reRno}" data-writer="reUserId">`;
//                 li+= `<div class="mb-3 reWriterInfo">`;
//                 li+= `<img alt="" src="/resources/image/logoimage.png">`;
//                 li+= `<span><strong>reUserId</strong></span>`;
//                 li+= `${rvo.content}`;
//                 li+= `<span class="badge rounded-pill text-bg-dark">구월동</span>`;
//                 li+= `<span class="badge rounded-pill text-bg-dark">${rvo.regAt}</span>`;
//                 li+= `</div>`;
//                 li+= `<span>여기서 일하지마세요 ㅋㅋ </span>`;
//                 li+= `<button type="button" class="btn btn-outline-danger mod" data-bs-toggle="modal" data-bs-target="#myModal">e</button>`;
//                 li+= `<button type="button" class="btn btn-outline-warning del">x</button>`;
//                 li+= `</li>`;
//                 ul.innerHTML+=li;
//             }


//             //댓글 페이징 코드
//             let moreBtn = document.getElementById('moreBtn');
//             console.log(moreBtn);
//             //db에서 pgvo + list 같이 가져와야 값을 줄 수 있음.
//             if(result.pgvo.pageNo < result.endPage){
//                 moreBtn.style.visibility ='visible'; //버튼 표시
//                 moreBtn.dataset.page = page + 1;
//             }else {
//                 moreBtn.style.visibility = 'hidden'; //버튼 숨김
//             }

//         }else{
//             let li = `<li class="list-group-item">Comment List Empty</li>`;
//             innerHTML = li;
//         }
//     })
// }
// async function eraseReviewAtServer(cno, writer) {
//     try {
//         const url = '/review/del/'+cno+'/'+writer;
//         const config = {
//             method: 'delete'
//         };
//         const resp = await fetch(url, config);
//         const result = await resp.text();
//         return result;
//     } catch (err) {
//         console.log(err);
//     }
// }

// document.addEventListener('click',(e)=>{
//     if(e.target.classList.contains('del')){
//         let li = e.target.closest('li');
//         let cnoVal = li.dataset.cno;
//         let writerVal = li.dataset.writer;
//         console.log(writerVal);
//         eraseReviewAtServer(cnoVal, writerVal).then(result=>{
//             if(result ==1){
//                 alert('댓글삭제완료~!!');
//                 getReviewList(bnoVal);
//             }else if(result ==0){
//             	alert('작성자가 일치하지 않습니다.');
//             }
//         })
//     }else if(e.target.classList.contains('mod')){
//         let li = e.target.closest('li');
//         //nextSibling() : 같은 부모의 다음 형제 객체를 반환
//         let cmtText = li.querySelector('.fw-bold').nextSibling;

//         //기존내용 모달창에 반영 (수정하기 편하게...)
//         document.getElementById('cmtTextMod').value = cmtText.nodeValue;
//         //cmtModBtn에 data-cno 달기
//         document.getElementById('cmtModBtn').setAttribute('data-cno', li.dataset.cno);
//     }else if(e.target.id == 'cmtModBtn'){
//         let cmtDataMod={
//             cno :e.target.dataset.cno,
//             content : document.getElementById('cmtTextMod').value
//         };
//         console.log(cmtDataMod);
//         editReviewToServer(cmtDataMod).then(result => {
//             if(parseInt(result)){
//                 // 모달창 닫기
//                 document.querySelector('.btn-close').click();
//             }
//             getReviewList(bnoVal);
//         })
//     }else if(e.target.id == 'moreBtn'){
//         getReviewList(bnoVal, parseInt(e.target.dataset.page));
//     }

// })

// async function editReviewToServer(cmtDataMod){
//     try{
//         const url = '/review/'+cmtDataMod.cno;
//         const config ={
//             method: 'put',
//             headers: {
//                 'Content-Type' : 'application/json; charset=utf-8'
//             },
//             body: JSON.stringify(cmtDataMod)
//         };
//         const resp = await fetch(url, config);
//         const result = await resp.text();
//         return result;
//     }catch(err){
//         console.log(err);
//     }
// }
