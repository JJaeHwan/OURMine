<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
	<%@ taglib	uri="http://www.springframework.org/security/tags" prefix="security" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
							<h3 class="fw-bold mb-0">회사 목록</h3>
							<div class="col-auto d-flex w-sm-100">
								<button style="display: none" type="button" class="btn btn-dark btn-set-task w-sm-100" data-bs-toggle="modal" data-bs-target="#tickadd">
									Add Issue <i class="icofont-plus-circle me-2 fs-6"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
				<!-- Row end  -->
				<div class="row clearfix g-3">
					<div class="col-sm-12">
						<div class="card mb-3">
							<div class="card-body">
									<input type="text" class="form-control search" placeholder="Search" id="searchIssue" >
								<table id="myProjectTable" class="table table-hover align-middle mb-0" style="width: 100%">
									<thead>
									<tr>
										<th>회사 ID</th>
										<th>회사 이름</th>
										<th>회사 주소</th>
										<th>회사 전화번호</th>
										<th>회사 가입</th>
									</tr>
									</thead>
									<tbody id="companyList">

									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<!-- Row End -->
			</div>
		</div>



		<!-- 이슈 등록 -->
		<form class="insertIssueForm" method="post" >
			<div class="modal fade" id="tickadd" tabindex="-1" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered modal-md modal-dialog-scrollable">

					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title  fw-bold" id="leaveaddLabel">ISSUE Add</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="mb-3">
								<label for="issueTitle" class="form-label">이슈제목</label>
								<input type="text" class="form-control" id="issueTitle"  placeholder="제목입력" />
							</div>
							<div class="mb-3">
								<label for="issueContent" class="form-label">이슈내용</label>
								<textarea class="form-control" id="issueContent" rows="3" placeholder=""></textarea>
							</div>

							<div class="deadline-form">
								<div class="row g-3 mb-3">
									<div class="col">
										<label class="form-label">이슈상태</label>
										<select id= "issueCodeList" class="form-select " multiple aria-label="Default select Priority">

										</select>
									</div>
									<div class="col">
										<label class="form-label">이슈카테고리</label>
										<select id= "trackerCodeList" class="form-select " multiple aria-label="Default select Priority">

										</select>
									</div>
								</div>

							</div>

							<div class="deadline-form">
								<div class="row g-3 mb-3">
									<div class="col">
										<label for="issueEndDate" class="form-label">예상 종료날짜</label>
										<input type="date" class="form-control" id="issueEndDate">
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Done</button>
							<button type="submit" class="btn btn-primary">Create</button>
						</div>
					</div>
				</div>
			</div>
		</form>




		<!-- 이슈상태 컴플리트로 업데이트 치기 위한 모달 -->
			<div class="modal fade" id="changeStatus" tabindex="-1" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered modal-md modal-dialog-scrollable">

					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title  fw-bold" >이슈상태 변경</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="mb-3">
								<label class="form-label">이슈작성자</label>
								<input type="text" class="form-control" id="basicIssueWriter" readonly="readonly" />
							</div>
							<div class="mb-3">
								<label class="form-label">이슈제목</label>
								<input type="text" class="form-control" id="basicIssueTitle" readonly="readonly"/>
							</div>
							<div class="mb-3">
								<label class="form-label">이슈내용</label>
								<textarea class="form-control" id="basicIssueContent" rows="3" readonly="readonly"></textarea>
							</div>

							<div class="deadline-form">
								<div class="row g-3 mb-3">
									<div class="col">
										<label for="issueEndDate" class="form-label">예상 종료날짜</label>
										<input type="date" class="form-control" id="basicIssueEndDate" readonly="readonly" value="">
									</div>
								</div>
							</div>
						</div>
						<h5 class="fw-bold" > &nbsp; &nbsp; 이슈를 처리하시겠습니까?</h5>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Done</button>
							<button type="button" class="btn btn-primary completeBtn">Complete</button>
						</div>
					</div>
				</div>
			</div>
	</div>
</div>





<script type="text/javascript">


const add = (a,b) => a + b

headers['Content-Type'] = 'application/json'
headers['accept'] = 'application/json'



