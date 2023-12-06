//파일 첨부
document.getElementById('trigger').addEventListener('click',()=>{
    document.getElementById('files').click();
});
 
const regExpImg = new RegExp("\.(jpg|jpeg|png|gif)$");
const maxSize = 1024*1024*20; 

function fileValidation(fileName, fileSize){
    if(!regExpImg.test(fileName)){
        return 0;
    }else 
    if(fileSize > maxSize){
        return 0;
    }else {
        return 1;
    }
}

document.addEventListener('change', (e) => {
    if (e.target.id == 'files') {
        document.getElementById('regBtn').disabled = false;
        const fileObj = document.getElementById('files').files;
        let div = document.getElementById('fileZone');
        div.innerHTML = "";
        let isOk = 1;
        let ul = `<ul>`;

        for (let file of fileObj) {
            let validResult = fileValidation(file.name, file.size);
            isOk *= validResult;

            if (validResult) {
                ul += `<li>`;
                ul += `<div>`;

                var reader = new FileReader();
                reader.onload = function(e) {
                    var img = document.createElement("img");
                    img.setAttribute("src", e.target.result);
                    img.setAttribute("style", "max-width: 100px; max-height: 100px; margin-right: 10px;");
                    document.querySelector("div#fileZone").appendChild(img);
                };
                reader.readAsDataURL(file);
                ul += `</div>`;
                ul += `</li>`;
            }
        }
        ul += `</ul>`;
        div.innerHTML = ul;

        if (isOk == 0) {
            document.getElementById('regBtn').disabled = true;
        }
    }
});

//등록 버튼 클릭 시 alert
document.getElementById('regBtn').addEventListener('click', (e) => {
    var selectedValue = document.getElementById('proMenu').value;
    var titleValue = document.getElementById('title').value;
    var contentValue = document.getElementById('content').value;

    if (selectedValue === "unselect") {
        alert("업종을 선택해 주세요.");
        //폼 제출 막음
        e.preventDefault();
    } else {
        if (titleValue == "" || titleValue == null || contentValue == "" || contentValue == null) {
            alert("빈칸을 입력해 주세요.");
            e.preventDefault();
        }
    }
});

//메뉴 추가, 삭제 버튼
document.addEventListener('click', (e) => {
    let ul = document.getElementById("menuList");

    if (e.target.id === 'addMenu') {
        //li 생성
        let li = document.createElement('li');
        li.innerHTML = `
            메뉴 : <input type="text" name="menus">
            가격 : <input type="text" name="prices">
            설명 : <input type="text" name="explains">
            <button type="button" id="delMenu">삭제</button>
        `;
        //li 추가
        ul.appendChild(li);
    } else if (e.target.id === 'delMenu') {
        //li 삭제
        e.target.closest('li').remove();
    }
});