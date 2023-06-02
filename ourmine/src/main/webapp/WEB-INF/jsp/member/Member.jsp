<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<style>

    a.orgchart:hover {
        background-color: #FFA07A;
    }
</style>
  <div class="row align-items-center">
    <div class="border-0 mb-4">
        <div class="card-header p-0 no-bg bg-transparent d-flex align-items-center px-0 justify-content-between border-bottom flex-wrap">
            <h3 class="fw-bold py-3 mb-0">직원 관리</h3>
            <div class="d-flex py-2 project-tab flex-wrap w-sm-100">
                <ul class="nav nav-tabs tab-body-header rounded ms-3 prtab-set w-sm-100 orgLvl" role="tablist">

                </ul>
            </div>
        </div>
    </div>
</div>
	<div id="memberDiv" class="row row-cols-2">

	</div>
<script>
	const add = (a,b) => a + b;
	let memberDiv = document.querySelector('#memberDiv');
	let orgLvl = document.querySelector('.orgLvl');
    let org = [];
	headers['accept'] = 'application/json';
	headers['Content-Type'] = 'application/json';
	console.log('여기 오긴오냐');
	async function memberOrgLvl(){
		await axios.get("/ourmine/member/memberOrgLvl",{headers: headers})
			.then( resp => {
				let data = resp.data;
				org = [...data];
				console.log("org = ", org)
                orgLvl.innerHTML +=   `<li class="nav-item"><a id="allList" onclick="memberList()" class="nav-link active orgchart active" data-bs-toggle="tab" href="#All-list" role="tab"  style="transition: background-color 0.2s ease;">전체</a></li>`
				data.filter(item => item.lvl === 2).map(user => {
					orgLvl.innerHTML += ` <li class="nav-item"><a data-orgchart=\${user.orgchartId} id="allList" class="nav-link orgchart" data-bs-toggle="tab" href="#All-list" role="tab" style="transition: background-color 0.2s ease; hover: background-color #FFA07A;">\${user.departmentName}</a></li>`
				})
			})
    }
	memberOrgLvl().then(() => {
		let orgchart = document.querySelectorAll('.orgchart');
        orgchart.forEach(item => {
			item.addEventListener('click', (e) => {
				const orgchartId =  e.target.dataset.orgchart
				console.log("orgchart = ", orgchartId)
                axios.get('/ourmine/member/memberOrgLvlListSelect', {
					params : {
						orgchartId : orgchartId
                    }}, {headers:headers})
                    .then(resp => {
						let data = resp.data;
	                    console.log("조직도 나오냐",data)
	                    memberDiv.innerHTML = '';
	                    memberDiv.innerHTML +=data.filter(user => user.memberName !== null).map(item => `
                                    <div class="col">
                                        <div class="card teacher-card">
                                            <div class="card-body d-flex">
                                                <div class="profile-av pe-xl-4 pe-md-2 pe-sm-4 pe-4 text-center w220">
                                                \${item.imageContents !==null ? `<img src="\${item.imageContents}" alt="" class="avatar xl rounded-circle img-thumbnail shadow-sm">` : `<img src="assets/images/lg/avatar3.jpg" alt="" class="avatar xl rounded-circle img-thumbnail shadow-sm">`}
                                                    <div class="about-info d-flex align-items-center mt-3 justify-content-center">
                                                        <div class="followers me-2">
                                                            <i class="icofont-tasks color-careys-pink fs-4"></i>
                                                            <span class="">04</span>
                                                        </div>
                                                        <div class="star me-2">
                                                            <i class="icofont-star text-warning fs-4"></i>
                                                            <span class="">4.5</span>
                                                        </div>
                                                        <div class="own-video">
                                                            <i class="icofont-data color-light-orange fs-4"></i>
                                                            <span class="">04</span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="teacher-info border-start ps-xl-4 ps-md-3 ps-sm-4 ps-4 w-100">
                                                    <h6  class="mb-0 mt-2  fw-bold d-block fs-6">\${item.memberName}</h6>
                                                    <span class="light-info-bg py-1 px-2 rounded-1 d-inline-block fw-bold small-11 mb-0 mt-1">\${item.memberGrade}</span><br>
                                                    <span class="light-info-bg py-1 px-2 rounded-1 d-inline-block fw-bold small-11 mb-0 mt-1">\${item.companyName} : \${item.departmentName !== null ? item.departmentName : '등록된 부서가 없습니다.'}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    `).reduce(add);
                       })
                    })
            })
        })




function memberList(){
	fetch("/ourmine/member/memberList",{
		method : "GET",
		headers: {
			'accept': 'application/json',
		},
	}).then(resp => resp.json())
		.then(data => {
			console.log(data);
			memberDiv.innerHTML = '';
			memberDiv.innerHTML += data.map(item => `
    <div class="col">
        <div class="card teacher-card">
            <div class="card-body d-flex">
                <div class="profile-av pe-xl-4 pe-md-2 pe-sm-4 pe-4 text-center w220">
                \${item.imageContents !==null ? `<img src="\${item.imageContents}" alt="" class="avatar xl rounded-circle img-thumbnail shadow-sm">` : `<img src="assets/images/lg/avatar3.jpg" alt="" class="avatar xl rounded-circle img-thumbnail shadow-sm">`}
                    <div class="about-info d-flex align-items-center mt-3 justify-content-center">
                        <div class="followers me-2">
                            <i class="icofont-tasks color-careys-pink fs-4"></i>
                            <span class="">04</span>
                        </div>
                        <div class="star me-2">
                            <i class="icofont-star text-warning fs-4"></i>
                            <span class="">4.5</span>
                        </div>
                        <div class="own-video">
                            <i class="icofont-data color-light-orange fs-4"></i>
                            <span class="">04</span>
                        </div>
                    </div>
                </div>
                <div class="teacher-info border-start ps-xl-4 ps-md-3 ps-sm-4 ps-4 w-100">
                    <h6  class="mb-0 mt-2  fw-bold d-block fs-6">\${item.memberName}</h6>
                    <span class="light-info-bg py-1 px-2 rounded-1 d-inline-block fw-bold small-11 mb-0 mt-1">\${item.memberGrade}</span><br>
                    <span class="light-info-bg py-1 px-2 rounded-1 d-inline-block fw-bold small-11 mb-0 mt-1">\${item.companyName} : \${item.departmentName !== null ? item.departmentName : '등록된 부서가 없습니다.'}</span>
                </div>
            </div>
        </div>
    </div>
    `).reduce(add);
		})
}
memberList();


</script>