<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib	uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
.grid-container {
		display: grid;
		grid-template-columns: 1fr 380px;
		grid-gap: 20px;
		grid-template-areas:
        "main right"
		"left right"
	;
}

.grid-main {
		grid-area: main;
}

.grid-right {
		grid-area: right;
}

.grid-left-bottom {
		grid-area: left;
}

	.grid-main {
		grid-area: main;
	}

	.grid-right {
		grid-area: right;
	}
	.grid-left-bottom {
		grid-area: left;
	}

</style>
 <script src="https://cdnjs.cloudflare.com/ajax/libs/gitgraph.js/1.11.4/gitgraph.min.js"></script>
<div class="grid-container">
   <div class="grid-main">
	   <canvas id="gitGraph">

	   </canvas>
   </div>


<div class="card card-chat border-right border-top-0 border-bottom-0  w380 grid-right">
	<div class="px-4 py-3 py-md-4">
		<div class="input-group mb-3">
			<input type="text" class="form-control mb-1" placeholder="Search...">
		</div>

		<div class="nav nav-pills justify-content-between text-center" role="tablist">
			<a class="flex-fill rounded border-0 nav-link active" data-bs-toggle="tab" href="#chat-recent" role="tab" aria-selected="true">커밋 히스토리</a>
			<a class="flex-fill rounded border-0 nav-link" data-bs-toggle="tab" href="#chat-groups" role="tab" aria-selected="false">깃허브 주소</a>
			<a class="flex-fill rounded border-0 nav-link" data-bs-toggle="tab" href="#chat-contact" role="tab" aria-selected="false">Pull Request 요청</a>
		</div>
	</div>

	<div class="tab-content border-top">
		<div class="tab-pane fade show active" id="chat-recent" role="tabpanel">
			<ul class="list-unstyled list-group list-group-custom list-group-flush mb-0 gitMemberCommit">


			</ul>
		</div>
		<div class="tab-pane fade" id="chat-groups" role="tabpanel">
			<ul class="list-unstyled list-group list-group-custom list-group-flush mb-0">
				<li class="list-group-item px-md-4 py-3 py-md-4">
					<a href="javascript:void(0);" class="d-flex">
						<div class="avatar rounded-circle no-thumbnail">WD</div>
						<div class="flex-fill ms-3 text-truncate">
							<h6 class="d-flex justify-content-between mb-0"><span>Website Design
                                                    </span> <small class="msg-time">15/04/2021</small></h6>
							<span class="text-muted">The point of using Lorem Ipsum</span>
						</div>
					</a>
				</li>
				<li class="list-group-item px-md-4 py-3 py-md-4">
					<a href="javascript:void(0);" class="d-flex">
						<div class="avatar rounded-circle no-thumbnail">AD</div>
						<div class="flex-fill ms-3 text-truncate">
							<h6 class="d-flex justify-content-between mb-0"><span>App Development
                                                    </span> <small class="msg-time">13/04/2021</small></h6>
							<span class="text-muted">If you are going to use a passage</span>
						</div>
					</a>
				</li>
				<li class="list-group-item px-md-4 py-3 py-md-4">
					<a href="javascript:void(0);" class="d-flex">
						<div class="avatar rounded-circle no-thumbnail">QC</div>
						<div class="flex-fill ms-3 text-truncate">
							<h6 class="d-flex justify-content-between mb-0"><span>Quality Assurance
                                                    </span> <small class="msg-time">12/04/2021</small></h6>
							<span class="text-muted">The point of using Lorem Ipsum</span>
						</div>
					</a>
				</li>
			</ul>
		</div>
		<div class="tab-pane fade" id="chat-contact" role="tabpanel">
			<ul class="list-unstyled list-group list-group-custom list-group-flush mb-0">
				<li class="list-group-item px-md-4 py-3 py-md-4">
					<a href="javascript:void(0);" class="d-flex">
						<img class="avatar rounded-circle" src="assets/images/xs/avatar10.jpg" alt="">
						<div class="flex-fill ms-3 text-truncate">
							<div class="d-flex justify-content-between mb-0">
								<h6 class="mb-0">Hannah Gill</h6>
								<div class="text-muted">
									<i class="fa fa-heart-o pl-2 text-danger"></i>
									<i class="fa fa-trash pl-2 text-danger"></i>
								</div>
							</div>
							<span class="text-muted">hannahgill@my-Task.com</span>
						</div>
					</a>
				</li>

			</ul>
		</div>
		</div>
	</div>


	<div class="col-xl-8 col-lg-12 col-md-12 flex-column grid-left-bottom">
		<div class="row g-3">

			<div class="col-md-6">
				<div class="card">
					<div class="card-header py-3 d-flex justify-content-between bg-transparent border-bottom-0">
						<h6 class="mb-0 fw-bold ">브랜치 현황</h6>
					</div>
					<div class="card-body">
						<div class="row g-2 row-deck">
							<div class="col-md-6 col-sm-6">
								<div class="card">
									<div class="card-body ">
										<i class="icofont-checked fs-3"></i>
										<h6 class="mt-3 mb-0 fw-bold small-14">커밋 갯수</h6>
										<span class="text-muted commitCount">400</span>
									</div>
								</div>
							</div>
							<div class="col-md-6 col-sm-6">
								<div class="card">
									<div class="card-body ">
										<i class="icofont-usb fs-3"></i>
										<h6 class="mt-3 mb-0 fw-bold small-14">병합 횟수</h6>
										<span class="text-muted merged">17</span>
									</div>
								</div>
							</div>
							<div class="col-md-6 col-sm-6">
								<div class="card">
									<div class="card-body ">
										<i class="icofont-crown-king fs-3"></i>
										<h6 class="mt-3 mb-0 fw-bold small-14">커밋왕</h6>
										<span class="text-muted commitKing">06</span>
									</div>
								</div>
							</div>
							<div class="col-md-6 col-sm-6">
								<div class="card">
									<div class="card-body ">
										<i class="icofont-architecture-alt fs-3"></i>
										<h6 class="mt-3 mb-0 fw-bold small-14">현재 에러 브랜치</h6>
										<span class="text-muted errorBranch">14</span>
									</div>
								</div>
							</div>
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

  <script>
	  let gitMemberCommit = document.querySelector('.gitMemberCommit');
  let projectIdHidden = document.querySelector('#projectIdHidden');
  let companyIdHidden = document.querySelector('#companyIdHidden');
	  let commitCount = document.querySelector('.commitCount');
	  let merged = document.querySelector('.merged');
	  let commitKing = document.querySelector('.commitKing');
	  let errorBranch = document.querySelector('.errorBranch');

  let projectIdHiddenValue = projectIdHidden.value;
  let companyIdHiddenValue = companyIdHidden.value;
  console.log("companyIdHiddenValue = ",companyIdHiddenValue);
  console.log("projectIdHiddenValue = ",projectIdHiddenValue);
  headers['Content-Type'] = 'application/json'
  headers['accept'] = 'application/json'
