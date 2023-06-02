<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<div class="body d-flex py-lg-3 py-md-2">
	<div class="container-xxl">
		<div class="row clearfix">
                 <div class="col-md-12">
                     <div class="card border-0 mb-4 no-bg">
                         <div class="card-header py-3 px-0 d-flex align-items-center  justify-content-between border-bottom">
                            <h3 class=" fw-bold flex-fill mb-0">My Page</h3>
                             <div class="btn-group" role="group" aria-label="Basic outlined example">
                             <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#editproject"><i class="icofont-edit text-success"></i></button>
                             <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#deleteproject"><i class="icofont-ui-delete text-danger"></i></button>
                         </div>

                     </div>
                 </div>
             </div><!-- Row End -->
             <div class="row g-3">
                 <div class="col-xl-8 col-lg-12 col-md-12" >
                 	<div class="card teacher-card  mb-3" id="myPage">
                 	
                 	</div>
<!-- ========================================== 프로젝트  ================================================= -->

					<h6 class="fw-bold  py-3 mb-3">Current Client Project</h6>
                        <div class="teachercourse-list mb-3">
                            <div class="row g-3 gy-5 pt-3 row-deck">
                                <div class="col-xxl-6 col-xl-6 col-lg-6 col-md-12 col-sm-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center justify-content-between mt-5">
                                                <div class="lesson_name">
                                                    <div class="project-block light-info-bg">
                                                        <i class="icofont-paint"></i>
                                                    </div>
                                                    <span class="small text-muted project_name fw-bold"> Social Geek Made </span>
                                                    <h6 class="mb-0 fw-bold  fs-6  mb-2">UI/UX Design</h6>
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-center">
                                                <div class="avatar-list avatar-list-stacked pt-2">
                                                    <img class="avatar rounded-circle sm" src="assets/images/xs/avatar2.jpg" alt="">
                                                    <img class="avatar rounded-circle sm" src="assets/images/xs/avatar1.jpg" alt="">
                                                    <img class="avatar rounded-circle sm" src="assets/images/xs/avatar3.jpg" alt="">
                                                    <img class="avatar rounded-circle sm" src="assets/images/xs/avatar4.jpg" alt="">
                                                    <img class="avatar rounded-circle sm" src="assets/images/xs/avatar8.jpg" alt="">
                                                </div>
                                            </div>
                                            <div class="row g-2 pt-4">
                                                <div class="col-6">
                                                    <div class="d-flex align-items-center">
                                                        <i class="icofont-paper-clip"></i>
                                                        <span class="ms-2">5 Attach</span>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="d-flex align-items-center">
                                                        <i class="icofont-sand-clock"></i>
                                                        <span class="ms-2">4 Month</span>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="d-flex align-items-center">
                                                        <i class="icofont-group-students "></i>
                                                        <span class="ms-2">5 Members</span>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="d-flex align-items-center">
                                                        <i class="icofont-ui-text-chat"></i>
                                                        <span class="ms-2">10</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="dividers-block"></div>
                                            <div class="d-flex align-items-center justify-content-between mb-2">
                                                <h4 class="small fw-bold mb-0">Progress</h4>
                                                <span class="small light-danger-bg  p-1 rounded"><i class="icofont-ui-clock"></i> 35 Days Left</span>
                                            </div>
                                            <div class="progress" style="height: 8px;">
                                                <div class="progress-bar bg-secondary" role="progressbar" style="width: 25%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100"></div>
                                                <div class="progress-bar bg-secondary ms-1" role="progressbar" style="width: 25%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>
                                                <div class="progress-bar bg-secondary ms-1" role="progressbar" style="width: 10%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xxl-6 col-xl-6 col-lg-6 col-md-12 col-sm-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center justify-content-between mt-5">
                                                <div class="lesson_name">
                                                    <div class="project-block bg-lightgreen">
                                                        <i class="icofont-vector-path"></i>
                                                    </div>
                                                    <span class="small text-muted project_name fw-bold"> Practice to Perfect </span>
                                                    <h6 class="mb-0 fw-bold  fs-6  mb-2">Website Design</h6>
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-center">
                                                <div class="avatar-list avatar-list-stacked pt-2">
                                                    <img class="avatar rounded-circle sm" src="assets/images/xs/avatar2.jpg" alt="">
                                                    <img class="avatar rounded-circle sm" src="assets/images/xs/avatar1.jpg" alt="">
                                                    <img class="avatar rounded-circle sm" src="assets/images/xs/avatar3.jpg" alt="">
                                                    <img class="avatar rounded-circle sm" src="assets/images/xs/avatar4.jpg" alt="">
                                                </div>
                                            </div>
                                            <div class="row g-2 pt-4">
                                                <div class="col-6">
                                                    <div class="d-flex align-items-center">
                                                        <i class="icofont-paper-clip"></i>
                                                        <span class="ms-2">4 Attach</span>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="d-flex align-items-center">
                                                        <i class="icofont-sand-clock"></i>
                                                        <span class="ms-2">1 Month</span>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="d-flex align-items-center">
                                                        <i class="icofont-group-students "></i>
                                                        <span class="ms-2">4 Members</span>
                                                    </div>
                                                </div>
                                                <div class="col-6">
                                                    <div class="d-flex align-items-center">
                                                        <i class="icofont-ui-text-chat"></i>
                                                        <span class="ms-2">3</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="dividers-block"></div>
                                            <div class="d-flex align-items-center justify-content-between mb-2">
                                                <h4 class="small fw-bold mb-0">Progress</h4>
                                                <span class="small light-danger-bg  p-1 rounded"><i class="icofont-ui-clock"></i> 15 Days Left</span>
                                            </div>
                                            <div class="progress" style="height: 8px;">
                                                <div class="progress-bar bg-secondary" role="progressbar" style="width: 25%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100"></div>
                                                <div class="progress-bar bg-secondary ms-1" role="progressbar" style="width: 25%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>
                                                <div class="progress-bar bg-secondary ms-1" role="progressbar" style="width: 39%" aria-valuenow="39" aria-valuemin="0" aria-valuemax="100"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
