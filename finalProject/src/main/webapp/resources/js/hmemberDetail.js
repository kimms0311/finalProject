//현재 날짜
let today = new Date();
let year = today.getFullYear();
let month = ('0' + (today.getMonth() + 1)).slice(-2);
let day = ('0' + today.getDate()).slice(-2);

//가입 날짜
let regYear = regAt.slice(0,4);
let regMonth = regAt.slice(5,7);
let regDay = regAt.slice(8,10);

 //현재 날짜와 가입 날짜 차이 계산
 let timeDifference = Math.abs(today - new Date(regYear, regMonth-1, regDay)); 
 let daysDifference = Math.ceil(timeDifference / (1000*60*60*24));

document.getElementById('calcDate').innerHTML = `<i class="bi bi-calendar"></i>아보카트 가입일 ${daysDifference} 일 전`;

//기본 프로필일 경우, 삭제 버튼 가리기
document.addEventListener('DOMContentLoaded', function() {
    if (src === "../resources/image/기본 프로필.png") {
        document.getElementById('delBtn').style.display = 'none';
    }
});

//프로필 수정, 삭제 버튼 보이기
function editProfile(event) {
    const editProfile = document.getElementById('editProfile');

    //클릭한 좌표
    const x = event.clientX;
    const y = event.clientY;

    //editProfile 위치 설정
    editProfile.style.left = `${x}px`;
    editProfile.style.top = `${y}px`;

    editProfile.style.display = editProfile.style.display === 'block' ? 'none' : 'block';
}

document.getElementById('backPro').addEventListener('click', editProfile);
 
document.getElementById('editBtn').addEventListener('click',()=>{
    const editProfile = document.getElementById('editProfile');
    document.getElementById('profile').click();
    editProfile.style.display = 'none';
});

const regExp = new RegExp("\.(exe|sh|bat|js|msi|dll)$");
const regExpImg = new RegExp("\.(jpg|jpeg|png)$"); 
const maxSize = 1024*1024*20;

function fileValidation(fileName, fileSize){
   if(!regExpImg.test(fileName)){
       return 0;
   }else 
    if(regExp.test(fileName)){
        return 0;
    }else if(fileSize > maxSize){
        return 0;
    }else {
        return 1;
    }
}

function profileToServer(email, files) {
    const formData = new FormData();
    formData.append('file', files[0]);
    const url = baseUrl + email;

    $.ajax({
        url: url,
        type: 'post',
        data: formData,
        contentType: false,
        processData: false,

        success: function(result) {
            console.log(result);
            document.getElementById('profile').value = "";
            location.reload();
        },
        error: function(err) {
            console.log('Error:', err);
        }
    });
}

// 프로필 사진 서버 전송
document.addEventListener('change', (e) => {
    if (e.target.id == 'profile') {
        let files = $('#profile')[0].files;

        if (files.length > 0) {
            let fileName = files[0].name;
            let fileSize = files[0].size;
            let validResult = fileValidation(fileName, fileSize);

            if (validResult === 0) {
                alert("업로드할 수 없는 파일입니다.");
                document.getElementById('profile').value = "";
            } else {
                profileToServer(email, files);
            }
        }
    }
});

async function deleteProfileToServer(email) {
    try {
        const url = '/hmember/deleteFile/'+email;
        const config = {
            method : 'delete',
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        location.reload();
        return result;
    } catch (err) {
        console.log(err);
    }
}

//프로필 삭제 버튼
document.getElementById('delBtn').addEventListener('click',()=>{
    const editProfile = document.getElementById('editProfile');
    editProfile.style.display = 'none';
    deleteProfileToServer(email);
});

