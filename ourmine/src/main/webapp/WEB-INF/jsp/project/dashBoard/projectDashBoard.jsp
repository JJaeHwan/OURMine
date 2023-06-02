<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="row align-items-center">
    <div class="border-0 mb-4" id="projectHeader">

    </div>
</div>   
 <div class="row g-3 mb-3 row-deck">
    <div class="col-md-12 col-lg-4 col-xl-4 col-xxl-4">
        <div class="card ">
            <div class="card-body" id="projectData">

            </div>
        </div>
    </div>
    <div class="col-md-12 col-lg-4 col-xl-4 col-xxl-4">
        <div class="card ">
            <div class="card-body" id="issueHeader">
           
            </div>
        </div>
    </div>
    <div class="col-md-12 col-lg-4 col-xl-4 col-xxl-4">
        <div class="card ">
            <div class="card-body" id="workData">
            
            </div>
        </div>
    </div>
</div><!-- Row End -->

<div class="row g-3 row-deck">
	<div class="col-xxl-4 col-xl-4 col-lg-4 col-md-12">
		  <div class="card">
		      <div class="card-header py-3">
		          <h6 class="mb-0 fw-bold ">인원별데이터찍기</h6>
		      </div>
		      <div class="card-body">
		          <div class="flex-grow-1 mem-list" id="proData">
		              
		          </div>
		      </div>
		  </div> <!-- .card: My Timeline -->
		</div>
		<div class="col-xxl-4 col-xl-4 col-lg-4 col-md-6">
		    <div class="card">
		        <div class="card-header py-3">
		            <h6 class="mb-0 fw-bold ">최근이슈</h6>
		        </div>
		        <div class="card-body mem-list" id="issueList">

		       </div>
		  </div> <!-- .card: My Timeline -->
		</div>
		 <div class="col-xxl-4 col-xl-4 col-lg-4 col-md-6">
		    <div class="card">
		        <div class="card-header py-3">
		            <h6 class="mb-0 fw-bold ">일감담당자 처리율 찍기 </h6>
		        </div>
		        <div class="card-body mem-list" id="workList">
		        
		      </div>
		 </div>
	</div>
</div>




<input id="projectIdHidden" type="hidden" value="${projectId }">
<input id="companyIdHidden" type="hidden" value="${companyId }">
<script>
let projectIdHidden = document.querySelector('#projectIdHidden');
let companyIdHidden = document.querySelector('#companyIdHidden');
let projectIdHiddenValue = projectIdHidden.value;
let companyIdHiddenValue = companyIdHidden.value;
console.log("projectIdHiddenValue:",projectIdHiddenValue)
console.log("companyIdHiddenValue:",companyIdHiddenValue)

headData();