<!-- ===================================  일감 ======================================================= -->

                    <div class="col-xl-4 col-lg-12 col-md-12">
                        <div class="card mb-3">
                            <div class="card-header py-3">
                                <h6 class="mb-0 fw-bold ">Client Task</h6>
                            </div>
                            <div class="card-body">
                                <div class="planned_task client_task" >
                                    <div class="dd" data-plugin="nestable">
                                        <ol class="dd-list" id="mpPwList">
                                        	<li class="dd-item mb-3">
                                                <div class="dd-handle">
                                                    <div class="task-info d-flex align-items-center justify-content-between">
                                                        <h6 class="light-info-bg py-1 px-2 rounded-1 d-inline-block fw-bold small-14 mb-0">UI/UX Design</h6>
                                                        <div class="task-priority d-flex flex-column align-items-center justify-content-center">
                                                            <div class="avatar-list avatar-list-stacked m-0">
                                                                <img class="avatar rounded-circle small-avt sm" src="assets/images/xs/avatar2.jpg" alt="">
                                                                <img class="avatar rounded-circle small-avt sm" src="assets/images/xs/avatar1.jpg" alt="">
                                                            </div>
                                                            <span class="badge bg-warning text-end mt-1">Inprogress</span>
                                                        </div>
                                                    </div>
                                                    <p class="py-2 mb-0">Lorem ipsum dolor sit amet, consectetur adipiscing elit. In id
                                                        nec scelerisque massa.</p>
                                                    <div class="tikit-info row g-3 align-items-center">
                                                        <div class="col-sm">
                                                        </div>
                                                        <div class="col-sm text-end">
                                                            <div class="small text-truncate light-danger-bg py-1 px-2 rounded-1 d-inline-block fw-bold small"> Social Geek Made </div>
                                                        </div>
                                                    </div>
                                                </div>
        
                                            </li>	
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!-- Row End -->
            </div>
        </div>
	</div>

