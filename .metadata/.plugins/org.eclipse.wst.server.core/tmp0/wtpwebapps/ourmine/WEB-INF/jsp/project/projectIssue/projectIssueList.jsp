<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib	uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
th.sortable {
    cursor: pointer;
}
</style>
<div id="mytask-layout" class="theme-indigo">

	<!-- main body area -->
	<div class="main px-lg-4 px-md-4">

		<!-- Body: Body -->
		<div class="body d-flex py-lg-3 py-md-2">
			<div class="container-xxl">
				<div class="row align-items-center">
					<div class="border-0 mb-4">
						<div class="card-header py-3 no-bg bg-transparent d-flex align-items-center px-0 justify-content-between border-bottom flex-wrap">
							<h3 class="fw-bold mb-0">이슈관리</h3>
							<div class="col-auto d-flex w-sm-100">
								<button type="button" class="btn btn-dark btn-set-task w-sm-100" data-bs-toggle="modal" data-bs-target="#tickadd">
									이슈 추가 <i class="icofont-plus-circle me-2 fs-6"></i>
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
								<input type="text" class="form-control" placeholder="Search" id="searchIssue" >
								<table id="myProjectTable" class="table table-hover align-middle mb-0" style="width: 100%">
									<thead>
									<tr>
										<th data-key="projectIssueId" data-order="asc" class="sortable">이슈 ID</th>
										<th data-key="trackerName" data-order="asc" class="sortable">종류</th>
										<th data-key="issueTitle" data-order="asc" class="sortable">이슈 제목</th>
										<th data-key="issueWriter" data-order="asc" class="sortable">작성자</th>
										<th data-key="issueDate" data-order="asc" class="sortable">이슈발행 날짜</th>
										<th data-key="issueStatus" data-order="asc" class="sortable" id="nowStatus">진행상태</th>
										<th>Actions</th>
									</tr>
									</thead>
									<tbody id="issueList">
									<tr style="display: none">
										<th>이슈 ID</th>
										<th>이슈 제목</th>
										<th>작성자</th>
										<th>이슈발행 날짜</th>
										<th>진행상태</th>
										<th>진행상태</th>
										<th>Actions</th>
									</tr>
									</tbody>
								</table>
								<nav aria-label="Page navigation">
								    <div>
								    <ul style="display: flex" class="pagination justify-content-center">
								        <li class="page-item disabled" >  <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>  </li>
								        <li class="page-item" style="display: flex" id="issuesContainer"><a class="page-link" href="#">1</a></li>
								        <li class="page-item">  <a class="page-link" href="#">Next</a> </li>
								    </ul>
								    </div>
								</nav>
							</div>
						</div>
					</div>
				</div>
				<!-- Row End -->
			</div>
		</div>
		<div class="row taskboard g-3 py-xxl-4">
			<div class="col-xxl-4 col-xl-4 col-lg-4 col-md-12 mt-xxl-4 mt-xl-4 mt-lg-4 mt-md-4 mt-sm-4 mt-4">
				<h6 class="fw-bold py-3 mb-0">상태: 긴급</h6>
				<div class="progress_task">
					<div class="dd" data-plugin="nestable" >
						<ol class="dd-list" id="statusHigh">
						
						</ol>
					</div>
				</div>
			</div>
			<div class="col-xxl-4 col-xl-4 col-lg-4 col-md-12 mt-xxl-4 mt-xl-4 mt-lg-4 mt-md-0 mt-sm-0 mt-0">
				<h6 class="fw-bold py-3 mb-0">상태: 보통</h6>
				<div class="review_task">
					<div class="dd" data-plugin="nestable" >
						<ol class="dd-list" id="statusMid">
						
						</ol>
					</div>
				</div>
			</div>
			<div class="col-xxl-4 col-xl-4 col-lg-4 col-md-12 mt-xxl-4 mt-xl-4 mt-lg-4 mt-md-0 mt-sm-0 mt-0">
				<h6 class="fw-bold py-3 mb-0">상태: 낮음</h6>
				<div class="completed_task">
					<div class="dd" data-plugin="nestable" >
						<ol class="dd-list" id="statusLow">
						
						</ol>
					</div>
				</div>
			</div>
		</div>


		<!-- 이슈 등록 -->
		<form class="insertIssueForm" method="post" >
			<div class="modal fade" id="tickadd" tabindex="-1" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered modal-md modal-dialog-scrollable">

					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title  fw-bold" id="leaveaddLabel">이슈 추가</h5>
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
									<div class="col-sm-12">
                                    <label for="formFileMultipleone" class="form-label">이슈 알림 대상자</label>
                                    <select id="alarmReceiver" class="form-select" multiple aria-label="Default select Priority">
                                        
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
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">등록</button>
						</div>
					</div>
				</div>
			</div>
		</form>



		<!-- 이슈 상세보기 여기에서 진행중 -> 완료로 바꿀거임  -->
		<div class="modal fade" id="issueDetail" tabindex="-1" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered modal-md modal-dialog-scrollable">

				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title  fw-bold" >이슈 상세보기</h5>
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
									<label class="form-label">이슈상태</label>
									<input type="text" class="form-control" id="basicIssueStatus" readonly="readonly" value="">
								</div>
								<div class="col">
									<label class="form-label">이슈카테고리</label>
									<input type="text" class="form-control" id="basicIssueTracker" readonly="readonly" value="">
								</div>
							</div>
							<div class="row g-3 mb-3">
								<div class="col">
									<label for="issueEndDate" class="form-label">이슈 발생날짜</label>
									<input type="date" class="form-control" id="basicIssueEventDate" readonly="readonly" value="">
									<label for="issueEndDate" class="form-label">예상 종료날짜</label>
									<input type="date" class="form-control" id="basicIssueEndDate" readonly="readonly" value="">
								</div>
							</div>
						</div>
						<div class="mb-3">
							<label class="form-label">진행상태</label>
							<input type="text" class="form-control" id="basicIssueProcess" readonly="readonly"/>
						</div>
						<div class="mb-3">
							<label class="form-label" id="commentLabel">이슈해결코멘트</label>
							<input type="text" class="form-control" id="basicIssueComment" readonly="readonly"/>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</div>


