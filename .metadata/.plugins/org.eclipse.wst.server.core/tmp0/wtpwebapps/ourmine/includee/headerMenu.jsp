<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<style>
    /* CSS */
    #simple-tree-sidebar {
        transform: translateX(100%);
        transition: transform 0.5s ease-out;
    }

    #simple-tree-sidebar.visible {
        transform: translateX(0);
    }
    #simple-tree-sidebar {
        position: fixed;
        right: 0;
        top: 0;
        height: 100%;
        width: 300px;
        overflow-y: auto;
        background: white;
        border-left: 1px solid #ccc;
        transform: translateX(100%);
        transition: transform 0.3s ease-out;
    }

    #simple-tree-sidebar.visible {
        transform: translateX(0);
    }
    .folder {
        border: 1px solid #000;
        margin: 10px;
        padding: 10px;
    }

    .folder-toggle {
        cursor: pointer;
        font-weight: bold;
    }

    .folder-details {
        display: none; /* 초기에는 감춰져 있습니다. */
    }

    .folder.open .folder-details {
        display: block; /* folder가 open 클래스를 가지면 보입니다. */
    }
    .orgchartBtn:hover {
        cursor: pointer;
    }
    @keyframes pulse {
        0% {
            background-color: #fff; /* 시작색 */
        }
        50% {
            background-color: orange; /* 중간색 */
        }
        100% {
            background-color: #fff; /* 종료색 */
        }
    }
    .orange {
        border-radius: 50%;  /* 동그랗게 만들기 */
        overflow: hidden;  /* 내부의 모든 요소도 동그랗게 만들기 */
    }
</style>
<security:authentication property="principal" var="principal"/>

<c:set var="companyId" value="${principal.realUser.companyId}" />
<c:choose>
   <c:when test="${companyId eq 0 }">
      <script>
          const companyId1 = undefined;
          console.log("companyId1 =",companyId1)
       </script>
   </c:when>
   <c:otherwise>
      <script>
         const companyId1 = ${companyId};
         console.log("companyId1 =",companyId1)
      </script>
   </c:otherwise>
</c:choose>

<!-- Body: Header -->
<div class="container-xxl">

    <!-- header rightbar icon -->
    <div class="h-right d-flex align-items-center mr-5 mr-lg-0 order-1">
        <div class="d-flex">

            <!-- 채팅 -->
            <a class="nav-link collapsed" href="/ourmine/company/${companyId}/chat/chat" title="Chat">
                <i class="icofont-chat fs-5"></i>
            </a>

            <!-- 조직도 --><!-- text-primary : 글자색 -->
            <a type="a" href="/ourmine/company/${companyId}/orgchart/orgchartList" class="nav-link collapsed orgchartBtn" title="Organization chart">
                <i class="icofont-company fs-5"></i>
            </a>


        </div>

        <!-- 알림(종) 아이콘 -->
        <div class="dropdown notifications zindex-popover">
            <a class="nav-link dropdown-toggle pulse" href="#" role="button" data-bs-toggle="dropdown">
                <i class="icofont-alarm fs-5 orange"></i>
                <span class="pulse-ring"></span>
            </a>
            <div id="notification-icon">
                <span class="badge" id="notification-badge"></span>
            </div>
            <div id="NotificationsDiv" class="dropdown-menu rounded-lg shadow border-0 dropdown-animation dropdown-menu-sm-end p-0 m-0">
                <div class="card border-0 w380">
                    <div class="card-header border-0 p-3">
                        <h5 class="mb-0 font-weight-light d-flex justify-content-between">
                            <span>알림</span>
                            <span class="badge text-white">11</span>
                        </h5>
                    </div>

                    <!-- 알림 내용 -->
                    <div class="tab-content card-body">
                        <div class="tab-pane fade show active">
                            <ul class="list-unstyled list mb-0">
                                <li class="py-2 mb-1 border-bottom alarmList">

                                </li>

                            </ul>
                        </div>
                    </div>
                    <a class="card-footer text-center border-top-0" href="#"> View all notifications</a>
                </div>
            </div>
        </div>

        <!-- 프로필 -->
        <!-- Manager -->
        <security:authorize access="hasRole('MANAGER')">
        <security:authentication property="principal" var="authMember"/>
        <div class="dropdown user-profile ml-2 ml-sm-3 d-flex align-items-center zindex-popover">
            <div class="u-info me-2">
                <p class="mb-0 text-end line-height-sm "><span class="font-weight-bold"><security:authentication property="principal.realUser.memberName"/></span></p>
