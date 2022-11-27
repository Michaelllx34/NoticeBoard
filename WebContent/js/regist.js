function sendit(){
    //id/password를 입력했을때만 true 되어 넘어가도록
    const userid = document.getElementById('userid');
    const isIdCheck = document.getElementById('isIdCheck')
    const userpw = document.getElementById('userpw');
    const userpw_re = document.getElementById('userpw_re');
    const name = document.getElementById('name');
    const hp = document.getElementById('hp');
    const email = document.getElementById('email');
    const hobby = document.getElementsByName('hobby');

    //정규표현식
    const expIdText = /^[A-Za-z]{4,20}$/;
    const expPwText = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}/;
    const expNameText = /[가-힣]+$/;
    const expHpText = /^\d{3}-\d{3,4}-\d{4}$/;
    const expEmailText = /^[A-Za-z0-9\-\.]+@[A-Za-z0-9\-\.]+\.[A-Za-z0-9]+$/;
    
    //id
    if(userid.value == ''){
        alert('아이디를 입력하세요');
        userid.focus();
        return false;
    }
    if(!expIdText.test(userid.value)){
        alert('아이디는 4자이상 20자 이하의 대문자로 시작하는 조합이다.');
        userid.focus();
        return false;
    }
    //isIdcheck
    if(isIdCheck.value == 'n'){
    	alert('아이디 중복체크 버튼을 눌러주세요');
    	return false;
    }

    //password 
    if(userpw.value == ''){
        alert('비밀번호를 입력하세요');
        userpw.focus(); 
        return false;
    }
    if(!expPwText.test(userpw.value)){
        alert('비밀번호 형식을 확인하세요.\n영어 대문자, 소문자, 숫자, 특수문자을 포함한 8자이상')
        userpw.focus();
        return false;
    }
    if(userpw.value != userpw_re.value){
        alert('비밀번호와 비밀번호 확인의 값이 다릅니다');
        userpw_re.focus();
        return false;
    }

    //name
    if(!expNameText.test(name.value)){
        alert('이름은 한글로 입력하세요.')
        name.focus();
        return false;
    }

    //hp
    if(!expHpText.test(hp.value)){
        alert('휴대폰번호 형식을 확인하세요\n 하이픈(-)dmf 포함해야 합니다.');
        hp.focus();
        return false;
    }
    
    //email
    if(!expEmailText.test(email.value)){
        alert('이메일 형식을 확인하세요\n.');
        email.focus();
        return false;
    }

    //hobby
    let count =0;
    for(let i in hobby){
        if(hobby[i].checked){
            count++;
        }
    }
    if(count == 0 ){
        alert('취미는 적어도 한개 이상 선택하세요');
        return false;
    }
    return true
}	

//중복체크

function clickBtn(){
	const xhr = new XMLHttpRequest();
	const userid = document.getElementById('userid').value;
	const isIdCheck = document.getElementById('isIdCheck');
	xhr.open('get', 'idcheck.jsp?userid='+userid, true);
	xhr.send();
	xhr.onreadystatechange = function(){
		if(xhr.readyState == XMLHttpRequest.DONE && xhr.status ==200){
			const result = xhr.responseText;
			if(result.trim() == "ok"){
				document.getElementById('checkmsg').innerHTML = "<b style='color:deepskyblue'>사용할 수 있는 아이디</b>";
				isIdCheck.value ='y';
			}else{
				document.getElementById('checkmsg').innerHTML = "<b style='color:red'>사용할 수 없는 아이디</b>";
			}
		}
	}
}

function idModify(){
	const isIdCheck = document.getElementById('isIdCheck');
	isIdCheck.value='n';
	document.getElementById('checkmsg').innerHTML = " ";
}
