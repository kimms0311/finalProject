document.getElementById('showPwBtn').addEventListener('click',(e)=>{
    let pwInput = document.getElementById('pw');

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

let resultZone = document.getElementById('resultZone');
if (isOk == -1) {
    resultZone.innerText = '잘못된 비밀번호입니다.';
} 