<%--             <security:authentication property="principal.authorities"/> --%>
               <small style="color: orange;"><security:authentication property="principal.realUser.companyName"/>,
                                <security:authentication property="principal.realUser.memberGrade"/></small>
            </div>
            <a class="nav-link dropdown-toggle pulse p-0 memberImage" href="#" role="button" data-bs-toggle="dropdown" data-bs-display="static">

            </a>

            <div class="dropdown-menu rounded-lg shadow border-0 dropdown-animation dropdown-menu-end p-0 m-0">
                <div class="card border-0 w280">
                    <div class="card-body pb-0">
                        <div class="d-flex py-1">
                        <span class="memberImage2"></span>
                            <%-- <img class="avatar rounded-circle" src="${cPath}/resources/mytask/documentation/assets/images/profile_av.png" alt="profile"> --%>
                            <div class="flex-fill ms-3">
                                <p class="mb-0"><span class="font-weight-bold"><security:authentication property="principal.realUser.memberName"/></span></p>
                                <small class="">${authMember.username}</small>
                            </div>
                        </div>

                        <div><hr class="dropdown-divider border-dark"></div>
                    </div>
                    <div class="list-group m-2 ">
                        <a href="/ourmine/project/projectList" class="list-group-item list-group-item-action border-0 "><i class="icofont-home fs-6 me-3"></i>프로젝트</a>
                        <a href="/ourmine/member/memberList" class="list-group-item list-group-item-action border-0 "><i class="icofont-tasks fs-5 me-3"></i>직원관리</a>
                        <a href="/ourmine/member/memberView" class="list-group-item list-group-item-action border-0 "><i class="icofont-user-alt-3 fs-5 me-3"></i>MyPage</a>
                        <a href="" class="list-group-item list-group-item-action border-0 "><i class="icofont-users-alt-5 fs-5 me-3"></i>회사 인원 추가하기</a>
                  <form id="logoutForm" action="${cPath}/logout" method="post">
                        <security:csrfInput/>
                        </form>
                        <a href="javascript:$('#logoutForm').submit();" class="list-group-item list-group-item-action border-0 "><i class="icofont-logout fs-6 me-3"></i>로그아웃</a>
                    </div>
                </div>
            </div>
        </div>
        </security:authorize>

        <!-- Member -->
        <security:authorize access="hasRole('MEMBER')">
<%--         <security:authorize access="isAuthenticated()"> --%>
        <security:authentication property="principal" var="authMember"/>
        <div class="dropdown user-profile ml-2 ml-sm-3 d-flex align-items-center zindex-popover">
            <div class="u-info me-2">
                <p class="mb-0 text-end line-height-sm "><span class="font-weight-bold"><security:authentication property="principal.realUser.memberName"/></span></p>
<%--             <security:authentication property="principal.authorities"/> --%>
               <small style="color: orange;">

               <!-- 회사정보 유무 확인 후 메뉴 출력 -->
               <c:set var="companyName" value="${principal.realUser.companyName }"/>
               <c:choose>
	               <c:when test="${not empty companyName}">
		               <security:authentication property="principal.realUser.companyName"/>,
	               </c:when>
	               <c:otherwise>
	                  회사정보가 없습니다.
	               </c:otherwise>
               </c:choose>
		       <security:authentication property="principal.realUser.memberGrade"/>
               </small>
            </div>
            <a class="nav-link dropdown-toggle pulse p-0 memberImage" href="#" role="button" data-bs-toggle="dropdown" data-bs-display="static">

            </a>

            <div class="dropdown-menu rounded-lg shadow border-0 dropdown-animation dropdown-menu-end p-0 m-0">
                <div class="card border-0 w280">
                    <div class="card-body pb-0">
                        <div class="d-flex py-1">
                            <span class="memberImage2"></span>
                           <%-- <img class="avatar rounded-circle" src="${cPath}/resources/mytask/documentation/assets/images/profile_av.png" alt="profile">--%>
                            <div class="flex-fill ms-3">
                                <p class="mb-0"><span class="font-weight-bold"><security:authentication property="principal.realUser.memberName"/></span></p>
                                <small class="">${authMember.username}</small>
                            </div>
                        </div>

                        <div><hr class="dropdown-divider border-dark"></div>
                    </div>
                    <div class="list-group m-2 ">
                        <a href="projects.html" class="list-group-item list-group-item-action border-0 "><i class="icofont-home fs-6 me-3"></i>프로젝트</a>
                        <a href="/task.html" class="list-group-item list-group-item-action border-0 "><i class="icofont-tasks fs-5 me-3"></i>작업</a>
                        <a href="/ourmine/member/memberView" class="list-group-item list-group-item-action border-0 "><i class="icofont-user-alt-3 fs-5 me-3"></i>MyPage</a>
	               			<c:if test="${empty companyName}">
		                        <a href="/ourmine/company/companyListJoin" class="list-group-item list-group-item-action border-0 "><i class="icofont-contact-add fs-5 me-3"></i>회사 가입하기</a>
	               			</c:if>
                        <form id="logoutForm" action="${cPath}/logout" method="post">
                        <security:csrfInput/>
                        </form>
                        <a href="javascript:$('#logoutForm').submit();" class="list-group-item list-group-item-action border-0 "><i class="icofont-logout fs-6 me-3"></i>로그아웃</a>
