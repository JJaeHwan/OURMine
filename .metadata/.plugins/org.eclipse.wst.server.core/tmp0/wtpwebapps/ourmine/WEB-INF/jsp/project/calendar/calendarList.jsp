<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

    <!-- plugin css file  -->
    <link rel="stylesheet" href="${cPath }/resources/css/main.min.css">
	
    
    <!-- project css file  -->
    <link rel="stylesheet" href="${cPath}/resources/css/my-task.style.min.css">

<style>


	 .modal {
	        position: fixed;
	        width: 100%;
	        /* fixed일 때는 height:100% 동작 */
	        height: 100%;
	        left: 0px;
	        top: 0px;
	        background-color: rgba(0, 0, 0, 0.274);
	        /* 무조건 크겡! */
	        z-index: 314;
	        display: none;
	    }

	    .detailModal {
	        position: fixed;
	        width: 100%;
	        /* fixed일 때는 height:100% 동작 */
	        height: 100%;
	        left: 0px;
	        top: 0px;
	        background-color: rgba(0, 0, 0, 0.274);
	        /* 무조건 크겡! */
	        z-index: 315;
	        display: none;
	    }
	    .modifyModal {
	        position: fixed;
	        width: 100%;
	        /* fixed일 때는 height:100% 동작 */
	        height: 100%;
	        left: 0px;
	        top: 0px;
	        background-color: rgba(0, 0, 0, 0.274);
	        /* 무조건 크겡! */
	        z-index: 315;
	        display: none;
	    }


	    .modalCont {
	        width: 400px;
	        height: 260px;
	        /* 수평 가운데 정렬 */
	        margin-top: 15%;
	        margin-left: 38%;
	        padding-left: 20px;
	        border-radius: 5%;
	        background-color: rgb(255, 255, 255);
	        color: rgb(9, 9, 8);
	    }

	    .detailModalCont {
	        width: 410px;
	        height: 700px;
	        /* 수평 가운데 정렬 */
	        margin-top: 7%;
	        margin-left: 38%;
	        padding-left: 30px;
	        border-radius: 5%;
	        background-color: rgb(255, 255, 255);
	        color: rgb(9, 9, 8);
	    }
	    .modifyModalCont {
	        width: 410px;
	        height: 720px;
	        /* 수평 가운데 정렬 */
	        margin-top: 7%;
	        margin-left: 38%;
	        padding-left: 30px;
	        border-radius: 5%;
	        background-color: rgb(255, 255, 255);
	        color: rgb(9, 9, 8);
	    }


	    .modalInput {
	    	padding: 5px;
	        width: 250px;
	        height: 40px;
	        font-size: 15px;
	        border: 0;
	        border-radius: 15px;
	        outline: none;
	        padding-left: 10px;
	        background-color: rgb(233, 233, 233);
	    }

	    .calendarCenter {
	        margin: 0 auto;
	    }

	    /* IE */
	    select::-ms-expand {
	        display: none;
	    }

	    .select {
	        width: 150px;
	        height: 35px;
	        background: url('https://freepikpsd.com/media/2019/10/down-arrow-icon-png-7-Transparent-Images.png') calc(100% - 5px) center no-repeat;
	        background-size: 20px;
	        padding: 5px 30px 5px 10px;
	        border-radius: 4px;
	        outline: 0 none;
	    }

	    .select option {
	        background: black;
	        color: #fff;
	        padding: 3px 0;
	    }

		.fc-day-sun a {
		  color: red;
		  text-decoration: none;
		}

		/* 토요일 날짜 파란색 */
		.fc-day-sat a {
		  color: blue;
		  text-decoration: none;
		}

/* 	 	#calSaveBtn{
			margin-left: 210px;
		} */


		span{
			display: inline-block;
		}

		textarea{
			width: 350px;
			/* height: 150px; */
			resize: none;
		}

		.form-control{
			width: 350px;
		}
		.form-select{
			width: 350px;
		}
		#caButtonDivs{
			width: 100%;
			margin-left: 48%;
		}
		.caButtonDiv{
			 display:inline-block 
		}
/* 		#closeBtn{
			margin-left: 100px;
		} */

