<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="body d-flex py-lg-3 py-md-2">
         <div class="container-xxl">
             <div class="row clearfix">
                 <div class="col-md-12">
                     <div class="card border-0 mb-4 no-bg">
                         <div class="card-header py-3 px-0 d-flex align-items-center  justify-content-between border-bottom">
                            <h3 class=" fw-bold flex-fill mb-0">나의 회사</h3>
                             <div class="btn-group" role="group" aria-label="Basic outlined example">
                             <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#editproject"><i class="icofont-edit text-success"></i></button>
                             <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#deleteproject"><i class="icofont-ui-delete text-danger"></i></button>
                         </div>
                         </div>
                     </div>
                 </div>
             </div><!-- Row End -->
             <div class="row g-3">
                 <div class="col-xl-8 col-lg-12 col-md-12">
                     <div class="card teacher-card  mb-3">
                         <div class="card-body d-flex teacher-fulldeatil">
                             <div class="profile-teacher pe-xl-4 pe-md-2 pe-sm-4 pe-4 text-center w220">
                                 <a href="#">
                                     <img src="assets/images/lg/avatar3.jpg" alt="" class="avatar xl rounded-circle img-thumbnail shadow-sm">
                                 </a>
                                 <div class="about-info d-flex align-items-center mt-3 justify-content-center flex-column">
                                     <h6 class="mb-0 fw-bold d-block fs-6 memberName"></h6>
                                     <span class="text-muted small memberGrade"></span>
                                 </div>
                             </div>
                             <div class="teacher-info border-start ps-xl-4 ps-md-4 ps-sm-4 ps-4 w-100">
                                 <h6  class="mb-0 mt-2  fw-bold d-block fs-6 memberCompany"></h6>
                                 <span class="py-1 fw-bold small-11 mb-0 mt-1 text-muted">Ryan Ogden</span>
                                 <p class="mt-2 small">The purpose of lorem ipsum is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesn't distract from the layout. A practice not without controversy</p>
                                 <div class="row g-2 pt-2">
                                     <div class="col-xl-5">
                                         <div class="d-flex align-items-center">
                                             <i class="icofont-ui-touch-phone"></i>
                                             <span class="ms-2 small memberCompanyTel"></span>
                                         </div>
                                     </div>
                                     <div class="col-xl-5">
                                         <div class="d-flex align-items-center">
                                             <i class="icofont-address-book"></i>
                                             <span class="ms-2 small memberCompanyAddr"></span>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>

                 <form id="sub" onsubmit="handleSubmit(event)">
                     <div class="modal fade" id="editproject" tabindex="-1" aria-hidden="true">

                         <div class="modal-dialog modal-dialog-centered modal-md modal-dialog-scrollable">

                             <div class="modal-content">
                                 <div class="modal-header">
                                     <h5 class="modal-title  fw-bold" id="editprojectLabel">내 회사 수정</h5>
                                     <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                 </div>

                                 <div class="modal-body">
                                     <div class="mb-3">
                                         <label for="exampleFormControlInput78" class="form-label">이름</label>
                                         <input name="companyName" type="text" class="form-control nameInput companyName" id="exampleFormControlInput78" value="" readonly>
                                     </div>


                                     <div class="modal-body">
                                         <div class="mb-3">
                                             <label for="exampleFormControlInput78" class="form-label">주소</label>
                                             <input  name="companyAddr"  type="text" class="form-control mailInput companyAddr" id="exampleFormControlInput78" value="" >
                                             <span id="addr"></span>
                                         </div>


                                         <div class="mb-3">
                                             <label for="exampleFormControlInput78" class="form-label">회사 전화번호</label>
                                             <input  name="memberTel" type="text" class="form-control companyTel" id="exampleFormControlInput78" value="" >
                                             <input  name="memberId" type="hidden" class="form-control IdInput" id="exampleFormControlInput78" value="" >
                                             <span id="tel"></span>
                                         </div>

                                         <div class="mb-3">
                                             <label for="exampleFormControlInput78" class="form-label">비밀번호</label>
                                             <input  name="memberPassword" type="password" class="form-control memberPassword" id="exampleFormControlInput78" value="" >
                                             <span id="pass"></span>
                                     </div>



                                         <div class="modal-footer">
                                             <button type="button" class="btn btn-secondary cancel" data-bs-dismiss="modal" onclick="handelCancel()">취소</button>
                                             <button type="submit" class="btn btn-primary">완료</button>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>

                 </form>
        </div>


 <script>