<!--                         <a href="ui-elements/auth-signin.html" class="list-group-item list-group-item-action border-0 "><i class="icofont-logout fs-6 me-3"></i>로그아웃</a> -->
                    </div>
                </div>
            </div>
        </div>

            <!-- 상세모달 -->
            <form id="alarmForm" enctype="multipart/form-data" method="post">
                <div class="modal" id="modifyModal" >
                    <div class="modal-dialog">
                        <div class="modal-content card mb-3" id="modifyContent">
                            <div class="card-body">
                                <div class="row g-3 align-items-center">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>제목</label>
                                            <input type="text" id="alarmTitle" name="noticeBoardTitle" class="myModal-title form-control">
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>보낸이</label>
                                            <input type="text" id="alarmWriter" name="noticeBoardWriter" class="form-control" readonly>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label>작성일자</label>
                                            <input type="text" id="alarmDate" name="noticeBoardWriteDate" class="form-control" readonly>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </security:authorize>
        <!-- 프로필 끝 -->

</div>
  <!-- 조직도 트리 형태 -->
    <div id="simple-tree-sidebar" class="sidebar px-4 py-4 py-md-5 me-0">


    </div>

    <!-- menu toggler -->
    <button class="navbar-toggler p-0 border-0 menu-toggle order-3" type="button" data-bs-toggle="collapse" data-bs-target="#mainHeader">
        <span class="fa fa-bars"></span>
    </button>

    <!-- 메인 검색창 -->
    <div class="order-0 col-lg-4 col-md-4 col-sm-12 col-12 mb-3 mb-md-0 ">
        <div class="input-group flex-nowrap input-group-lg">
<!--             <button type="button" class="input-group-text" id="addon-wrapping"><i class="fa fa-search"></i></button> -->
            <input type="hidden" class="form-control" placeholder="Search" aria-label="search" aria-describedby="addon-wrapping">
<!--             <button type="button" class="input-group-text add-member-top" id="addon-wrappingone" data-bs-toggle="modal" data-bs-target="#addUser"><i class="fa fa-plus"></i></button> -->
        </div>
    </div>

   <!-- 구독 정보 -->
   <security:authorize access="hasRole('MANAGER')">
   <div class="logo-text" style="text-align: center;">
    <security:authentication property="principal.realUser.memberName"/>
    (남은 구독 일자 :
    <security:authentication property="principal.realUser.subscribeDate"/>
    일)

    구독 중 <a class="ms-link active" href="/ourmine/subscribe/itemList.do"><span> / 결제하기</span></a>
    </div>
    </security:authorize>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.8/jstree.min.js"></script>
    <script type="text/javascript">
		headers['Content-Type'] = 'application/json'
		headers['accept'] = 'application/json'
		let orgchartBtn = document.querySelector('.orgchartBtn');
		const sidebar = document.getElementById("simple-tree-sidebar");
		let memberImage = document.querySelector('.memberImage');
		let memberImage2 = document.querySelector('.memberImage2');
		let alarmForm = document.querySelector('#alarmForm');
		let alarmTitle = document.querySelector('#alarmTitle');
		let alarmWriter = document.querySelector('#alarmWriter');
		let alarmDate = document.querySelector('#alarmDate');
		let alarmContent = document.querySelector('#alarmContent');



		async function memberImageList(){
		await axios.get('/ourmine/member/memberViewJson',{headers:headers})
				.then(resp => {
					let data = resp.data;
					console.log('data = ',data)
					memberImage.innerHTML = '';
					memberImage2.innerHTML = '';
					let array = []
					array.push(data);
					array.map(item => {
						if(item.imageContents === null){
							console.log('이미지없음')
                            memberImage.innerHTML +=  `<img class="avatar lg rounded-circle img-thumbnail" src="${cPath}/resources/mytask/documentation/assets/images/profile_av.png" alt="profile">`
							memberImage2.innerHTML += `<img class="avatar lg rounded-circle img-thumbnail" src="${cPath}/resources/mytask/documentation/assets/images/profile_av.png" alt="profile">`
						}else{
							console.log('이미지있음')
							memberImage.innerHTML +=  `<img class="avatar lg rounded-circle img-thumbnail" src="\${item.imageContents}" alt="profile">`
							memberImage2.innerHTML += `<img class="avatar lg rounded-circle img-thumbnail" src="\${item.imageContents}" alt="profile">`
						}
					})
				})
		}
		memberImageList();

		let alarmList = document.querySelector('.alarmList');


