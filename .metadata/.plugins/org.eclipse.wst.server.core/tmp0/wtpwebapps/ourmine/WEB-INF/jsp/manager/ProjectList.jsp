<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<div class="row align-items-center">
    <div class="border-0 mb-4">
        <div class="card-header p-0 no-bg bg-transparent d-flex align-items-center px-0 justify-content-between border-bottom flex-wrap">
            <h3 class="fw-bold py-3 mb-0">프로젝트</h3>
            <div class="d-flex py-2 project-tab flex-wrap w-sm-100">
            	 <security:authorize access="hasRole('MANAGER')">
	             <button type="button" class="btn btn-dark w-sm-100" data-bs-toggle="modal"
	                        data-bs-target="#createproject"><i class="icofont-plus-circle me-2 fs-6"></i>프로젝트생성
	                </button>
	             </security:authorize>
            	
                <ul class="nav nav-tabs tab-body-header rounded ms-3 prtab-set w-sm-100" role="tablist">
                    <li class="nav-item"><a id="allList" class="nav-link active" data-bs-toggle="tab" href="#All-list"
                                            role="tab">전체</a></li>
                    <li class="nav-item"><a id="startedList" class="nav-link" data-bs-toggle="tab" href="#Started-list"
                                            role="tab">진행중</a></li>
                    <li class="nav-item"><a id="completedList" class="nav-link" data-bs-toggle="tab"
                                            href="#Completed-list" role="tab">완료</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!---============================================================================================================================ -->
<div id="proList">

</div>
<!---============================================================================================================================ -->
<!-- 수정 모달-->
 <security:authorize url="/company/${companyId}/project/projectList/projectView">
<form class="editForm">
    <div class="modal fade" id="editproject" tabindex="-1" aria-hidden="true">

        <div class="modal-dialog modal-dialog-centered modal-md modal-dialog-scrollable">

            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title  fw-bold" id="editprojectLabel">프로젝트 수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <div class="mb-3">
                        <label for="exampleFormControlInput78" class="form-label">프로젝트이름</label>
                        <input type="text" class="projectNameIn form-control" id="exampleFormControlInput78" value="">
                        <input type="hidden" class="editproid" id="editprojectId" value="">
                    </div>

                    <div class="mb-3">
                        <label for="exampleFormControlTextarea786" class="form-label">프로젝트설명</label>
                        <textarea class="form-control" id="exampleFormControlTextarea786" rows="3"></textarea>
                    </div>

                    <!-- <div class="mb-3">
                        <label for="formFileMultiple456" class="form-label">ProjectImages & Document</label>
                            <input class="form-control" type="file" id="formFileMultiple456">
                    </div> -->

                    <div class="deadline-form">
                        <div class="row g-3 mb-3">
                            <div class="col">
                                <label for="datepickerded123" class="form-label">시작날짜</label>
                                <input type="date" class="form-control" id="datepickerded123" value="">
                            </div>

                            <div class="col">
                                <label for="datepickerded456" class="form-label">종료날짜</label>
                                <input type="date" class="form-control" id="datepickerded456" value="">
                            </div>
                        </div>

                        <!-- <div class="row g-3 mb-3">
                            <div class="col-sm-12">
                                <label class="form-label">Notifation Sent</label>
                                <select	class="form-select" aria-label="Default select example">
                                    <option selected>All</option>
                                    <option value="1">Team Leader Only</option>
                                    <option value="2">Team Member Only</option>
                                </select>
                            </div>
                        </div> -->
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" id="editBtn" class="btn btn-primary">Edit</button>
                </div>
            </div>
        </div>
    </div>
</form>
</security:authorize>
<!---============================================================================================================================ -->
<!-- 삭제 모달 -->
 <security:authorize url="/company/${companyId}/project/projectList/projectDelete">
