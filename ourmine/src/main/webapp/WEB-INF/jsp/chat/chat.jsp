<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<!-- <h4> 웹소켓 샘플 </h4> -->
<!-- <button class="wsControl" data-role="connect">연결수립</button> -->
<!-- <button class="wsControl" data-role="disconnect" disabled="disabled">연결종료</button> -->
<br />
<!-- <input type="text" class="wsControl" id="msgInput"  disabled="disabled"/> -->
<!-- <button class="wsControl" data-role="send"  disabled="disabled">전송</button> -->

<div id="mytask-layout" class="theme-indigo">
    <!-- main body area -->
    <div class="main">
        <!-- Body: Body -->
        <div class="body d-flex">
            <div class="container-xxl p-0">
                <div class="row g-0">
                    <div class="col-12 d-flex">
                       <!-- Card: -->
                        <div class="card card-chat border-right border-top-0 border-bottom-0  w380" id="searchCard">
                        <button type="button" class="btn btn-dark btn-set-task w-sm-100" data-bs-toggle="modal" data-bs-target="#createtask"><i class="icofont-plus-circle me-2 fs-6"></i>채팅방 만들기</button>
                            <div class="px-4 py-3 py-md-4">
                                <div class="input-group mb-3">
                                    <input type="text" class="form-control mb-1" placeholder="검색..." id="searchChatting" >
                                </div>

                                <div class="nav nav-pills justify-content-between text-center" role="tablist">
                                    <a class="flex-fill rounded border-0 nav-link active" data-bs-toggle="tab" href="#chat-recent" role="tab" aria-selected="true">Chat</a>
                                    <a class="flex-fill rounded border-0 nav-link" data-bs-toggle="tab" href="#chat-groups" role="tab" aria-selected="false">Members Groups</a>
                                    <a class="flex-fill rounded border-0 nav-link" data-bs-toggle="tab" href="#chat-contact" role="tab" aria-selected="false">Contact</a>
                                </div>
                            </div>
							<!-- 개인채팅목록 -->
                            <div class="tab-content border-top">
                                <div class="tab-pane fade show active" id="chat-recent" role="tabpanel">


                                </div>
								<!-- 그룹채팅목록 -->
                                <div class="tab-pane fade" id="chat-groups" role="tabpanel">

                                </div>
								<!-- 친구목록 -->
                                <div class="tab-pane fade" id="chat-contact" role="tabpanel">

                                </div>
                            </div>
                        </div>
                        <!-- Card: -->
                        <div class="card card-chat-body border-0  w-100 px-4 px-md-5 py-3 py-md-4">

                            <!-- Chat: Header -->
                            <div class="chat-header d-flex justify-content-between align-items-center border-bottom pb-3">
                                <div class="d-flex align-items-center">
                                    <a href="${cPath}/index" title="Home"><i class="fa fa-home fs-5"></i></a>
                                    <div class="ms-3" id="chattingNameArea">

                                    </div>
                                </div>
                                <div class="d-flex">
                                	<div id="chattingOutBtn">
                                	</div>
                                	<div class="dropdown">
									    <a class="nav-link py-2 px-3 text-muted d-none d-lg-block dropdown-toggle" href="javascript:void(0);" type="button" id="dropdownMenuButton5" data-bs-toggle="dropdown" aria-expanded="false">
									        <i class="fa fa-info-circle"></i>
									    </a>
									    <div class="dropdown-menu p-4 text-muted border-0 shadow" style="max-width: 200px;" id="chattingInfoArea">
									    </div>
									</div>
                                </div>
                            </div>

                            <!-- 채팅 : body -->
                            <ul class="chat-history list-unstyled mb-0 py-lg-5 py-md-4 py-3 flex-grow-1" id="chatSender">
								
                            </ul>

                            <!-- 채팅 : Footer -->
                            <div class="chat-message">
								<div class="modal-footer">
	                            <textarea class="form-control wsControl" id="msgInput"  rows="4" cols="40" placeholder="메세지 작성..."  ></textarea><br>
									<button class="btn btn-primary wsControl" data-role="send" onclick="msgCommit()" >전송</button>
                           		</div>
                            </div>
                        </div>
                    </div>
                </div> 
                <!-- row end -->
            </div>
        </div>
    </div>
