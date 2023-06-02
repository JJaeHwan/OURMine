<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

    <title>회원가입</title>
    <link rel="icon" href="#" type="image/x-icon"> <!-- Favicon-->
    <!-- project css file  -->
    <link rel="stylesheet" href="${cPath }/resources/css/my-task.style.min.css">

    <script type="text/javascript" src="${cPath}/resources/js/jquery-3.6.3.min.js"></script>

</head>
<style>
   #nextBtn{
      width: 380px;
   }
   .error {
      color: red;
   }
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("#btnRegist").bind("click", function(){
			$("#frmRegist").submit();
		});
	})
</script>

<body>

<div id="mytask-layout" class="theme-indigo">

    <!-- main body area -->
    <div class="main p-2 py-3 p-xl-5">

        <!-- Body: Body -->
        <div class="body d-flex p-0 p-xl-5">
            <div class="container-xxl">

                <div class="row g-0">
                    <div class="col-lg-6 d-none d-lg-flex justify-content-center align-items-center rounded-lg auth-h100">
                        <div style="max-width: 25rem;">
                            <div class="text-center mb-5">
                                 <svg  width="4rem" fill="currentColor" class="bi bi-clipboard-check" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
                                    <path d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1v-1z"/>
                                    <path d="M9.5 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5h3zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3z"/>
                                </svg>
                            </div>
                            <div class="mb-5">
                                <h2 class="color-900 text-center">My-Task Let's Management Better</h2>
                            </div>
                            <!-- Image block -->
                            <div class="">
                                <img src="${cPath }/resources/images/login-img.svg" alt="login-img">
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 d-flex justify-content-center align-items-center border-0 rounded-lg auth-h100">
                        <div class="w-100 p-3 p-md-5 card border-0 bg-dark text-light" style="max-width: 32rem;">
                            <!-- Form -->
                            <form id="frmRegist" name="frmRegist" action="${cPath }/member/memberJoin" method="post" class="row g-1 p-3 p-md-4" onsubmit="handleSubmit(event)">
                                <div class="col-12 text-center mb-1 mb-lg-5">
                                    <h1>회원가입</h1>
                                </div>
                                <div class="col-12">
                                    <div class="mb-2">
                                        <label class="form-label">이메일</label>
                                        <input name="memberEmail" type="email" class="form-control form-control-lg" placeholder="name@example.com" onchange="handleChange(event)"/>
                                        <span id="check"></span>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="mb-2">
                                        <label class="form-label">이름</label>
                                        <input name="memberName" class="form-control form-control-lg" placeholder="이름" onchange="handleChange(event)"/>
                                    	<span id="memberName"></span>
                                    </div>
                                </div>
                                  <div class="col-12">
                                    <div class="mb-2">
                                        <label class="form-label">전화번호</label>
                                        <input name="memberTel" class="form-control form-control-lg" placeholder="010-1111-1111" onchange="handleChange(event)"/>
                                    	<span id="memberTel"></span>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="mb-2">
                                        <label class="form-label">비밀번호</label>
                                        <input name="memberPassword"  type="password" class="form-control form-control-lg" placeholder="비밀번호(8~20자 영문,숫자,특수문자 조합)" onchange="handleChange(event)"/>
                                        <span id="pass"></span>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="mb-2">
                                        <label class="form-label">비밀번호 확인</label>
                                        <input type="password" name="memberPasswordResult" class="form-control form-control-lg" placeholder="비밀번호 재입력" onchange="handleChange(event)"/>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                                        <label class="form-check-label" for="flexCheckDefault">
                                            <a href="#" title="Terms and Conditions" class="text-secondary">서비스 이용약관, 개인정보 처리방침</a>을 확인하였고,이에 동의합니다.
                                        </label>
                                        <span id="terms"></span>
                                    </div>
                                </div>
                                <div class="col-12 text-center mt-4">
                                    <button type="button" class="btn btn-lg btn-block btn-light lift text-uppercase" alt="SIGNUP" id="btnRegist">회원가입</button>
                                </div>
                                <div class="col-12 text-center mt-4">
                                    <span class="text-muted"> 이미 가입 하셨나요? <a href="/ourmine/login" class="text-secondary"> 로그인 하러가기 </a></span>
                                </div>
                            </form>
                            <!-- End Form -->
                        </div>
                    </div>
                </div> <!-- End Row -->
            </div>
        </div>
    </div>