let memberName = document.querySelector('.memberName');
let memberGrade = document.querySelector('.memberGrade');
let memberPassword = document.querySelector('.memberPassword');
let memberCompany = document.querySelector('.memberCompany');
let memberCompanyTel = document.querySelector('.memberCompanyTel');
let memberCompanyAddr = document.querySelector('.memberCompanyAddr');
let companyName = document.querySelector('.companyName');
let companyAddr = document.querySelector('.companyAddr');
let companyTel = document.querySelector('.companyTel');
let tel = document.querySelector('#tel');
let addr = document.querySelector('#addr');
let pass = document.querySelector('#pass');
let cancel = document.querySelector('.cancel');




const myCompany = {
    companyName : '',
    companyAddr : '',
    companyTel : '',
    memberPassword : ''
}

//headers['Content-Type'] = 'application/json'
headers['accept'] = 'application/json'

const myCompanyAjax = () => {
	fetch('/ourmine/company/companyViewJson',{
		method : 'POST',
        headers : headers,
    }).then(resp => resp.json())
        .then(data => {
	        console.log(data)
            myCompany.companyName = data.companyName;
            myCompany.companyAddr = data.companyAddr;
            myCompany.companyTel = data.companyTel;
            memberName.innerHTML = data.memberName;
            memberGrade.innerHTML = data.memberGrade;
            memberCompany.innerHTML = data.companyName;
            memberCompanyTel.innerHTML =data.companyTel;
            memberCompanyAddr.innerHTML = data.companyAddr
            companyName.value =  data.companyName;
            companyAddr.value = data.companyAddr;
            companyTel.value = data.companyTel;
        })
}
myCompanyAjax();


const handelCancel = () => {
    addr.innerHTML = '';
    tel.innerHTML = '';
	pass.innerHTML = '';
	memberPassword.value = '';
    companyAddr.value = myCompany.companyAddr;
    companyTel.value = myCompany.companyTel;
}

const handleSubmit = (e) => {
    e.preventDefault();
	let isSubmit = true;
	pass.innerHTML = '';
    addr.innerHTML = '';
    tel.innerHTML = '';
    let companyNameValue = companyName.value;
	let memberPasswordValue = memberPassword.value;
    let companyAddrValue = companyAddr.value;
    let companyTelValue = companyTel.value;
    if(companyAddrValue.trim() === '') {
        addr.innerHTML = '주소를 입력해주세요';
        addr.style.color = 'red';
	    isSubmit = false;
    }
    if(companyTelValue.trim() === '') {
        tel.innerHTML = '전화번호 를 입력해주세요';
        tel.style.color = 'red';
	    isSubmit = false;
    }
	if(memberPasswordValue.trim() === ''){
		pass.innerHTML = '비밀번호 를 입력해주세요';
		pass.style.color = 'red';
		isSubmit = false;
    }

	if(isSubmit === false) return false;
	myCompany.companyAddr = companyAddrValue;
	myCompany.companyTel = companyTelValue;
	myCompany.memberPassword = memberPasswordValue;
	myCompany.companyName = companyNameValue;
	console.log(JSON.stringify(myCompany));

	headers['Content-Type'] = 'application/json'
	headers['accept'] = 'application/json'


	fetch('/ourmine/company/companyView',{
		method : 'POST',
        headers : headers,
        body : JSON.stringify(myCompany)
    }).then(resp => resp.json())
        .then(data => {
			if(data === -1){
				pass.innerHTML = '비밀번호 가 맞지않습니다.';
				pass.style.color = 'red';
				return false;
            }
	        cancel.click();
	        handelCancel();
        })
}




</script>