</div>
<!-- 채팅방 생성 모달 -->
<div class="modal fade" id="createtask" tabindex="-1"  aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title  fw-bold" id="createprojectlLabel"> 채팅방 생성 </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label  class="form-label">채팅방 이름</label>
                        <input class="form-control" id="groupChatName" placeholder="채팅방 이름.."/>
                    </div>
                    <div class="mb-3">
                        <label  class="form-label">상위부서</label>
                        <select class="form-select" id="selDeptArea" onchange="fselChange(this)" aria-label="Default select Project Category">
                            <option selected>부서</option>
                            

                        </select>
                    </div>
                    <div class="mb-3">
                        <label  class="form-label">하위부서</label>
                        <select class="form-select" id="selTeamArea" onchange="fselChange2(this)" aria-label="Default select Project Category">
                            <option selected>팀</option>
                            <option value="1">Website Design</option>

                        </select>
                    </div>
                    
                    <div class="row g-3 mb-3">
                        <div class="col-sm">
                            <label  class="form-label">이름</label>
                            <select class="form-select" id="selMemArea" multiple aria-label="Default select Priority">

                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary" onclick="createGroupChat()">생성</button>
                </div>
            </div>
            </div>
        </div>
<security:authentication property="principal" var="principal"/>

<input id="chatId" type="hidden" value="${principal.realUser.memberEmail }">
<input id="memId" type="hidden" value="${principal.realUser.memberId }">
<input id="memName" type="hidden" value="${principal.realUser.memberName }">