function headData(){
headers['Content-Type'] = 'application/json'
headers['accept'] = 'application/json'
const selectHeadData = {
	projectId : '',
	companyId : ''
}
selectHeadData.companyId = companyIdHiddenValue;
selectHeadData.projectId = projectIdHiddenValue;
	let projectHeader = document.getElementById("projectHeader");
axios.post(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/dashBoard/dashBoardJson`,selectHeadData,{headers : headers})
		.then(resp => {
			let data = resp.data
			console.log("dashBoardHeadData", data)
			projectHeader.innerHTML+=
				`
					<div class="card-header p-0 no-bg bg-transparent d-flex align-items-center px-0 border-bottom flex-wrap" >
						<h3 class="fw-bold py-3 mb-0">NO.\${data.projectId}</h3>
					</div>
					<div  class="card" >
						<div class="card-body">
							<table class="table" border="1" style="width: 100%; text-align: center; ">
								<thead class="table-light">
									<tr>
										<th colspan="3">제목</th>
										<td><h5>\${data.projectName}</h5></td>
										<th>PM</th>
											<td>\${data.memberName}</td>
									</tr>
									<tr>
										<th>참여인원수</th>
											<td> \${data.memberCount}명</td>
										<th>내용</th>
											<td> \${data.projectContent}</td>
										<th>기간</th>
											<td> \${data.projectStartDate} ~ \${data.projectEndDate}</td>
									</tr>
								</thead>
							 </table>
						</div>
					</div>

				`
		})
}

projectData();

function projectData(){
	let copy = [];
	headers['Content-Type'] = 'application/json'
	headers['accept'] = 'application/json'
	let projectData = document.querySelector("#projectData");
	axios.get(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/dashBoard/projectData`, {
		params: {
			projectId: projectIdHiddenValue
		}
	},{headers : headers})
			.then(resp =>{
				let data = resp.data
				console.log("projectData:",data);
				copy = [...data];
				console.log("copyProjectData:",copy);
				let firstData = true;
				return  data.flatMap(item => item.projectMembers.map((member, i) => {
					let seriesData = copy[0].progress
					console.log("진행률:",seriesData);
					if(firstData){
					projectData.innerHTML +=
						`
							<div class="d-flex align-items-center">
							<div class="avatar lg  rounded-1 no-thumbnail bg-lightyellow color-defult"><i class="bi bi-journal-check fs-4"></i></div>
							<div class="flex-fill ms-4">
								<div class="">진행상태</div>
								<h5 class="mb-0 ">\${copy[0].projectStatusName}</h5>
							</div>
							<a href="task.html" title="view-members" class="btn btn-link text-decoration-none  rounded-1"><i class="icofont-hand-drawn-right fs-2 "></i></a>
						</div>
						<div id="apex-circle-chart"></div>
						<div class="timesheet-info d-flex align-items-center justify-content-around flex-wrap">
							<div class="intime d-flex align-items-center">
								<i class="icofont-ui-calendar fs-3 color-lavender-purple"></i>
								<span class="fw-bold ms-1">total-Day: \${copy[0].totalDay}</span>
							</div>
							<div class="intime d-flex align-items-center">
								<i class="icofont-ui-timer fs-4 color-light-success"></i>
								<span class="fw-bold ms-1">D-Day \${copy[0].leftDays}</span>
							</div>
						</div>
						`
					      projectStatus(seriesData);
						
				
						firstData=false;
						
					}
					
					proData.innerHTML +=
						`
						<div class="py-2 d-flex align-items-center border-bottom">
		                  <div class="d-flex ms-2 align-items-center flex-fill">
		                      <img src="assets/images/xs/avatar6.jpg" class="avatar lg rounded-circle img-thumbnail" alt="avatar">
		                      <div class="d-flex flex-column ps-2">
		                          <h6 class="fw-bold mb-0">\${member.memberName}</h6>
		                          <span class="small text-muted">\${member.projectRole}</span>
		                      </div>
		                  </div>
		                  <button type="button" class="btn light-danger-bg text-end" data-bs-toggle="modal" data-bs-target="#dremovetask">Remove</button>
		              </div>

					`
					
				}))
				
				
			})
}
issueData();
function issueData(){
	let copy = [];
	headers['Content-Type'] = 'application/json'
	headers['accept'] = 'application/json'
	let issueHeader = document.querySelector("#issueHeader");
	let issueList = document.querySelector("#issueList");
	axios.get(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/dashBoard/issueData`, {
		params: {
			projectId: projectIdHiddenValue
		}
	},{headers : headers})
			.then(resp =>{
				let data = resp.data
				console.log("issueData:",data);
				copy = [...data];
				console.log("copyIssueData:",copy);
				let firstData = true;
				return  data.flatMap(item => item.trackerList.map((issue, i) => {
					let seriesData = copy[0].completeIssuePercentage
					console.log("진행률:",seriesData);
					if(firstData){
						issueHeader.innerHTML +=
							`
							<div class="d-flex align-items-center">
									<div class="avatar lg  rounded-1 no-thumbnail bg-lightblue color-defult"><i class="bi bi-list-check fs-4"></i></div>
									<div class="flex-fill ms-4">
										<div class="">전체 이슈</div>
										<h5 class="mb-0 ">\${copy[0].completeIssueCount}/\${copy[0].totalIssueCount}</h5>
									</div>
									<a href="task.html" title="space-used" class="btn btn-link text-decoration-none  rounded-1"><i class="icofont-hand-drawn-right fs-2 "></i></a>
							</div>
								<div id="apex-circle-chart2"></div>
								<div class="timesheet-info d-flex align-items-center justify-content-around flex-wrap">

									<div class="intime d-flex align-items-center">
										<i class="icofont-ui-timer fs-4 color-light-success"></i>
										<span class="fw-bold ms-1">긴급: \${copy[0].highStatusCount}</span>
									</div>
									<div class="intime d-flex align-items-center">
										<i class="icofont-ui-timer fs-4 color-light-success"></i>
										<span class="fw-bold ms-1">보통: \${copy[0].midStatusCount}</span>
									</div>
									<div class="intime d-flex align-items-center">
										<i class="icofont-ui-timer fs-4 color-light-success"></i>
										<span class="fw-bold ms-1">낮음: \${copy[0].lowStatusCount}</span>
									</div>
								</div>
							`
							issueStatus(seriesData);

						firstData=false;

					}
					issueList.innerHTML +=
						`
						 <div class="timeline-item ti-danger border-bottom ms-2">
			                <div class="d-flex">
			                    <span class="avatar d-flex justify-content-center align-items-center rounded-circle light-success-bg" style="font-size: 11px" >\${issue.trackerName}</span>
			                    <div class="flex-fill ms-3">
			                        <div class="mb-1"><strong>\${issue.issueTitle}</strong></div>
			                        <span class="d-flex text-muted">\${issue.timeAgo} AGO</span>
			                    </div>
			                </div>
			            </div>
						`
				}))
			})
}

workData();
function workData(){
	headers['Content-Type'] = 'application/json'
	headers['accept'] = 'application/json'
	let workHeader = document.querySelector("#workData");
	axios.get(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/dashBoard/workData`, {
		params: {
			projectId: projectIdHiddenValue
		}
	},{headers : headers})
			.then(resp => {
				let data = resp.data
				console.log("workData:", data);
				let seriesData = data.completeWorkPercentage;
				console.log("진행률:",seriesData);
				workHeader.innerHTML+=
					`
					  <div class="d-flex align-items-center">
                    <div class="avatar lg  rounded-1 no-thumbnail bg-lightgreen color-defult"><i class="bi bi-clipboard-data fs-4"></i></div>
                    <div class="flex-fill ms-4">
                        <div class="">일감</div>
                        <h5 class="mb-0 ">\${data.completeCount}/\${data.totalCount}</h5>
                    </div>
                    <a href="task.html" title="renewal-date" class="btn btn-link text-decoration-none  rounded-1"><i class="icofont-hand-drawn-right fs-2 "></i></a>
                </div>
                <div id="apex-circle-chart3"></div>
	            <div class="timesheet-info d-flex align-items-center justify-content-around flex-wrap">
	                <div class="intime d-flex align-items-center">
	                    <i class="icofont-lunch fs-3 color-lavender-purple"></i>
	                    <span class="fw-bold ms-1">진행:\${data.startedCount} </span>
	                </div>
	                <div class="intime d-flex align-items-center">
	                    <i class="icofont-ui-timer fs-4 color-light-success"></i>
	                    <span class="fw-bold ms-1">피드백:\${data.feedCount} </span>
	                </div>
	                <div class="intime d-flex align-items-center">
	                    <i class="icofont-ui-timer fs-4 color-light-success"></i>
	                    <span class="fw-bold ms-1">보류:\${data.stayCount} </span>
	                </div>
	                <div class="intime d-flex align-items-center">
	                    <i class="icofont-ui-timer fs-4 color-light-success"></i>
	                    <span class="fw-bold ms-1">요청:\${data.requestCount} </span>
	                </div>
	            </div>
					`
				workStatus(seriesData)
			})
}
workMemberData();
function workMemberData(){
	headers['Content-Type'] = 'application/json'
	headers['accept'] = 'application/json'
	let workMemberList = document.querySelector("#workList");
	axios.get(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/dashBoard/workMemberData`, {
		params: {
			projectId: projectIdHiddenValue
		}
	},{headers : headers})
			.then(resp => {
				let data = resp.data
				console.log("workMemberData:", data);
				data.map(item=>{
					workMemberList.innerHTML+=
						`
						<div class="progress-count mb-4">
							<div class="d-flex justify-content-between align-items-center mb-1">
								<h6 class="mb-0 fw-bold d-flex align-items-center">\${item.projectWorkPic}</h6>
								<span class="small text-muted">\${item.completePercentage}%</span>
							</div>
							<div class="progress" style="height: 10px;">
							  <div class="progress-bar light-info-bg" role="progressbar" style="width: \${item.completePercentage}%" aria-valuenow="\${item.completePercentage}" aria-valuemin="0" aria-valuemax="100"></div>
						  </div>
					    </div>

						`
				})

			})
}



// 원형그래프 데이터 
 function projectStatus(seriesData){
    let options = {
        chart: {
            height: 250,
            type: 'radialBar',
        },
        colors: ['var(--chart-color1)'],
        plotOptions: {
            radialBar: {
                hollow: {
                    size: '70%',
                }
            },
        },
        series: [seriesData],
        labels: ['진행률'],
    }
    let chart = new ApexCharts(
        document.querySelector("#apex-circle-chart"),
        options
    );
   chart.render();
    
}

 function issueStatus(seriesData){

	 let options2 = {
        chart: {
            height: 250,
            type: 'radialBar',
        },
        colors: ['var(--chart-color1)'],
        plotOptions: {
            radialBar: {
                hollow: {
                    size: '70%',
                }
            },
        },
        series: [seriesData],
        labels: ['진행률'],
    }
	 let chart = new ApexCharts(
        document.querySelector("#apex-circle-chart2"),
        options2
    );

    chart.render();
}



function workStatus(seriesData){
	let options3 = {
        chart: {
            height: 250,
            type: 'radialBar',
        },
        colors: ['var(--chart-color1)'],
        plotOptions: {
            radialBar: {
                hollow: {
                    size: '70%',
                }
            },
        },
        series: [seriesData],
        labels: ['진행률'],
    }
	let chart = new ApexCharts(
        document.querySelector("#apex-circle-chart3"),
        options3
    );

    chart.render();
}
</script>                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                