<div id="Page" >
  <form class="delForm" onsubmit="deleteSubmit(event)" enctype="multipart/form-data">
	   <div class="modal fade deleteModal" id="deleteproject" tabindex="-1" aria-hidden="true">

	   	<div class="modal-dialog modal-dialog-centered modal-md modal-dialog-scrollable">
	   		<div class="modal-content">
	               <div id="project-id" class="form-label"></div>
	   			<div class="modal-header">
	   				<h5 class="modal-title  fw-bold" id="deleteprojectLabel">본인 확인을 위해 비밀번호를 입력해주세요</h5>
	   				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	   			</div>
	   			<div class="modal-body justify-content-center flex-column d-flex">
	   				  <input name="memberPassword" type="password" class="form-control nameInput memberPass" id="exampleFormControlInput78" value="" onchange="passChange(event)">
	   				<p class="mt-4 fs-5 text-center passTag"></p>
	   			</div>
	   			<div class="modal-footer">
	   				<button type="button" class="btn btn-secondary deleteCancel" data-bs-dismiss="modal" onclick="handleCancel()">Cancel</button>
	   				<button type="submit" id="delBtn" class="btn btn-danger color-fff">Delete</button>
	   			</div>
	   		</div>
	   	</div>
	   </div>
	  </form>
</div>

<script>

const todo = {
	    projectWorkId : '',
        todoId : '',
	    memberName : '',
}


const add = (a,b) => a + b;

let projectIdHidden = document.querySelector('#projectIdHidden');
let projectIdHiddenValue = projectIdHidden.value;
console.log("projectIdHiddenValue: ", projectIdHiddenValue);

let companyIdHidden = document.querySelector('#companyIdHidden');
let companyIdHiddenValue = companyIdHidden.value;
console.log("companyIdHiddenValue: ", companyIdHiddenValue);


let memberPass =  document.querySelector('.memberPass');
let delForm = document.querySelector('.delForm');
let deleteCancel =  document.querySelector('.deleteCancel')
let passTag = document.querySelector('.passTag');



console.log(memberPass);
console.log(deleteCancel);

const member = {
	memberPassword : ''
}
const handleCancel = () => {
	memberPass.value =  '';
	passTag.innerHTML = '';
	deleteCancel.click();
}

const passChange = (e) => {
	const {name,value} = e.target;
	add(name,value)
}

const add = (name,value) => {
	member[name] = value;
	console.log(member)
}



	headers['Content-Type'] = 'application/json'
    headers['accept'] = 'application/json'
        const deleteSubmit = (e) => {
            e.preventDefault();
            fetch('/ourmine/member/memberDelete',{
                method : 'POST',
                headers : headers,
                body: JSON.stringify(member)
            }).then(resp => resp.json())
                .then(data => {
                	console.log(passTag);
                    if(data === -1){
           			 passTag.innerHTML = '비밀번호가 맞지 않습니다.';
           			 passTag.style.display = 'block';
           			 passTag.style.color = 'red';
       		 }else{
       					deleteCancel.click();
						memberPass.value =  '';
						passTag.innerHTML = '';
					}
    })

}



</script>


 <script>
 let myPage = document.querySelector('#myPage');
 const myMember = {
		 memberEmail : '',
		 memberTel : '',
		 memberPassword : '',
		 memberPasswordResult : '',
 }