<script>
	headers['accept'] = 'application/json';
	const loginfoId = $("#chatId").val();
	const memId = $("#memId").val();
	const memName = $("#memName").val();
	const messageArea = $("#chatSender");
	const chatListArea = $("#chat-recent");
	const chatGroupListArea = $("#chat-groups");
	const coMemListArea = $("#chat-contact");
	const msgInput = $("#msgInput");
	const selMemArea = $("#selMemArea");
	const selDeptArea = $("#selDeptArea");
	const selTeamArea = $("#selTeamArea");
	const chattingNameArea = $("#chattingNameArea");
	const chattingInfoArea = $("#chattingInfoArea");
	const chattingOutBtn = $("#chattingOutBtn");
	
	const createModalClose =()=>{
		$('#createtask').modal('hide'); 
	}
	
	const messageAreaScroll = document.querySelector("#chatSender").offsetHeight;

	var today = new Date();

	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);

	var dateString = year + '-' + month  + '-' + day;
	
	var hours = ('0' + today.getHours()).slice(-2); 
	var minutes = ('0' + today.getMinutes()).slice(-2);
	var seconds = ('0' + today.getSeconds()).slice(-2); 

	var timeString = hours + ':' + minutes  + ':' + seconds;
	
	let ws = null;
	let room = 0;
	
	
	// ===================검색 기능===================
		
	const inputId = $("#searchChatting")
		
            inputId.on("keyup", function () {
               let inputValue = inputId.val().toUpperCase();
               let searchChatList = $(".searchChatList");
               
               $.each(searchChatList, function (i, v) {
                  let dataValue = $(this).find(".searchChatTarget").html();
                  if (dataValue.toUpperCase().indexOf(inputValue) > -1) {
                     $(this).show();
                     return;
                  } else {
                     $(this).hide();
                  }
               })
            });
	
	// ================ 채팅방 나가기 =========================
	const roomOut = (room)=>{
		console.log("room",room);
		
		$.ajax({
	          type:"get",
	          url:"/ourmine/company/${companyId}/chat/roomOut",
	          data : "room="+room,
	          dataType:"json",
	          success:function(resp){
	              console.log("roomOut:{}",resp);
	              location.reload();
// 	              selectChatList();
// 	              selectGroupChatList();
	          },
	          error: function (request, status, error) {
	              console.log("code: " + request.status)
	              console.log("message: " + request.responseText)
	              console.log("error: " + error);
	          }
	         
	     });
		
	}
	
	// ==============채팅방 대화 리스트(챗룸에서 호출됨)===================
	// ============== 채팅방 참여자 리스트, 채팅방 이름 ===================
	const getChattingList =(room,roomName)=>{
		
		$.ajax({
	          type:"get",
	          url:"/ourmine/company/${companyId}/chat/getThisChattingMemberList",
	          data : "room="+room,
	          dataType:"json",
	          success:function(resp){
	              console.log("getThisChattingMemberList:{}",resp);

	              chattingOutBtn.html('');
	              chattingInfoArea.html('');

		      		for(let i=0; i<resp.length; i++){
		      			chattingInfoArea.append(
		 		      		` 
							<p class="mb-0">\${resp[i]}</p>
		 		      		`
		 		      	  );
		      		}
		            chattingOutBtn.append(
		            	  ` <a class="nav-link py-2 px-3 text-muted d-none d-lg-block chattingOutBtn" href="javascript:void(0);" onclick="roomOut(room)" title="out" data-roomnum="\${room}"><i class="icofont-logout">채팅 나가기</i></a>`
		            );
	          },
	          error: function (request, status, error) {
	              console.log("code: " + request.status)
	              console.log("message: " + request.responseText)
	              console.log("error: " + error);
	          }
	         
	     });
		
		$.ajax({
	          type:"get",
	          url:"/ourmine/company/${companyId}/chat/getChatContList",
	          data : {chattingId:room},
	          dataType:"json",
	          success:function(resp){
	              console.log("getChattingList:{}",resp);
	              messageArea.html('');
	              chattingNameArea.html('');
	              chattingInfoArea.html('');
   				  chattingNameArea.append(
	      				` 
	      				  <h6 class="mb-0">\${roomName}</h6>
                             <small class="text-muted">Last seen: 3 hours ago</small>
	      				`
	      				);
		      		for(let i=0; i<resp.length; i++){
		      			if(resp[i].memberId==memId){

		      				messageArea.append(
		      						`
		      						<li class="mb-3 d-flex flex-row-reverse align-items-end">
		      	                    <div class="max-width-70 text-right">
		      	                        <div class="user-info mb-1">
		      	                            <span class="text-muted small">나</span>
		      	                        </div>
		      	                        <div class="card border-0 p-3 bg-primary text-light">
		      	                            <div class="message">\${resp[i].chattingContent}</div>
		      	                        </div>
		      	                        <div class="user-info mb-1">
		      	                            <span class="text-muted small">\${resp[i].chattingContentTime}</span>
		      	                        </div>
									 </div>
		      	                     </li>
		      	                `
		      				);
		      				}else{
		      					messageArea.append(
		      							`
		      	                        <li class="mb-3 d-flex flex-row align-items-end">
		      	                        <div class="max-width-70">
		      	                            <div class="user-info mb-1">
		      	                                <img class="avatar sm rounded-circle me-1" src="assets/images/xs/avatar2.jpg" alt="">
		      	                                <span class="text-muted small">\${resp[i].memberName}</span>
		      	                            </div>
		      	                            <div class="card border-0 p-3">
		      	                                <div class="message">\${resp[i].chattingContent}</div>
		      	                            </div>
		      	                          	<div class="user-info mb-1">
		      	                          <span class="text-muted small">\${resp[i].chattingContentTime}</span>
		      	                          	</div>
		      	                        </div>
		      	                    </li>
		      	                    `
		      					);
		      				}
		      			}
	          },
	          error: function (request, status, error) {
	              console.log("code: " + request.status)
	              console.log("message: " + request.responseText)
	              console.log("error: " + error);
	          }
	         
	     });
	}
	// =============================채팅방===============================
	const chatRoom = $("#chat-recent").on("click", ".wsControl" ,function(event){
		console.log(this);
		switch (this.dataset.role) {
		case "connect":
// 			console.log("connect",connect)
			room = $(this).data("room");
			roomName = $(this).data("roomname");
			console.log("room =", room);
			console.log("roomName =", roomName);
			
			getChattingList(room,roomName);
			
			if(ws != null){
				ws.close(1000);
			}
			
			ws = connectWS();
			
			// 웹소켓이 연결이 되고 0.5초 후에 체팅방 번호를 전송..
			setTimeout(() => {
				var sendMsg2 = {
						"roomConnect"	: "roomConnect",
						"room"			: room,
						"userId"		: "loginfoId",
				};
				ws.send(JSON.stringify(sendMsg2));	
			}, 500);			
			
			break;
			
		}
	});
	const iconClickChatting = (resp,createSingleChatThis) =>{
		
		console.log("iconClickChatting:{}","iconClickChatting");
		console.log("iconClickChatting:{}",resp);
		console.log("createSingleChatThis:{}",createSingleChatThis);
		
		switch (createSingleChatThis.dataset.role) {
		case "connect":
// 			console.log("connect",connect)
				room = resp.chattingId;
			
			let roomName = '';
			if(resp.chattingMemName==memName){
				roomName = resp.chattingName;
			}else{
				roomName = resp.chattingMemName;
			}
			console.log("room =", room);
			console.log("roomName =", roomName);
			
			getChattingList(room,roomName);
			
			if(ws != null){
				ws.close(1000);
			}
			
			ws = connectWS();
			
			// 웹소켓이 연결이 되고 0.5초 후에 체팅방 번호를 전송..
			setTimeout(() => {
				var sendMsg2 = {
						"roomConnect"	: "roomConnect",
						"room"			: room,
						"userId"		: "loginfoId",
				};
				ws.send(JSON.stringify(sendMsg2));	
			}, 500);			
			
			break;
		}

	}
	// ========================단체 채팅방 ==========================
	const chatGroupRoom = $("#chat-groups").on("click", ".wsControl" ,function(event){
		console.log(this);
		switch (this.dataset.role) {
		case "connect":
// 			console.log("connect",connect)
			room = $(this).data("room");
			roomName = $(this).data("roomname");
			console.log("room =", room);
			console.log("roomName =", roomName);
			
			getChattingList(room,roomName);
			
			if(ws != null){
				ws.close(1000);
			}
			
			ws = connectWS();
			
			// 웹소켓이 연결이 되고 0.5초 후에 체팅방 번호를 전송..
			setTimeout(() => {
				var sendMsg2 = {
						"roomConnect"	: "roomConnect",
						"room"			: room,
						"userId"		: "loginfoId",
				};
				ws.send(JSON.stringify(sendMsg2));	
			}, 500);			
			
			break;
			
		}
	});

	
	// ======================= wsControl =====================
	const wsControl = $(".wsControl").on("click",function(event){
		console.log(this);
		switch (this.dataset.role) {
		case "disconnect":
			ws.close(1000);
			break;
			
		case "send":
			let message = msgInput.val();
			// 서버에 전송할 메시지 전문.
			let sendMsg = {
					"msg"		: msgInput.val(),
					"room"		: room,
					"userId"	: loginfoId,
			};
			// 메시지를 서버에 보내는 이벤트 (acltion)
			ws.send(JSON.stringify(sendMsg));
			// 입력창 데이터 기화.
			msgInput.val("");
			break;
		}
	});
	
	// ================= 채팅방 메세지 DB저장 =================
	const msgCommit =()=>{
		let sendMsg = $("#msgInput").val();
		console.log("sendMsg:{}",sendMsg);
 		let data = {
 				chattingContent:sendMsg,
 				chattingId:room
 		}
		$.ajax({
	          type:"post",
	          url:"/ourmine/company/${companyId}/chat/msgCommit",
	          data : JSON.stringify(data),
	          dataType:"json",
	          headers : headers,
	          success:function(resp){
	              console.log("결과확인:{}",resp);  // 요기 코드가 길어지면  별도 함수로 처리/ 그래야 가독성이 유지됨

	          },
	          error: function (request, status, error) {
	              console.log("code: " + request.status)
	              console.log("message: " + request.responseText)
	              console.log("error: " + error);
	          }
	         
	     });
		
	}
	
	
	
	// ======================팀리스트 출력문======================
	const printTeamList = function(resp){
		selTeamArea.html('');
		for(let i=0; i<resp.length; i++){
			let jOption = document.createElement("option");
			jOption.value = `\${resp[i].orgchartId}`;
			jOption.innerHTML = `\${resp[i].departmentName}`; 
//	 		if(jOption.value == ${param.typeNumber})
//	 			jOption.selected="selected";
			selTeamArea.append(jOption);
		}
	}
	// =======================팀리스트===========================
	function fselChange(p_this){
		orgchartId = p_this.value;
		$.ajax({
	          type:"get",
	          url:"/ourmine/company/${companyId}/chat/getTeamList",
	          data : {orgchartId:orgchartId},
	          dataType:"json",
	          success:function(resp){
	              console.log("결과확인:{}",resp);  // 요기 코드가 길어지면  별도 함수로 처리/ 그래야 가독성이 유지됨
	              printTeamList(resp);
	              printMemList(resp);
	          },
	          error: function (request, status, error) {
	              console.log("code: " + request.status)
	              console.log("message: " + request.responseText)
	              console.log("error: " + error);
	          }
	         
	     });
	}
	function fselChange2(p_this){
		orgchartId = p_this.value;
		$.ajax({
	          type:"get",
	          url:"/ourmine/company/${companyId}/chat/getTeamList",
	          data : {orgchartId:orgchartId},
	          dataType:"json",
	          success:function(resp){
	              console.log("결과확인:{}",resp);  // 요기 코드가 길어지면  별도 함수로 처리/ 그래야 가독성이 유지됨
	              printMemList(resp);
	          },
	          error: function (request, status, error) {
	              console.log("code: " + request.status)
	              console.log("message: " + request.responseText)
	              console.log("error: " + error);
	          }
	         
	     });
	}
	// ==========================부서리스트 출력문========================
	const printDeptList = function(resp){
		selDeptArea.html('');;
		for(let i=0; i<resp.length; i++){
			let jOption = document.createElement("option");
			jOption.value = `\${resp[i].orgchartId}`;
			jOption.innerHTML = `\${resp[i].departmentName}`; 
//	 		if(jOption.value == ${param.typeNumber})
//	 			jOption.selected="selected";
			selDeptArea.append(jOption);
		}
	}
	
	// ==============================부서리스트====================
	const getDepartment = () =>{
		$.ajax({
	          type:"get",
	          url:"/ourmine/company/${companyId}/chat/deptList",
	          dataType:"json",
	          success:function(resp){
	              console.log("결과확인:{}",resp);  // 요기 코드가 길어지면  별도 함수로 처리/ 그래야 가독성이 유지됨
	              printDeptList(resp);
	          },
	          error: function (request, status, error) {
	              console.log("code: " + request.status)
	              console.log("message: " + request.responseText)
	              console.log("error: " + error);
	          }
	         
	     });
	}
	
	// ==========================직원리스트 출력문===============
	const printMemList = function(resp){
		selMemArea.html('');
		for(let i=0; i<resp.length; i++){
			let jOption = document.createElement("option");
			jOption.value = `\${resp[i].memberId}`;
			jOption.innerHTML = `\${resp[i].memberName}`; 
//	 		if(jOption.value == ${param.typeNumber})
//	 			jOption.selected="selected";
			selMemArea.append(jOption);
		}
	}
	// ===========================직원리스트====================
	const getSelectMemberList = () =>{
		$.ajax({
	          type:"get",
	          url:"/ourmine/company/${companyId}/chat/coMemList",
	          dataType:"json",
	          success:function(resp){
	              console.log("결과확인:{}",resp);  // 요기 코드가 길어지면  별도 함수로 처리/ 그래야 가독성이 유지됨
	              printMemList(resp);
	          },
	          error: function (request, status, error) {
	              console.log("code: " + request.status)
	              console.log("message: " + request.responseText)
	              console.log("error: " + error);
	          }
	         
	     });
	}
	// ================ 그룹 채팅방 생성 ====================
	const createGroupChat = () => {
		let selMem = $("#selMemArea").val();
		console.log("selMem:{}",selMem);
		let gName = $("#groupChatName").val();
		console.log("gName:{}",gName);
		
 		let data = {
 				memberList:[],
				chattingName:gName
 		}
 		for (let i = 0; i < selMem.length; i++) {
 			  data.memberList[i] = selMem[i];
 		}
 		
 		$.ajax({
	          type:"post",
	          url:"/ourmine/company/${companyId}/chat/makeRoom",
	          data : JSON.stringify(data),
	          contentType : "application/json;charset=utf-8",
	          dataType:"json",
	          headers : headers,
	          success:function(resp){
	              console.log("결과확인:{}",resp);  // 요기 코드가 길어지면  별도 함수로 처리/ 그래야 가독성이 유지됨
	              createModalClose();
	              chatGroupListArea.html('');
	              selectGroupChatList();
	          },
	          error: function (request, status, error) {
	              console.log("code: " + request.status)
	              console.log("message: " + request.responseText)
	              console.log("error: " + error);
	          }
	         
	        });
	}
	
	// ================ 1:1 채팅방 생성 ====================
	let createSingleChatThis='';
	const createSingleChat = 
		$("#chat-contact").on("click","#createSingleChat",function(){
			
	 		console.log("체킁");
	 		console.log(this);
	 		createSingleChatThis = this;
			
	 		let mId = $(this).attr('mid');
	 		let cName = $(this).attr('mname');
	 		console.log("mId:{}",mId);
	 		console.log("cName:{}",cName);
	 		
	 		let data = {
	 				compareMemId:mId,
					chattingName:cName
	 		}
	 		
	 		
	 		console.log("data:{}",data);
	 		$.ajax({
		          type:"post",
		          url:"/ourmine/company/${companyId}/chat/makeSingleRoom",
		          data : JSON.stringify(data),
		          contentType : "application/json;charset=utf-8",
		          dataType:"json",
		          headers : headers,
		          success:function(resp){
		              console.log("makeSingleRoom결과확인:{}",resp);  // 요기 코드가 길어지면  별도 함수로 처리/ 그래야 가독성이 유지됨
		              iconClickChatting(resp,createSingleChatThis);
// 		              location.reload();
// 		              chatListArea.html('');
// 		              selectChatList();
// 		              console.log("resp.chattingId결과확인:{}",resp.chattingId);  
// 		              console.log("resp.chattingMemName결과확인:{}",resp.chattingMemName);  
// 		              console.log("resp.chattingName결과확인:{}",resp.chattingName); 
		          },
		          error: function (request, status, error) {
		              console.log("code: " + request.status)
		              console.log("message: " + request.responseText)
		              console.log("error: " + error);
		          }
		         
		        });
		})
	
	// ================ 회사 맴버 목록 ====================
	const selectCoMemList = () =>{
		$.ajax({
	          type:"get",
	          url:"/ourmine/company/${companyId}/chat/coMemList",
	          dataType:"json",
	          success:function(resp){
	              console.log("selectCoMemList:{}",resp);  // 요기 코드가 길어지면  별도 함수로 처리/ 그래야 가독성이 유지됨
	              for(let i=0; i<resp.length; i++){
	            	  coMemListArea.append($("<p>").append(
						`<ul class="list-unstyled list-group list-group-custom list-group-flush mb-0 searchChatList">
                             <li class="list-group-item px-md-4 py-3 py-md-4">
                                 <a href="javascript:void(0);" class="d-flex">
                                     <img class="avatar rounded-circle" src="assets/images/xs/avatar10.jpg" alt="">
                                     <div class="flex-fill ms-3 text-truncate">
                                         <div class="d-flex justify-content-between mb-0 wsControl" id="createSingleChat" mname="\${resp[i].memberName}" mid="\${resp[i].memberId}" data-role="connect">
                                             <h6 class="mb-0 searchChatTarget">\${resp[i].memberName}</h6>
                                             <div class="text-muted">
                                                 <i class="icofont-chat pl-2 text-danger"></i>
                                             </div>
                                         </div>
                                         <span class="text-muted">\${resp[i].memberEmail}</span>
                                     </div>
                                 </a>
                             </li>
                         </ul> `
					));
	          	}
	          },
	          error: function (request, status, error) {
	              console.log("code: " + request.status)
	              console.log("message: " + request.responseText)
	              console.log("error: " + error);
	          }
	         
	        });
	}
	

	// ================ 개설된 채팅방 목록 ====================	
	const selectChatList = () =>{
		$.ajax({
	          type:"get",
	          url:"/ourmine/company/${companyId}/chat/chatJson",
	          dataType:"json",
	          success:function(resp){
	              console.log("selectChatList:{}",resp);  
	              console.log("memId:{}",memId); 
	              for(let i=0; i<resp.length; i++){
		              if(resp[i].chattingMemName==memName){
	              		console.log("resp[0].memberId:{}",resp[0].memberId);  
		              chatListArea.append(
						`<ul class="list-unstyled list-group list-group-custom list-group-flush mb-0 searchChatList">
		                  <li class="list-group-item px-md-4 py-3 py-md-4 wsControl" data-room="\${resp[i].chattingId}" data-roomname="\${resp[i].chattingName}" data-role="connect">
		                      <a href="javascript:void(0);" class="d-flex">
		                          <img class="avatar rounded-circle" src="assets/images/xs/avatar6.jpg" alt="">
		                          <div class="flex-fill ms-3 text-truncate">
		                              <h6 class="d-flex justify-content-between mb-0">
			                              <span class="searchChatTarget">\${resp[i].chattingName}</span>
		                               <small class="msg-time">10:45 AM</small></h6>
		                               <span class="text-muted">Last content</span>
		                          </div>
		                      </a>
		                  </li>
		                </ul>`
		                );
		              }else{
		            	chatListArea.append(
						`<ul class="list-unstyled list-group list-group-custom list-group-flush mb-0 searchChatList">
		                  <li class="list-group-item px-md-4 py-3 py-md-4 wsControl" data-room="\${resp[i].chattingId}" data-roomname="\${resp[i].chattingName}" data-role="connect">
		                      <a href="javascript:void(0);" class="d-flex">
		                          <img class="avatar rounded-circle" src="assets/images/xs/avatar6.jpg" alt="">
		                          <div class="flex-fill ms-3 text-truncate">
		                              <h6 class="d-flex justify-content-between mb-0">
		                            	  <span class="searchChatTarget">>\${resp[i].chattingMemName}</span>
		                              <small class="msg-time">10:45 AM</small></h6>
		                               <span class="text-muted">Last content</span>
		                          </div>
		                      </a>
		                  </li>
		              </ul>`
		           	  );
					}
	          	}
	          },
	          error: function (request, status, error) {
	              console.log("code: " + request.status)
	              console.log("message: " + request.responseText)
	              console.log("error: " + error);
	          }
	         
	        });
	}
	
	// ================ 그룹 채팅방 목록 ====================
	const selectGroupChatList = () =>{
		$.ajax({
	          type:"get",
	          url:"/ourmine/company/${companyId}/chat/getGroupChatList",
	          dataType:"json",
	          success:function(resp){
	              console.log("selectGroupChatList:{}",resp);  // 요기 코드가 길어지면  별도 함수로 처리/ 그래야 가독성이 유지됨
	              for(let i=0; i<resp.length; i++){
	            	  chatGroupListArea.append(
						`
						<ul class="list-unstyled list-group list-group-custom list-group-flush mb-0 searchChatList">
		                  <li class="list-group-item px-md-4 py-3 py-md-4 wsControl" data-room="\${resp[i].chattingId}" data-roomname="\${resp[i].chattingName}" data-role="connect">
		                      <a href="javascript:void(0);" class="d-flex">
		                          <img class="avatar rounded-circle" src="assets/images/xs/avatar6.jpg" alt="">
		                          <div class="flex-fill ms-3 text-truncate">
		                              <h6 class="d-flex justify-content-between mb-0 searchChatTarget"><span>\${resp[i].chattingName}</span> <small class="msg-time">10:45 AM</small></h6>
		                              <span class="text-muted">Last content</span>
		                          </div>
		                      </a>
		                  </li>
		              </ul>
		              `
					);
	          	}
	          },
	          error: function (request, status, error) {
	              console.log("code: " + request.status)
	              console.log("message: " + request.responseText)
	              console.log("error: " + error);
	          }
	         
	        });
	}


	// ================ connectWS ====================
	// ================ 실시간 채팅 + 스크롤 =============
	function connectWS(){
		
		let ws = new WebSocket("ws://localhost${cPath}/ws/echo");
		ws.onopen=function(event){
			console.log(event);
// 			messageArea.append($("<p>").html("Connect!"));
			chatRoom.prop("disabled", (i,v)=>!v);
			chatGroupRoom.prop("disabled", (i,v)=>!v);
		}
		ws.onclose=function(event){
			console.log(event);
// 			messageArea.append($("<p>").html("DisConnect!"));
			chatRoom.prop("disabled", (i,v)=>!v);
			chatGroupRoom.prop("disabled", (i,v)=>!v);
		}
		ws.onmessage=function(event){
			console.log(event);
			let messageVO = JSON.parse(event.data);
			let msg = JSON.parse(messageVO.message);
			console.log("messageVO : {}", msg.msg);
			
			console.log("loginfoId:{}",loginfoId);
			

			
			if(messageVO.sender==loginfoId){
				
			messageArea.append(
					`
					<li class="mb-3 d-flex flex-row-reverse align-items-end">
                    <div class="max-width-70 text-right">
                        <div class="user-info mb-1">
                            <span class="text-muted small">나</span>
                        </div>
                        <div class="card border-0 p-3 bg-primary text-light">
                            <div class="message">\${msg.msg}</div>
                        </div>
                        <div class="user-info mb-1">
                            <span class="text-muted small">\${dateString} \${timeString}</span>
                        </div>
                    </div>
					</li>
                `
			);
			}else{
				messageArea.append(
						`
                        <li class="mb-3 d-flex flex-row align-items-end">
                        <div class="max-width-70">
                            <div class="user-info mb-1">
                                <img class="avatar sm rounded-circle me-1" src="assets/images/xs/avatar2.jpg" alt="avatar">
                                <span class="text-muted small">\${messageVO.sender}</span>
                            </div>
                            <div class="card border-0 p-3">
                                <div class="message">\${msg.msg}</div>
                            </div>
                            <div class="user-info mb-1">
                            	<span class="text-muted small">\${dateString} \${timeString}</span>
                        	</div>
                        </div>
                    </li>
                    `
				);
			}
			console.log("scroll",messageAreaScroll)
			//let mvHeight = messageArea[0].children.length * 105; 
		 	messageArea[0].scrollTo(0, messageArea[0].scrollHeight);
//			스크롤 안먹음 
		}
		return ws;
	}
	selectChatList();
	selectCoMemList();
	getSelectMemberList();
	getDepartment();
	selectGroupChatList();
	
</script>