</div>
    <script>
    let regex = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])"); // 이메일 정규식
    let reg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/; // 비밀번호 정규식
    let regPone = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/; // 전화번호 정규식
    let memberName  = document.querySelector("#memberName")
    let memberTel  = document.querySelector("#memberTel")
    let check = document.querySelector("#check")
  	let pass =  document.querySelector("#pass")
    let isTel = true;
    let isEmail = true;
    let ismemName = true;
  	let isPassword = true;
    let isFormCheckInput = false;
    let formCheckInput = document.querySelector('.form-check-input');
    let terms = document.querySelector('#terms');


    formCheckInput.addEventListener('click', () => isFormCheckInput = !isFormCheckInput)



     const member = {
    		 memberName : '',
    		 memberEmail : '',
    		 memberTel : '',
    		 memberPassword : '',
    		 memberPasswordResult : '',
     }
     const handleChange = (e) => {
    	 const {name,value} = e.target;
    	  console.log(name,value)
    	  add(name,value);
    	  handlePasscheck();
    	  handlePhoeCheck();
    	  handleNameCheck();
    	  handleCheckChange();

     }
     const add = (name,value) => {
  	 	 member[name] = value;
  	 	 console.log(member);
    }

    const handlePhoeCheck = () => {
    	if(member.memberTel === ''){
    		memberTel.innerHTML = '';
    		isTel = false;
    		return false;
    	}
    	if(!regPone.test(member.memberTel)){
    		memberTel.innerHTML = '';
    		memberTel.innerHTML = '올바른 전화번호 형식이 아닙니다.';
    		memberTel.style.color = 'red'
    		isTel = false;
			return false;
    	}else {
    		memberTel.innerHTML = '';
    		memberTel.innerHTML = '사용가능한 전화번호 입니다';
    		memberTel.style.color = 'green';
    		isTel = true;
    	}
    }
    const handleNameCheck = () => {
    	if(member.memberName === ''){
    		memberName.innerHTML = '';
    		memberName.innerHTML = '이름을 입력해주세요';
    		ismemName = false;
    		return false;
    	}else {
    		memberName.innerHTML = '';
    		ismemName = true;
    	}

    }

     const handleCheckChange = () => {
  //  	 e.preventDefault();
    	 fetch('/ourmine/member/member/json',{
     		method : 'POST',
     		 headers: {
     			    'Content-Type': 'application/json',

     			  },
     		 body: JSON.stringify(member),
     	 })
     	.then((response) => response.json())
     	.then((data) => {
     			if(member.memberEmail === ''){
     				check.innerHTML = '';
     				isEmail = false;
     				return false;
     			}
     			if( !regex.test(member.memberEmail)){
     				check.innerHTML = '';
     				check.innerHTML = '올바른 이메일 형식이 아닙니다.';
     				check.style.color = 'red'
     				isEmail = false;
     				return false;
     			}else{
     				if(data > 0){
     				check.innerHTML = '';
     	     		 check.innerHTML = '이미 가입된 이메일입니다.';
     	     		check.style.color = 'red';
     	     		isEmail = false;
     	     		return false;
     	     		 }else{
     	     		check.innerHTML = '';
     	     		check.innerHTML = '사용 가능한 이메일입니다.';
     	     		check.style.color = 'green';
     	     		isEmail = true;
     	     		return false;
     	     	  }
     			}



     		 })

     }
   const handlePasscheck = () => { // 비밀번호 정규식 체크
    	let password = member.memberPassword;
   		console.log(password);
    	 if(member.memberPassword === ''){
    		 pass.innerHTML = '';
    		 isPassword = false;
    		 return false;
    	 }
    	if( !reg.test(password)){
    		 pass.innerHTML = '올바른 비밀번호 형식이 아닙니다.';
			 pass.style.color = 'red';
			 isPassword = false;
			 return false;
    	}else{
    		 pass.innerHTML = '사용 가능한 비밀번호 입니다.';
			 pass.style.color = 'green';
			 isPassword = true;
			 return false;
    	}
   }

     const handleSubmit = (e) => {

    	 e.preventDefault();

		 if( ! isFormCheckInput ){
			 terms.innerHTML = '';
			 terms.innerHTML = '약관을 체크해 주세요';
			 terms.style.color = 'red';
         }else{
			 terms.innerHTML = '';
         }

    	 if(member.memberEmail === ''){
    		 check.innerHTML = '';
			check.innerHTML = '이메일을 입력해주세요';
			check.style.color = 'red';
			isEmail = false;
    	 }
    	 if(member.memberName === ''){
    		 memberName.innerHTML = '';
    		 memberName.innerHTML = '이름을 입력해주세요';
    		 memberName.style.color = 'red';
    		 ismemName = false;
    	 }
    	 if(member.memberTel === ''){
    		 memberTel.innerHTML = '';
    		 memberTel.innerHTML = '전화번호를 입력해주세요';
    		 memberTel.style.color = 'red';
    		 isTel = false;
    	 }
    	 if(member.memberPassword === ''){
    		 pass.innerHTML = '';
    		 pass.innerHTML = '';
    		 pass.innerHTML = '비밀번호를 입력해주세요';
    		 pass.style.color = 'red'
    	     isPassword = false;

    	 }else{

    		 if(member.memberPassword != member.memberPasswordResult){
        		 pass.innerHTML = '';
        		 pass.innerHTML = '비밀번호 가 같지 않습니다.';
        		 pass.style.color = 'red';
        		 isPassword = false;
        	 }
    	 }

    	 console.log("istel = ",isTel);
    	 console.log("isEmail = ",isEmail);
    	 console.log("ismemName = ",ismemName);
    	 console.log("isPassword = ",isPassword);
    	 console.log("isFormCheckInput = ",isFormCheckInput);

    	 if(isTel && isEmail && ismemName && isPassword && isFormCheckInput) {
    	 fetch('/ourmine/member/memberJoin',{
    		method : 'POST',
    		 headers: {
    			    'Content-Type': 'application/json',
    			    'accept': 'application/json',
    			  },
    		 body: JSON.stringify(member),
    	 })
    		 .then((response) => response.json())
    		 .then((data) => {
    			 if(data > 0){
    				  console.log('성공:', data);
    				  location.href = '/ourmine/homepage';
    			 }

    		 })

    	 }
     }

     </script>