async function myPageLoad() {
	await fetch('/ourmine/member/memberViewJson', {
		method: 'GET',
		headers: {
			'accept': 'application/json',
		}
	}).then(resp => resp.json())
			.then(data => {
				console.log("회원정보", data);
				myMember.memberEmail = data.memberEmail;
				myMember.memberTel = data.memberTel;
				myMember.memberPassword = data.memberPassword;
				console.log(myMember);
				myPage.innerHTML += `
				
                         <div class="card-body d-flex teacher-fulldeatil">
                             <div class="profile-teacher pe-xl-4 pe-md-2 pe-sm-4 pe-4 text-center w220">
                                 <a href="#">
                          <!-- 회원이미지 쓸곳 -->   <img src="\${data.imageContents}" alt="" class="avatar xl rounded-circle img-thumbnail shadow-sm">

                                 </a>
                                 <div class="about-info d-flex align-items-center mt-3 justify-content-center flex-column">
                                     <h6 class="mb-0 fw-bold d-block fs-6">\${data.memberName}</h6>
                                     <span class="text-muted small">\${data.memberGrade}</span>
                                 </div>
                             </div>
                             <div class="teacher-info border-start ps-xl-4 ps-md-4 ps-sm-4 ps-4 w-100">

                                 <h6  class="mb-0 mt-2  fw-bold d-block fs-6">\${data.companyName === null ? '등록된 회사가 없습니다.' : data.companyName}</h6>

                                 <span class="py-1 fw-bold small-11 mb-0 mt-1 text-muted"><span>CEO : </span>\${data.companyCeo === null ? '등록된 회사가 없습니다.' : data.companyCeo}</span>
                                 <p class="mt-2 small">The purpose of lorem ipsum is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesn't distract from the layout. A practice not without controversy</p>
                                 <div class="row g-2 pt-2">
                                     <div class="col-xl-5">
                                         <div class="d-flex align-items-center">
                                             <i class="icofont-ui-touch-phone"></i>
                                             <span class="ms-2 small">\${data.memberTel}</span>
                                         </div>
                                     </div>
                                     <div class="col-xl-5">
                                         <div class="d-flex align-items-center">
                                             <i class="icofont-email"></i>
                                             <span class="ms-2 small">\${data.memberEmail}</span>
                                         </div>
                                     </div>

                                     <div class="col-xl-5">
                                         <div class="d-flex align-items-center">
                                             <i class="icofont-address-book"></i>
                                             <span class="ms-2 small">2734  West Fork Street,EASTON 02334.</span>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                         </div>
				                         
                     


                      <!-- 수정 모달-->
                     <form id="sub" enctype="multipart/form-data" method="post" action="/ourmine/member/memberUpdate">
                     <div class="modal fade" id="editproject" tabindex="-1" aria-hidden="true">

                         <div class="modal-dialog modal-dialog-centered modal-md modal-dialog-scrollable">

                             <div class="modal-content">
                                 <div class="modal-header">
                                     <h5 class="modal-title  fw-bold" id="editprojectLabel">내 정보 수정</h5>
                                     <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                 </div>

                                 <div class="modal-body">
                                     <div class="mb-3">
                                         <label for="exampleFormControlInput78" class="form-label">이름</label>
                                         <input name="memberName" type="text" class="form-control nameInput" id="exampleFormControlInput78" value="\${data.memberName}" readonly>
                                     </div>


                                     <div class="modal-body">
                                         <div class="mb-3">
                                             <label for="exampleFormControlInput78" class="form-label">이메일</label>
                                             <input name="memberEmail" type="text" class="form-control mailInput" id="exampleFormControlInput78" value="\${data.memberEmail}" >
                                             <span id="mail"></span>
                                         </div>


                                         <div class="mb-3">
                                             <label for="exampleFormControlInput78" class="form-label">전화번호</label>
                                             <input  name="memberTel" type="text" class="form-control telInput" id="exampleFormControlInput78" value="\${data.memberTel}" >
                                             <input  name="memberId" type="hidden" class="form-control IdInput" id="exampleFormControlInput78" value="\${data.memberId}" >
                                             <span id="tel"></span>
                                         </div>

										<div class="mb-3">
                                             <label for="exampleFormControlInput78" class="form-label">내 이미지</label>
                                             <input  name="file" type="file" class="form-control telInput" id="exampleFormControlInput78" value="\${data.memberTel}" >
                                         </div>

                                         <div class="mb-3">
                                             <label for="exampleFormControlInput78" class="form-label">비밀번호</label>
                                             <input  name="memberPassword" type="password" class="form-control passInput" id="exampleFormControlInput78" value="" >
                                             <span id="pass"></span>
                                         </div>



                                         <div class="modal-footer">
                                             <button type="button" class="btn btn-secondary clo" data-bs-dismiss="modal">취소</button>
                                             <button type="submit" class="btn btn-primary">완료</button>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </form>
                     `
			})
}


 
 
