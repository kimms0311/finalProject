//좋아요 버튼 클릭시
document.addEventListener('click', (e)=>{
    console.log(bnoVal);
    console.log(userEmail);

    if(e.target.classList.contains('btn-outline-danger')){ //안 누른 상태면
        console.log("좋아요 등록");
        e.target.classList.replace('btn-outline-danger', 'btn-danger');
        likeToServer(bnoVal, userEmail);
    }else if(e.target.classList.contains('btn-danger')){ //이미 누른 상태면
        console.log("좋아요 취소"); 
        e.target.classList.replace('btn-danger', 'btn-outline-danger');
        likeToServer(bnoVal, userEmail);
    }
})

//좋아요 정보 보내주기
async function likeToServer(bno, email){ 
    try{
        const url = '/community/'+bno+'/'+email;
        const config = {
            method : "post"
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result; 
        
    }catch(err){
        console.log(err);
    }
}

