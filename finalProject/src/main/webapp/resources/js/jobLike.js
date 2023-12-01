let like = document.getElementsByClassName('bi-heart');
let likeBtn = document.getElementById('likeBtn');

//like 여부 지정하는 변수
let state = 0;



// 찜하기
likeBtn.addEventListener('click', () => {
    console.log("memEmail>>" + "'" + memEmail+"'");

    if (memEmail == null && memEmail == undefined || memEmail == '') {
        alert("로그인 해주세요.");

    } else {
            // 찜 클릭시 상황에 따라 아이콘 toggle 및 state값 설정
            if (likeBtn.classList.contains('bi-heart-fill')) {
                // 찜취소
                // 취소 시 status -1 변경
                state = -1;
            } else {
                // state 0(처음으로 찜)인 경우 state 값을 3으로 지정하여 별도로 처리->db에서 insert로 생성
                state = (state === 0) ? 3 : 1;
            }
            
            likeToServer(proBnoVal, memEmail, state);
            
            console.log("proBnoVal>>" + proBnoVal + "/ memEmail>>" + memEmail + "/ state>>" + state);
        
    }
});



async function likeToServer(proBnoVal, memEmail, state) { 
    try {
        const url = "/job/like";
        const config = {
            method: "post",
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                liBno: proBnoVal,
                liUserId: memEmail,
                liStatus: state
            })
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result; 
    } catch (err) {
        console.log(err);
    }
}