async function alarmListMember(){
	await axios.get('/ourmine/alarm/alarmList',{headers: headers})
		.then(resp => {
			let data = resp.data;
			console.log("알림 리스트", data)
			let html = '';
			data.forEach((item, index) => {
				html += `  <a href="javascript:void(0);" class="d-flex" id="item\${index}">
                        <div class="flex-fill ms-2">
                            <p class="d-flex justify-content-between mb-0 ">
                                <span class="font-weight-bold">\${item.alarmSender}</span>
                                <small>\${item.alarmDate}</small>
                            </p>
                            <span class="">\${item.alarmContent}<span class="badge bg-success">Review<span></span>
                        </div>
                    </a>`
			});

			alarmList.innerHTML = html;
			data.forEach((item, index) => {
				// 각 아이템에 클릭 이벤트 리스너를 추가
				document.getElementById(`item\${index}`).addEventListener('click', () => modelView(item));
			});
		})
}
		alarmListMember();
		headers['accept'] = 'application/json';
		headers['Content-Type'] = 'application/json'

		orgchartBtn.addEventListener('click', () => {
			let simpleTreeSidebar = $("#simple-tree-sidebar");
			if (simpleTreeSidebar.hasClass("visible")) {
				simpleTreeSidebar.removeClass("visible");

			} else {
				axios.get(`/ourmine/company/${companyId}/orgchart/orgchartTreeJson`, { headers: headers })
					.then(resp => {
						let data = resp.data;
						console.log('트리 데이터', data);
						updateSidebar(data);
						simpleTreeSidebar.addClass("visible");
					});
			}
		});

		function createHierarchy(data, parentId) {
			return data
				.filter(item => item.seniorDepartmentId === parentId)
				.map(item => ({
					title: `부서 이름: $\{item.departmentName}`,
					key: item.orgchartId,
					children: createHierarchy(data, item.orgchartId),
					departmentCreateDate: item.departmentCreateDate,
					memberId: item.memberId === null ? 'None' : item.memberId
				}));
		}

		function updateSidebar(data) {
			let simpleTreeSidebar = $("#simple-tree-sidebar");

			let hierarchy = createHierarchy(data, null);
			simpleTreeSidebar.fancytree({
				extensions: ["table"],
				checkbox: true,
				selectMode: 2,
				source: hierarchy,
				table: {
					checkboxColumnIdx: 0,
					nodeColumnIdx: 1
				},
				renderColumns: function (event, data) {
					let node = data.node,
						$tdList = $(node.tr).find(">td");

					$tdList.eq(2).text(`부서 생성 날짜: \${node.data.departmentCreateDate}`);
					$tdList.eq(3).text(`회원 ID: \${node.data.memberId}`);
					$tdList.eq(4).text(`조직도 ID: \${node.key}`);
				}
			});
		}


		// 웹소켓 서버에 연결
		let socket = new WebSocket('ws://localhost/ourmine/aws/echo');

		// 연결이 열리면 서버에 메시지를 보낼 수 있습니다.
		socket.onopen = function(event) {

		};

		// 서버로부터 메시지를 받으면 이 함수가 호출됩니다.
		let orange = document.querySelector('.orange');

		orange.addEventListener('click', function() {
			this.style.animation = '';
		});


		function modelView(item){
			console.log("modelView Item, ",item);
            alarmTitle.value = item.alarmContent;
			alarmDate.value = item.alarmDate;
			alarmWriter.value = item.alarmSender;
			let modalElement = document.getElementById('modifyModal');
			let modalInstance = new bootstrap.Modal(modalElement);
			modalInstance.show();
		}






		socket.onmessage = function(e) {
			let receivedData = JSON.parse(e.data);
			console.log("receivedData = ",receivedData)
			orange.style.animation = "pulse 1s infinite";
			let message = JSON.parse(receivedData.message);
			let alarm = [];

			let time = message.time;
			console.log("time = ",time)
			alarm.push("message", message);
			alarm.shift();
			console.log("alarm = ", alarm)
			alarm.map(item => {
			return 	alarmList.innerHTML +=  `
                    <a href="javascript:void(0);" class="d-flex">
                        <div class="flex-
                        fill ms-2">
                            <p class="d-flex justify-content-between mb-0 ">
                                <span class="font-weight-bold">\${item.sander}</span>
                                <small>\${item.time}</small>
                            </p>
                            <span class="">\${item.message}<span class="badge bg-success">Review</span>
                        </div>
                    </a>`;
            })

		};
		// 연결이 닫히거나 에러가 발생하면 이 함수가 호출됩니다.
		socket.onerror = function(error) {
			console.log('WebSocket Error: ', error);
		};

		socket.onclose = function(event) {
			console.log('WebSocket connection closed: ', event.code);
		};

    </script>