</style>
<!-- ============================== 시큐리티 ================================================ -->
<security:authentication property="principal" var="principal"/>
<c:forEach items="${principal.realUser.proAttendRole }" var="roleList">
    <c:set var="memberId" value="${roleList.memberId }"/>
    <c:set var="projectRoleId" value="${roleList.projectRoleId }"/>
</c:forEach>   

<div id="mytask-layout" class="theme-indigo">


        <!-- Body: Body -->
        <div class="body d-flex py-lg-3 py-md-2">
            <div class="container-xxl">
                <div class="row align-items-center">
                    <div class="border-0 mb-4">
                       <div class="card">
                       		<h6><img src="${cPath}/resources/images/color_red.jpg">긴급 <img src="${cPath}/resources/images/color_yellow.jpg"> 높음 
                       		<img src="${cPath}/resources/images/color_navy.jpg"> 보통 <img src="${cPath}/resources/images/color_grey.jpg"> 낮음</h6>
                            <!-- <h3 class="fw-bold mb-0">달력</h3> -->
                            <!-- <div class="col-auto d-flex">
                                <button type="button" class="btn btn-dark " data-bs-toggle="modal" data-bs-target="#addevent"><i class="icofont-plus-circle me-2 fs-6"></i>Add Event</button>
                            </div> -->
                        </div> 
                    </div>
                </div> <!-- Row end  -->
                <div class="row clearfix g-3">
                    <div class="col-lg-12 col-md-12 ">
                       <!-- card: Calendar -->
                        <div class="card">
                            <div class="card-body" id='calendar'></div>
                            <script>
	                            let calendar = null;

	                            $(function () {
	                                const Calendar = FullCalendar.Calendar; // 캘린더 api 생성하기

	                                const calendarEl = document.getElementById('calendar'); // body에 캘린더 넣을 부분 태그선택

	                                calendar = new Calendar(calendarEl, {
	                                	height: 900,
	                                    selectable: true,
	                                    selectHelper: true,
	                                    select: function (res) {

	                                        console.log("select했을때 머가오는지 체킁",res);
	                                        /* modal.show() */
	                                    },
	                                    headerToolbar: {
	                                        left: 'prev,next today',
	                                        center: 'title',
	                                        right: 'dayGridMonth,timeGridWeek,timeGridDay'
	                                    },
	                                    events:{
	                                    	url : "/ourmine/company/${companyId}/project/${projectId}/calendar/calendar_FC",
	                                    	method : "get",
	                                        extraParams: {
	                                        	/* companyId:2,
												projectId:4 */
	                                        }
	                                    },
	                                   /*  events: function(info){
										 	//console.log(info.event.extendedProps.companyId);
											//console.log(info.event.extendedProps.projectId);
										 	//let data = {projectId:projectId, companyId:companyId};
	                                    	$.ajax({
														url : "/ourmine/calendar/calendar_FC",
														method : "get",
														data : {
															companyId:2,
															projectId:4
														},
														dataType : "json"

													})
													.done(
															function(resp,
																	textStatus,
																	jqXHR) {
															})
													.fail(
															function(jqXHR,
																	status,
																	error) {
																console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
															});
	                                    }  */
	                                    //	'/ourmine/calendar/calendar_FC'  // url 서블릿 주소 써주면 됨!
	                                    //,
	                                    editable: false, // 드래그

	                                    locale: 'ko', // 한국어
	                                    /* timeZone: 'local', */

	                                    /* eventDrop: function (info) {    // 드래그해서 위치 지정하면 날짜 수정
	                                        let id = info.event.id;
	                                        let title = info.event.title;
	                                        let start = info.event.start.toISOString().substr(0, 10);
	                                        $.ajax({
	                                            url: "",
	                                            type: "post",
	                                            data: { id: id, title: title, start: start},
	                                            success: function () {
	                                                alert("일정이 변경되었습니다. ")
	                                            }
	                                        })
	                                    }, */
	                                    // 일정 클릭하면 상세보기 모달로 보여주기
	                                    eventClick: function caClick(info) {
	                                    	
	                                    	
	                                        console.log(info.event.title)
	                                        console.log(info.event.extendedProps.projectWorkId)
	                                        let projectWorkId = info.event.extendedProps.projectWorkId;

	                                        var x = info.event.start
	                                        var y = info.event.end
											let offset = x.getTimezoneOffset() * 60000; //ms단위라 60000곱해줌
											let dateOffsetS = new Date(x.getTime() - offset);
											let dateOffsetE = new Date(y.getTime() - offset);
											console.log(dateOffsetS.toISOString());


	                                        $("#projectWorkTitle").html(info.event.title);
	                                        $("#projectId").val(info.event.extendedProps.projectId);
	                                        $("#companyId").val(info.event.extendedProps.companyId);
	                                        $("#projectWorkStatusId").val(info.event.extendedProps.projectWorkStatusId);
	                                        $("#projectWorkStatus").val(info.event.extendedProps.projectWorkStatus);
	                                        $("#writer").val(info.event.extendedProps.writer);
	                                        $("#start").val(dateOffsetS.toISOString().substr(0, 10));
	                                        $("#end").val(dateOffsetE.toISOString().substr(0, 10));
	                                        $("#projectPriorityId").val(info.event.extendedProps.projectPriorityId);
	                                        $("#projectPriorityName").val(info.event.extendedProps.projectPriorityName);
	                                        $("#projectWorkContent").val(info.event.extendedProps.projectWorkContent);
	                                        $("#projectWorkId").val(info.event.extendedProps.projectWorkId);
	                                        $("#calPicId").val(info.event.extendedProps.picId);
	                                        
	                                        const loginMemberId = ${memberId};
	                                        console.log("loginMemberId", loginMemberId)

	                                        const projectRoleId = ${projectRoleId};
	                                        console.log("projectRoleId",projectRoleId);

	                                        const caPicId = info.event.extendedProps.picId;
	                                        console.log("caPicId",caPicId);
	                                        
	                                        if (caPicId == loginMemberId) {
	                                        	document.querySelector("#caModifyBtn").style.display = "block";
	                                        	document.querySelector("#calendarDeleteBtn").style.display = "block";
	                                        }else if(projectRoleId == 1){
	                                        	document.querySelector("#caModifyBtn").style.display = "block";
	                                        	document.querySelector("#calendarDeleteBtn").style.display = "block";
	                                        }
	                                        
	                                        
	                                        
	                                        detailModal.show();
	                                        
	                                        

	                                        $("#calendarDeleteBtn").on("click",function(){
	                                        	calendarDelete(projectWorkId)
	                                        })
	                                    }

	                                });
	                                calendar.render();
	                            });

                            </script>
                        </div>
                    </div>
                </div><!-- Row End -->
            </div>
        </div>

        <div class="myCalendarbody">

            <!-- 날짜를 클릭하면 나오는 모달 -->
            <!-- <div id="modal" class="modal">
                <div id="modalCont" class="modalCont">
                    <br> <br>
                    담당자 : <input id="modalInput" class="modalInput" type="text" value="" placeholder="예약담당자"><br> <br>
                    환자번호 :
                    <select id="patientName" class="select">
                        <option disabled selected>환자이름 🚑</option>
                        <option value="apple">apple</option>
                        <option value="orange">orange</option>
                        <option value="grape">grape</option>
                        <option value="melon">melon</option>
                    </select><br> <br>
                    침상번호 : <input id="modalInput" class="modalInput" type="text" placeholder="침상번호">
                    <br> <br>
                    <button id="modalSubmit" class="modalSubmit" onclick="allSave()">등록하기</button>
                    <button id="modalButton" onclick="modalClose()">X</button>
                </div>
            </div> -->

            <!-- 일정을 클릭하면 나오는 모달 -->
            <div id="detailModal" class="detailModal">
                <div id="detailModalCont"  class="detailModalCont">
                    <br><br>
                    <h5 id="projectWorkTitle" name="projectWorkTitle" class="mb-0 fw-bold "></h5>
                    <hr>
                    	<input id="projectId" name="projectId" class="modalInput"  type="hidden">
                    	<input id="companyId" name="companyId" class="modalInput"  type="hidden">
                    	<input id="projectWorkId" name="projectWorkId" class="modalInput"  type="hidden">
                    	<input id="projectWorkStatusId" name="projectWorkStatusId" class="modalInput" type="hidden">
                    	<input id="calPicId" name="picId" class="modalInput"  type="hidden" >

	                    <i class="icofont-clock-time"></i> <span> 상  태 : </span>
	                    <input id="projectWorkStatus" name="projectWorkStatus" class="form-control" type="text" readonly="readonly">
	                    <br>
	                    <i class="icofont-user"></i> <span> 담당자  : </span>
	                    <input id="writer" class="form-control" name="projectWorkPic" type="text" readonly="readonly">
	                    <br>
	                    <i class="icofont-calendar"></i> <lable> 시작날짜 : </lable>
	                    <input id="start" class="form-control" name="projectWorkStartDate" type="text" readonly="readonly">
	                    <br>
	                    <i class="icofont-calendar"></i> <lable> 종료날짜 : </lable>
	                    <input id="end" name="projectWorkEndDate" class="form-control" type="text" readonly="readonly">
	                    <br>
	                    <!-- 우선순위 id -->
	                    <input id="projectPriorityId" name="projectPriorityId" class="modalInput" type="hidden">

	                    <i class="icofont-flag"></i> <lable> 우선순위 : </lable>
	                    <input id="projectPriorityName" name="projectPriorityName" class="form-control" type="text" readonly="readonly">
	                    <br>
	                    <i class="icofont-page"></i> <label for="exampleFormControlTextarea786" class="form-label">내용</label>
	                    <textarea id="projectWorkContent" name="projectWorkContent" type="text" class="form-control" readonly="readonly" rows="3" ></textarea>
	                    <br>
	                    <div class="modal-footer">
		                    <div class="caButtonDiv"><button type="button" id="caModifyBtn" class="btn btn-primary" onclick="openModify()" style="display:none;" >수정</button></div>
		                    <div class="caButtonDiv"><button type="button" id="calendarDeleteBtn" class="btn btn-primary" style="display:none;" >삭제</button></div>
		                    <div class="caButtonDiv"><button id="closeBtn" onclick="detailModalClose()" class="btn btn-secondary">닫기</button></div>
	                    </div>

                </div>
            </div>

            <!-- 일정 수정 모달 -->
            <div id="modifyModal" class="modifyModal">
                <div id="modifyModalCont" class="modifyModalCont">
	                <br><br>
                	<form name="modifyForm" id="modifyForm" novalidate>
                		<input id="calMoProjectId" name="projectId" class="modalInput"  type="hidden">
                		<input id="projectWorkId1" name="projectWorkId" class="modalInput" type="hidden" >
                		<input id="companyId1" name="companyId" class="modalInput" type="hidden" >

	                    <input id="projectWorkTitle1" name="projectWorkTitle" class="form-control" type="text" >
	                    <hr>
		                    <i class="icofont-clock-time"></i> <span> 상  태 </span>
		                    <select id="projectWorkStatusId1" name="projectWorkStatusId" class="form-select">
		                        <option value="1">요청</option>
		                        <option value="2">진행</option>
		                        <option value="3">피드백</option>
		                        <option value="4">완료</option>
		                        <option value="5">보류</option>
                    		</select>
                    		<br>
		                    <i class="icofont-user"></i> <label> 담당자 </label>
		                    <select class="form-select" id="calProjectMemberList"  name="picId" >
		                    	<!-- <option value="0" selected>담당자</option> -->
		                    </select>
		                    <br>
		                    <i class="icofont-calendar"> </i><lable> 시작날짜 </lable>
		                    <input id="start1" name="projectWorkStartDate" class="form-control" type="date">
		                    <br>
		                    <i class="icofont-calendar"></i> <lable> 종료날짜 </lable>
		                    <input id="end1" name="projectWorkEndDate" class="form-control" type="date" >
		                    <br>
		                    <i class="icofont-flag"></i> <lable> 우선순위 </lable>
		                    <select id="projectPriorityId1" name="projectPriorityId" class="form-select">
		                        <option value="1">긴급</option>
		                        <option value="2">높음</option>
		                        <option value="3">보통</option>
		                        <option value="4">낮음</option>
                    		</select>
		                    <br>
		                    <i class="icofont-page"></i> <label for="exampleFormControlTextarea786" class="form-label">내용</label>
		                    <textarea class="form-control"  id="projectWorkContent1" name="projectWorkContent"  type="text"  rows="3" ></textarea>
		                    <br>
		                    <div class="modal-footer">
		                    	<button type="button" id="calSaveBtn" class="btn btn-primary" >등록하기</button>
		                    	<button type="button" id="closeBtn" onclick="caModifyModalClose()" class="btn btn-secondary" >닫기</button>
		                    </div>
                    </form>
                </div>
            </div>

            <!-- <div id='calendar-container' class="calendarCenter">
                <div
                    style='height: 30px; text-align: center; font-size: 50px; color: rgb(66, 75, 247); margin-bottom: 30px; font-weight: bolder;'>
                    예약일정</div>
                <div id='calendar'></div> 캘린더가 생성되는 곳
            </div> -->
        </div>
        

   