<form class="delForm">
    <div class="modal fade" id="deleteproject" tabindex="-1" aria-hidden="true">

        <div class="modal-dialog modal-dialog-centered modal-md modal-dialog-scrollable">
            <div class="modal-content">
                <div id="project-id" class="form-label"></div>
                <div class="modal-header">
                    <h5 class="modal-title  fw-bold" id="deleteprojectLabel"> Delete item Permanently?</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body justify-content-center flex-column d-flex">
                    <i class="icofont-ui-delete text-danger display-2 text-center mt-2"></i>
                    <p class="mt-4 fs-5 text-center">You can only delete this item Permanently</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" id="delBtn" class="btn btn-danger color-fff">Delete</button>
                </div>
            </div>
        </div>
    </div>
</form>
</security:authorize>
<!---============================================================================================================================ -->
<!--멤버 추가 모달 -->
<security:authorize url="/company/${companyId}/project/projectList/projectInsertMember">
<div class="modal fade" id="addUser" tabindex="-1" aria-labelledby="addUserLabel" aria-hidden="true">

    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title  fw-bold" id="addUserLabel">프로젝트 인원 관리</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">

                <div class="inviteby_email">
                    <div class="input-group mb-3">
                        <!-- 검색창으로 활용 -->
                        <input type="text" class="form-control searchName " placeholder="이름" id="searchName" >


                    </div>
                </div>
                <!-- 멤버추가 리스트 확인 -->
                <div class="members_list" data-coId="">
                    <h6 class="fw-bold ">현재 참여중 인원</h6>
                    <ul class="list-unstyled list-group list-group-custom list-group-flush mb-0">
                        <!-- 현재 참여중인 프로젝트멤버  -->
                        <li id="nowUserList">

                        </li>
                    </ul>
                    <h6 class="fw-bold ">인원추가 목록</h6>
                    <ul class="list-unstyled list-group list-group-custom list-group-flush mb-0">
                        <!--반복문으로 해당회사 인원수만큼 li 개수가 나온다.-->
                        <li id="addUserList">

                        </li>

                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
</security:authorize>
<!---==========================프로젝트생성모달================================================================================================== -->
<form class="insertProjectForm" method="post">
    <div class="modal fade" id="createproject" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-md modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title  fw-bold" id="createprojectlLabel"> Create Project</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <div class="mb-3">
                        <label for="exampleFormControlInput77" class="form-label">Project Name</label>
                        <input type="text" class="form-control" id="exampleFormControlInput77"
                               placeholder="Explain what the Project Name">
                    </div>

                    <div class="deadline-form">

                        <div class="row g-3 mb-3">
                            <div class="col">
                                <label for="datepickerded" class="form-label">Project Start Date</label>
                                <input type="date" class="form-control" id="datepickerded">
                            </div>
                            <div class="col">
                                <label for="datepickerdedone" class="form-label">Project End Date</label>
                                <input type="date" class="form-control" id="datepickerdedone">
                            </div>
                        </div>

                        <div class="deadline-form">
                            <div class="row g-3 mb-3">
                                <div class="col">
                                    <label class="form-label">PM 지정</label>
                                    <select id= "getPmId" class="form-select getmemberlist" multiple aria-label="Default select Priority">

                                    </select>
                                </div>
                                <div class="col">
                                    <label class="form-label">PL 지정(멤버목록)</label>
                                    <select id="getPlId" class="form-select getmemberlist" multiple aria-label="Default select Priority">

                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <%--                                <div class="col-sm-12">--%>
                            <%--                                    <label class="form-label">Notifation Sent</label> <select--%>
                            <%--                                        class="form-select" aria-label="Default select example">--%>
                            <%--                                    <option selected>All</option>--%>
                            <%--                                    <option value="1">Team Leader Only</option>--%>
                            <%--                                    <option value="2">Team Member Only</option>--%>
                            <%--                                </select>--%>
                            <%--                                </div>--%>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="exampleFormControlTextarea78" class="form-label">Description</label>
                        <textarea class="form-control" id="exampleFormControlTextarea78"
                                  rows="3" placeholder=""></textarea>
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
<!---============================================================================================================================ -->

