//댓글 등록 버튼 클릭시
document.getElementById("cmtPostBtn").addEventListener('click', ()=>{
    const cmtText = document.getElementById('cmtText').value;
    const cmtWriter = document.getElementById('cmtWriter').innerText; 
    const cmtEmail = document.getElementById('cmtEmail').value;

    if(cmtText == "" || cmtText == null){ //댓글을 안 적었을 때
        alert("댓글을 입력해주세요.");
        document.getElementById('cmtText').focus();
        return false; //메서드 종료
    }else{
        let cmtData = {
            cmtBno : bnoVal, //jsp에서 보내준 값
            cmtEmail : cmtEmail,
            cmtNickName : cmtWriter,
            cmtContent : cmtText
        };
        console.log(cmtData);
        
        //전송 function
        postCommentToServer(cmtData).then(result => {
            if(result == 1){
                alert("댓글 등록 성공");
                //댓글 등록 후 인풋 빈값으로 만들어주기
                document.getElementById('cmtText').value = '';
            }

            //화면에 뿌리기
            spreadCommentList(bnoVal);
        })
    }//if문
})

//댓글 전송 메서드
async function postCommentToServer(cmtData){
    try{
        const url ="/communityCmt/post"; 
        const config = { 
            method : "post",
            headers : { 
                'Content-type' : 'application/json; charset=utf-8'
            },
            body : JSON.stringify(cmtData) 
        };

        const resp = await fetch(url, config);
        const result = await resp.text(); 
        return result;

    }catch(err){
        console.log(err);
    }
}

//서버에 댓글 리스트를 달라고 요청
async function getCommentListFromServer(bno){ //페이징을 위해 나중에 page 추가
    try{
        const resp = await fetch('/communityCmt/'+bno);
        const result = await resp.json(); 
        return result; 
        
    }catch(err){
        console.log(err);
    }
}

//화면에 뿌리기
function spreadCommentList(bno){
    getCommentListFromServer(bno).then(result => {
        console.log(result); //ph객체 : pgvo, totalCount, cmtList
        const ul = document.getElementById('cmtListArea'); //댓글 영역을 감싸는 ul
        if(result.length > 0){ //댓글이 있다면
            //다시 댓글을 뿌릴 때 기존 값 삭제 1page일 경우만
            
                ul.innerHTML = ""; //jsp에 임시로 넣어둔 댓글 표시영역을 지우고, 비어있는 값으로 바꿔버리기
            
            for(let cvo of result){
                
                console.log(cvo.cmtIsDel);
                //부모댓글
                if(cvo.cmtIsDel == 'Y'){
                    if(cvo.cmtAnswerCnt > 0){
                        let str = `<li class="cmtLi" data-cmtcno="${cvo.cmtCno}">삭제된 댓글입니다.</li>`;
                        str += `<ul class="repliesUl" id="replies-${cvo.cmtCno}">`; // 자식 댓글을 위한 ul 요소 추가
                        ul.innerHTML += str;
                    }  
                }else{
                    let str = `<li class="cmtLi" data-cmtcno="${cvo.cmtCno}">`;
                    str += `<div class="cmtContainer">`; 
    
                    str += `<div class="cmtUserLine">
                            <div><i class="bi bi-person-circle"></i> ${cvo.cmtNickName} `;
                    str += `<span class=""> ${cvo.cmtModAt}</span></div>`;
                    //수정, 삭제 버튼
                    if(cvo.cmtEmail == userEmail){ 
                        str += `<div class="userDropdownMenu">
                        <button class="boardUserBtn cmtUserBtn" type="button">
                            <i class="bi bi-three-dots cmtUserBtn"></i>
                        </button>
                        <ul class="cmtUserMenu menu-off" style="display:none">
                            <a class="modBtn" href="#" data-bs-toggle="modal" data-bs-target="#myModal">수정하기</a>
                            <a class="delBtn" href="#">삭제하기</a>
                        </ul>
                        </div>`
                    }
                    str += `</div>`;
                    
                    str += `<div class="cmtContentLine">${cvo.cmtContent}</div>`;

                    if(userEmail){
                        str += `<div class="cmtReBtnLine"><button class="reCmtBtn no-${cvo.cmtCno}" data-cmtnickname="${cvo.cmtNickName}">답글쓰기</button></div>`;
                    }
                    
                    str += `</div></li></ul>`;

                    if(cvo.cmtAnswerCnt > 0){
                        str += `<ul class="repliesUl" id="replies-${cvo.cmtCno}">`; // 자식 댓글을 위한 ul 요소 추가
                    }
                    
                    ul.innerHTML += str;
                    
                }
                
                //자식댓글
                hasReply(cvo.cmtCno).then(result =>{
                    if(result.length > 0){
                        for(let cvo of result){ 
                            let reUl = document.getElementById(`replies-${cvo.reCmtCno}`);

                            let str = `<li class="cmtLi2" data-recno=${cvo.reCno}>`;
                            str += `<div class="cmtContainer">`; 

                            str += `<div class="cmtUserLine">
                                    <div><i class="bi bi-person-circle"></i> ${cvo.reNickName} `;
                            str += `<span class=""> ${cvo.reModAt}</span></div>`;
                            //수정, 삭제 버튼
                            if(cvo.reEmail == userEmail){
                                str += `<div class="userDropdownMenu">
                                <button class="boardUserBtn cmtUserBtn" type="button">
                                    <i class="bi bi-three-dots cmtUserBtn"></i>
                                </button>
                                <ul class="cmtUserMenu menu-off" style="display:none">
                                    <a class="modBtn" href="#" data-bs-toggle="modal" data-bs-target="#myModal">수정하기</a>
                                    <a class="delBtn" href="#">삭제하기</a>
                                </ul>
                                </div>`
                            }
                            str += `</div>`;
                            
                            str += `<div class="cmtContentLine">${cvo.reContent}</div>`;
                            
                            str += `</div></li></ul>`;
                            
                            reUl.innerHTML += str;

                            // 마지막 댓글에 클래스 추가
                            const lastComment = ul.lastElementChild;
                            lastComment.classList.add('last-comment');
                           
                        }
                    }
                })
            }

        }else{
            let str = `<li class="list-group-item">첫 댓글을 남겨주세요.</li>`;
            ul.innerHTML = str;
        }
        
    })
}