<script >

/* const loginMemberId = ${memberId};
console.log("loginMemberId", loginMemberId)

const projectRoleId = ${projectRoleId};
console.log("projectRoleId",projectRoleId); */





//const caPicId = $("#writer").val();
//console.log("caPicId",caPicId);

/* if (projectRoleId === 1) {
	document.querySelector("#taskAddBtn").style.display = "block";
	//pwtaskAddBtn();
} */


//스프링 security CSRF를  설정하면 아래 토큰 값을 get이외의 방식에는 전송해야 한당
const header = '${_csrf.headerName}';
const token =  '${_csrf.token}';

const Modal = $('#modal')
const modalClose = () => {
    modal.hide();
}
const detailModal = $('.detailModal')


const detailModalClose = () => {
	console.log("닫기버튼클릭");
	document.querySelector("#caModifyBtn").style.display = "none";
    document.querySelector("#calendarDeleteBtn").style.display = "none";
	detailModal.hide();
	//location.reload();
	//detailModal.style.display="none";
	//detailModal.modal('hide');
}
const modifyModal = $('.modifyModal')

// 모달창에서 일정 수정하기
const caModifyModal = document.querySelector("#modifyModal");
const caModifyModalClose = () => {
	
	caModifyModal.style.display="none";
}
// 수정 버튼 클릭
const openModify = () => {
	modifyModal.show();
	detailModalClose();

	$("#modifyModalCont").find("[name=projectWorkTitle]").val($(detailModal).find("#projectWorkTitle").html());
	$("#modifyModalCont").find("[name=companyId]").val($(detailModal).find("#companyId").val());
	$("#modifyModalCont").find("[name=projectWorkStatusId]").val($(detailModal).find("#projectWorkStatusId").val());
	$("#modifyModalCont").find("[name=projectWorkStatus]").val($(detailModal).find("#projectWorkStatus").val());
	$("#modifyModalCont").find("[name=projectWorkPic]").val($(detailModal).find("#writer").val());
	$("#modifyModalCont").find("[name=projectWorkStartDate]").val($(detailModal).find("#start").val());
	$("#modifyModalCont").find("[name=projectWorkEndDate]").val($(detailModal).find("#end").val());
	$("#modifyModalCont").find("[name=projectPriorityId]").val($(detailModal).find("#projectPriorityId").val());
	$("#modifyModalCont").find("[name=projectPriorityName]").val($(detailModal).find("#projectPriorityName").val());
	$("#modifyModalCont").find("[name=projectWorkContent]").val($(detailModal).find("#projectWorkContent").val());
	$("#modifyModalCont").find("[name=projectWorkId]").val($(detailModal).find("#projectWorkId").val());
	$("#modifyModalCont").find("[name=picId]").val($(detailModal).find("#calPicId").val());
	$("#modifyModalCont").find("[name=projectId]").val($(detailModal).find("#projectId").val());

}