<security:authentication property="principal" var="principal"/>
<c:forEach items="${principal.realUser.proAttendRole }" var="roleList">
    <c:set var="companyId" value="${roleList.companyId }"/>
</c:forEach>


<script type="text/javascript">

    const company = {
        companyId: '',
        projectId: '',
        memberId: '',
        projectRoleId: ''
    }
    const project = {
        projectId: ''
    }
    const projectOBj = {
        projectId: '',
        projectName: '',
        projectContent: '',
        projectStartDate: '',
        projectEndDate: '',
    }
    let editProject = {
        projectId: '',
        projectName: '',
        projectContent: '',
        projectStartDate: '',
        projectEndDate: '',
    }
    let delData = {
        memberId: '',
        companyId: '',
        projectId: '',
        projectRoleId: '',
        projectAttendAk: ''
    }

    let insertdata = {
        projectName: '',
        projectContent: '',
        projectStartDate: '',
        projectEndDate: '',
        projectMembers:[{
        	 projectRoleId : '',
             memberId: ''
        }, {
        	 projectRoleId : '',
             memberId: ''
        }],
        projectAlarms:[{
            alarmContent : '',
        }, {
            alarmContent : '',
        }]
    }

    const companyId100 = ${companyId};
    console.log("companyId100", companyId100)

    projectList();
    selectpllist();
    insertProject();
    const add = (a, b) => a + b;

    const selectElement = document.getElementById('plList');

    // 프로젝트 참가 인원 리스트