//수정
async function editCommentToServer(cmtModData){
    try{
        const url = '/communityCmt/'+cmtModData.cmtCno;
        const config = {
            method : 'put',
            headers : {
                'content-type' : 'application/json; charset=utf-8'
            },
            body : JSON.stringify(cmtModData)
        };

        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
        
    }catch(err){
        console.log(err);
    }
}

//삭제
async function removeCommentToServer(cno){
    try{
        const url = '/communityCmt/'+cno;
        const config = {
            method : 'delete',
        };

        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;

    }catch(err){
        console.log(err);
    }
}

document.addEventListener('click', (e)=>{
    console.log(e.target);
    //수정버튼 클릭시
    if(e.target.classList.contains('modBtn')){
        console.log('수정버튼 클릭!');
        let li = e.target.closest('li');
        //nextSibling() : 같은 부모의 다음 형제 객체를 반환 => ${cvo.content}
        let cmtText = li.querySelector('.fw-bold').nextSibling;
        console.log(cmtText);
        //기존 내용 모달창에 반영
        document.getElementById('cmtTextMod').value = cmtText.innerText; 
        //value는 input태그에만 사용
        //nodeValue = innerText(div로 쌓여있을 때)
        //cmtModBtn에 data-cno 달기 
        console.log(li.dataset.cmtcno);
        document.getElementById('cmtModBtn').setAttribute('data-cmtcno', li.dataset.cmtcno);
        //dataset 대문자 인식X 소문자로만 cmtcno
    //모달창의 수정버튼 클릭시
    }else if(e.target.id == 'cmtModBtn'){
        let cmtModData = {
            cmtCno : e.target.dataset.cmtcno,
            cmtContent : document.getElementById('cmtTextMod').value
        };
        console.log(cmtModData);

        editCommentToServer(cmtModData).then(result => {
            if(result == 1){
                document.querySelector('.btn-close').click();
                alert("댓글 수정 성공");
            }
            spreadCommentList(bnoVal);
        })

    //삭제버튼 클릭시
    }else if(e.target.classList.contains('delBtn')){
        console.log('삭제버튼 클릭!');
        let li = e.target.closest('li');
        let cnoVal = li.dataset.cmtcno;

        removeCommentToServer(cnoVal).then(result => {
            if(result == 1){
                alert("댓글 삭제 성공");
            }
            spreadCommentList(bnoVal);
        })

    }
})

//-------------------------------------------------------------
//대댓글!

//서버에 cno를 주고 대댓글 리스트 받아오기
async function hasReply(cno){ 
    try{
        const resp = await fetch('/reCmt/'+cno);
        const result = await resp.json(); 
        return result; 
        
    }catch(err){
        console.log(err);
    }
}

