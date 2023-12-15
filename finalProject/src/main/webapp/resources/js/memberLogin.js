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

// document.getElementById('loginBtn').addEventListener('click',(e)=>{
//     let emailInput = document.getElementById('email');
//     let pwInput = document.getElementById('pw');

//     if(emailInput.value == null || emailInput.value == ''){
//         emailInput.focus();
//         document.getElementById('emailMsg').style = "display:inline-block";
//         document.getElementById('pwMsg').style = "display:none";
//         document.getElementById('pwMsg').style = "display:none";
//     }else if(emailInput.value != null || emailInput.value != '' && pwInput.value == null || pwInput.value == ''){
//         pwInput.focus();
//         document.getElementById('pwMsg').style = "display:inline-block";
//         document.getElementById('emailMsg').style = "display:none";
//         document.getElementById('emailMsg').style = "display:none";
//     }
// })