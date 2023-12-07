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

// 글 내용에 따라 textarea 줄 수 조정하는 함수
function adjustTextareaRows() {
    var textarea = document.getElementById('dynamicTextarea');
    
    // 글 내용에서 줄바꿈 수를 세어 변수 저장
    var lineCount = (textarea.value.match(/\n/g) || []).length + 1;

    textarea.rows = lineCount;
}

// 페이지가 로드되면 adjustTextareaRows 함수 설정
document.addEventListener('DOMContentLoaded', adjustTextareaRows);
// textarea에 글을 입력할 때도 adjustTextareaRows 함수 설정
document.getElementById('dynamicTextarea').addEventListener('input', adjustTextareaRows);