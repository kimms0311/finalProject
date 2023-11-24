//프로필 버튼 클릭시 메뉴 나타나게(토글)
document.getElementById('my').addEventListener('click',()=>{
    if(document.getElementById('myMenu').classList.contains('off')){
        document.getElementById('myMenu').style = "display:inline-block";
        document.getElementById('myMenu').classList.remove('off');
        document.getElementById('myMenu').classList.add('on');
    
    }else{
        document.getElementById('myMenu').style = "display:none";
        document.getElementById('myMenu').classList.remove('on');
        document.getElementById('myMenu').classList.add('off');
    }
})

//로그아웃
document.getElementById('logoutLink').addEventListener('click', (e)=>{
	e.preventDefault(); //기존에 있던 이벤트를 없애는 형태
	document.getElementById('logoutForm').submit();
})