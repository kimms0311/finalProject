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

// async function insertFileToServer(category, file){
//     try {
//         let path = "/"+category+"/"+file;
//         let config = {
//             method : "post",
//             headers : {
//                 "content-type" : "application/json; charset=UTF-8"
//             },
//             body : JSON.stringify(file)
//         };

//         const resp = await fetch(path, config);
//         const result = await resp.text();
//         return result;
//     } catch (error) {
//         console.log(error);
//     }
// }

// 파일을 업로드했을 경우
document.addEventListener('change', (e)=>{
    if(e.target.id == 'files'){
        document.getElementById('fileZone').style = "display:block";
        document.getElementById('fileForm').style = "margin-bottom:0px";

        document.getElementById('regBtn').disabled = false;

        // input file 요소에 저장된 file 정보를 가져오는 속성
        const fileObj = document.getElementById('files').files;
        console.log(fileObj);

        let div = document.getElementById('fileZone');

        // 기존값 삭제
        div.innerHTML = "";

        let isOk = 1;
        let ul = `<ul class="imageUl">`;
        for (let i = 0; i < fileObj.length; i++) {
            let file = fileObj[i];
            let validResult = fileValidation(file.name, file.size);
            isOk *= validResult;
            ul += `<li class="imageLi ${i === fileObj.length - 1 ? 'last-file' : ''}" id="${file.name}">`; 
            ul += `<div class="oneImg">`; //마지막 파일일 때 클래스 추가
            ul += `${file.name}`;
            ul += `<span class="${validResult ? 'imgOk' : 'imgNo'}">${validResult ? '가능' : '불가능'}</span></div>`;
            ul += `<button class="imageCancelBtn" data-filename="${file.name}">X</button></li>`;
        }
        ul += `</ul>`;
        div.innerHTML = ul;

        if(isOk == 0){
            document.getElementById('regBtn').disabled = true;
        }

    }
    
})


//파일 삭제버튼 메서드
document.addEventListener('click', (e) => {
    const fileInput = document.getElementById('files');
    const fileObj = fileInput.files;
    let fileObjLength = fileObj.length;

    if (e.target.classList.contains('imageCancelBtn')) {
        const filename = e.target.dataset.filename;
        const liToRemove = document.getElementById(filename);
        
        if (liToRemove) {
            fileObjLength--;
            liToRemove.remove();
    
            // 새로운 FileList 생성
            const newFileList = createFileListWithoutFileName(fileObj, filename);
    
            // 새로운 FileList를 input에 설정
            fileInput.files = newFileList;
        }
    
        console.log(fileObjLength);
    
        if (fileObjLength == 0) {
            document.getElementById('fileZone').style = "display:none";
            document.getElementById('fileForm').style = "margin-bottom:30px";
        }
    }
});

function createFileListWithoutFileName(fileList, fileNameToRemove) {
    const newFiles = [];
    
    for (let i = 0; i < fileList.length; i++) {
        if (fileList[i].name !== fileNameToRemove) {
            newFiles.push(fileList[i]);
        }
    }
    console.log(newFiles);
    // 새로운 FileList 생성
    const newFileList = new DataTransfer();
    
    for (const file of newFiles) {
        newFileList.items.add(file);
    }
    
    return newFileList.files;
}

/*
<ul class="list-group">
  <li class="list-group-item">An item</li>
</ul>

*/