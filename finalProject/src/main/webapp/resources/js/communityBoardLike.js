//좋아요 버튼 클릭시
document.getElementById('likeBtn').addEventListener('click', ()=>{
	let currentLikeCount = parseInt(document.getElementById('cmLikeCnt').innerText);

	if(!(userEmail)){
		alert('로그인을 해주세요.');
	}

	if(userEmail){
	    if(document.getElementById('likeBtn').classList.contains('bi-heart')){ //안 누른 상태면
	        console.log("좋아요 등록");
	        document.getElementById('likeBtn').classList.replace('bi-heart', 'bi-heart-fill');
			document.getElementById('cmLikeCnt').innerText = currentLikeCount + 1;
	        likeToServer(bnoVal, userEmail);
	    }else if(document.getElementById('likeBtn').classList.contains('bi-heart-fill')){ //이미 누른 상태면
	        console.log("좋아요 취소"); 
	        document.getElementById('likeBtn').classList.replace('bi-heart-fill', 'bi-heart');
			document.getElementById('cmLikeCnt').innerText = currentLikeCount - 1;
	        likeToServer(bnoVal, userEmail);

	    }
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

