//확인 클릭 시 게시글 삭제
document.addEventListener('click', (e) => {
    if(e.target.id == 'delBtn') {
       if(!confirm("게시글을 삭제하시겠습니까?")) {
            e.preventDefault();
            return;
       }
    }
})

if(likeCnt==0) {
    document.getElementById('likeCount').innerText
    = '가장 먼저 좋아요를 남겨보세요.';
}

//좋아요 여부 체크
let isLiked  = false;

async function checkLike(user, bno) {
    try {
        const url = '/store/checkLike/'+user+'/'+bno;
        const resp = await fetch(url);
        const isLiked = await resp.text();
        console.log(isLiked);

        likeOrNot(isLiked === '1');
    } catch (err) {
        console.log(err);
    }
}

//좋아요 눌렀을 경우 빨간 하트 보여주기
function likeOrNot(isLiked) {
    const heartIcon = document.getElementById('like');

    if (isLiked) {
        //기존에 좋아요를 누른 경우
        heartIcon.classList.replace('bi-heart','bi-heart-fill');
    } 
}

async function updateLike(likeData) {
    try {
        const url = '/store/updateLike';
        const config = {
            method : 'post',
            headers : {
                'Content-Type':'application/json; charset=utf-8'
            },
            body : JSON.stringify(likeData)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (err) {
        console.log(err);
    }
}

async function likeOrDislike(bno, user) {
    let likeData = {
        liBno : bno,
        liUserId : user
    };
    
    try {
        const result = await updateLike(likeData);
        const likeCount = document.getElementById('likeCount');

        if (result>0) {
            likeCount.innerText = result;
        } else {
            likeCount.innerText = '가장 먼저 좋아요를 남겨보세요.';
        }
    } catch (err) {
        console.error(err);
    }
}

document.getElementById("like").addEventListener('click', (e)=> {
    if(user == "") {
        alert("로그인 하신 후 이용해 주세요.")
    } else {
         if(e.target.classList.contains('bi-heart')){
            e.target.classList.replace('bi-heart','bi-heart-fill');
            likeOrDislike(bno, user);
        }else if(e.target.classList.contains('bi-heart-fill')){
            e.target.classList.replace('bi-heart-fill','bi-heart');
            likeOrDislike(bno, user);
        }
    }
})