let company = document.querySelector('#companyList');
let search = document.querySelector('.search');

search.addEventListener('input', () => {
	company.innerHTML = '';
	if(search.value.trim() === '') {
		companyList();
		return false;
	};
	let value = search.value;
	axios.get('/ourmine/company/companySearch', {
		params : {
			search : value
		}
	},{headers: headers})
			.then(resp => {
				let searchData = resp.data;
				console.log("search data = ",searchData)
				searchData.map(item => {
					company.innerHTML += `
						<tr>
						<td>\${item.companyId}</td>
						<td>\${item.companyName}</td>
						<td>\${item.companyAddr}</td>
						<td>\${item.companyTel}</td>
						<td>\${item.memberCount > 0 && item.requestStatus ==='승인됨' ? `<button type="button"  class="btn btn-success" data-company=\${item.companyId}>승인됨</button>` : (item.memberCount > 0 && item.requestStatus ==='거절됨' ?
							`<button type="button"  class="btn btn-danger" data-company=\${item.companyId}>거절됨</button>` :
							(item.memberCount > 0 ?
							`<button type="button"  style="margin-right: 10px;" class="btn btn-warning" data-company=\${item.companyId}>신청완료</button><button type="button" class="btn btn-outline-secondary cancellation" data-company=\${item.companyId}>취소</button>` :
							`<button type="button" class="btn btn-outline-secondary joinBtn" data-company=\${item.companyId}>참가</button>`))}</td>
						</tr>
					`
				})
			})
})



 async function companyList() {
	await axios.get('/ourmine/company/companySearch',{headers:headers})
			.then(resp => {
				let data = resp.data;
				console.log("companySearch = ",data)
				  company.innerHTML = '';
				  company.innerHTML += data.map(item =>
						`
						<tr>
						<td>\${item.companyId}</td>
						<td>\${item.companyName}</td>
						<td>\${item.companyAddr}</td>
						<td>\${item.companyTel}</td>
						<td>\${item.memberCount > 0 && item.requestStatus ==='승인됨' ? `<button type="button"  class="btn btn-success" data-company=\${item.companyId}>승인됨</button>` : (item.memberCount > 0 && item.requestStatus ==='거절됨' ?
								`<button type="button"  class="btn btn-danger" data-company=\${item.companyId}>거절됨</button>` :
								(item.memberCount > 0 ?
								`<button type="button"  style="margin-right: 10px;" class="btn btn-warning" data-company=\${item.companyId}>신청완료</button><button type="button" class="btn btn-outline-secondary cancellation" data-company=\${item.companyId}>취소</button>` :
								`<button type="button" class="btn btn-outline-secondary joinBtn" data-company=\${item.companyId}>참가</button>`))}</td>
						</tr>
	 					`
				).reduce(add)
			})
}

const companyInsert = {
	companyId : ''
}
function attachEventListeners() {
	let joinBtn = document.querySelectorAll('.joinBtn');
	let cancellation = document.querySelectorAll('.cancellation');

	// 참가 버튼
	joinBtn.forEach(item => {
		item.addEventListener('click', async (e) => {
			if (!e.target.classList.contains('joinBtn')) return;
			let { company } = e.target.dataset;
			companyInsert.companyId = company;
			console.log("companyInsert.companyId =", companyInsert.companyId);
			let resp = await axios.post('/ourmine/waiting/waitingInsert', companyInsert, { headers: headers });
			let data = resp.data;
			console.log("insert 성공여부 ", data);
			if (data > 0) {
				await companyList();
				attachEventListeners();
			}
		});
	});

	// 취소 버튼
	cancellation.forEach(item => {
		item.addEventListener('click', async (e) => {
			let { company } = e.target.dataset;
			console.log("company Id = ", company);
			companyInsert.companyId = company;
			let resp = await axios.post("/ourmine/waiting/waitingDelete", companyInsert, { headers: headers });
			let data = resp.data;
			console.log(data);
			if (data > 0) {
				await companyList();
				attachEventListeners();
			}
		});
	});
}
companyList().then(attachEventListeners);



</script>



