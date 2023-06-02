<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.js"></script>
<style>
	/* 그리드 헤더 색상 */
	.ag-theme-alpine {
		--ag-header-background-color: #484c7f;
		--ag-header-foreground-color: #ffffff;
	}
	/* 그리드 내용 가운데 정렬 */
	.ag-row .ag-cell {
		display: flex;
		justify-content: center; /* align horizontal */
		align-items: center;
		/* 		align-content: center; */
	}
	.ag-header-cell-text {
		margin-left: 60px;
	}

 	.modal{
	 	position: fixed;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		background: rgba(0, 0, 0, 0.8);
	}
	.swal2-container {
		z-index: 9999999999999;
	}
</style>


<body>

<div id="mytask-layout" class="theme-indigo">

    <!-- main body area -->
    <div class="main px-lg-4 px-md-4">

        <!-- Body: Body -->
		<div class="body d-flex py-lg-3 py-md-2">
			<div class="container-xxl">
				<div class="row align-items-center">
					<div class="border-0 mb-4">
						<div
								class="card-header py-3 no-bg bg-transparent d-flex align-items-center px-0 justify-content-between border-bottom flex-wrap">
							<h3 class="fw-bold mb-0">전체 일감</h3>
							<div class="col-auto d-flex w-sm-100">
								<security:authorize url="/company/${companyId}/project/${projectId}/projectWork/projectWorkForm">
								<button id="taskAddBtn" type="button" class="btn btn-dark btn-set-task w-sm-100" data-bs-toggle="modal" data-bs-target="#pwInsertModal" >
									일감 추가 <i class="icofont-plus-circle me-2 fs-6"></i>
								</button>
								</security:authorize>
							</div>
						</div>
					</div>
				</div>
				<!-- Row end  -->
				<div class="row clearfix g-3">
					<div class="col-sm-12">
						<div class="card mb-3">
							<div class="card-body">
								<input type="text" class="form-control" placeholder="Search" id="searchProjectWork" >
								<table id="myProjectTable" class="table table-hover align-middle mb-0" style="width: 100%">
									<thead>
									<tr>
										<th>번호</th>
										<th>상태</th>
										<th>우선순위</th>
										<th>제목</th>
										<th>담당자</th>
										<th>시작일</th>
										<th>마감일</th>
										<th>등록일</th>
										<th>수정 / 삭제</th>
									</tr>
									</thead>
									<tbody id="pwList">
									<tr style="display: none">
										<th>번호</th>
										<th>상태</th>
										<th>우선순위</th>
										<th>제목</th>
										<th>담당자</th>
										<th>시작일</th>
										<th>마감일</th>
										<th>등록일</th>
										<th>수정 / 삭제</th>
									</tr>
									</tbody>
								</table>
								<nav aria-label="Page navigation">
								    <div>
								    <ul style="display: flex" class="pagination justify-content-center">
								        <li class="page-item disabled" >  <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>  </li>
								        <li class="page-item" style="display: flex" id="pwContainer"><a class="page-link" href="#">1</a></li>
								        <li class="page-item">  <a class="page-link" href="#">Next</a> </li>
								    </ul>
								    </div>
								</nav>
							</div>
						</div>
					</div>
                </div>
                <!-- Row end  -->
            </div>
        </div>
			<div class="row clearfix  g-3">
				<div class="col-lg-12 col-md-12 flex-column">
					<div class="row g-3 row-deck">
					<div class="row taskboard g-3 py-xxl-4">

					<div class="col-xxl-4 col-xl-4 col-lg-4 col-md-12 mt-xxl-4 mt-xl-4 mt-lg-4 mt-md-4 mt-sm-4 mt-4">
						<h6 class="fw-bold py-3 mb-0">상태 : 진행중</h6>
						<div class="progress_task">
							<div class="dd" data-plugin="nestable">
								<ol class="dd-list" id="pwInProgress">


								</ol>
							</div>
						</div>
					</div>

					<div class="col-xxl-4 col-xl-4 col-lg-4 col-md-12 mt-xxl-4 mt-xl-4 mt-lg-4 mt-md-0 mt-sm-0 mt-0">
						<h6 class="fw-bold py-3 mb-0">상태 : 피드백</h6>
						<div class="review_task">
							<div class="dd" data-plugin="nestable">
								<ol class="dd-list" id="pwFeedback">


								</ol>
							</div>
						</div>
					</div>

					<div class="col-xxl-4 col-xl-4 col-lg-4 col-md-12 mt-xxl-4 mt-xl-4 mt-lg-4 mt-md-0 mt-sm-0 mt-0">
						<h6 class="fw-bold py-3 mb-0">상태 : 완료</h6>
						<div class="completed_task">
							<div class="dd" data-plugin="nestable">
								<ol class="dd-list" id="pwCompleted">


								</ol>
							</div>
						</div>
					</div>

					</div>
					</div>
				</div>
			</div>

		<!-- ===================================================================================================================================== -->
		<!-- 상세조회 모달 -->
		<div class="modal" id="pwDetailModal">
			<div class="modal-dialog modal-dialog-centered modal-md modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title  fw-bold" id="pwProjectWorkTitle" name="projectWorkTitle"></h4>
				</div>
				<div class="modal-body">
					<div class="mb-3">
						<input id="pwProjectId" name="projectId" class="modalInput"  type="hidden" >
									<input id="pwCompanyId" name="companyId" class="modalInput"  type="hidden">
						<input id="pwProjectWorkId" name="projectWorkId" class="modalInput"  type="hidden">
									<input id="pwProjectWorkStatusId" name="projectWorkStatusId" class="modalInput" type="hidden">
						<input id="pwPicId" name="picId" class="modalInput"  type="hidden" >
					</div>
					<div class="mb-3">
						<i class="icofont-clock-time"></i> <label  class="form-label">상 태</label>
						<input class="form-control" id="pwProjectWorkStatus" name="projectWorkStatus" readonly="readonly">
					</div>
					<div class="mb-3">
						<i class="icofont-user"></i> <label  class="form-label">담당자</label>
						<input class="form-control"  id="pwProjectWorkPic"  name="projectWorkStatus" readonly="readonly">
					</div>
					<div class="deadline-form mb-3">
						<form>
							<div class="row">
								<div class="col">
								<i class="icofont-calendar"></i> <label for="datepickerded" class="form-label">시작 날짜</label>
								<input type="date" class="form-control" id="pwProjectWorkStartDate" name="projectWorkStartDate" readonly="readonly">
								</div>
								<div class="col">
								<i class="icofont-calendar"></i> <label for="datepickerdedone" class="form-label">종료 날짜</label>
								<input type="date" class="form-control" id="pwProjectWorkEndDate" name="projectWorkEndDate" readonly="readonly">
								</div>
							</div>
						</form>
					</div>
					<input id="pwProjectPriorityId" name="projectPriorityId" class="modalInput" type="hidden">
					<div class="row g-3 mb-3">
						<div class="col-sm">
							<i class="icofont-flag"></i> <label  class="form-label">우선순위</label>
							<input id="pwProjectPriorityName" name="projectPriorityName" class="form-control" type="text" readonly="readonly">
						</div>
					</div>
					<div class="mb-3">
						<i class="icofont-page"></i> <label for="exampleFormControlTextarea786" class="form-label">내용</label>
						<textarea class="form-control" id="pwProjectWorkContent" name="projectWorkContent" rows="3" readonly="readonly"></textarea>
					</div>
				</div>
				<div class="modal-footer">
					<button style="display: none"  type="button" class="btn btn-primary" onclick="pwModifyBtn()">수정</button>
					<!-- <button type="button" class="btn btn-primary" id="pwDeleteBtn" >삭제</button> -->
					<button type="button" class="btn btn-secondary" onclick="pwModalClose()">닫기</button>
				</div>
			</div>
			</div>
		</div>
		<!-- ===================================================================================================================================== -->
		<!-- 등록 모달 -->
		<div class="modal fade" id="pwInsertModal" tabindex="-1"  aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered modal-md modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title  fw-bold" id="createprojectlLabel">일감 등록</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="pwInsertForm" novalidate>
						<div class="mb-3">
							<label  class="form-label">제 목</label>
							<input type="text" class="form-control" id="pwInProjectWorkStatus" name="projectWorkTitle" required="required">
						</div>
						<div class="mb-3">
								<i class="icofont-clock-time"></i> <label  class="form-label">상 태</label>
							<select class="form-select"  id="pwInProjectWorkStatusId" name="projectWorkStatusId"  aria-label="Default select Project Category">
								<option value="1" selected>요청</option>
								<option value="2">진행</option>
								<option value="3">피드백</option>
								<!-- <option value="4">완료</option> -->
								<option value="5">보류</option>
							</select>
						</div>


						<div class="mb-3">
							<i class="icofont-user"></i> <label  class="form-label">담당자</label>
							<select ID= "getProjectMemberList" class="form-select " name="picId">
										</select>

						</div>
						<div class="deadline-form mb-3">
								<div class="row">
									<div class="col">
									<label for="datepickerded" class="form-label">시작 날짜</label>
									<input type="date" id="pwInProjectWorkStartDate" name="projectWorkStartDate" class="form-control" required="required">
									</div>
									<div class="col">
									<label for="datepickerdedone" class="form-label">종료 날짜</label>
									<input type="date" id="pwInProjectWorkEndDate" name="projectWorkEndDate" class="form-control" >
									</div>
								</div>
						</div>
						<div class="row g-3 mb-3">
							<div class="col-sm">
								<i class="icofont-flag"></i> <label  class="form-label">우선순위</label>
								<select class="form-select" id="pwInProjectPriorityId" name="projectPriorityId" aria-label="Default select Priority">
									<option value="1">긴급</option>
									<option value="2">높음</option>
									<option value="3">보통</option>
									<option value="4">낮음</option>
								</select>
							</div>
						</div>
						<div class="mb-3">
							<i class="icofont-page"></i> <label for="exampleFormControlTextarea786" class="form-label">내용</label>
							<textarea class="form-control" id="pwInProjectWorkContent" name="projectWorkContent" rows="3" placeholder="내용을 입력해주세요"></textarea>
						</div>
				<div class="modal-footer">
					<button type="button" id="pwInBtn" class="btn btn-primary">등록</button>
				</div>
					</form>
				</div>
			</div>
			</div>
		</div>

		<!-- ===================================================================================================================================== -->
		<!-- 수정 모달 -->
		<div class="modal" id="pwModifyModal">
			<div class="modal-dialog modal-dialog-centered modal-md modal-dialog-scrollable">
			<div class="modal-content" id="pwModifyModalCont" >
				<form id="pwModifyForm" >
					<div class="modal-header">
						<input type="text" class="form-control" id="pwMoProjectWorkTitle" name="projectWorkTitle">
					</div>
					<div class="modal-body">
						<div class="mb-3">
							<input id="pwMoProjectId" name="projectId" class="modalInput"  type="hidden">
									<input id="pwMoCompanyId" name="companyId" class="modalInput"  type="hidden">
							<input id="pwMoProjectWorkId" name="projectWorkId" class="modalInput"  type="hidden">
						</div>
						<div class="mb-3">
							<i class="icofont-clock-time"></i> <label  class="form-label">상 태</label>
							<select class="form-select"  id="pwMoProjectWorkStatusId" name="projectWorkStatusId"  aria-label="Default select Project Category">
									<option value="1">요청</option>
									<option value="2">진행</option>
									<option value="3">피드백</option>
									<!-- <option value="4">완료</option> -->
									<option value="5">보류</option>
							</select>
						</div>
						<div class="mb-3">
							<i class="icofont-user"></i> <label  class="form-label">담당자</label>
							<select id="moProjectMemberList" name="picId"  class="form-select ">
							</select>
						</div>
						<div class="deadline-form mb-3">
								<div class="row">
									<div class="col">
									<i class="icofont-calendar"></i> <label for="datepickerded" class="form-label">시작 날짜</label>
									<input type="date" class="form-control" id="pwMoProjectWorkStartDate" name="projectWorkStartDate" >
									</div>
									<div class="col">
									<i class="icofont-calendar"></i> <label for="datepickerdedone" class="form-label">종료 날짜</label>
									<input type="date" class="form-control" id="pwMoProjectWorkEndDate" name="projectWorkEndDate" >
									</div>
								</div>
						</div>
						<div class="row g-3 mb-3">
							<div class="col-sm">
								<i class="icofont-flag"></i> <label  class="form-label">우선순위</label>
								<select class="form-select" id="pwMoProjectPriorityId" name="projectPriorityId">
									<option value="1">긴급</option>
									<option value="2">높음</option>
									<option value="3">보통</option>
									<option value="4">낮음</option>
								</select>
							</div>
						</div>
						<div class="mb-3">
							<i class="icofont-page"></i> <label for="exampleFormControlTextarea786" class="form-label">내용</label>
							<textarea class="form-control" id="pwMoProjectWorkContent" name="projectWorkContent" rows="3"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" id="btnSave" class="btn btn-primary" >등록</button>
						<button type="button" class="btn btn-secondary" onclick="pwModifyModalClose()">닫기</button>
					</div>
				</form>
			</div>
			</div>
		</div>
		<!-- =====================   삭제 모달  =============================-->
        <div class="modal fade" id="dremovetask" tabindex="-1"  aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                	<input id="pwDeProjectWorkId" name="projectWorkId" class="modalInput"  type="text">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body justify-content-center flex-column d-flex">
                    <i class="icofont-ui-delete text-danger display-2 text-center mt-2"></i>
                    <p class="mt-4 fs-5 text-center">삭제하겠습니까?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-danger color-fff" id="pwDeleteBtn" >삭제</button>
                </div>
            </div>
            </div>
        </div>
	</div>
