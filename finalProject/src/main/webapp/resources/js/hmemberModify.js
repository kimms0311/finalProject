//서연
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
        }
    }).open();
})

document.addEventListener('click',()=>{
    document.getElementById('e').value
})

//비밀번호 눈 버튼 
document.getElementById('showPwBtn').addEventListener('click',(e)=>{
    let pwInput = document.getElementById('pw1');

    if (pwInput.type === "password") {
        pwInput.type = "text";
        let showPwBtn = document.getElementById('showPwBtn');
        showPwBtn.className = showPwBtn.className.replace('bi-eye-slash', 'bi-eye');
    } else {
        pwInput.type = "password";
        let showPwBtn = document.getElementById('showPwBtn');
        showPwBtn.className = showPwBtn.className.replace('bi-eye', 'bi-eye-slash');
    }
})

//이메일 정규표현식&중복체크
let emailVal = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
document.getElementById('email').addEventListener('change',()=>{
    let email = document.getElementById('email').value;
    console.log(email);
    //정규표현식
    if(!emailVal.test(email)){
        document.getElementById('emailMsg').style = "display:inline-block";
        document.getElementById('emailMsg2').style = "display:none";
    }else{
        document.getElementById('emailMsg').style = "display:none";
        //이메일 존재 여부
        hasEmail(email).then(result =>{
            if(result == 1){
                document.getElementById('emailMsg2').style = "display:inline-block";
            }else{
                document.getElementById('emailMsg2').style = "display:none";
            }
        })
    }
})

//이메일 전송 메서드
async function hasEmail(email){
    try{
        const resp = await fetch('/member/email/'+email);
        const result = await resp.text();
        return result;

    }catch(err){
        console.log(err);
    }
}

//비밀번호 정규표현식
let pwVal = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
document.getElementById('pw').addEventListener('change',()=>{
    let pw = document.getElementById('pw').value;
    console.log(pw);

    //문자길이
    if(pw.length < 8 || pw.length > 16){
        document.getElementById('pwMsg2').style = "display:inline-block";
    }else{
        document.getElementById('pwMsg2').style = "display:none";
        //정규표현식
        if(!pwVal.test(pw)){
            document.getElementById('pwMsg').style = "display:inline-block";
        }else{
            document.getElementById('pwMsg').style = "display:none";
        }
    }

    
})

//닉네임 중복체크
document.getElementById('nick').addEventListener('change',()=>{
    let nick = document.getElementById('nick').value;
    console.log(nick);
    
    hasNick(nick).then(result =>{
        if(result == 1){
            document.getElementById('nickMsg').style = "display:inline-block";
        }else{
            document.getElementById('nickMsg').style = "display:none";
        }
    })

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



//하연
document.getElementById('pw2').addEventListener('change',()=>{
    let pw1 = document.getElementById('pw1').value;
    let pw2 = document.getElementById('pw2').value;

    //비밀번호 일치 확인
    if(pw1!=pw2){
        document.getElementById('pwMsg3').style = "display:inline-block";
    } else {
        document.getElementById('pwMsg3').style = "display:none";
    }
})

//비밀번호 눈 버튼 
document.getElementById('showPwBtn2').addEventListener('click',(e)=>{
    let pwInput2 = document.getElementById('pw2');

    if (pwInput2.type === "password") {
        pwInput2.type = "text";
        let showPwBtn = document.getElementById('showPwBtn2');
        showPwBtn.className = showPwBtn.className.replace('bi-eye-slash', 'bi-eye');
    } else {
        pwInput2.type = "password";
        let showPwBtn = document.getElementById('showPwBtn2');
        showPwBtn.className = showPwBtn.className.replace('bi-eye', 'bi-eye-slash');
    }
})