let url = window.location.pathname;
let category = url.substring(url.indexOf('/')+1,url.lastIndexOf('/'));

// 트리거 버튼 누르면 파일 업로드 시작
document.getElementById('trigger').addEventListener('click',()=>{
    document.getElementById('files').click();
})

// 실행파일, 이미지 파일에 대한 정규 표현식
const regExp = new RegExp("\.(exe|sh|bat|js|msi|dll)$"); // 실행파일
const regExpImg = new RegExp("\.(jpg|jpeg|png|gif)$"); // 이미지파일
const maxSize = 1024*1024*20; // 파일 최대 사이즈 20MB

function fileValidation(fileName, fileSize){
    if(!regExpImg.test(fileName)){
        return 0;
    }else if(regExp.test(fileName)){
        return 0;
    }else if(fileSize > maxSize){
        return 0;
    }else{
        return 1;
    }
}

async function insertFileToServer(category, file){
    try {
        let path = "/"+category+"/"+file;
        let config = {
            method : "post",
            headers : {
                "content-type" : "application/json; charset=UTF-8"
            },
            body : JSON.stringify(file)
        };

        const resp = await fetch(path, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

// 파일을 업로드했을 경우
document.addEventListener('change', (e)=>{
    if(e.target.id == 'files'){
        document.getElementById('regBtn').disabled = false;

        // input file 요소에 저장된 file 정보를 가져오는 속성
        const fileObj = document.getElementById('files').files;
        console.log(fileObj);

        let div = document.getElementById('fileZone');



        // 기존값 삭제
        div.innerHTML = "";

        let isOk = 1;
        let ul = `<ul class="list-group">`;
        for(let file of fileObj){
            let validResult = fileValidation(file.name, file.size);
            isOk *= validResult;
            ul += `<li class="list-group-item">`;
            ul += `<div class="mb-3">`;
            ul += `${validResult ? '<div class="mb-3">업로드 가능</div>' : '<div class="mb-3 text-danger">업로드 불가능</div>'}`;
            ul += `${file.name}`;
            ul += `<span class="badge rounded-pill text-bg-${validResult ? 'success' : 'danger'}">${file.size}</span></div>`;
        }
        ul += `</li></ul>`;
        div.innerHTML = ul;

        if(isOk == 0){
            document.getElementById('regBtn').disabled = true;
        }

    }
})

/*
<ul class="list-group">
  <li class="list-group-item">An item</li>
</ul>

*/