</div>

<!-- ============================================================================== -->
<security:authentication property="principal" var="principal"/>
<c:forEach items="${principal.realUser.proAttendRole }" var="roleList">
    <c:set var="memberId" value="${roleList.memberId }"/>
    <c:set var="projectRoleId" value="${roleList.projectRoleId }"/>
</c:forEach>

<input id="projectIdHidden" type="hidden" value="${projectId }">
<input id="companyIdHidden" type="hidden" value="${companyId }">


<script type="text/javascript">

// 로그인한 멤버 아이디
const loginMemberId = ${memberId};
console.log("loginMemberId", loginMemberId)

// 로그인한 멤버 롤
const projectRoleId = ${projectRoleId};
console.log("projectRoleId",projectRoleId);

// 일감등록버튼 롤에 맞춰서 보이고 안보이게
/* if (projectRoleId === 1) {
	document.querySelector("#taskAddBtn").style.display = "block";
	//pwtaskAddBtn();
} */

let searchProjectWork = document.querySelector("#searchProjectWork");
	const selectPwList = {

	}

	const add = (a,b) => a + b;
	let projectIdHidden = document.querySelector('#projectIdHidden');
	let projectIdHiddenValue = projectIdHidden.value;
	let companyIdHidden = document.querySelector('#companyIdHidden');
	let companyIdHiddenValue = companyIdHidden.value;
	console.log("projectIdHiddenValue:",projectIdHiddenValue)
	console.log("companyIdHiddenValue:",companyIdHiddenValue)