// ============================ 멤버 리스트 ==============================

const calPmList = document.querySelector("#calProjectMemberList");

const calPmemberList = function(resp){

	for(let i=0; i<resp.length; i++){
		let calOption = document.createElement("option");
		calOption.value = `\${resp[i].memberId}`;
		calOption.innerHTML = `\${resp[i].memberName}`;
		calPmList.appendChild(calOption);
		//MoPmList.appendChild(pwOption);
	}
}


const calProjectMemberList = function(){
console.log("멤버리스트");
   $.ajax({
	  type:"get",
	  url:"/ourmine/company/${companyId}/project/${projectId}/calendar/projectMemberList",
	  async:true,
	  dataType:"json",
	  success:function(resp){
	      console.log("결과확인",resp);  // 요기 코드가 길어지면  별도 함수로 처리/ 그래야 가독성이 유지됨
	      calPmemberList(resp);
	  },
	  error: function (request, status, error) {
	      console.log("code: " + request.status)
	      console.log("message: " + request.responseText)
	      console.log("error: " + error);
	  }

	})
};

calProjectMemberList();



//======================== 수정 ================================================
    /*  const updateFormSubmit = function(e){ */
$("#calSaveBtn").bind("click",function(){
   	console.log("등록하기버튼")
	let data = {
		projectWorkId:modifyForm.projectWorkId.value,
		projectWorkTitle:modifyForm.projectWorkTitle.value,
		projectWorkContent:modifyForm.projectWorkContent.value,
		projectWorkPic:modifyForm.picId.options[modifyForm.picId.selectedIndex].innerHTML,
		projectWorkStartDate:modifyForm.projectWorkStartDate.value,
		projectWorkEndDate:modifyForm.projectWorkEndDate.value,
		projectWorkStatusId:modifyForm.projectWorkStatusId.value,
		projectPriorityId:modifyForm.projectPriorityId.value,
		picId:modifyForm.picId.value
	}


    $.ajax({

         url: "/ourmine/company/${companyId}/project/${projectId}/calendar/calendarUpdate",
         data: JSON.stringify(data),
         contentType: "application/json;charset=utf-8",
         type: "POST",
         dataType: 'json',
         beforeSend : function(xhr){  // 헤더에 값 세팅, 항상 요따구로 씀
             xhr.setRequestHeader(header, token);
         },
              success: function (res) {
		 alert("일정 수정 성공!");
           	console.log("체킁: ",res)
            caModifyModalClose();
            calendar.refetchEvents();
            calendar.render();
          },
            error: function (request, status, error) {
	            alert("일정 수정에 실패하였습니다.")
	            console.log("상태코드:" + request.status + "\n" + "에러내용:" + request.responseText + "\n" + "error:" + error);
            }
        })
    });