async function MyPageJs() {
	 let regex = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])"); // 이메일 정규식
	 let reg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/; // 비밀번호 정규식
	 let regPone = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/; // 전화번호 정규식
	 let mailInput = document.querySelector('.mailInput');
	 let telInput = document.querySelector('.telInput');
	 let passInput = document.querySelector('.passInput');
	 let IdInput = document.querySelector('.IdInput');
	 let nameInput = document.querySelector('.nameInput');
	 let clo = document.querySelector('.clo');
	 let pass = document.querySelector('#pass');
	 let mail = document.querySelector('#mail');
	 let tel = document.querySelector('#tel');
	 let sub = document.querySelector('#sub');
	 let formData = new FormData();
	 let fileField = document.querySelector("input[type='file']");

	 let myMember = {
		 memberId: '',
		 memberEmail: '',
		 memberName: '',
		 memberTel: '',
		 memberPassword: '',
	 }

	 const mailValue = mailInput.value;
	 const telValue = telInput.value;
	 let isEmail = true;
	 let isTel = true;
	 let isPassword = true;

	 clo.addEventListener('click', () => {
		 pass.innerHTML = '';
		 passInput.value = '';
		 tel.innerHTML = '';
		 mail.innerHTML = '';
		 mailInput.value = mailValue;
		 console.log("mailInputvalue", mailInput.value);
		 telInput.value = telValue;
	 })


	 mailInput.addEventListener('change', (e) => {
		 const {name, value} = e.target;
		 console.log(name, value);
		 add(name, value);
	 })
	 telInput.addEventListener('change', (e) => {
		 const {name, value} = e.target;
		 console.log(name, value);
		 add(name, value);
	 })
	 passInput.addEventListener('change', (e) => {
		 const {name, value} = e.target;
		 console.log(name, value);
		 add(name, value);
	 })

	 const add = (name, value) => {
		 myMember[name] = value;
		 myMember["memberId"] = IdInput.value;
		 myMember["memberName"] = nameInput.value;
		 console.log(myMember.memberId)
	 }


	 sub.addEventListener('submit', (e) => {
		 console.log("e => ", e);
		 e.preventDefault();
		 console.log('여기까지오니')
		 e.preventDefault();

		 if (mailInput.value === '') {
			 mail.innerHTML = '';
			 mail.innerHTML = '이메일을 입력해주세요';
			 mail.style.color = 'red';
			 isEmail = false;
		 } else {
			 isEmail = true;
			 mail.innerHTML = '';
		 }
		 if (telInput.value === '') {
			 tel.innerHTML = '';
			 tel.innerHTML = '전화번호를 입력해주세요';
			 tel.style.color = 'red';
			 isTel = false;
		 } else {
			 isTel = true;
			 tel.innerHTML = '';
		 }
		 if (passInput.value === '') {
			 pass.innerHTML = '';
			 pass.innerHTML = '비밀번호를 입력해주세요';
			 pass.style.color = 'red'
			 isPassword = false;
		 } else {
			 isPassword = true;
			 pass.innerHTML = '';
		 }


		 if (isTel && isEmail && isPassword) {

			 if (fileField.files[0] != undefined) {
				 formData.set("file", fileField.files[0]);
			 }
			 formData.set("memberId", IdInput.value);
			 formData.set("memberEmail", mailInput.value);
			 formData.set("memberName", nameInput.value);
			 formData.set("memberTel", telInput.value);
			 formData.set("memberPassword", passInput.value);
			 console.log(formData);
			 headers['accept'] = 'application/json';
			 headers['Content-Type'] = 'multipart/form-data';
			 let page = $('#myPage');

		 	return axios.post('/ourmine/member/memberUpdate', formData, {headers: headers})
					 .then( (resp) => {
						 let data = resp.data;
						 if (data === -1) {
							 pass.innerHTML = '비밀번호가 일치하지 않습니다.';
							 pass.style.color = 'red';
							 return false;
						 } else {
							 pass.innerHTML = '';
							 passInput.value = '';
						 }

						 if (data > 0) {
							 console.log('성공:', data);
							 clo.click();
							 page.empty();
							 memberImageList();
							  myPageLoad();
							 passInput.value = '';
						 } else {
							 pass.innerHTML = '';
							 passInput.value = '';
						 }
					 })
					 .catch((error) => {
						 console.error("memberUpdate : ", error);
					 });
		 }
	 })
 }
myPageLoad().then(MyPageJs)

</script>