// PL 지정
    function selectpllist() {
    let plList = document.querySelectorAll(".getmemberlist");
        console.log("plList",plList);
        console.log("pl리스트오냐")
    headers['Content-Type'] = 'application/json'
    headers['accept'] = 'application/json'
        fetch(`/ourmine/company/\${companyId100}/project/projectMemberJson`, {
            method: "GET",
            headers: headers,
        }).then(resp => resp.json())
            .then((data,i) => {
                console.log("프로젝트리스트", data);
                plList.forEach(list =>{
                    list.innerHTML += data.map(item =>
                        ` <option data-optionid=\${item.memberId} value="\${item.memberId}">\${item.memberName}</option> `
                    )
                })
            })
    }


    let proList = document.querySelector("#proList");
    headers['Content-Type'] = 'application/json'
    headers['accept'] = 'application/json'

    function projectList() {
//     	var principal = ${principal};
//     	console.log("principal",principal);
        fetch(`/ourmine/company/\${companyId100}/project/projectListJson`, {
            method: "GET",
            headers: headers,
        }).then(resp => resp.json())
            .then(data => {
                console.log("프로젝트리스트", data);

                proList.innerHTML += data.map(item => `
     <div class="card-body cardList" data-ccc =\${item.companyId} data-proId = \${item.projectId} data-proname =\${item.projectName} data-procontent =\${item.projectContent} data-prostartday =\${item.projectStartDate} data-proendday=\${item.projectEndDate}  style="width:400px;border:1px solid red;float:left;">
     <div class="d-flex align-items-center justify-content-between mt-5">
         <div class="lesson_name">
         <h2 class="mb-0 fw-bold fs-6 mb-2 movedash">
         	<a href="/ourmine/company/\${item.companyId}/project/\${item.projectId}/dashBoard" data-proName=\${item.projectName}> \${item.projectName}  </a>
         </h2>
             <h6 class="mb-0 fw-bold  fs-6  mb-2" data-proContent=\${item.projectContent}>\${item.projectContent}</h6>
         </div>
         <div class="btn-group" role="group" aria-label="Basic outlined example">
         
         	    <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#editproject" onclick="editPname(\${item})"><i class="icofont-edit text-success"></i></button>
         	   
	             <button type="button" class="btn btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#deleteproject"><i class="icofont-ui-delete text-danger"></i></button>
         </div>
     </div>
     <div class="d-flex align-items-center">
         <div class="avatar-list avatar-list-stacked pt-2">
         \${Array.from({ length: item.projectAttendMemberCount},()=>'<img class="avatar rounded-circle sm" src="${cPath}/resources/mytask/documentation/assets/images/xs/avatar7.jpg" alt="">').join('')}
             <span data-bs-compId=\${item.companyId}  class="addUserBtn avatar rounded-circle text-center pointer sm" data-bs-toggle="modal" data-bs-target="#addUser"><i class="icofont-ui-add"></i></span>
         </div>
     </div>
     <div class="row g-2 pt-4">
         <div class="col-6">
             <div class="d-flex align-items-center">
                 <i class="icofont-paper-clip"></i>
                 <span class="ms-2">\${item.projectTodoCount} Works</span>
             </div>
         </div>
         <div class="col-6">
             <div class="d-flex align-items-center">
                 <i class="icofont-sand-clock"></i>
                 <span class="ms-2">\${item.projectStartDate} </span>
             </div>
         </div>
         <div class="col-6">
             <div class="d-flex align-items-center">
                 <i class="icofont-group-students "></i>
                 <span class="ms-2">\${item.projectAttendMemberCount} Members</span>
             </div>
         </div>
         <div class="col-6">
             <div class="d-flex align-items-center">
                      <i class="icofont-sand-clock"></i>
                 <span class="ms-2">\${item.projectEndDate}</span>

             </div>
         </div>
     </div>
     <div class="dividers-block"></div>
     <div class="d-flex align-items-center justify-content-between mb-2">
         <h4 class="small fw-bold mb-0">Progress(\${item.progress}%)</h4>
<!--          \${item.leftDays <= 14 && item.progress!=100 ? `<button type="button" class="btn btn-outline-danger">확인</button>` : ''} -->
           <span id='days\${item.projectId}'   class=" days small light-danger-bg  p-1 rounded"><i class="icofont-ui-clock">
           </i> \${item.leftDays === 0 ? 'Completed' : item.leftDays +'Days Left' } </span>
     </div>

     <div class="progress" style="height: 8px;" >
         <div id='progre\${item.projectId}' class="prog progress-bar bg-secondary" data-progress=\${item.progress} data-statusname=\${item.projectStatusName} role="progressbar" style="width: \${item.progress}%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100"></div>
     </div>
	</div>
     `).reduce(add)
                // 위에서 먼저 찍어주고
                content();
            })
            
    }


    //  const editPname = (item) => {
    //      console.log("event: ", item);
    //  }

    // 리스트가 뜨고 안에 내용을 맞춰서 찍어주기 위해 순서를 맞춘다 projectList()->content()
    function content() {

        // Completed일때
        let days = document.querySelectorAll('.days');
        let daysvalue = days.innerHTML;
         console.log("days: ", days);
        days.forEach(item => {
            if (item.innerHTML.includes('Completed')) {
                item.classList.remove('days', 'small', 'light-danger-bg', 'p-1', 'rounded');
                item.setAttribute('class', 'days small light-success-bg  p-1 rounded');
            } else {
                item
            }
        })

        const prodiv = document.querySelectorAll(".prog");
        prodiv.forEach((item) => {
            const proStatus = item.getAttribute('data-progress');
            console.log("proStatus: ", proStatus);
            if (proStatus == 100) {
                item.classList.remove('prog', 'progress-bar', 'bg-secondary');
                item.setAttribute('class', 'prog progress-bar bg-success');
            } else {
                item
            }
        })

        const allProjects = document.querySelectorAll(".prog");
        const projList = document.querySelectorAll('.cardList');
        // console.log("projList: ", projList);

        document.getElementById("startedList").addEventListener("click", function () {
            allProjects.forEach((item, i) => {
                let data = item.getAttribute('data-statusname')
                console.log("data:", data);
                if (data !== 'STARTED') {
                    console.log('aa');
                    projList[i].style.display = 'none';
                    console.log("projList[i]", projList[i]);
                } else {
                    projList[i].style.display = '';
                }
            })
        })

        document.getElementById("completedList").addEventListener("click", function () {
            allProjects.forEach((item, i) => {
                let data = item.getAttribute('data-statusname')
                console.log("data:", data);
                if (data !== 'COMPLETED') {
                    console.log('aa');
                    projList[i].style.display = 'none';
                    console.log("projList[i]", projList[i]);
                } else {
                    projList[i].style.display = '';
                }
            })
        })

        document.getElementById("allList").addEventListener("click", function () {
            allProjects.forEach((item, i) => {
                let data = item.getAttribute('data-statusname')
                projList[i].style.display = '';

            })
        })
        // 수정 눌렀을 때 모달에 기존 내용 채우기

        $(".cardList").on('click', function () {
            let projid = $(this).data("proid");
            let projname = $(this).data("proname");
            let projcont = $(this).data("procontent")
            let projsday = $(this).data("prostartday");
            let projeday = $(this).data("proendday");

            editProject.projectId = projid;
            editProject.projectName = projname;
            editProject.projectContent = projcont;
            editProject.projectStartDate = projsday;
            editProject.projectEndDate = projeday;

            $("#editprojectId").val(editProject.projectId);
            $("#exampleFormControlInput78").val(editProject.projectName);
            $("#exampleFormControlTextarea786").val(editProject.projectContent);
            $("#datepickerded123").val(editProject.projectStartDate);
            $("#datepickerded456").val(editProject.projectEndDate);

            // console.log(editProject.projectId);
            // console.log(editProject.projectName);
            // console.log(editProject.projectContent);
            // console.log(editProject.projectStartDate);
            // console.log(editProject.projectEndDate);
        })

        // 프로젝트카드 최상위
        $(".cardList").on('click', function () {
            let proje = $(this).data("proid");
            let comId = $(this).data("ccc");
            delData.projectId = proje;
            company.companyId = comId;
            company.projectId = proje;
            project.projectId = proje;
            console.log("projectId:", project.projectId);
            console.log("companyId:", company.companyId);
        })

        $(".members_list").on('click', function () {

        })

        // ==================== 프로젝트 삭제 ====================
        let delForm = document.querySelector('.delForm');
        delForm.addEventListener('submit', function (e) {
            e.preventDefault();

            headers['Content-Type'] = 'application/json'
            headers['accept'] = 'application/json'
            fetch(`/ourmine/company/\${companyId100}/project/projectDelete`, {
                method: 'POST',
                headers: headers,
                body: JSON.stringify(project)
            }).then(resp => resp.json)
                .then(data => console.log(data));
            $('#deleteproject').modal('hide');
            clearListDiv();
            projectList();
        });
    }


    function  insertProject() {
    //=========================프로젝트 생성=========================
        let plList = document.querySelectorAll(".getmemberlist");
        plList.forEach((item,i) =>(
            item.addEventListener('change', function (e){
                let option = e.target.options[e.target.selectedIndex];
                let select = option.getAttribute("data-optionid");
                console.log("select", select);
                if(i === 0){
                    insertdata.projectMembers[0].memberId = select;
                    insertdata.projectMembers[0].projectRoleId = 1;
                }else{
                    insertdata.projectMembers[1].memberId = select;
                    insertdata.projectMembers[1].projectRoleId = 2;
                }
                console.log(insertdata);
            })
        ))
    let insertForm = document.querySelector(".insertProjectForm");
    insertForm.addEventListener('submit', function (e) {
        console.log("생성이벤트?");
        e.preventDefault();
        const selectPl = document.getElementById("getPlId");
        const selectPM = document.getElementById("getPmId");
        const selectedValue = selectPl.value;
        const selectedValue2 = selectPM.value;

//         console.log("Selected memberId[1]:", insertdata.members[1].memberId);
        console.log("인서트데이터전체",insertdata );
        const projectName = $("#exampleFormControlInput77").val();
        const projectContent = $("#exampleFormControlTextarea78").val();
        const projectStartDate = $("#datepickerded").val();
        const projectEndDate = $("#datepickerdedone").val();

        insertdata.projectName = projectName;
        insertdata.projectContent = projectContent;
        insertdata.projectStartDate = projectStartDate;
        insertdata.projectEndDate = projectEndDate;
        insertdata.projectAlarms[0].alarmContent = projectContent
        insertdata.projectAlarms[1].alarmContent = projectContent
        console.log("insertdata 여기까지: ", insertdata);
        headers['Content-Type'] = 'application/json'
        headers['accept'] = 'application/json'
        fetch(`/ourmine/company/\${companyId100}/project/projectInsert`, {
            method: "POST",
            headers: headers,
            body: JSON.stringify(insertdata)
        }).then(response => response.json())
            .then(data => {
                console.log("data :", data)
                if (data > 0) {
                    $("#createproject").modal("hide");
                }
                clearListDiv();
                projectList();
            })
    })
    }

    //=========================프로젝트 수정=========================
    let editForm = document.querySelector(".editForm");
    editForm.addEventListener('submit', function (e) {
        e.preventDefault();
        const projectId = $("#editprojectId").val();
        const projectName = $(".projectNameIn").val();
        const projectContent = $("#exampleFormControlTextarea786").val();
        const projectStartDate = $("#datepickerded123").val();
        const projectEndDate = $("#datepickerded456").val();

        projectOBj.projectId = projectId;
        projectOBj.projectName = projectName;
        projectOBj.projectContent = projectContent;
        projectOBj.projectStartDate = projectStartDate;
        projectOBj.projectEndDate = projectEndDate
        console.log(projectOBj.projectId);
        headers['Content-Type'] = 'application/json'
        headers['accept'] = 'application/json'
        fetch(`/ourmine/company/\${companyId100}/project/projectView`, {
            method: "POST",
            headers: headers,
            body: JSON.stringify(projectOBj)
        }).then(response => response.json())
            .then(data => {
                console.log("data :", data)
                if (data > 0) {
                    $("#editproject").modal("hide");

                    clearListDiv();
                    projectList();
                }
            })
    })
    //=========================프로젝트 인원추가=========================
    let removeDiv = $("#remove");
    let addUList = document.querySelector("#addUserList");
    let nowList = document.querySelector("#nowUserList");
    let addUser = document.querySelectorAll(".addUserBtn");
    let addUserArray = [];
    let userData = []

    // 프로젝트 인원추가에다가 버튼 클릭이벤트 ======================================================================================================================================================================================
    $(document).on('click', '.addUserBtn', () => {
        console.log("클릭이벤트");
        clearUserLi();
        addProjectUserList();
    })

    // 프로젝트 인원추가에다가 데이터 뿌려주는거 ======================================================================================================================================================================================
    async function addProjectUserList() {
        console.log(JSON.stringify(company));
        await fetch('/ourmine/association/associationList', {
            method: "POST",
            headers: headers,
            body: JSON.stringify(company)
        }).then(resp => resp.json())
            .then(data => {
                console.log("userdata", data);
                userData = [...data]
                console.log("userdata", userData)
                searchMembers();
                data.filter(item => item.projectAttendStatus === 'ATTEND').map((user) => {
                    nowList.innerHTML +=
                        `
                        	<input class="attendData" type="hidden" value="\${user.projectRoleId}">

                        	<li class="list-group-item py-3 text-center text-md-start">
                        	    <div class="d-flex align-items-center flex-column flex-sm-column flex-md-column flex-lg-row">
                        	        <div class="no-thumbnail mb-2 mb-md-0">
                        	            <img class="avatar lg rounded-circle" src="${cPath}/resources/mytask/documentation/assets/images/xs/avatar8.jpg" alt="">
                        	        </div>
                        	        <div class="flex-fill ms-3 text-truncate">
                        	            <h6 class="mb-0  fw-bold" data-memberiddata=\${user.memberId} data-projectiddata=\${user.projectId} data-projectroleiddata=\${user.projectRoleId} data-projectattendkey=\${user.projectAttendAk}>\${user.memberName}</h6>
                        	            <span class="text-muted" data-companyiddata=\${user.companyId}>\${user.memberEmail}</span>
                        	       \${user.projectRoleId===2 ? "<span>PL</span>"
                        	       : (user.projectRoleId===1 ? "<span>PM</span>"
                        	       : '<button class="btn btn-dark deleteMemberBtn" type="button"  >제거</button>' )}

                        	        </div>
                        	    </div>
                        	</li>
                        `
                })

                data.filter(item => item.projectAttendStatus === 'NO').map((user) => {
                    addUList.innerHTML += `
                             <input class="attendData" type="hidden" value="\${user.projectRoleId}"  >

                            <li class="list-group-item py-3 text-center text-md-start">
                                <div class="d-flex align-items-center flex-column flex-sm-column flex-md-column flex-lg-row">
                                    <div class="no-thumbnail mb-2 mb-md-0">
                                        <img class="avatar lg rounded-circle"  src="${cPath}/resources/mytask/documentation/assets/images/xs/avatar8.jpg" alt="">
                                    </div>
                                    <div class="flex-fill ms-3 text-truncate">
                                        <h6 class="mb-0  fw-bold"> \${user.memberName} </h6>
                                        <span class="text-muted">\${user.memberEmail}</span>
                                        <button class="btn btn-dark insertMemberBtn" type="button" data-memberiddata =\${user.memberId}  data-companyiddata =\${user.companyId} data-projectiddata =\${user.projectId}  data-projectroleiddata =\${user.projectRoleId} data-projectattendkey=\${user.projectAttendAk} >추가</button>
                                    </div>
                                </div>
                            </li>
                  `
                }).reduce(add)

            })
    }

    // 수정하고 나서 비우는거 ======================================================================================================================================================================================
    function clearListDiv() {
        $("#proList").empty();
    }

    // 프로젝트 참가 인원 볼때 클리어하는거 ======================================================================================================================================================================================
    function clearUserLi() {
        // $('#remove').html();
        let list = document.getElementById("addUserList");
        let lastlist = list.lastElementChild;

        let nowlist = document.getElementById("nowUserList");
        let nowlastlist = nowlist.lastElementChild;

        while (lastlist) {
            list.removeChild(lastlist);
            lastlist = list.lastElementChild;
        }
        while (nowlastlist) {
            nowlist.removeChild(nowlastlist);
            nowlastlist = nowlist.lastElementChild;
        }
    }

    // 프로젝트참가 딜리트 버튼 클릭 이벤트 ======================================================================================================================================================================================
    $(document).on('click', '.deleteMemberBtn', function (e) {
        console.log("멤버 제거 버튼눌렀니?");
        // let memberId = $('.deleteMemberBtn').data('memberiddata');
        // // let memberId = $('.deleteMemberBtn').data('memberiddata');
        // let companyId = $('.deleteMemberBtn').data('companyiddata');
        // let projectId = $('.deleteMemberBtn').data('projectiddata');
        // let projectRoleId = $('.deleteMemberBtn').data('projectroleiddata');
        // let projectAttendAk = $('.deleteMemberBtn').data('projectattendkey');
        // let projectAttendAk = $('.deleteMemberBtn').data('projectattendkey');

        let listItem = e.target.closest('.list-group-item');

        // 해당 요소 내에서 h6 태그를 찾는다.
        let h6 = listItem.querySelector('h6');

        // h6 태그의 dataset을 출력한다.
        console.log("h6태그에 있는 dataset", h6.dataset);


        const {projectattendkey, projectroleiddata, projectiddata, companyiddata, memberiddata} = h6.dataset;


        console.log("대체키", projectattendkey)
        console.log("멤버아이디", memberiddata)
        console.log(projectroleiddata)
        console.log(projectiddata)
        console.log(companyiddata)


        delData.memberId = memberiddata;
        delData.companyId = companyiddata;
        delData.projectId = projectiddata;
        delData.projectRoleId = projectroleiddata;
        delData.projectAttendAk = projectattendkey;

        // console.log("삭제memid",memberId);
        // console.log("삭제compid",companyId);
        // console.log("삭제projectid", projectId);
        // console.log("삭제projectroleid",projectRoleId);
        // console.log("삭제projectattendKey", projectAttendAk);
        console.log("delData : ", delData);

        deleteMemberProjectAttend(delData);
        clearUserLi();
        addProjectUserList();


    })

    // 프로젝트참가 딜리트 ======================================================================================================================================================================================
    function deleteMemberProjectAttend(delData) {
        console.log("delllll", delData);
        console.log("projectAttendAk 잘 오니?", delData.projectattendkey);
        headers['Content-Type'] = 'application/json'
        headers['accept'] = 'application/json'
        fetch(`/ourmine/company/\${companyId100}/projectAttend/projectAttendDelete`, {
            method: "POST",
            headers: headers,
            body: JSON.stringify(delData)
            // body : JSON.stringify($('.deleteMemberBtn').data('projectattendkey'))
        }).then(resp => resp.json())
            .then(data => console.log("참가인원제거데이터",data))

    }


    // 프로젝트참가 인서트 버튼 클릭이벤트
    $(document).on('click', '.insertMemberBtn', function (e) {
        console.log("멤바추가 버튼 눌렀니?");
        const {projectattendkey, projectroleiddata, projectiddata, companyiddata, memberiddata} = e.target.dataset;
        delData.memberId = memberiddata;
        delData.companyId = companyiddata;
        // delData.projectId = projectiddata;
        delData.projectRoleId = projectroleiddata;
        delData.projectAttendAk = projectattendkey;

        insertMemberProjectAttend();
        clearUserLi();
        addProjectUserList();
    })

    // 프로젝트 참가 인서트
    function insertMemberProjectAttend() {
        console.log("인서트데이터", JSON.stringify(delData));
        headers['Content-Type'] = 'application/json'
        headers['accept'] = 'application/json'
        fetch(`/ourmine/company/\${companyId100}/projectAttend/projectAttendInsert`, {
            method: "POST",
            headers: headers,
            body: JSON.stringify(delData)
        }).then(resp => resp.json())
            .then(data => console.log("참가인원추가데이터", data))
    }

 function searchMembers() {
        const searchField = document.getElementById('searchName');
        const nowUserList = document.getElementById('nowUserList').getElementsByTagName('li');
        const addUserList = document.getElementById('addUserList').getElementsByTagName('li');

        const searchValue = searchField.value.toLowerCase();

        for (let i = 0; i < nowUserList.length; i++) {
            const username = nowUserList[i].textContent.toLowerCase();
            if (username.includes(searchValue)) {
                nowUserList[i].style.display = 'block';
            } else {
                nowUserList[i].style.display = 'none';
            }
        }

        for (let i = 0; i < addUserList.length; i++) {
            const username = addUserList[i].textContent.toLowerCase();
            if (username.includes(searchValue)) {
                addUserList[i].style.display = 'block';
            } else {
                addUserList[i].style.display = 'none';
            }
        }
    }

    // 검색 필드 이벤트 처리
    const searchField = document.getElementById('searchName');
    searchField.addEventListener('input', searchMembers);





</script>
<script>

</script>