<security:authentication property="principal" var="principal"/>

<input id="projectIdHidden" type="hidden" value="${projectId }">
<input id="companyIdHidden" type="hidden" value="${companyId }">


<script type="text/javascript">
	let searchIssue = document.querySelector("#searchIssue");
	const selectIssueList = {

	}
	const add = (a,b) => a + b;
	let projectIdHidden = document.querySelector('#projectIdHidden');
	let companyIdHidden = document.querySelector('#companyIdHidden');
	let projectIdHiddenValue = projectIdHidden.value;
	let companyIdHiddenValue = companyIdHidden.value;
	console.log("projectIdHiddenValue:",projectIdHiddenValue)
	console.log("companyIdHiddenValue:",companyIdHiddenValue)
	// ===========================이슈리스트 생성===========================
	let proList = document.querySelector("#issueList");
	console.log("proList",proList);
	let statusLow = document.querySelector("#statusLow");
	let statusMid = document.querySelector("#statusMid");
	let statusHigh = document.querySelector("#statusHigh");


	headers['Content-Type'] = 'application/json'
	headers['accept'] = 'application/json'
	 function issueList() {
		console.log("이슈리스트 오냐?")
	 axios.get(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/projectIssue/issueList`,{headers : headers})
				.then(resp => {
					let data = resp.data
					console.log("이슈리스트data:",data)
					
					proList.innerHTML+= data.map(item =>
							`
						<tr data-projectissueid =\${item.projectIssueId} data-issuetitle=\${item.issueTitle} data-issuewriter=\${item.projectIssueWriter} data-issueeventdate =	\${item.issueEventDate} data-issuecomment = \${item.projectIssueComment}
							data-issuecontent =\${item.issueContent} data-issueenddate =\${item.processEtDate} data-issuecodename=\${item.projectIssueCodeName} data-issuetrackername = \${item.trackerName} data-issuestatusname=\${item.projectStatusName} class="nowIssueList">
							<td>
								<a class="fw-bold text-secondary">\${item.projectIssueId}</a>
							</td>
							<td>
								\${item.trackerName ==='결함' ? `<span class="badge rounded-pill bg-danger">\${item.trackerName}</span>` 
											:item.trackerName === '이벤트' ? `<span class="badge rounded-pill bg-info">\${item.trackerName}</span>` 
													: `<span class="badge rounded-pill bg-primary">\${item.trackerName}</span>`}

								
							</td>
							<td class="issueDetail" data-issueiddata=\${item.projectIssueId} data-bs-toggle="modal" data-bs-target="#issueDetail" >
								\${item.issueTitle}
							</td>
							<td>
								<img class="avatar rounded-circle" src="\${item.imageContents != null ? item.imageContents : '#'}" alt="">
								<span class="fw-bold ms-1">\${item.projectIssueWriter}</span>
							</td>
							<td>
								\${item.issueEventDate}
						   </td>
							<td>
								\${item.projectStatusId===1 ? `<span class="badge bg-warning" data-issueid=\${item.projectStatusId}>\${item.projectStatusName}</span>` : `<span class="badge bg-success" data-issueid=\${item.projectStatusId}>\${item.projectStatusName}</span>`}
							</td>

							 <td>
								 <div class="btn-group" role="group" aria-label="Basic outlined example">
								\${item.projectStatusId===1 && item.myRoleId===1 ? `<button data-projectissueiddata =\${item.projectIssueId} type="button" class = "btn btn-outline-success issueCheckBtn" >체킁</button>` : `<span></span>`}
								 </div>
							 </td>
						 </tr>

           		 `
				).reduce(add)
					issueDetail();
					let totalItems = data[0].totalData; // 총 데이터 개수
					console.log("totalItems",totalItems);
					let pageSize = 5; // 한 페이지에 보여줄 데이터 개수
					let totalPages = Math.ceil(totalItems / pageSize); // 총 페이지 개수
					let pageCon = document.querySelector('#issuesContainer');
					let pagesArray = Array.from({length: totalPages}, (_, i) => i + 1); // 페이지 번호 배열을 생성
					let paginationHTML = pagesArray.map(pageNumber => `<a href="#" data-page="\${pageNumber}" class="page-link">\${pageNumber}</a>`).join('');
					document.querySelector('#issuesContainer').innerHTML = paginationHTML;

					let pageLinks = document.querySelectorAll('.page-link');
					pageLinks.forEach((link, index) => {
						link.addEventListener('click', function(event){
							console.log("클릭이벤트")

							event.preventDefault();
							let pageNumber = this.dataset.page;  // get page number from data-page attribute
							axios.get(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/projectIssue/issueList`,{
								params: {
									page: pageNumber
								}
							},{headers : headers})
									.then(resp => {
										let data = resp.data;
										console.log("dataaaaa",data);
										proList.innerHTML='';
										proList.innerHTML+= data.map(item =>
												`
						<tr data-projectissueid =\${item.projectIssueId} data-issuecomment = \${item.projectIssueComment} data-issuetitle=\${item.issueTitle} data-issuewriter=\${item.projectIssueWriter} data-issueeventdate =	\${item.issueEventDate}
							data-issuecontent =\${item.issueContent} data-issueenddate =\${item.processEtDate} data-issuecodename=\${item.projectIssueCodeName} data-issuetrackername = \${item.trackerName} data-issuestatusname=\${item.projectStatusName}
							class="nowIssueList">
							<td>
								<a class="fw-bold text-secondary">\${item.projectIssueId}</a>
							</td>
							<td>
							\${item.trackerName ==='결함' ? `<span class="badge rounded-pill bg-danger">\${item.trackerName}</span>` 
										:item.trackerName === '이벤트' ? `<span class="badge rounded-pill bg-info">\${item.trackerName}</span>` 
												: `<span class="badge rounded-pill bg-primary">\${item.trackerName}</span>`
							}
							
						</td>
							<td class="issueDetail" data-issueiddata=\${item.projectIssueId} data-bs-toggle="modal" data-bs-target="#issueDetail" >
								\${item.issueTitle}
							</td>
							<td>
							<img class="avatar rounded-circle" src="\${item.imageContents != null ? item.imageContents : '#'}" alt="">
								<span class="fw-bold ms-1">\${item.projectIssueWriter}</span>
							</td>
							<td>
								\${item.issueEventDate}
						   </td>
							<td>
								\${item.projectStatusId===1 ? `<span class="badge bg-warning" data-issueid=\${item.projectStatusId}>\${item.projectStatusName}</span>` : `<span class="badge bg-success" data-issueid=\${item.projectStatusId}>\${item.projectStatusName}</span>`}
							</td>

							 <td>
								 <div class="btn-group" role="group" aria-label="Basic outlined example">
								 \${item.projectStatusId===1 && item.myRoleId===1 ? `<button data-projectissueiddata =\${item.projectIssueId} type="button" class = "btn btn-outline-success issueCheckBtn" >체킁</button>` : `<span></span>`}
								 </div>
							 </td>
						 </tr>

           		 `
									).reduce(add)
									}).then(test =>{
										console.log("테스트콘솔")
										issueDetail();
							})
						});
					});

				})

	}
	// 정렬 
	$(document).ready(function(){
		  $('#myProjectTable th').each(function (column) {
		    $(this).click(function() {
		    	console.log("정렬클릭이벤트");
		      if($(this).is('.asc')) {
		        $(this).removeClass('asc');
		        $(this).addClass('desc');
		        sortdir=-1;

		      } else {
		        $(this).addClass('asc');
		        $(this).removeClass('desc'); sortdir=1;
		      }

		      $(this).siblings().removeClass('asc');
		      $(this).siblings().removeClass('desc');

		      var rec = $('#myProjectTable').find('tbody>tr').get();

		      rec.sort(function (a, b) {
		        var val1 = $(a).children('td').eq(column).text().toUpperCase();
		        var val2 = $(b).children('td').eq(column).text().toUpperCase();
		        return (val1 < val2)?-sortdir:(val1>val2)?sortdir:0;
		      });

		      $.each(rec, function(index, row) {
		          $('#myProjectTable tbody').append(row);
		      });
		    });
		 });
		});
	
	issueList();
	issueListBottom ();
	issueDetail();
	alarmReceiver();
	addIssueCodeList();
	addIssue();

	function issueListBottom (){
		axios.get(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/projectIssue/issueListBottom`,{
			params: {
				projectId: projectIdHiddenValue
			}
		},{headers : headers})
				.then(resp => {
					let data = resp.data
					console.log("bottomData:", data)
					data.filter(item => item.projectIssueCodeName === '긴급' && item.projectStatusId === 1).map((user) =>{
						statusHigh.innerHTML+=
								`
				
                          <li class="dd-item" data-id="\${user.issueId}"> <!-- data-id에 이슈id를 찍으면? -->
                              <div class="dd-handle">
	                              <div class="task-info d-flex align-items-center justify-content-between">
		                              <h6 class="light-info-bg py-1 px-2 rounded-1 d-inline-block fw-bold small-14 mb-0">제목: \${user.issueTitle}</h6>
			                              <div class="task-priority d-flex flex-column align-items-center justify-content-center">
			                                  <div class="avatar-list avatar-list-stacked m-0">
			                                  <img class="avatar rounded-circle" src="\${user.imageContents != null ? user.imageContents : '#'}" alt="">
			                                  </div>
			                                  <span class="badge bg-warning text-end mt-2">작성자: \${user.projectIssueWriter}</span>
			                              </div>
	                          	  </div>
                                  <p class="py-2 mb-0">\${user.issueContent}</p>
                                  <div class="tikit-info row g-3 align-items-center">
                                      <div class="col-sm">
                                          <ul class="d-flex list-unstyled align-items-center flex-wrap">
                                              <li class="me-2">
                                                  <div class="d-flex align-items-center">
                                                      <i class="icofont-flag"></i> <span class="ms-1">\${user.issueEventDate} ~ \${user.processEtDate} </span>

                                                  </div>
                                              </li>
                                          </ul>
                                      </div>
                                      <div class="col-sm text-end">
                                      \${user.trackerName ==='결함' ? `<span class="badge rounded-pill bg-danger">\${user.trackerName}</span>` 
      										:user.trackerName === '이벤트' ? `<span class="badge rounded-pill bg-info">\${user.trackerName}</span>` 
      												: `<span class="badge rounded-pill bg-primary">\${user.trackerName}</span>`}
      							
                                      </div>
                                  </div>
                              </div>

                          </li>
			`
					}	)
					data.filter(item => item.projectIssueCodeName === '보통'&& item.projectStatusId === 1).map((user) =>{
						statusMid.innerHTML+=
								`
                          <li class="dd-item" data-id="\${user.issueId}"> <!-- data-id에 이슈id를 찍으면? -->
                              <div class="dd-handle">
                                  <div class="task-info d-flex align-items-center justify-content-between">
                                      <h6 class="light-info-bg py-1 px-2 rounded-1 d-inline-block fw-bold small-14 mb-0">제목: \${user.issueTitle}</h6>
                                      <div class="task-priority d-flex flex-column align-items-center justify-content-center">
                                          <div class="avatar-list avatar-list-stacked m-0">
                                          <img class="avatar rounded-circle" src="\${user.imageContents != null ? user.imageContents : '#'}" alt="">
                                          </div>
                                          <span class="badge bg-warning text-end mt-2">작성자: \${user.projectIssueWriter}</span>
                                      </div>
                                  </div>
                                  <p class="py-2 mb-0">\${user.issueContent}</p>
                                  <div class="tikit-info row g-3 align-items-center">
                                      <div class="col-sm">
                                          <ul class="d-flex list-unstyled align-items-center flex-wrap">
                                              <li class="me-2">
                                                  <div class="d-flex align-items-center">
                                                      <i class="icofont-flag"></i> <span class="ms-1">\${user.issueEventDate} ~ \${user.processEtDate} </span>

                                                  </div>
                                              </li>
                                          </ul>
                                      </div>
                                      <div class="col-sm text-end">
                                      \${user.trackerName ==='결함' ? `<span class="badge rounded-pill bg-danger">\${user.trackerName}</span>` 
        										:user.trackerName === '이벤트' ? `<span class="badge rounded-pill bg-info">\${user.trackerName}</span>` 
        												: `<span class="badge rounded-pill bg-primary">\${user.trackerName}</span>`}
                                      </div>
                                  </div>
                              </div>

                          </li>
			`
					}	)
					data.filter(item => item.projectIssueCodeName === '낮음'&& item.projectStatusId === 1).map((user) =>{
						statusLow.innerHTML+=
								`
                          <li class="dd-item" data-id="\${user.issueId}"> <!-- data-id에 이슈id를 찍으면? -->
                              <div class="dd-handle">
                                  <div class="task-info d-flex align-items-center justify-content-between">
                                      <h6 class="light-info-bg py-1 px-2 rounded-1 d-inline-block fw-bold small-14 mb-0">제목: \${user.issueTitle}</h6>
                                      <div class="task-priority d-flex flex-column align-items-center justify-content-center">
                                          <div class="avatar-list avatar-list-stacked m-0">
                                          <img class="avatar rounded-circle" src="\${user.imageContents != null ? user.imageContents : '#'}" alt="">
                                          </div>
                                          <span class="badge bg-warning text-end mt-2">작성자: \${user.projectIssueWriter}</span>
                                      </div>
                                  </div>
                                  <p class="py-2 mb-0">\${user.issueContent}</p>
                                  <div class="tikit-info row g-3 align-items-center">
                                      <div class="col-sm">
                                          <ul class="d-flex list-unstyled align-items-center flex-wrap">
                                              <li class="me-2">
                                                  <div class="d-flex align-items-center">
                                                      <i class="icofont-flag"></i> <span class="ms-1">\${user.issueEventDate} ~ \${user.processEtDate} </span>

                                                  </div>
                                              </li>
                                          </ul>
                                      </div>
                                      <div class="col-sm text-end">
                                      \${user.trackerName ==='결함' ? `<span class="badge rounded-pill bg-danger">\${user.trackerName}</span>` 
        										:user.trackerName === '이벤트' ? `<span class="badge rounded-pill bg-info">\${user.trackerName}</span>` 
        												: `<span class="badge rounded-pill bg-primary">\${user.trackerName}</span>`}
                                      </div>
                                  </div>
                              </div>

                          </li>
			`
					}	)
				})
	}

	let createIssueData = {
		issueTitle :'',
		issueContent :'',
		processEtDate:'',
		projectIssueCodeId :'',
		trackerId :'',
		alarms : [{
			projectIssueId: '',
			alarmContent: '',
			alarmSender: ''
			}
		]
	}
	
	function clearInsertModal(){
		$("issueTitle").val('');
		$("issueContent").val('');
		$("issueEndDate").val('');
	}
	// ======================================이슈생성 알림대상자 리스트 뽑기
		function alarmReceiver(){
		console.log("오냐?리시버 리스트로 ")
	// alarmReceiver
		// let issueCode = document.querySelector("#issueCode");
		// let trackerCode = document.querySelector("#trackerCode");

		headers['Content-Type'] = 'application/json'
		headers['accept'] = 'application/json'
		let alarmReceiver = document.querySelector("#alarmReceiver");
		axios.get(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/projectIssue/issueReceiverList`, {
			params: {
				projectId: projectIdHiddenValue
			}
		},{headers : headers})
				.then(resp =>{
					let data = resp.data
					console.log("리시버리스트:",data)
					alarmReceiver.innerHTML+= data.map(item =>
							`
					<option value="\${item.memberId}">\${item.memberName}</option>
				` 
					).reduce(add)
				})
		}	
	

	// =======================================이슈생성=======================================
	function addIssue()  {
		let insertForm = document.querySelector(".insertIssueForm");
		insertForm.addEventListener('submit', function(e){
			e.preventDefault();
			console.log("이슈인써트 오냐?");
			let istitledata = $("#issueTitle").val();
			let iscontentdata = $("#issueContent").val();
			let isenddatedata = $("#issueEndDate").val();

			const selectIsCode = document.getElementById("issueCodeList");
			const selectedIsCodeValue = selectIsCode.value;
			console.log("selectedValue: ", selectedIsCodeValue);

			const selectIsTrackerCode = document.getElementById("trackerCodeList");
			const selectedIsTrackerCode = selectIsTrackerCode.value;
			console.log("selectedselectIsTrackerCode: ", selectedIsTrackerCode);

			createIssueData.issueTitle = istitledata;
			createIssueData.issueContent = iscontentdata;
			createIssueData.processEtDate = isenddatedata;
			createIssueData.projectIssueCodeId = selectedIsCodeValue;
			createIssueData.trackerId = selectedIsTrackerCode;

			console.log("title : ",createIssueData.issueTitle);

			headers['Content-Type'] = 'application/json'
			headers['accept'] = 'application/json'
			axios.post(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/projectIssue/projectIssueCreate`,createIssueData,{headers : headers})
					.then(resp => {
						let data = resp.data
						console.log("insertissuedata", data)
						clearInsertModal();
						$("#tickadd").modal("hide");
						clearIssueList();
						issueList();
						issueListBottom ();
						issueDetail();
						
						Swal.fire({
							icon: 'success',
							title:'등록완료',
							showConfirmButton: false,
							timer: 800
					})
					})

		})
	}
	// ===================이슈추가에서 이슈코드 트래커코드 리스트 뿌리기 ===================
	function addIssueCodeList(){
		console.log("오냐?코드선택리스트로?")
// issueCode,  trackerCode 리스트 /issueCode
		let issueCode = document.querySelector("#issueCodeList");
		let trackerCode = document.querySelector("#trackerCodeList");

		headers['Content-Type'] = 'application/json'
		headers['accept'] = 'application/json'
		axios.get(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/projectIssue/issueCode`,{headers : headers})
				.then(resp =>{
					let data = resp.data
					console.log("data:",data)
					issueCode.innerHTML+= data.map(item =>
							`
					<option value="\${item.projectIssueCodeId}">\${item.projectIssueCodeName}</option>
				`
					).reduce(add)
				})

		axios.get(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/projectIssue/trackerCode`,{headers : headers})
				.then(resp =>{
					let data = resp.data
					console.log("data:",data)
					trackerCode.innerHTML+= data.map(item =>
							`
					<option value="\${item.trackerId}">\${item.trackerName}</option>
				`
					).reduce(add)
				})


	}

	// ===================검색 기능===================
	searchIssue.addEventListener('input', () => {

		console.log('실행되나?');
		headers['Content-Type'] = 'application/json'
		headers['accept'] = 'application/json'
		let search = searchIssue.value;
		if (search.trim() === '') {
			console.log("트림트림")
			clearIssueList();
			issueList();
			issueListBottom ();
			issueDetail();
			return false;
		} else {

			axios.get(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/projectIssue/issueList`, {
						params: {
							search: search
						}
					}, {headers: headers},
			).then(resp => {
				let data = resp.data;
				console.log("searchData", data);
				clearIssueListMain();

				proList.innerHTML+= data.map(item =>
						`
           						<tr data-projectissueid =\${item.projectIssueId} data-issuetitle=\${item.issueTitle} data-issuewriter=\${item.projectIssueWriter} data-issueeventdate =	\${item.issueEventDate}
							data-issuecontent =\${item.issueContent} data-issueenddate =\${item.processEtDate} data-issuecodename=\${item.projectIssueCodeName} data-issuetrackername = \${item.trackerName} data-issuestatusname=\${item.projectStatusName} class="nowIssueList">

							<td>
								<a class="fw-bold text-secondary">\${item.projectIssueId}</a>
							</td>
							<td class="issueDetail" data-issueiddata=\${item.projectIssueId} data-bs-toggle="modal" data-bs-target="#issueDetail" >
								\${item.issueTitle}
							</td>
							<td>
							<img class="avatar rounded-circle" src="\${item.imageContents != null ? item.imageContents : '#'}" alt="">
								<span class="fw-bold ms-1">\${item.projectIssueWriter}</span>
							</td>
							<td>
								\${item.issueEventDate}
						   </td>
							<td>
								\${item.projectStatusId===1 ? `<span class="badge bg-warning" data-issueid=\${item.projectStatusId}>\${item.projectStatusName}</span>` : `<span class="badge bg-success" data-issueid=\${item.projectStatusId}>\${item.projectStatusName}</span>`}
							</td>

							 <td>
								 <div class="btn-group" role="group" aria-label="Basic outlined example">
								 \${item.projectStatusId===1 && item.projectRoleId===1 ? `<button data-projectissueiddata =\${item.projectIssueId} type="button" class = "btn btn-outline-success issueCheckBtn" >체킁</button>` : `<span></span>`}
								 </div>
							 </td>
						 </tr>

            `
			).reduce(add)


			}).then(test=>{
				issueDetail();
			})
		}
	})

	//=================== 이슈리스트 전부 클리어===================
	function clearIssueList() {
		let element = document.querySelector("#issueList");
		element.innerHTML = '';
		statusLow.innerHTML ='';
		statusMid.innerHTML ='';
		statusHigh.innerHTML ='';
	}
	// ===================이슈리스트 상위부분만 클리어 ===================
	function clearIssueListMain(){
		let element = document.querySelector("#issueList");
		element.innerHTML = '';
	}

	let updateIssueStatusData = {
		projectIssueId :''
	}
	issueDetail();
	function issueDetail() {

		$(".nowIssueList").on('click', function (){
// 			debugger;
			let issueTitle = $(this).data("issuetitle");
			let issueId = $(this).data("projectissueid");
			let issueContent = $(this).data("issuecontent");
			let issueWriter = $(this).data("issuewriter");
			let issueEventDate = $(this).data("issueeventdate");
			let processEtDate = $(this).data("issueenddate");
			let projectIssueCodeName = $(this).data("issuecodename")
			let trackerName = $(this).data("issuetrackername")
			let projectStatusName = $(this).data("issuestatusname")
			let projectIssueComment = $(this).data("issuecomment")
			
			console.log("issueId : ",issueId);
			console.log("issueTitle : ",issueTitle);
			console.log("issueContent : ",issueContent);
			console.log("issueWriter : ", issueWriter);
			console.log("issueEventDate : ", issueEventDate);
			console.log("processEtDate : ", processEtDate);
			console.log("projectIssueCodeName : ", projectIssueCodeName);
			console.log("trackerName : ", trackerName);
			console.log("projectStatusName : ", projectStatusName);
			console.log("projectIssueComment : ", projectIssueComment);



			$("#basicIssueWriter").val(issueWriter);
			$("#basicIssueTitle").val(issueTitle);
			$("#basicIssueContent").val(issueContent);
			$("#basicIssueStatus").val(projectIssueCodeName);
			$("#basicIssueTracker").val(trackerName);
			$("#basicIssueEventDate").val(issueEventDate);
			$("#basicIssueEndDate").val(processEtDate);
			$("#basicIssueProcess").val(projectStatusName);
			$("#basicIssueComment").val(projectIssueComment);
			
			if($("#basicIssueProcess").val()=="STARTED"){
				$("#basicIssueComment").css("display","none")
				$("#commentLabel").css("display","none")
			}
			if($("#basicIssueProcess").val()=="COMPLETED"){
				$("#basicIssueComment").css("display","block")
				$("#commentLabel").css("display","block")
			}
			
			updateIssueStatus();
			updateIssueStatusData.projectIssueId = issueId;
			function updateIssueStatus(){
				let updateStatusForm = document.querySelector(".updateIssueStatusForm");
				let completeButton = document.querySelector(".completeBtn");
				completeButton.addEventListener('click', function (e){
					e.preventDefault();
					headers['Content-Type'] = 'application/json'
					headers['accept'] = 'application/json'
					axios.get(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/projectIssue/issueView`,{
						params: {
							projectIssueId: updateIssueStatusData.projectIssueId
						}
					},{headers : headers})
							.then(resp => {
								let data = resp.data
								console.log("projectIssueStatusUpdate", data)

							})
				})
			}
		})
	}

	// =========================================== 이슈상태 변경 complete으로 ===========================================
$(document).on('click', '.issueCheckBtn', function(e) {
  let issueId = $(this).data("projectissueiddata");
  console.log("스윗안issueId: ", issueId);
  console.log("스윗알랏오냐?");

  e.preventDefault();

  Swal.fire({
    icon: 'question',
    title: '이슈를 확인처리 하시겠습니까?',
    showCancelButton: true,
    confirmButtonText: 'COMPLETED',
    cancelButtonText: 'CANCEL'
  }).then(function(result) {
    if (result.isConfirmed) {
      Swal.fire({
        title: '이슈확인 코멘트 남기기',
        input: 'text',
        inputPlaceholder: '텍스트를 입력하세요',
        showCancelButton: true,
        confirmButtonText: '보내기',
        cancelButtonText: '취소',
        inputValidator: (value) => {
          // 입력값 유효성 검사
          if (!value) {
            return '텍스트를 입력해야 합니다.';
          }
        }
      }).then(function(result) {
        if (result.isConfirmed) {
          const userInput = result.value;
            headers['Content-Type'] = 'application/json'
  			headers['accept'] = 'application/json'
  			let updateStatusData = {
            	projectIssueId:'',
            	projectIssueComment:''
            }
            updateStatusData.projectIssueComment = userInput;
            updateStatusData.projectIssueId = issueId;
            console.log("projectIssueComment",updateStatusData.projectIssueComment);
            console.log("업데이트projectIssueId",updateStatusData.projectIssueId);
            
          const request1 = axios.post(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/projectIssue/projectIssueComment`,updateStatusData,{headers : headers});
          headers['Content-Type'] = 'application/json'
    	  headers['accept'] = 'application/json'
          const request2 = axios.get(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/projectIssue/projectIssueStatusUpdate`, {
            params: {
              projectIssueId: issueId
            },
            headers: { headers} });
         

          Promise.all([request1, request2])
            .then(responses => {
              // 두 개의 요청이 모두 성공한 경우
              const response1 = responses[0];
              const response2 = responses[1];
              // 각 응답 데이터 처리
              console.log('텍스트에 관련된 Ajax 요청 성공:', response1.data);
              console.log('완료 처리에 대한 Ajax 요청 성공:', response2.data);
              // 추가 로직 실행
              clearIssueList();
              issueList();
              issueListBottom();
              issueDetail();
            })
            .catch(error => {
              // 두 개의 요청 중 하나라도 실패한 경우
              console.log('Ajax 요청 실패:', error);
              // 오류 처리 로직 실행
            });
        }
      });
    }
  });
});





</script>