// 수정 폼 이벤트
const modalSubmit = function(event) {
	event.preventDefault();
	console.log("체킁: {}","체킁");
	/* let form = this; */
	updateFormSubmit();

    return false;
};


// 삭제 버튼 누를시
const calendarDelete = (projectWorkId) => {
	console.log("projectWorkId :", projectWorkId)

	 $.ajax({
        url: "/ourmine/company/${companyId}/project/${projectId}/calendar/calendarDelete",
        data: JSON.stringify(projectWorkId),
        contentType : "application/json;charset=utf-8",
        type: "post",
        dataType:"json",
        beforeSend : function(xhr){  // 헤더에 값 세팅, 항상 요따구로 씀
            xhr.setRequestHeader(header, token);
        },
        success: function (res) {
        	console.log("삭제 확인", res);
            alert("삭제 완료");
            //detailModalClose();
            location.href=location.href;

        },
        error: function (request, status, error) {
        	alert("삭제 실패");
            console.log("상태코드:" + request.status + "\n" + "에러내용:" + request.responseText + "\n" + "error:" + error);
        }
    });
}


</script>

   <!-- Add Event-->
    <div class="modal fade" id="addevent" tabindex="-1"  aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-md modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title  fw-bold" id="eventaddLabel">Add Event</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="exampleFormControlInput99" class="form-label">Event Name</label>
                    <input type="text" class="form-control" id="exampleFormControlInput99">
                </div>
                <div class="mb-3">
                    <label for="formFileMultipleone" class="form-label">Event Images</label>
                    <input class="form-control" type="file" id="formFileMultipleone">
                </div>
                <div class="deadline-form">
                    <form>
                        <div class="row g-3 mb-3">
                          <div class="col">
                            <label for="datepickerded" class="form-label">Event Start Date</label>
                            <input type="date" class="form-control" id="datepickerded">
                          </div>
                          <div class="col">
                            <label for="datepickerdedone" class="form-label">Event End Date</label>
                            <input type="date" class="form-control" id="datepickerdedone">
                          </div>
                        </div>
                    </form>
                </div>
                <div class="mb-3">
                    <label for="exampleFormControlTextarea78" class="form-label">Event Description (optional)</label>
                    <textarea class="form-control" id="exampleFormControlTextarea78" rows="3" placeholder="Add any extra details about the request"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Done</button>
                <button type="button" class="btn btn-primary">Create</button>
            </div>
        </div>
        </div>
    </div>
</div>

<!-- Plugin Js-->
<script src="${cPath}/resources/js/main.min.js"></script>