//<!-- ===================================================================================================================================== -->
	// 모달 열기/ 닫기
	// 상세조회

	const pwModal = document.querySelector("#pwDetailModal");
	const pwModalOpen = () => {
		pwModal.style.display = "block"; // 보이게
	}
	const pwModalClose = () => {
	//	pwModal.style.display = "none"; // 안보이게
		/* location.href=location.href; */
		$('#pwDetailModal').modal('hide');
	}




    // 일감 수정 모달창
    const pwModifyModal = document.querySelector("#pwModifyModal");
    const pwModifyModalClose = () => {
    	//pwModifyModal.style.display = "none"
    	$('#pwModifyModal').modal('hide');

    }

    // 수정 버튼 클릭 => 수정모달열림
    const pwModifyBtn = () => {
	   	pwModifyModal.style.display="block";
	   	pwModalClose();


    }
	// 토큰 설정 : 스프링 security CSRF를  설정하면 아래 토큰 값을 get이외의 방식에는 전송해야 함
	const header = '${_csrf.headerName}';
	const token =  '${_csrf.token}';

// <!--=============================== 리스트 생성 ================================== -->
let pwList = document.querySelector("#pwList");
	console.log("pwList",pwList);
	let pwInProgress =  document.querySelector("#pwInProgress");
	let pwFeedback =  document.querySelector("#pwFeedback");
	let pwCompleted =  document.querySelector("#pwCompleted");


	headers['Content-Type'] = 'application/json'
	headers['accept'] = 'application/json'




	function projectWorkList() {
		console.log("리스트 오냐?")
		axios.get(`/ourmine/company/${companyId}/project/${projectId}/projectWork/projectWorkListJson`,{headers : headers})
				.then(resp => {
					let data = resp.data
					console.log("data@@@@:",data)

					pwList.innerHTML+= data.map(item =>
					`
					
					<tr data-projectworkid =\${item.projectWorkId} data-projectworkstatus=\${item.projectWorkStatus} data-projectworkstatusid=\${item.projectWorkStatusId} data-projectpriorityname=\${item.projectPriorityName}
					data-projectpriorityid=\${item.projectPriorityId} data-projectworktitle =\${item.projectWorkTitle} data-projectworkpic =\${item.projectWorkPic} data-picid =\${item.picId} data-projectWorkStartDate =\${item.projectWorkStartDate}
					data-projectWorkEndDate =\${item.projectWorkEndDate} data-projectWorkWriteDate =\${item.projectWorkWriteDate} data-projectworkcontent =\${item.projectWorkContent}  data-companyid =\${item.companyId}  data-projectid =\${item.projectId} data-memberid =\${item.memberId} class="nowPwList">
							<td>
								<a class="fw-bold text-secondary"  >\${item.projectWorkId}</a>
							</td>
							<td>
								\${item.projectWorkStatusId===1 ? `<span class="badge bg-warning" data-workid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>` :item.projectWorkStatusId===2
								 ? `<span class="badge bg-primary" data-workid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:item.projectWorkStatusId===3
									 ?`<span class="badge bg-info" data-workid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:item.projectWorkStatusId===4
									 ?`<span class="badge bg-success" data-workid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:`<span class="badge bg-danger" data-workid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`}
							</td>
							<td>
								\${item.projectPriorityName}
							</td>
							<td class="pwDetailModal" name="projectWorkId" data-projectworkiddata=\${item.projectworkid} data-bs-toggle="modal" data-bs-target="#pwDetailModal" >
								\${item.projectWorkTitle}
							</td>

							<td>
								<img class="avatar rounded-circle" src="#" alt="">
								<span class="fw-bold ms-1">\${item.projectWorkPic}</span>
							</td>

							<td>
								\${item.projectWorkStartDate}
						   </td>
							<td>
								\${item.projectWorkEndDate}
						   </td>
							<td>
								\${item.projectWorkWriteDate}
						   </td>
						   <td>
	                           <div class="btn-group" role="group" aria-label="Basic outlined example">
		                           \${item.picId === loginMemberId || projectRoleId === 1 ? `<button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#pwModifyModal" id="pwDetailMoalOpen"><i class="icofont-edit text-success"></i></button>` : `<span></span>`}
		                           \${item.picId === loginMemberId || projectRoleId === 1 ? ` <button type="button" class="btn btn-outline-secondary deleterow" data-projectworkid =\${item.projectWorkId} ><i class="icofont-ui-delete text-danger"></i></button>` : `<span></span>`}
	                           </div>
                       		</td>


						 </tr>
					`
				).reduce(add)
					data.filter(item=> item.projectWorkStatus === '진행').map((user) => {
		        	//console.log("진행중",pwInProgress);
		        	pwInProgress.innerHTML+=
		        		`
	                   	<li class="dd-item" data-id="\${user.projectWorkId}"> <!-- data-id에 이슈id를 찍으면? -->
	                         <div class="dd-handle">
	                             <div class="task-info d-flex align-items-center justify-content-between">
	                                 <h6 class="light-info-bg py-1 px-2 rounded-1 d-inline-block fw-bold small-14 mb-0">제목: \${user.projectWorkTitle}</h6>
	                                 <div class="task-priority d-flex flex-column align-items-center justify-content-center">
	                                     <span class="badge bg-secondary text-end mt-2">담당자: \${user.projectWorkPic}</span>
	                                     <span class="badge bg-primary text-end mt-2">\${user.projectWorkStatus}</span>
	                                     <div class="avatar-list avatar-list-stacked m-0">
											 <img class="avatar rounded-circle small-avt" src="\${user.imageContents !== null ? user.imageContents : '/ourmine/resources/mytask/documentation/assets/images/profile_av.png'}" alt=""> <!-- 담당자 -->
	                                     </div>
	                                 </div>
	                             </div>
	                             <p class="py-2 mb-0">\${user.projectWorkContent}</p>
	                             <div class="tikit-info row g-3 align-items-center">
	                                 <div class="col-sm">
	                                             <div class="d-flex align-items-center">
	                                                 <i class="icofont-flag"></i> <span class="ms-1">\${user.projectWorkStartDate} ~ \${user.projectWorkEndDate} </span>
	                                             </div>
	                                 </div>
	                                 <div class="col-sm text-end">
	                                     <div class=" small text-truncate light-danger-bg py-1 px-2 rounded-1 d-inline-block fw-bold small"> 우선순위 : \${user.projectPriorityName}</div>
	                                 </div>
	                             </div>
	                         </div>
	                     </li>
		             `
		        });
	        	data.filter(item=> item.projectWorkStatus === '피드백').map((user) => {
	        	//console.log("진행중",pwInProgress);
	        		pwFeedback.innerHTML+=
	        			`
	                      <li class="dd-item" data-id="\${user.projectWorkId}"> <!-- data-id에 이슈id를 찍으면? -->
	                          <div class="dd-handle">
	                              <div class="task-info d-flex align-items-center justify-content-between">
	                                  <h6 class="light-info-bg py-1 px-2 rounded-1 d-inline-block fw-bold small-14 mb-0">제목: \${user.projectWorkTitle}</h6>
	                                  <div class="task-priority d-flex flex-column align-items-center justify-content-center">
	                                      <span class="badge bg-secondary text-end mt-2">담당자: \${user.projectWorkPic}</span>
	                                      <span class="badge bg-info text-end mt-2">\${user.projectWorkStatus}</span>
	                                      <div class="avatar-list avatar-list-stacked m-0">
	                                          <img class="avatar rounded-circle small-avt" src="${cPath}/resources/images/xs/avatar6.jpg" alt="">
	                                      </div>
	                                  </div>
	                              </div>
	                              <p class="py-2 mb-0">\${user.projectWorkContent}</p>
	                              <div class="tikit-info row g-3 align-items-center">
	                                  <div class="col-sm">
	                                              <div class="d-flex align-items-center">
	                                                  <i class="icofont-flag"></i> <span class="ms-1">\${user.projectWorkStartDate} ~ \${user.projectWorkEndDate} </span>
	                                              </div>
	                                  </div>
	                                  <div class="col-sm text-end">
	                                      <div class=" small text-truncate light-danger-bg py-1 px-2 rounded-1 d-inline-block fw-bold small"> 우선순위 : \${user.projectPriorityName}</div>
	                                  </div>
	                              </div>
	                          </div>
	                      </li>
	     		   	  `
	        	})
	        	data.filter(item=> item.projectWorkStatus === '완료').map((user) => {
	       	//console.log("진행중",pwInProgress);
	       		pwCompleted.innerHTML+=
	       			`
	                      <li class="dd-item" data-id="\${user.projectWorkId}"> <!-- data-id에 이슈id를 찍으면? -->
	                          <div class="dd-handle">
	                              <div class="task-info d-flex align-items-center justify-content-between">
	                                  <h6 class="light-info-bg py-1 px-2 rounded-1 d-inline-block fw-bold small-14 mb-0">제목: \${user.projectWorkTitle}</h6>
	                                  <div class="task-priority d-flex flex-column align-items-center justify-content-center">
	                                      <span class="badge bg-secondary text-end mt-2">담당자: \${user.projectWorkPic}</span>
	                                      <span class="badge bg-success text-end mt-2">\${user.projectWorkStatus}</span>
	                                      <div class="avatar-list avatar-list-stacked m-0">
	                                          <img class="avatar rounded-circle small-avt" src="${cPath}/resources/images/xs/avatar6.jpg" alt="">
	                                      </div>
	                                  </div>
	                              </div>
	                              <p class="py-2 mb-0">\${user.projectWorkContent}</p>
	                              <div class="tikit-info row g-3 align-items-center">
	                                  <div class="col-sm">
	                                              <div class="d-flex align-items-center">
	                                                  <i class="icofont-flag"></i> <span class="ms-1">\${user.projectWorkStartDate} ~ \${user.projectWorkEndDate} </span>
	                                              </div>
	                                  </div>
	                                  <div class="col-sm text-end">
	                                      <div class=" small text-truncate light-danger-bg py-1 px-2 rounded-1 d-inline-block fw-bold small"> 우선순위 : \${user.projectPriorityName}</div>
	                                  </div>
	                              </div>
	                          </div>
	                      </li>
	          		`
		        })
				let totalItems = data[0].totalData; // 총 데이터 개수
					console.log("totalItems",totalItems);
					let pageSize = 5; // 한 페이지에 보여줄 데이터 개수
					let totalPages = Math.ceil(totalItems / pageSize); // 총 페이지 개수
					let pageCon = document.querySelector('#pwContainer');
					let pagesArray = Array.from({length: totalPages}, (_, i) => i + 1); // 페이지 번호 배열을 생성
					let paginationHTML = pagesArray.map(pageNumber => `<a href="#" data-page="\${pageNumber}" class="page-link">\${pageNumber}</a>`).join('');
					document.querySelector('#pwContainer').innerHTML = paginationHTML;
					
					
					
					let pageLinks = document.querySelectorAll('.page-link');
					pageLinks.forEach((link, index) => {
						link.addEventListener('click', function(event){
							console.log("클릭이벤트")

							event.preventDefault();
							let pageNumber = this.dataset.page;  // get page number from data-page attribute
							axios.get(`/ourmine/company/${companyId}/project/${projectId}/projectWork/projectWorkListJson`,{
								params: {
									page: pageNumber
								}
							},{headers : headers})
							.then(resp => {
								let data = resp.data;
								console.log("dataaaaa",data);
								pwList.innerHTML='';
								pwList.innerHTML+= data.map(item =>
								`
								<tr data-projectworkid =\${item.projectWorkId} data-projectworkstatus=\${item.projectWorkStatus} data-projectworkstatusid=\${item.projectWorkStatusId} data-projectpriorityname=\${item.projectPriorityName}
								data-projectpriorityid=\${item.projectPriorityId} data-projectworktitle =\${item.projectWorkTitle} data-projectworkpic =\${item.projectWorkPic} data-picid =\${item.picId} data-projectWorkStartDate =\${item.projectWorkStartDate}
								data-projectWorkEndDate =\${item.projectWorkEndDate} data-projectWorkWriteDate =\${item.projectWorkWriteDate} data-projectworkcontent =\${item.projectWorkContent}  data-companyid =\${item.companyId}  data-projectid =\${item.projectId} class="nowPwList">
										<td>
											<a class="fw-bold text-secondary"  >\${item.projectWorkId}</a>
										</td>
										<td>
											\${item.projectWorkStatusId===1 ? `<span class="badge bg-warning" data-workid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>` :item.projectWorkStatusId===2
											 ? `<span class="badge bg-primary" data-workid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:item.projectWorkStatusId===3
												 ?`<span class="badge bg-info" data-workid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:item.projectWorkStatusId===4
												 ?`<span class="badge bg-success" data-workid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:`<span class="badge bg-danger" data-workid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`}
										</td>
										<td>
											\${item.projectPriorityName}
										</td>
										<td class="pwDetailModal" name="projectWorkId" data-projectworkiddata=\${item.projectworkid} data-bs-toggle="modal" data-bs-target="#pwDetailModal" >
											\${item.projectWorkTitle}
										</td>

										<td>
											<img class="avatar rounded-circle" src="#" alt="">
											<span class="fw-bold ms-1">\${item.projectWorkPic}</span>
										</td>

										<td>
											\${item.projectWorkStartDate}
									   </td>
										<td>
											\${item.projectWorkEndDate}
									   </td>
										<td>
											\${item.projectWorkWriteDate}
									   </td>
									   <td>
				                           <div class="btn-group" role="group" aria-label="Basic outlined example">
					                           \${item.picId === loginMemberId || projectRoleId === 1 ? `<button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#pwModifyModal" id="pwDetailMoalOpen"><i class="icofont-edit text-success"></i></button>` : `<span></span>`}
					                           \${item.picId === loginMemberId || projectRoleId === 1 ? ` <button type="button" class="btn btn-outline-secondary deleterow" data-projectworkid =\${item.projectWorkId} ><i class="icofont-ui-delete text-danger"></i></button>` : `<span></span>`}
				                           </div>
			                       		</td>


									 </tr>
								`
								).reduce(add)
								data.filter(item=> item.projectWorkStatus === '진행').map((user) => {
					        	//console.log("진행중",pwInProgress);
					        	pwInProgress.innerHTML+=
					        		`
				                   	<li class="dd-item" data-id="\${user.projectWorkId}"> <!-- data-id에 이슈id를 찍으면? -->
				                         <div class="dd-handle">
				                             <div class="task-info d-flex align-items-center justify-content-between">
				                                 <h6 class="light-info-bg py-1 px-2 rounded-1 d-inline-block fw-bold small-14 mb-0">제목: \${user.projectWorkTitle}</h6>
				                                 <div class="task-priority d-flex flex-column align-items-center justify-content-center">
				                                     <span class="badge bg-secondary text-end mt-2">담당자: \${user.projectWorkPic}</span>
				                                     <span class="badge bg-primary text-end mt-2">\${user.projectWorkStatus}</span>
				                                     <div class="avatar-list avatar-list-stacked m-0">
														 <img class="avatar rounded-circle small-avt" src="\${user.imageContents !== null ? user.imageContents : '/ourmine/resources/mytask/documentation/assets/images/profile_av.png'}" alt=""> <!-- 담당자 -->
				                                     </div>
				                                 </div>
				                             </div>
				                             <p class="py-2 mb-0">\${user.projectWorkContent}</p>
				                             <div class="tikit-info row g-3 align-items-center">
				                                 <div class="col-sm">
				                                             <div class="d-flex align-items-center">
				                                                 <i class="icofont-flag"></i> <span class="ms-1">\${user.projectWorkStartDate} ~ \${user.projectWorkEndDate} </span>
				                                             </div>
				                                 </div>
				                                 <div class="col-sm text-end">
				                                     <div class=" small text-truncate light-danger-bg py-1 px-2 rounded-1 d-inline-block fw-bold small"> 우선순위 : \${user.projectPriorityName}</div>
				                                 </div>
				                             </div>
				                         </div>
				                     </li>
					             `
					        });
				        	data.filter(item=> item.projectWorkStatus === '피드백').map((user) => {
				        	//console.log("진행중",pwInProgress);
				        		pwFeedback.innerHTML+=
				        			`
				                      <li class="dd-item" data-id="\${user.projectWorkId}"> <!-- data-id에 이슈id를 찍으면? -->
				                          <div class="dd-handle">
				                              <div class="task-info d-flex align-items-center justify-content-between">
				                                  <h6 class="light-info-bg py-1 px-2 rounded-1 d-inline-block fw-bold small-14 mb-0">제목: \${user.projectWorkTitle}</h6>
				                                  <div class="task-priority d-flex flex-column align-items-center justify-content-center">
				                                      <span class="badge bg-secondary text-end mt-2">담당자: \${user.projectWorkPic}</span>
				                                      <span class="badge bg-info text-end mt-2">\${user.projectWorkStatus}</span>
				                                      <div class="avatar-list avatar-list-stacked m-0">
				                                          <img class="avatar rounded-circle small-avt" src="${cPath}/resources/images/xs/avatar6.jpg" alt="">
				                                      </div>
				                                  </div>
				                              </div>
				                              <p class="py-2 mb-0">\${user.projectWorkContent}</p>
				                              <div class="tikit-info row g-3 align-items-center">
				                                  <div class="col-sm">
				                                              <div class="d-flex align-items-center">
				                                                  <i class="icofont-flag"></i> <span class="ms-1">\${user.projectWorkStartDate} ~ \${user.projectWorkEndDate} </span>
				                                              </div>
				                                  </div>
				                                  <div class="col-sm text-end">
				                                      <div class=" small text-truncate light-danger-bg py-1 px-2 rounded-1 d-inline-block fw-bold small"> 우선순위 : \${user.projectPriorityName}</div>
				                                  </div>
				                              </div>
				                          </div>
				                      </li>
				     		   	  `
				        	})
				        	data.filter(item=> item.projectWorkStatus === '완료').map((user) => {
				       	//console.log("진행중",pwInProgress);
				       		pwCompleted.innerHTML+=
				       			`
				                      <li class="dd-item" data-id="\${user.projectWorkId}"> <!-- data-id에 이슈id를 찍으면? -->
				                          <div class="dd-handle">
				                              <div class="task-info d-flex align-items-center justify-content-between">
				                                  <h6 class="light-info-bg py-1 px-2 rounded-1 d-inline-block fw-bold small-14 mb-0">제목: \${user.projectWorkTitle}</h6>
				                                  <div class="task-priority d-flex flex-column align-items-center justify-content-center">
				                                      <span class="badge bg-secondary text-end mt-2">담당자: \${user.projectWorkPic}</span>
				                                      <span class="badge bg-success text-end mt-2">\${user.projectWorkStatus}</span>
				                                      <div class="avatar-list avatar-list-stacked m-0">
				                                          <img class="avatar rounded-circle small-avt" src="${cPath}/resources/images/xs/avatar6.jpg" alt="">
				                                      </div>
				                                  </div>
				                              </div>
				                              <p class="py-2 mb-0">\${user.projectWorkContent}</p>
				                              <div class="tikit-info row g-3 align-items-center">
				                                  <div class="col-sm">
				                                              <div class="d-flex align-items-center">
				                                                  <i class="icofont-flag"></i> <span class="ms-1">\${user.projectWorkStartDate} ~ \${user.projectWorkEndDate} </span>
				                                              </div>
				                                  </div>
				                                  <div class="col-sm text-end">
				                                      <div class=" small text-truncate light-danger-bg py-1 px-2 rounded-1 d-inline-block fw-bold small"> 우선순위 : \${user.projectPriorityName}</div>
				                                  </div>
				                              </div>
				                          </div>
				                      </li>
				          		`
					        })

		     })
		     document.getElementById('pwList').innerHTML="";
			 pwInProgress.innerHTML = '';
			 pwFeedback.innerHTML = '';
			 pwCompleted.innerHTML = '';

			})

		})

	})
		     document.getElementById('pwList').innerHTML="";
			 pwInProgress.innerHTML = '';
			 pwFeedback.innerHTML = '';
			 pwCompleted.innerHTML = '';

}

		  projectWorkList();

/* 	let createIssueData = {
		issueTitle :'',
		issueContent :'',
		processEtDate:'',
		projectIssueCodeId :'',
		trackerId :''
	} */




//<!-- =============== 테이블 행을 클릭했을 때  ================================= -->

	$(document).on('click','.nowPwList',function(){
		console.log("버튼클릭");

		let projectWorkId = $(this).data("projectworkid");
		let projectWorkTitle = $(this).data("projectworktitle");
		let projectWorkStatusId = $(this).data("projectworkstatusid");
		let projectWorkStatus = $(this).data("projectworkstatus");
		let projectWorkPic = $(this).data("projectworkpic");
		let picId = $(this).data("picid");
		let projectWorkStartDate = $(this).data("projectworkstartdate");
		let projectWorkEndDate = $(this).data("projectworkenddate");
		let projectPriorityId = $(this).data("projectpriorityid");
		let projectPriorityName = $(this).data("projectpriorityname");
		let projectWorkContent = $(this).data("projectworkcontent");
		let companyId = $(this).data("companyid");
		let projectId = $(this).data("projectid");

		console.log("projectworkid",projectWorkId);
		console.log("projectworktitle",projectWorkTitle);
		console.log("projectWorkStatusId",projectWorkStatusId);
		console.log("projectWorkStatus",projectWorkStatus);
		console.log("projectWorkPic",projectWorkPic);
		console.log("projectWorkStartDate",projectWorkStartDate);
		console.log("projectWorkEndDate",projectWorkEndDate);
		console.log("projectPriorityId",projectPriorityId);
		console.log("projectPriorityName",projectPriorityName);
		console.log("projectWorkContent",projectWorkContent);
		console.log("companyId",companyId);
		console.log("projectId",projectId);

		 $("#pwProjectWorkTitle").html(projectWorkTitle);
		 $("#pwProjectId").val(projectId);
         $("#pwCompanyId").val(companyId);
         $("#pwProjectWorkStatusId").val(projectWorkStatusId);
         $("#pwProjectWorkStatus").val(projectWorkStatus);
         $("#pwProjectWorkPic").val(projectWorkPic);
         $("#pwProjectWorkStartDate").val(projectWorkStartDate);
         $("#pwProjectWorkEndDate").val(projectWorkEndDate);
         $("#pwProjectPriorityId").val(projectPriorityId);
         $("#pwProjectPriorityName").val(projectPriorityName);
         $("#pwProjectWorkContent").val(projectWorkContent);
         $("#pwProjectWorkId").val(projectWorkId);
         $("#pwDeProjectWorkId").val(projectWorkId);
         $("#pwPicId").val(picId);

        $("#pwModifyModalCont").find("[name=projectWorkTitle]").val($(pwDetailModal).find("#pwProjectWorkTitle").html());
 	   	$("#pwModifyModalCont").find("[name=companyId]").val($(pwDetailModal).find("#pwCompanyId").val());
 	   	$("#pwModifyModalCont").find("[name=projectId]").val($(pwDetailModal).find("#pwProjectId").val());
 	   	$("#pwModifyModalCont").find("[name=projectWorkStatusId]").val($(pwDetailModal).find("#pwProjectWorkStatusId").val());
 	   	$("#pwModifyModalCont").find("[name=projectWorkStatus]").val($(pwDetailModal).find("#pwProjectWorkStatus").val());
 	   	$("#pwModifyModalCont").find("[name=projectWorkPic]").val($(pwDetailModal).find("#pwProjectWorkPic").val());
 	   	$("#pwModifyModalCont").find("[name=projectWorkStartDate]").val($(pwDetailModal).find("#pwProjectWorkStartDate").val());
 	   	$("#pwModifyModalCont").find("[name=projectWorkEndDate]").val($(pwDetailModal).find("#pwProjectWorkEndDate").val());
 	   	$("#pwModifyModalCont").find("[name=projectPriorityId]").val($(pwDetailModal).find("#pwProjectPriorityId").val());
 	   	$("#pwModifyModalCont").find("[name=projectPriorityName]").val($(pwDetailModal).find("#pwProjectPriorityName").val());
 	   	$("#pwModifyModalCont").find("[name=projectWorkContent]").val($(pwDetailModal).find("#pwProjectWorkContent").val());
 	   	$("#pwModifyModalCont").find("[name=projectWorkId]").val($(pwDetailModal).find("#pwProjectWorkId").val());
 	   	$("#pwModifyModalCont").find("[name=picId]").val($(pwDetailModal).find("#pwPicId").val());

	});




//<!-- ===================== 프로젝트별 멤버리스트 =========================== -->



	const pmList = document.querySelector("#getProjectMemberList");

	//const MoPmList =  document.querySelector("#MoProjectMemberList");

	const pMemberList = function(resp){

		for(let i=0; i<resp.length; i++){
			let pwOption = document.createElement("option");
			pwOption.value = `\${resp[i].memberId}`;
			pwOption.innerHTML = `\${resp[i].memberName}`;
			pmList.appendChild(pwOption);
			//MoPmList.appendChild(pwOption);
		}
	}
	const moPmList =  document.querySelector("#moProjectMemberList");

	const moMemberList = function(resp){

		for(let i=0; i<resp.length; i++){
			let pwOption = document.createElement("option");
			pwOption.value = `\${resp[i].memberId}`;
			pwOption.innerHTML = `\${resp[i].memberName}`;
			moPmList.appendChild(pwOption);
		}
	}


   const projectMemberList = function(){
	 $.ajax({
		  type:"get",
		  url:"/ourmine/company/${companyId}/project/${projectId}/projectWork/projectMemberList",
		  async:true,
		  dataType:"json",
		  success:function(resp){
		      console.log("결과확인",resp);  // 요기 코드가 길어지면  별도 함수로 처리/ 그래야 가독성이 유지됨
		      pMemberList(resp);
		      moMemberList(resp);
		  },
		  error: function (request, status, error) {
		      console.log("code: " + request.status)
		      console.log("message: " + request.responseText)
		      console.log("error: " + error);
		  }

		})
	};

	projectMemberList();
//<!-- ====================================== 검색  ========================================================= -->
searchProjectWork.addEventListener('input', () => {

		console.log('실행되나?');
		headers['Content-Type'] = 'application/json'
		headers['accept'] = 'application/json'
		let search = searchProjectWork.value;
		if (search.trim() === '') {
			console.log("트림트림")
			document.getElementById('pwList').innerHTML="";
			projectWorkList();
			return false;
		} else {

			axios.get(`/ourmine/company/${companyId}/project/${projectId}/projectWork/projectWorkListJson`, {
						params: {
							search: search
						}
					}, {headers: headers},
			).then(resp => {
				let data = resp.data;
				console.log("searchData", data);
				document.getElementById('pwList').innerHTML="";

				pwList.innerHTML+= data.map(item =>
					`
					<tr data-projectworkid =\${item.projectWorkId} data-projectworkstatus=\${item.projectWorkStatus} data-projectworkstatusid=\${item.projectWorkStatusId} data-projectpriorityname=\${item.projectPriorityName}
					data-projectpriorityid=\${item.projectPriorityId} data-projectworktitle =\${item.projectWorkTitle} data-projectworkpic =\${item.projectWorkPic} data-picid =\${item.picId} data-projectWorkStartDate =\${item.projectWorkStartDate}
					data-projectWorkEndDate =\${item.projectWorkEndDate} data-projectWorkWriteDate =\${item.projectWorkWriteDate} data-projectworkcontent =\${item.projectWorkContent}  data-companyid =\${item.companyId}  data-projectid =\${item.projectId} class="nowPwList">
						<td>
							<a class="fw-bold text-secondary"  >\${item.projectWorkId}</a>
						</td>
						<td>
							\${item.projectWorkStatusId===1 ? `<span class="badge bg-warning" data-workid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>` :item.projectWorkStatusId===2
								? `<span class="badge bg-primary" data-workid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:item.projectWorkStatusId===3
									?`<span class="badge bg-info" data-workid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:item.projectWorkStatusId===4
									?`<span class="badge bg-success" data-workid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:`<span class="badge bg-danger" data-workid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`}
						</td>
						<td>
							\${item.projectPriorityName}
						</td>
						<td class="pwDetailModal" name="projectWorkId" data-projectworkiddata=\${item.projectworkid} data-bs-toggle="modal" data-bs-target="#pwDetailModal" >
							\${item.projectWorkTitle}
						</td>

						<td>
							<img class="avatar rounded-circle" src="#" alt="">
							<span class="fw-bold ms-1">\${item.projectWorkPic}</span>
						</td>

						<td>
							\${item.projectWorkStartDate}
						</td>
						<td>
							\${item.projectWorkEndDate}
						</td>
						<td>
							\${item.projectWorkWriteDate}
						</td>
						<td>
							<div class="btn-group" role="group" aria-label="Basic outlined example">
							 \${item.picId === loginMemberId || projectRoleId === 1 ? `<button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#pwModifyModal" id="pwDetailMoalOpen"><i class="icofont-edit text-success"></i></button>` : `<span></span>`}
	                         \${item.picId === loginMemberId || projectRoleId === 1 ? ` <button type="button" class="btn btn-outline-secondary deleterow" data-projectworkid =\${item.projectWorkId} ><i class="icofont-ui-delete text-danger"></i></button>` : `<span></span>`}
							</div>
						</td>


						</tr>
					`
				).reduce(add)


				})
				document.getElementById('pwList').innerHTML="";
		}
})



//=================== 리스트 전부 클리어===================
function clearPwList() {
	document.getElementById('pwList').innerHTML="";
/* 	statusLow.innerHTML ='';
	statusMid.innerHTML ='';
	statusHigh.innerHTML =''; */
}

// ===================이슈리스트 상위부분만 클리어 ===================
function clearPwListMain(){
	document.getElementById('pwList').innerHTML="";
 }
//<!-- ===================================================================================================================================== -->
	// 일감 등록
  	let pwSendData = function(contentType, form){
  		let data = {};
  		$(form).find(":input[name]").each(function(index, input){
  			let propertyName = this.name;
  			let propertyValue = $(this).val();
  			data[propertyName] = propertyValue;
  		});
  		if(contentType.indexOf("json") >= 0)
  			data = JSON.stringify(data);	// marshalling
  		console.log(data);
  		return data;
  	}
//	<!-- ===================================================================================================================================== -->
	$(function() {
		// let data = $('#insertForm').serialize();
		$('#pwInBtn').bind("click",function(e) {
			console.log("등록모달")
			e.preventDefault();
			

			let data = {
				projectWorkTitle:pwInsertForm.projectWorkTitle.value,
				projectWorkContent:pwInsertForm.projectWorkContent.value,
				projectWorkPic: pwInsertForm.picId.options[pwInsertForm.picId.selectedIndex].innerHTML,
				projectWorkStartDate:pwInsertForm.projectWorkStartDate.value,
				projectWorkEndDate:pwInsertForm.projectWorkEndDate.value,
				projectWorkStatusId:pwInsertForm.projectWorkStatusId.value,
				projectPriorityId:pwInsertForm.projectPriorityId.value,
				picId:pwInsertForm.picId.value
			}


			console.log("데이터 확인: ", data);

			if (data.projectWorkTitle === '' || data.projectWorkContent === '' || data.projectWorkPic === '' || data.projectWorkStartDate === '' 
					|| data.projectWorkEndDate === ''  || data.projectWorkStatusId === ''  || data.projectPriorityId === '' || data.picId === '' ) {
				Swal.fire({
					icon: 'warning',
					title:'모두 입력해주세요',
					showConfirmButton: false,
					timer: 1000
				})
				return; // 등록 중단
		    }
			
			
			$.ajax({
				type: 'POST',
				url: '/ourmine/company/${companyId}/project/${projectId}/projectWork/projectWorkForm',
				data: JSON.stringify(data),
				contentType : "application/json;charset=utf-8",
				beforeSend : function(xhr){  // 헤더에 값 세팅, 항상 요따구로 씀
	                      xhr.setRequestHeader(header, token);
	                  },
				success: function(res) {
					console.log("확인 : ", res);
					Swal.fire({
							icon: 'success',
							title:'등록완료',
							showConfirmButton: false,
							timer: 800
					})
					$('#pwInsertModal').modal('hide')
					$('#pwInsertForm')[0].reset();
					projectWorkList();
					//location.href=location.href;
				},
				error: function(xhr, status, error) {
					alert('게시글 등록에 실패하였습니다.');
			        console.log("error: " + error);
				}
			});
		});

//	<!-- ===================================================================================================================================== -->
		// 일감 수정
		$("#btnSave").bind("click", function(){
			console.log("수정폼 click");
			let data = {
					projectWorkId:pwModifyForm.projectWorkId.value,
					projectWorkTitle:pwModifyForm.projectWorkTitle.value,
					projectWorkContent:pwModifyForm.projectWorkContent.value,
					projectWorkPic:pwModifyForm.picId.options[pwModifyForm.picId.selectedIndex].innerHTML,
					projectWorkStartDate:pwModifyForm.projectWorkStartDate.value,
					projectWorkEndDate:pwModifyForm.projectWorkEndDate.value,
					projectWorkStatusId:pwModifyForm.projectWorkStatusId.value,
					projectPriorityId:pwModifyForm.projectPriorityId.value,
					picId:pwModifyForm.picId.value
			}

			$.ajax({

				url: '/ourmine/company/${companyId}/project/${projectId}/projectWork/projectWorkView',
				data: JSON.stringify(data),
				//data: $('#pwModifyForm').serialize(),
				contentType: "application/json;charset=utf-8",
				type: 'POST',
				dataType: 'json',
				beforeSend : function(xhr){  // 헤더에 값 세팅, 항상 요따구로 씀
	                      xhr.setRequestHeader(header, token);
	                  },
				success: function(res) {
						pwModifyModalClose();
						projectWorkList();
						//location.reload();
				},
				error: function(xhr, status, error) {
					alert('게시글 수정에 실패하였습니다.');
			        console.log("상태코드:" + request.status + "\n" + "에러내용:" + request.responseText + "\n" + "error:" + error);
				}
			});
		});


	});
//<!-- ===================================================================================================================================== -->
		// 일감 삭제
		$(document).on('click', '.deleterow', function(e){
			 console.log("삭제클릭");
			 let projectWorkId = $(this).data("projectworkid");

			 console.log("projectWorkId",projectWorkId);
			 e.preventDefault();
			 Swal.fire({
					icon: 'warning',
					title: '삭제 하시겠습니까?',
					showCancelButton: true,
					confirmButtonText: '확인',
					cancelButtonText: '취소'
				}).then(function (result){
					if(result.isConfirmed){
						axios.post(`/ourmine/company/${companyId}/project/${projectId}/projectWork/projecWorktDelete`,projectWorkId,{headers : headers})

						.then(resp => {
							$("#dremovetask").modal('hide');
		                    projectWorkList();

						})

					}
				})

		})


		/* const pwDelete = (projectWorkId) => {



			$.ajax({
		                 url: "/ourmine/company/${companyId}/project/${projectId}/projectWork/projecWorktDelete",
		                 data: JSON.stringify(projectWorkId),
		                 contentType : "application/json;charset=utf-8",
		                 type: "post",
		                 dataType:"json",
		                 beforeSend : function(xhr){  // 헤더에 값 세팅, 항상 요따구로 씀
		                     xhr.setRequestHeader(header, token);
		                 },
		                 success: function (res) {
		                 	console.log("삭제 확인", res);
		                 	$("#dremovetask").modal('hide');
		                    projectWorkList();

		                 },
		                 error: function (request, status, error) {
		                 	alert("삭제 실패");
		                     console.log("상태코드:" + request.status + "\n" + "에러내용:" + request.responseText + "\n" + "error:" + error);
		                 }
		             });
		}; */
//<!-- ===================================================================================================================================== -->






</script>






<!-- Jquery Core Js -->
<%-- <script src="${cPath }/resources/mytask/HTML/dist/assets/bundles/libscripts.bundle.js"></script> --%>

<!-- Plugin Js-->
<%-- <script src="${cPath }/resources/mytask/HTML/dist/assets/bundles/nestable.bundle.js"></script>   --%>

<!-- Jquery Page Js -->
<%-- <script src="${cPath }/resources/mytask/HTML/js/template.js"></script> --%>
<%--  <script src="${cPath }/resources/mytask/HTML/js/page/task.js"></script>     --%>

</body>
