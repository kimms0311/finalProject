
console.log("boardRegister.js connect");

// 트리거 버튼 클릭시 file업로드 실행
document.getElementById('trigger').addEventListener('click',()=>{
    document.getElementById('files').click();
});

//이미지 파일만 가능한 정규표현식 작성
const regExpImg = new RegExp("\.(jpg|jpeg|png)$"); //이미지 파일만 
const maxSize = 1024*1024*20; //파일 최대 사이즈

function fileValidation(fileName, fileSize){

    if(regExpImg.test(fileName) && fileSize < maxSize){
        return 1;
    }else {
        return 0;
    }
}

document.addEventListener('change',(e)=>{
    console.log("change >> e.target"+e.target);
    if(e.target.id == 'files'){
        //파일을 다시 추가할 때는 버튼 상태를 원래대로 변경
        document.getElementById('regBtn').disabled = false;
        
        //input file element에 저장된 file의 정보를 가져오는 property 
        const fileObj = document.getElementById('files').files;
        console.log(fileObj);

        //첨부파일에 대한 정보를 fileZone에 기록
        let div = document.getElementById('fileZone');
        
        //기존 값이 있다면 삭제
        div.innerHTML="";

        let isOk = 1; //여러 파일이 모두 검증에 통과해야 하기 때문에 * 로 각 파일마다 통과여부 확인
        let ul=`<ul class="list-group list-group-flush">`;
            for(let file of fileObj){
                let vaildResult = fileValidation(file.name, file.size); //0 또는 1로 리턴
                isOk *= vaildResult;
                ul+= `<li class="list-group-item d-flex justify-content-between align-items-start">`;
                ul+= `<div class="img">`;
                ul+= `<img alt="첨부이미지영역" src="${file.result}">`;
                ul+= `</div>`;
                ul+= `<div class="ms-2 me-auto">`;
                ul+= `${vaildResult ? '<div class="fw-bold">업로드 가능</div>' : '<div class="fw-bold text-danger">업로드 불가능</div>'}`;
                ul+= `${file.name}</div>`;
                ul+= `<span class="badge rounded-pill text-bg-${vaildResult ? 'success':'danger'}">${file.size}Bypes</span></li>`;
            }
            ul +=`</ul>`;
            div.innerHTML = ul;

            if(isOk == 0){
                document.getElementById('regBtn').disabled = true;
            }
    }
})