async function branch(){
await 	axios.get(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/git/gitListJson`, {headers : headers})
			.then(resp => {
				let data = resp.data;
				console.log("git Date :", data);

				// 사용자 정의 템플릿 생성
				let myTemplateConfig = {
					colors: ["#979797", "#008fb5", "#f1c109"], // 브랜치 색상 설정
					branch: {
						lineWidth: 10,
						spacingX: 20,
						mergeStyle: "bezier",
						showLabel: true,  // 레이블 표시 설정
						label: {
							color: "blue",
							strokeColor: "black",
							strokeWidth: 2,
							fontSize: "10pt",
							fontFamily: "Courier New"  // 레이블 폰트 변경
						},
					},
					commit: {
						spacingY: -20,
						dot: {
							size: 12,
						},
						message: {
							displayAuthor: false,
							displayBranch: false,
							displayHash: false,
							font: "normal 12pt Arial",
							color: "black",
						},
					},
				};

				let myTemplate = new GitGraph.Template(myTemplateConfig);

				// GitGraph 인스턴스 생성 시 사용자 정의 템플릿 적용
				let gitgraph = new GitGraph({template: myTemplate, mode: "compact", orientation: "horizontal", elementId: "gitGraph"});

				// main 브랜치 생성
				let main = gitgraph.branch("main");

// data를 시간 순으로 정렬
				data.sort((a, b) => new Date(a.commitDate) - new Date(b.commitDate));

// 브랜치를 담을 객체
				let branches = {};

// data 순회하면서 브랜치와 커밋 생성
				data.forEach((commitData, index) => {
					let branchName = commitData.branchName;

					// BRANCH_FROM에 해당하는 브랜치를 parentBranch로 설정
					let parentBranch = branches[commitData.branchFrom];

					// 브랜치가 존재하지 않으면 생성
					if (!branches[branchName]) {
						// 부모 브랜치가 있으면 해당 브랜치에서 새 브랜치 생성
						if (parentBranch) {
							branches[branchName] = parentBranch.branch(branchName);
						} else {
							branches[branchName] = gitgraph.branch(branchName);
						}
					}

					// 해당 브랜치에 커밋
					branches[branchName].commit({
						message: `Commit by \${commitData.memberName} at \${commitData.commitMessage} : \${commitData.commitDate} `,
						detailId: commitData.gitId,  // optional, adds hyperlinks to commits
						author: commitData.memberName,  // optional, specify the author of the commit
					});

					// IS_MERGED 값이 1이면 해당 브랜치를 MERGE_BRANCH_NAME으로 병합
					if (commitData.isMerged == 1) {
						let mergeBranch = branches[commitData.mergeBranchName];
						if (mergeBranch) {
							mergeBranch.merge(branches[branchName], `Merge \${commitData.memberName}'s work into \${commitData.mergeBranchName}`);
						}
					}
				})
			});
}
	  branch().then(memberCommitData).then(branchStatus)

async function memberCommitData(){
 await 	axios.get(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/git/gitMemberCommitSelect`, {headers : headers})
			.then(resp => {
				let data = resp.data;
				data.map(item => {
					gitMemberCommit.innerHTML += `	<li class="list-group-item px-md-4 py-3 py-md-4">
													<a href="javascript:void(0);" class="d-flex">
														<img class="avatar rounded-circle" src="\${item.imageContents}" alt="">
														<div class="flex-fill ms-3 text-truncate">
															<h6 class="d-flex justify-content-between mb-0"><span>\${item.memberName}</span> <small class="msg-time">\${item.commitDate}</small></h6>
															<span class="text-muted">\${item.commitMessage}</span>
														</div>
													</a>
												</li>`
				})
			})
}
async function branchStatus(){
	await axios.get(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/git/gitCommitCount`, {headers : headers})
			.then(resp => {
				let data = resp.data;
				console.log("branchStatus =", data)
				commitCount.innerHTML = data.reduce((sum, git) => sum + git.commitCount,0);
				merged.innerHTML = data[0].isMerged;
				commitKing.innerHTML =  data.reduce((maxId, obj) => (maxId.value > obj.value ? maxId : obj.memberName), data[0].memberName);
				errorBranch.innerHTML = data[0].errorBranch;
			})
}

  </script>
