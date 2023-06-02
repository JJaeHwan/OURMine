<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>      
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="security"%>    

<script type="text/javascript" src="${cPath}/resources/js/sweetalert2/sweetalert2.all.min.js"></script>
<link rel="stylesheet" href="${cPath}/resources/js/sweetalert2/sweetalert2.min.css">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <title>:: My-Task:: Signin</title>
    <link rel="icon" href="#" type="image/x-icon"> <!-- Favicon-->
    <!-- project css file  -->
    <link rel="stylesheet" href="${cPath }/resources/css/my-task.style.min.css">
</head>
   <c:if test="${not empty message }">
   <script type="text/javascript">
      window.addEventListener("DOMContentLoaded", function(){
         Swal.fire({
              icon: 'error',
              title: 'Oops...',
              text: '${message}'
            })
      });
   </script>
   </c:if>
<style>
	#signIn{
		width: 360px;
	}
</style>
<script type="text/javascript">
   	function fnMemberSelect(event){
   		for(let op of event.target.options){
   			if(op.selected){
   				document.loginForm.memberEmail.value = op.dataset.memEmail??"";
   				document.loginForm.memPass.value = op.dataset.memPass??"";
   			}
   		}	
   	}
</script>
<body>

<div id="mytask-layout" class="theme-indigo">

    <!-- main body area -->
    <div class="main p-2 py-3 p-xl-5 ">
        
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
                            <form method="post" class="row g-1 p-3 p-md-4" name="loginForm">
                            <security:csrfInput/>
                                <div class="col-12 text-center mb-1 mb-lg-5">
                                    <h1>로그인</h1>
                                </div>
                                <div class="col-12">
                                    <div class="mb-2">
                                        <label class="form-label">이메일주소</label>
                                        <input id = "memberEmail" name="memberEmail" type="email" class="form-control form-control-lg" placeholder="name@example.com" required />
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="mb-2">
                                        <div class="form-label">
                                            <span class="d-flex justify-content-between align-items-center">
                                                비밀번호
                                                <a class="text-secondary" href="auth-password-reset.html">비밀번호찾기</a>
                                            </span>
                                        </div>
                                        <input id="memPass" name="memberPassword" type="password" class="form-control form-control-lg" placeholder="***************" name="memberPassword" required />
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                                        <label class="form-check-label" for="flexCheckDefault">
                                            기억하기
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12 text-center mt-4">
                                    <input type="submit" value="로그인" class="btn btn-lg btn-block btn-light lift text-uppercase" atl="signin" id="signIn"  />
                                </div>
                                <div class="col-12 text-center mt-4">
                                    <span class="text-muted"> 아직 계정을 가지고 있지 않나요? <a href="/ourmine/member/memberJoin" class="text-secondary"> 회원가입 하러가기 </a></span>
                                </div>
                                <select class="custom-select" onchange="fnMemberSelect(event);">
						          	<option>로그인유저 선택</option>
						          	<option data-mem-email="wjdwoghks@naver.com" data-mem-pass="wjdwoghks12!">상위관리자[ADMIN]</option>
						          	<option data-mem-email="dlwpdls@naver.com" data-mem-pass="wjdwoghks12!">기업관리자[MANAGER]</option>
						          	<option data-mem-email="djawl@naver.com" data-mem-pass="wjdwoghks12!">일반회원[MEMBER, COMPANY 1, PROJECT 1]</option>
						          	<option data-mem-email="dlfma10@naver.com" data-mem-pass="wjdwoghks12!">일반회원[MEMBER, COMPANY 3, PM]</option>
						          	<option data-mem-email="dlfma12@naver.com" data-mem-pass="wjdwoghks12!">일반회원[MEMBER, COMPANY 3, PL]</option>
						          	<option data-mem-email="dlfma13@naver.com" data-mem-pass="wjdwoghks12!">일반회원[MEMBER, COMPANY 3, EMPLOYEE]</option>
						          </select>
                                
                            </form>
                            <!-- End Form -->
                        </div>
                    </div>
                </div> <!-- End Row -->
            </div>
        </div>
    </div>
</div>

<!-- Jquery Core Js -->
<script src="${cPath }/resources/js/libscripts.bundle.js"></script>
</body>
</html>