document.addEventListener('click', (e)=>{
    //답글쓰기 눌렀을 때
    if(e.target.classList.contains('reCmtBtn')){
        console.log(e.target);
        let li = e.target.closest('li');
        console.log(li);
        let cmtCno = li.dataset.cmtcno;
        console.log(cmtCno);
        let button = li.querySelector('.reCmtBtn');
        button.remove();
        //let cmtNickName = e.target.dataset.cmtnickname;

    
        let str = `<div class="reCommentWrite">`;
        str += `<input type="hidden" id="writerEmail" value="${userEmail}">
                <input type="hidden" id="cmtCno" value=${cmtCno}>
                <span class="cmtWriter" id="reWriter">${userNick}</span>
                <textarea rows="1" class="cmtText reText" id="reText" placeholder="댓글을 남겨주세요"></textarea>
                <button type="button" id="rePostBtn" class="cmtPostBtn rePostBtn">등록</button>
                <button type="button" id="cancelBtn" class="cmtCancelBtn cancelBtn">취소</button></div>`; 
        
        li.innerHTML += str;

        //취소 버튼 눌렀을 때
        let cancelBtn = li.querySelector('.cancelBtn');
        cancelBtn.addEventListener('click', ()=> {
            // 입력 폼을 제거
            li.querySelector('.reCommentWrite').remove();

            // 답글 쓰기 버튼을 다시 보이게 함
            li.appendChild(button);
        });
    }
    
    //대댓글 등록 버튼 눌렀을 때
    if(e.target.classList.contains('rePostBtn')){
        const cmtCno = document.getElementById('cmtCno').value;
        const writerEmail = document.getElementById('writerEmail').value;
        const reWriter = document.getElementById('reWriter').innerText;
        const reText = document.getElementById('reText').value;

        if(reText == "" || reText == null){ //댓글을 안 적었을 때
            alert("댓글을 입력해주세요.");
            document.getElementById('reText').focus();
            return false; //메서드 종료
        }else{
            let reData = {
                reCmtCno : cmtCno, 
                reBno : bnoVal,
                reEmail : writerEmail,
                reNickName : reWriter,
                reContent : reText
            };
            console.log(reData);

            //전송 function
            postReplyToServer(reData).then(result => {
                if(result == 1){
                    alert("대댓글 등록 성공");
                }

                //화면에 뿌리기
                spreadCommentList(bnoVal);
            })
        }
    }
    
})

//대댓글 전송 메서드
async function postReplyToServer(reData){
    try{
        const url ="/reCmt/post"; 
        const config = { 
            method : "post",
            headers : { 
                'Content-type' : 'application/json; charset=utf-8'
            },
            body : JSON.stringify(reData) 
        };

        const resp = await fetch(url, config);
        const result = await resp.text(); 
        return result;

    }catch(err){
        console.log(err);
    }
}

//대댓글 수정
async function reEditToServer(reModData){
    try{
        const url = '/reCmt/'+reModData.reCno;
        const config = {
            method : 'put',
            headers : {
                'content-type' : 'application/json; charset=utf-8'
            },
            body : JSON.stringify(reModData)
        };

        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
        
    }catch(err){
        console.log(err);
    }
}

//대댓글 삭제
async function reRemoveToServer(cno){
    try{
        const url = '/reCmt/'+cno;
        const config = {
            method : 'delete',
        };

        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;

    }catch(err){
        console.log(err);
    }
}

document.addEventListener('click', (e)=>{
    //수정버튼 클릭시
    if(e.target.classList.contains('modBtn')){
        console.log('수정버튼 클릭!');
        let li = e.target.closest('li');
        //nextSibling() : 같은 부모의 다음 형제 객체를 반환 => ${cvo.content}
        let cmtText = li.querySelector('.fw-bold').nextSibling;
        console.log(cmtText);
        //기존 내용 모달창에 반영
        document.getElementById('cmtTextMod').value = cmtText.innerText; 
        //value는 input태그에만 사용
        //nodeValue = innerText(div로 쌓여있을 때)
        //cmtModBtn에 data-cno 달기 
        console.log(li.dataset.cmtcno);
        document.getElementById('cmtModBtn').setAttribute('data-recno', li.dataset.recno);
        //dataset 대문자 인식X 소문자로만 cmtcno
    //모달창의 수정버튼 클릭시
    }else if(e.target.id == 'cmtModBtn'){
        let reModData = {
            reCno : e.target.dataset.recno,
            reContent : document.getElementById('cmtTextMod').value
        };
        console.log(reModData);

        reEditToServer(reModData).then(result => {
            if(result == 1){
                document.querySelector('.btn-close').click();
                alert("대댓글 수정 성공");
            }
            
        })

    //삭제버튼 클릭시
    }else if(e.target.classList.contains('delBtn')){
        console.log('삭제버튼 클릭!');
        let li = e.target.closest('li');
        let cnoVal = li.dataset.recno;

        reRemoveToServer(cnoVal).then(result => {
            if(result == 1){
                alert("대댓글 삭제 성공");
            }
            
        })
    }
})

//게시글 삭제, 수정버튼 보이게하기
document.getElementById('boardUserMenuBtn').addEventListener('click',()=>{
    let userMenu = document.getElementById('boardUserMenu');
    if(userMenu.classList.contains('menu-off')){
        userMenu.classList.replace('menu-off', 'menu-on');
        userMenu.style = "display:inline-block";
    }else{
        userMenu.classList.replace('menu-on', 'menu-off');
        userMenu.style = "display:none";
    }

})

document.addEventListener('click', (e)=> {
    if (e.target.classList.contains('cmtUserBtn')) {
        const userMenu = e.target.closest('.cmtContainer').querySelector('.cmtUserMenu');
        if(userMenu.classList.contains('menu-off')){
            userMenu.classList.replace('menu-off', 'menu-on');
            userMenu.style = "display:inline-block";
        }else{
            userMenu.classList.replace('menu-on', 'menu-off');
            userMenu.style = "display:none";
        }
    }
});
