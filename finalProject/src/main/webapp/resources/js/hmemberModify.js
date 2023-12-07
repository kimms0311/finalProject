//지도 api
document.getElementById('addr').addEventListener('click', ()=>{
    //카카오 지도 발생
    new daum.Postcode({
        oncomplete: function(data) { //선택시 입력값 세팅
            console.log(data);
            // document.getElementById('addr').value = data.address;
            document.getElementById('addr').value = `${data.sido} ${data.sigungu} ${data.bname}`;
            document.getElementById('sido').value = data.sido;
            document.getElementById('sigg').value = data.sigungu;
            document.getElementById('emd').value = data.bname;
            registerBtnAbled();
        }
    }).open();
})

//비밀번호 눈 버튼 
document.getElementById('showPwBtn1').addEventListener('click',(e)=>{
    let pwInput = document.getElementById('pw1');
    
    if (pwInput.type === "password") {
        pwInput.type = "text";
        let showPwBtn = document.getElementById('showPwBtn1');
        showPwBtn.className = showPwBtn.className.replace('bi-eye-slash', 'bi-eye');
    } else {
        pwInput.type = "password";
        let showPwBtn = document.getElementById('showPwBtn1');
        showPwBtn.className = showPwBtn.className.replace('bi-eye', 'bi-eye-slash');
    }
})

document.getElementById('showPwBtn2').addEventListener('click',(e)=>{
    let pwInput = document.getElementById('pw2');

    if (pwInput.type === "password") {
        pwInput.type = "text";
        let showPwBtn = document.getElementById('showPwBtn2');
        showPwBtn.className = showPwBtn.className.replace('bi-eye-slash', 'bi-eye');
    } else {
        pwInput.type = "password";
        let showPwBtn = document.getElementById('showPwBtn2');
        showPwBtn.className = showPwBtn.className.replace('bi-eye', 'bi-eye-slash');
    }
})

//비밀번호 정규표현식
let pwVal = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;

document.getElementById('pw1').addEventListener('keyup',()=>{
    let pw1 = document.getElementById('pw1').value;
    let pw2 = document.getElementById('pw2').value;

    //문자길이
    if(pw1.length < 8 || pw1.length > 16){
        document.getElementById('pwMsg2_1').style = "display:inline-block";
    }else{
        document.getElementById('pwMsg2_1').style = "display:none";
        //정규표현식
        if(!pwVal.test(pw1)){
            document.getElementById('pwMsg1_1').style = "display:inline-block";
            document.getElementById('pwMsg1_2').style = "display:none";
            document.getElementById('pwMsg2_2').style = "display:none";
            registerBtnAbled();
        } else{
            document.getElementById('pwMsg1_1').style = "display:none";

            //비밀번호 입력 체크
            if(pw1!=='' && pw2=='') {
                document.getElementById('pwMsg2_2').style = "display:inline-block";
            } else {
                document.getElementById('pwMsg2_2').style = "display:none";
                registerBtnAbled();
            }
        }
    }   
})

document.getElementById('pw2').addEventListener('keyup',()=>{
    let pw1 = document.getElementById('pw1').value;
    let pw2 = document.getElementById('pw2').value;

    //비밀번호 입력 체크
    if(pw1!=='' && pw2=='') {
        document.getElementById('pwMsg2_2').style = "display:inline-block";
     } else if(pw1=='' && pw2=='') {
        document.getElementById('pwMsg1_1').style = "display:none";
        document.getElementById('pwMsg2_1').style = "display:none";
        document.getElementById('pwMsg1_2').style = "display:none";
        document.getElementById('pwMsg2_2').style = "display:none";
        registerBtnAbled();
     } else {
         document.getElementById('pwMsg2_2').style = "display:none";
  
        //비밀번호 일치 체크
        if(pw1!=pw2){
            document.getElementById('pwMsg1_2').style = "display:inline-block";
        } else {
            document.getElementById('pwMsg1_2').style = "display:none";
            registerBtnAbled();
        }
     }
})

//닉네임 중복 체크
document.getElementById('nick').addEventListener('change', async ()=>{
    let nick = document.getElementById('nick').value;
    console.log(nick);
    
    const result = await hasNick(nick);
    if(result == 1){
        document.getElementById('nickMsg').style = "display:inline-block";
    }else{
        document.getElementById('nickMsg').style = "display:none";
        registerBtnAbled();
    }
})

//닉네임 전송 메서드
async function hasNick(nick){
    try{
        const resp = await fetch('/member/nick/'+nick);
        const result = await resp.text();
        return result;

    }catch(err){
        console.log(err);
    }
}

//모든 조건 충족시 가입하기 버튼오픈
function registerBtnAbled(){
    const pwMsg1_1 = document.getElementById('pwMsg1_1');
    const pwMsg2_1 = document.getElementById('pwMsg2_1');
    const pwMsg1_2 = document.getElementById('pwMsg1_2');
    const pwMsg2_2 = document.getElementById('pwMsg2_2');
    const nickMsg = document.getElementById('nickMsg');
    const addrValue = document.getElementById('addr').value;
    const nickValue = document.getElementById('nick').value;

    const pwMsg1_1Display = window.getComputedStyle(pwMsg1_1).getPropertyValue('display');
    const pwMsg2_1Display = window.getComputedStyle(pwMsg2_1).getPropertyValue('display');
    const pwMsg1_2Display = window.getComputedStyle(pwMsg1_2).getPropertyValue('display');
    const pwMsg2_2Display = window.getComputedStyle(pwMsg2_2).getPropertyValue('display');
    const nickMsgDisplay = window.getComputedStyle(nickMsg).getPropertyValue('display');

    if(pwMsg1_1Display === 'none' && pwMsg2_1Display === 'none'&& pwMsg1_2Display === 'none' && pwMsg2_2Display === 'none' && nickMsgDisplay ==='none'
        && addrValue !== '' && nickValue !== ''){
       document.getElementById('regiBtn').disabled = false;
   } else {
       document.getElementById('regiBtn').disabled = true;
   }
}

//탈퇴 버튼
async function deleteMemBtn(email){
    try{
        const url = '/hmember/deleteMember/'+email;
        const config ={
            method: 'delete'
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        console.log(result);

        if (result === '1') {
            console.log("success");
            window.location.replace('http://localhost:8089/');
        }
    }catch(err){
        console.log(err);
    }
}

document.getElementById('deleteMemBtn').addEventListener('click',(e)=>{
    if (confirm('정말 탈퇴하시겠어요? \n작성한 댓글은 자동으로 삭제되지 않습니다.')) {
        deleteMemBtn(email);
    }
});


