<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="security"%>
<script
	src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.js"></script>
<style>
/* 그리드 헤더 색상 */
.ag-theme-alpine {
	-ag-header-background-color: #484c7f;
	-ag-header-foreground-color: #ffffff;
}

/* 그리드 내용 가운데 정렬 */
.ag-row .ag-cell {
	display: flex;
	justify-content: center;
	/* align horizontal */
	align-items: center;
	/* align-content: center; */
}

.ag-header-cell-text {
	margin-left: 60px;
}

#jiModal {
	display: block;
	position: fixed;
	left: 0px;
	top: 0px;
	width: 100vw;
	height: 100vh;
	background-color: rgba(0, 0, 0, 0.5);
	color: black;
	z-index: 99999999999; /* 상당히 큰값을 오디선가 다른 곳에 주었음! */
	display: none;
}

#jiModal2 {
	display: block;
	position: fixed;
	left: 0px;
	top: 0px;
	width: 100vw;
	height: 100vh;
	background-color: rgba(0, 0, 0, 0.5);
	color: black;
	z-index: 999999999999; /* 상당히 큰값을 오디선가 다른 곳에 주었음! */
	display: none;
}

#boTyDelModal {
	display: block;
	position: fixed;
	left: 0px;
	top: 0px;
	width: 100vw;
	height: 100vh;
	background-color: rgba(0, 0, 0, 0.5);
	color: black;
	z-index: 999999999999; /* 상당히 큰값을 오디선가 다른 곳에 주었음! */
	display: none;
}

#jiContent {
	margin: 2% auto;
	width: 800px;
	background-color: white;
}

#jiContent2 {
	margin: 15% auto;
	width: 800px;
	background-color: white;
}

#jiinsertContent {
	margin: 45% -30%;
	width: 800px;
	background-color: white;
}

#boTyDelContent {
	margin: 15% auto;
	height: 300px;
	width: 600px;
	background-color: white;
}

#modifyForm {
	display: none;
}

.reply-box {
	width: 770px;
	margin-bottom: 12px;
	max-height: 350px;
	overflow: auto;
	position: relative;
}


#textareaPart {
	height: 160px;
	overflow: auto;
  	position: relative;
}

#contModiArea{
	height: 200px;
}

#jiModifyForm{
	width: 770px;
	margin: auto;
}
#jiarea{
    max-width: 770px;
    margin: 1.75rem auto;
}
#quickFilter{
    margin: 1%;
	width: 25%;
}

</style>
<!-- 리플 수정모달 -->
<form id="modifyForm">
	<textarea rows="5" cols="20" id="area"></textarea>
	<input type="button" value="확인" id="btnok"> <input
		type="button" value="취소" id="btncancle">
</form>

<!-- 상세조회 Modal -->
<div id="jiModal">
	<div id="jiContent">
		<div class="">
			<div class="modal-header">
				<h5 class="boardTitle" id="boardTitle"></h5>
				<a id="boardTypeId1" style="display: none"></a>
				<hr>
			</div>
			<div class="card bg-light">
				<div class="card-body pt-4">
					<div class="modal-content">
						<table>
							<tr>
								<td>글번호</td>
								<td id="boardId"></td>
							</tr>
							<tr>
								<td>작성자</td>
								<td id="boardWriter"></td>
							</tr>
							<tr>
								<td>날짜</td>
								<td id="boardWriteDate"></td>
							</tr>
							<tr>
								<td>조회수</td>
								<td id="boardCount"></td>
							</tr>
						</table>
					</div>
					<div class="form-control modal-content" id="textareaPart">
						<div class="form-control">
							<div class="boardContentArea" id="boardContent"></div>
						</div>
					</div>
					<br>
					<div>
						<span>첨부파일</span><br> <span id="files2"></span>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-primary"
				onclick="openJiModal2()">수정</button>
			<button type="button" class="btn btn-primary" id="JIDelete">삭제</button>
			<button type="button" class="btn btn-secondary" onclick="jiClose()">닫기</button>
		</div>
		<!-- 댓글 입력상자 -->
		<section class="mb-5" id="reply">
			<div class="card bg-light">
				<div class="card-body pt-4">
					<!-- Comment form-->
					<form class="mb-4" name="insertReplyForm" id="insertReplyForm"
						enctype="multipart/form-data">
						<input id="boardId1" name="boardId" type="hidden" /> <input
							class="form-control" placeholder="댓글을 입력해 주세요!"
							name="replyContent" style="width: 100%;" />
					</form>
					<button type="button"
						class="btn btn-outline-primary col-md-12 action"
						onclick="replyInsert()">등록</button>
					<br>
					<br>
					<!-- Single comment-->
					<div class="reply-box"></div>
					<!-- 게시판 리스트 출력 -->
					<br>
					<br>
					<!-- 페이지 리스트 출력 -->
				</div>
			</div>
		</section>
	</div>
</div>
<!-- 수정 Modal -->
<div id="jiModal2">
	<div id="jiContent2">
		<div class="jiarea">
			<form name="jiModifyForm" id="jiModifyForm"
				enctype="multipart/form-data">
				<div class="modal-header"></div>

				<div class="modal-content">
					제목 :<input name="boardTitle" class="form-control" required></input>

					글번호 : <input name="boardId" class="form-control" readonly required></input>

					<hr>
					내용 :
					<textarea name="boardContent" class="form-control" id="contModiArea" required></textarea>
				</div>
			</form>
		</div>
		<span id="files"></span>
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" onclick="jiModify()">적용</button>
			<button type="button" class="btn btn-secondary" onclick="jiClose2()">닫기</button>
		</div>
	</div>
</div>
<!-- 게시판 타입 추가 모달 -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1"
	aria-labelledby="exampleModalCenterTitle" style="display: none;"
	aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalCenterTitle">Modal
					title</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form method="post" id="boTyInsForm">
					<!-- 아이디, 비밀번호, 이름, 입력받기 -->
					게시판 이름<br> <input type="text" name="boardType"
						id="boardTypeClean"><br>
					<hr>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary"
							onclick="boardTypeInsert(event)">전송</button>
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 게시판 타입 제거 모달 -->
<div id="boTyDelModal">
	<div id="boTyDelContent">
		<div class="card bg-light">
			<div class="card-body pt-4">
				<div>
					<div class="modal-header">
						<h5>게시판종류 삭제</h5>
						<hr>
					</div>
					<div class="modal-body">
						<div class="modal-content">
							<br>
							<h5 style="text-align: center;">게시판종류</h5>
							<br> <select name="boardTypeId" id="boardTypeId">
								<option value="0" selected>선택</option>
							</select> <br>
							<br>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary"
							onclick="boardTypeDel()">삭제</button>
						<button type="button" class="btn btn-secondary"
							onclick="BoTyDelModalClose()">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 등록 모달 -->
<div class="modal" id="jiinsertModal">
	<div class="modal-dialog">
		<div class="modal-content" id="jiinsertContent">
			<div class="card mb-3">
				<div
					class="card-header py-3 d-flex justify-content-between bg-transparent border-bottom-0">
					<h6 class="mb-0 fw-bold ">글등록</h6>
					<hr>
				</div>
				<div class="card-body">
					<form onsubmit="handleSubmit(event)" novalidate="novalidate"
						id="insertjiModal">
						<security:csrfInput />
						<div class="row g-3 align-items-center">
							<div>
								게시판종류<br> <select name="boardTypeId" id="boardTypeId3">
									<option value="0" selected>선택</option>
								</select>
								<hr>
							</div>
							<div class="col-md-12">
								<span id="fail"></span>
								<div class="form-group">
									<label class="form-label">제목</label> <input type="text"
										name="boardTitle" class="form-control" id="boardTitleClear"
										required>
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<label class="form-label">내용</label>
									<textarea class="form-control" name="boardContent" rows="5"
										cols="30" id="boardContentClear" required></textarea>
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<input type="file" multiple="multiple" name="files"
										id="filesClean" />
								</div>
								<div id="fileListDiv"></div>
							</div>
							<br>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary" id="jiInsertBtn">등록</button>
							<button type="button" class="btn btn-secondary"
								onclick="jiinsertClose()">닫기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 추가 버튼 -->

<!-- main body area -->


<!-- Body: Body -->
<div class="body d-flex py-lg-3 py-md-2">
	<div class="container-xxl">
		<div class="row align-items-center">
			<div class="border-0 mb-4">
				<div
					class="card-header py-3 no-bg bg-transparent d-flex align-items-center px-0 justify-content-between border-bottom flex-wrap">
					<h3 class="fw-bold mb-0">게시판</h3>
					<div class="col-auto d-flex w-sm-100">
						<button type="button"
							class="btn btn-dark btn-set-task w-sm-100 m-1"
							id="boardTypeDelBtn">게시판 제거</button>
						<button type="button"
							class="btn btn-dark btn-set-task w-sm-100 m-1"
							id="boardTypeAddBtn" data-bs-toggle="modal"
							data-bs-target="#exampleModalCenter">
							<i class="icofont-plus-circle me-2 fs-6"></i> 게시판 추가
						</button>
						<button type="button"
							class="btn btn-dark btn-set-task w-sm-100 m-1" id="boardAddBtn"
							data-bs-toggle="modal" data-bs-target="#jiinsertModal">
							<i class="icofont-plus-circle me-2 fs-6"></i> 글추가
						</button>
					</div>
				</div>
			</div>
			<br>

			<input type="text" class="form-control"  oninput="onQuickFilterChanged()"  id="quickFilter"   placeholder="검색..."/>
			<br>
			<!-- ag-grid영역 -->
			<br>
			<div id="myGrid" style="height: 600px; width: 100%;" class="ag-theme-alpine"></div>
		</div>
	</div>
</div>


<script>
		//검색
		 function onQuickFilterChanged() {
		    gridOptions.api.setQuickFilter(document.getElementById('quickFilter').value);
		  }
        //스프링 security CSRF를  설정하면 아래 토큰 값을 get이외의 방식에는 전송해야 한당
	    const header = '${_csrf.headerName}';
  		const token =  '${_csrf.token}';

        let fail   = document.querySelector("#fail");

        const JIModal = document.querySelector("#jiModal");

        const JIModal2 = document.querySelector("#jiModal2");

        const JIInsModal = document.querySelector("#jiinsertModal");

        const BoTyDelModal = document.querySelector("#boTyDelModal");

        const jiClose = () =>{
        	let paramboty = document.querySelector("#jiModal #boardTypeId1");
        	let param = paramboty.text;
        	console.log("param{}:",param);
            JIModal.style.display="none"; // 안 보이겡
            fgetData(param);
        }
        const jiClose2 = () =>{
            JIModal2.style.display="none"; // 안 보이겡
        }
        const BoTyDelModalClose = () =>{
        	BoTyDelModal.style.display="none"; // 안 보이겡
        }

//		 게시판 LIST
//		 bodynav로 이동
	    const fgetData = (boardTypeNum) => {   // 데이터 가져오는 비동기처리
	        // gridOptions.api. 대부분의 유용한 메소드가 여기에 있다
	        const xhr = new XMLHttpRequest();
	        xhr.open("GET","/ourmine/company/${companyId}/project/${projectId}/board/boardListJson?boardTypeId="+boardTypeNum, true);
	        xhr.onreadystatechange = () => {
	            if (xhr.readyState == 4 && xhr.status == 200) {
	//                 console.log(JSON.parse(xhr.responseText));
	                console.log("responseText : ", xhr.responseText);
	                gridOptions.rowData = JSON.parse(xhr.responseText);
	//                 gridOptions.api.setRowData(JSON.parse(xhr.responseText));
					document.getElementById('myGrid').innerHTML="";
	                new agGrid.Grid(gridDiv, gridOptions);

	            }
	        }
	        xhr.send();
	    }

        // insert모달 게시판 종류 띄우기
        const botyDisp = document.querySelector("#boardTypeId");
        const botyDisp3 = document.querySelector("#boardTypeId3");
		console.log("botyDisp3:{}",botyDisp3)

        const fboardList2 = function(resp){
        	for(let i=0; i<resp.length; i++){
        		let jOption = document.createElement("option");
        		jOption.value = `\${resp[i].boardTypeId}`;
        		jOption.innerHTML = `\${resp[i].boardType}`;
        		botyDisp.appendChild(jOption);
        	}
        }
        const fboardList3 = function(resp){
        	for(let i=0; i<resp.length; i++){
        		let jOption = document.createElement("option");
        		jOption.value = `\${resp[i].boardTypeId}`;
        		jOption.innerHTML = `\${resp[i].boardType}`;
        		botyDisp3.appendChild(jOption);
        	}
        }
		const boardTypeList2 = function(){
			console.log("타입리스트체킁:{}","체킁");
	        $.ajax({
	          type:"get",
	          url:"/ourmine/company/${companyId}/project/${projectId}/boardType/boardTypeList",
	          async:true,
	          dataType:"json",
	          success:function(resp){
// 	              console.log("결과확인",resp);  // 요기 코드가 길어지면  별도 함수로 처리/ 그래야 가독성이 유지됨
	              fboardList2(resp);
	              fboardList3(resp);
	          },
	          error: function (request, status, error) {
	              console.log("code: " + request.status)
	              console.log("message: " + request.responseText)
	              console.log("error: " + error);
	          }

	        })
		}

		// 게시글 수정 모달
        const openJiModal2 = () =>{
           JIModal2.style.display="block";

         let boardContVal =  $(JIModal).find("#boardContent").html();
         let boardCont = boardContVal.replaceAll(/<br>/g, "\n");
         console.log("boardCont:{}",boardCont);

         $("#jiContent2").find("[name=boardTitle]").val( $(JIModal).find("#boardTitle").html() );
         $("#jiContent2").find("[name=boardId]").val( $(JIModal).find("#boardId").html() );
         $("#jiContent2").find("[name=boardContent]").val( boardCont );

        }


		// 게시글 수정
		let modiformdata = function(contentType, form){

   		let data = {};
   		$('#jiModifyForm').find(":input[name]").each(function(index, input){
   			let propertyName = this.name;
   			let propertyValue = $(this).val();
   			data[propertyName] = propertyValue;
   		});
   		$('#jiModifyForm').find("textarea[name]").each(function(index, input){
   			let propertyName = this.name;
   			let contextText = $(this).val();
   			let propertyValue = contextText.replaceAll("\n", "<br>");
   			data[propertyName] = propertyValue;
   		});

   		if(contentType.indexOf("json") >= 0)
   			data = JSON.stringify(data);	// marshalling
   		console.log(data);
   		return data;
   		}

        const jiModify = (e) =>{

        	console.log("체킁2: {}","체킁2");

            let btvid = document.querySelector("#boardTypeId1");
        	console.log("btvid: {}", btvid);

    		let btvidValue = btvid.text;
        	console.log("btvidValue: {}", btvidValue);

//     			e.preventDefault();
    			let form = this;

        	let contextText = $("#jiModifyForm [name=boardContent]").val();
            console.log("contextText:{}",contextText); // css 선택자
            let boardCont = contextText.replaceAll("\n", "<br>");
            console.log("boardCont:{}",boardCont); // css 선택자

            $.ajax({
                url : '/ourmine/company/${companyId}/project/${projectId}/board/boardView',
                data : modiformdata('json', form),   // data : {"bonum" : reply.bonum},
                contentType : "application/json;charset=utf-8",
                type : 'post',
                dataType : 'json',  //   받아온 값에 JSON.parse
                beforeSend : function(xhr){  // 헤더에 값 세팅, 항상 요따구로 씀
                    xhr.setRequestHeader(header, token);
                },
                success : function(res){
                    console.log("check: ", res);
                    jiClose2();
                    jiClose();
                    fgetData(btvidValue);
                },
                error : function(xhr){
                    alert("상태 : ", "실패");
                }

            });


        }


        const jiinsertClose = () =>{
           $('#jiinsertModal').modal('hide'); // 안 보이겡
        }



        const jiDelete = (boIdData) => {
            console.log("boardId : {}", boIdData )

            let btvid2 = document.querySelector("#boardTypeId1");
        	console.log("btvid: {}", btvid2);

    		let btvidValue2 = btvid2.text;
        	console.log("btvidValue: {}", btvidValue2);

                 $.ajax({
                     url : '/ourmine/company/${companyId}/project/${projectId}/board/boardDelete',
                     data : JSON.stringify(boIdData),   // data : {"bonum" : reply.bonum},
                     contentType : "application/json;charset=utf-8",
                     type : 'post',
                     dataType : 'json',  //   받아온 값에 JSON.parse
                     beforeSend : function(xhr){  // 헤더에 값 세팅, 항상 요따구로 씀
                         xhr.setRequestHeader(header, token);
                     },
                     success : function(res){
                         console.log("check: ", res);
                         jiClose();
                         fgetData(btvidValue2);
                     },
                     error : function(xhr){
//                          alert("상태 : " + xhr.status);
                     }

                });
        }
        const boardHitUpdate = (boardIdParam) =>{
        	console.log("boardIdParam:{}",boardIdParam)
            $.ajax({
                url : '/ourmine/company/${companyId}/project/${projectId}/board/boardHitUpdate',
                data : JSON.stringify(boardIdParam),   // data : {"bonum" : reply.bonum},
                contentType : "application/json;charset=utf-8",
                type : 'post',
                dataType : 'json',  //   받아온 값에 JSON.parse
                beforeSend : function(xhr){  // 헤더에 값 세팅, 항상 요따구로 씀
                    xhr.setRequestHeader(header, token);
                },
                success : function(res){
                    console.log("check: ", res);
                },
                error : function(xhr){
//                     alert("상태 : " + xhr.status);
                }

           });
        }
        ///////////////////// 게시판종류 등록 ////////////////////
        const checkBoarTypeAleady = function(resp){

        	var validationCheck = true;

        	for(let i=0; i<resp.length; i++){
        		if(resp[i].boardType == '00' || resp[i].boardType == alreadyInCheck){
        			validationCheck = false;
        		}
        	}

        	if(!validationCheck){
        		alert("게시판명 중복");
        	}
        	return validationCheck;
        }

        const boardTypeList3 = function(){
			console.log("타입리스트체킁:{}","체킁");
			var validationCheck = true;
	        $.ajax({
	          type:"get",
	          url:"/ourmine/company/${companyId}/project/${projectId}/boardType/boardTypeList",
	          async:false,
	          dataType:"json",
	          success:function(resp){
// 	              console.log("결과확인",resp);  // 요기 코드가 길어지면  별도 함수로 처리/ 그래야 가독성이 유지됨
	        	  validationCheck = checkBoarTypeAleady(resp);

	          },
	          error: function (request, status, error) {
	              console.log("code: " + request.status)
	              console.log("message: " + request.responseText)
	              console.log("error: " + error);
	          }

	        })

	        return validationCheck;
		}

        let boardTypeInsertForm = function(contentType, form){


       		let boTyInsdata = {};
       		$('#boTyInsForm').find(":input[name]").each(function(index, input){
       			let propertyName = this.name;
       			console.log("propertyName");
       			let propertyValue = $(this).val();
       			console.log("propertyValue");
       			boTyInsdata[propertyName] = propertyValue;
       		});
       		if(contentType.indexOf("json") >= 0)
       			boTyInsdata = JSON.stringify(boTyInsdata);	// marshalling
       		console.log("boTyInsdata:{}",boTyInsdata);
       		return boTyInsdata;
       		}

        	let	alreadyInCheck = '00';

            const boardTypeInsert = (e) =>{
            	e.preventDefault();
            	let boardTypeInsert = document.querySelector("#boardTypeClean")
            	alreadyInCheck = boardTypeInsert.value;
            	console.log("boardTypeInsert:{}",boardTypeInsert);
            	console.log("alreadyInCheck:{}",alreadyInCheck);
            	console.log("체킁:",this);
        		let form = this;

        		var validationCheck = boardTypeList3();
        		if(!validationCheck) return;


                $.ajax({
                    url : '/ourmine/company/${companyId}/project/${projectId}/boardType/boardTypeForm',
                    data : boardTypeInsertForm('json', form),   // data : {"bonum" : reply.bonum},
                    contentType : "application/json;charset=utf-8",
                    type : 'post',
                    dataType : 'json',  //   받아온 값에 JSON.parse
                    beforeSend : function(xhr){  // 헤더에 값 세팅, 항상 요따구로 씀
                        xhr.setRequestHeader(header, token);
                    },
                    success : function(res){
                        console.log("check: ", res);
                        boardTypeInsert.value='';
                        location.reload();
                    },
                    error : function(xhr){
                        alert("상태 : ", "실패");
                    }

                });


            }
            //게시판 종류 삭제
            const boardTypeDel = () =>{
            	let boardType = document.querySelector("#boardTypeId");
            	let boardTypeId = boardType.value;
            	console.log("boardTypeId:{}",boardTypeId);
                $.ajax({
                    url : '/ourmine/company/${companyId}/project/${projectId}/boardType/boardTypeDelete',
                    data : JSON.stringify(boardTypeId),   // data : {"bonum" : reply.bonum},
                    contentType : "application/json;charset=utf-8",
                    type : 'post',
                    dataType : 'json',  //   받아온 값에 JSON.parse
                    beforeSend : function(xhr){  // 헤더에 값 세팅, 항상 요따구로 씀
                        xhr.setRequestHeader(header, token);
                    },
                    success : function(res){
                        console.log("check: ", res);
                        location.href=location.href;
                    },
                    error : function(xhr){
                        alert("상태 : ", "실패");
                    }

                });
            }

        ////////////////// 댓글 ///////////////////

        // 댓글 목록
        const replyBox = document.querySelector(".reply-box");


        const replyGetList =(boardIdParam)=>{
        	console.log("replyboardId:{}",boardIdParam);
         	console.log("체킁4:",replyBox);
         replyBox.innerHTML="";
        	$.ajax({
        	  type:"get",
        	  url:"/ourmine/reply/boardReplyListJson?boardId="+ boardIdParam,
        	  dataType:"json",
        	  success:function(resp){
        	      console.log("결과확인",resp);  // 요기 코드가 길어지면  별도 함수로 처리/ 그래야 가독성이 유지됨
	              	for(let i=0; i<resp.length; i++){
                     console.log("루핑구:",i);
	            		let replyList = document.createElement("div");
	            		replyList.innerHTML = `작성자 : \${resp[i].replyWriter}               `;
	            		replyList.innerHTML += `작성일 : \${resp[i].replyWriteDate}<br>`;
	            		replyList.innerHTML += `<a name="boardId" vid ="\${resp[i].boardId}" /><br>`;
	            		replyList.innerHTML += `<textarea class="form-control" name="replyContent" vid ="\${resp[i].replyId}">\${resp[i].replyContent}</textarea>`;
	            		replyList.innerHTML += `
	            		<br>
	            		<p class="p2">
	    	                <input type="button" idx="\${resp[i].replyId}" vid ="\${resp[i].boardId}" value="댓글수정" name="r_modify" class="r_modify_action" >
	    	                <input type="button" idx="\${resp[i].replyId}" vid ="\${resp[i].boardId}" value="댓글삭제" name="r_delete" class="r_delete_action" >
	                 	</p>`
	            		replyBox.appendChild(replyList);
	            	}
        	  },
        	  error: function (request, status, error) {
        	      console.log("code: " + request.status)
        	      console.log("error: " + error);
        	  }

        	})
        }


        // 댓글 등록
        let replyInsertFormdata = function(contentType, form){
       		let reInsdata = {};
       		$('#insertReplyForm').find(":input[name]").each(function(index, input){
       			let propertyName = this.name;
       			console.log("propertyName");
       			let propertyValue = $(this).val();
       			console.log("propertyValue");
       			reInsdata[propertyName] = propertyValue;
       		});
       		if(contentType.indexOf("json") >= 0)
       			reInsdata = JSON.stringify(reInsdata);	// marshalling
       		console.log("reInsdata:{}",reInsdata);
       		return reInsdata;
       		}


            const replyInsert = (e) =>{
            	console.log("체킁:",this);
        		let form = this;
        		let bvid = document.querySelector("#boardId1");
        		let bvidValue = bvid.value;
            	console.log("bvidValue: {}", bvidValue);
            	let inputarea = $('#insertReplyForm').find("input.form-control");
            	console.log("inputarea: {}", inputarea);

                $.ajax({
                    url : '/ourmine/reply/replyInsert',
                    data : replyInsertFormdata('json', form),   // data : {"bonum" : reply.bonum},
                    contentType : "application/json;charset=utf-8",
                    type : 'post',
                    dataType : 'json',  //   받아온 값에 JSON.parse
                    beforeSend : function(xhr){  // 헤더에 값 세팅, 항상 요따구로 씀
                        xhr.setRequestHeader(header, token);
                    },
                    success : function(res){
                        console.log("check: ", res);
                        console.log("p",inputarea[0]);
                        inputarea.val('');
                        replyGetList(bvidValue);
                    },
                    error : function(xhr){
                        alert("상태 : ", "실패");
                    }

                });


            }
        // 댓글 삭제
        $(function(){
	        $(document).on('click', '.r_delete_action', function(){
	    		vidx = $(this).attr('idx');
	    		bvid = $(this).attr('vid');
	        	console.log("체킁: vidx: {}",vidx);
	        	console.log("체킁: bvid: {}",bvid);
	//     			e.preventDefault();

	            $.ajax({
	                url : '/ourmine/reply/replyDelete',
	                data : vidx,   // data : {"bonum" : reply.bonum},
	                contentType : "application/json;charset=utf-8",
	                type : 'post',
	                dataType : 'text',  //   받아온 값에 JSON.parse
	                beforeSend : function(xhr){  // 헤더에 값 세팅, 항상 요따구로 씀
	                    xhr.setRequestHeader(header, token);
	                },
	                success : function(res){
	                    console.log("check: ", res);
	                    replyGetList(bvid);

	                },
	                error : function(xhr){
	//                     alert("상태 : ", "실패");
	                }

	            });
	        });


	        $(document).on('click', '.r_modify_action', function(){
            //console.log("체킁:",this);
            let $txtArea = $(this).closest("div").find("textarea");
            let bvid = document.querySelector("#boardId1");
    		let bvidValue = bvid.value;
        	console.log("bvidValue: {}", bvidValue);

            //console.log("체킁2 : " , $txtArea.val());
            //console.log("체킁3 :", $txtArea.attr("vid"));

            let boardReplyVO = {
               replyId: $txtArea.attr("vid"),
               replyContent: $txtArea.val()
            }

            $.ajax({
	                url : '/ourmine/reply/replyUpdate',
	                data : JSON.stringify(boardReplyVO),   // data : {"bonum" : reply.bonum},
	                contentType : "application/json;charset=utf-8",
	                type : 'post',
	                dataType : 'text',  //   받아온 값에 JSON.parse
	                beforeSend : function(xhr){  // 헤더에 값 세팅, 항상 요따구로 씀
	                    xhr.setRequestHeader(header, token);
	                },
	                success : function(res){
	                    console.log("check: ", res);
	                    replyGetList(bvidValue);

	                },
	                error : function(xhr){
	//                     alert("상태 : ", "실패");
	                }

	            });
	        });
        	$("#boardTypeDelBtn").on("click", function(){
        		BoTyDelModal.style.display="block";
        	});

        });




        const gridDiv = document.querySelector("#myGrid");



                const columnDefs = [
//                     { field: "boardTypeId", headerName: "게시판종류", cellStyle: {textAlign: 'center'}, maxWidth: 100 },
                    { field: "boardId", headerName: "게시글번호", cellStyle: {textAlign: 'center'}, maxWidth: 200 },
                    { field: "boardWriter", headerName: "글쓴이", cellStyle: {textAlign: 'center'}, maxWidth: 200 },
                    { field: "boardTitle", headerName: "제목", cellStyle: {textAlign: 'left'}, minWidth: 300 },
                    { field: "boardCount", headerName: "조회수", cellStyle: {textAlign: 'center'}, maxWidth: 200 },
                    { field: "boardWriteDate", headerName: "작성일자", cellStyle: {textAlign: 'center'}, maxWidth: 250 },
                    { field: "boardModifyDate", headerName: "수정일자", cellStyle: {textAlign: 'center'}, maxWidth: 250 }

                ];

                // specify the data
                // const rowData = [];

                // let the grid know which columns and what data to use
                const gridOptions = {
                    defaultColDef: {    // 일일이 컬럼에 정의하지 않고 한번에 기본 옵션 설정!
                        sortable: true,
                        filter: true,
                        resizable: true,
                        editable: false,
                        setDataValue : true
                    },
                    columnDefs: columnDefs,
                    //row1Data: rowData,
                    pagination: true,
                    paginationAutoPageSize: true,
                    onGridReady: function (event) {		// 열 자동 조절 기능
                        event.api.sizeColumnsToFit();
                    },
                    onCellClicked: params => { // example event handler
                        console.log('cell was clicked ㅇㅇㅇ', params.data);
						let boardIdParam = params.data.boardId;
						let files2 = document.querySelector('#files2');



                    	// DB 조회수증가
						axios.get(`/ourmine/boardCoNotice/boardCoFile/\${boardIdParam}`, {headers:headers})
								.then(resp => {
									files2.innerHTML = '';
									console.log("resp.data =" ,resp.data);
									let axiosData = resp.data;
									console.log("엑시오스 데이터",axiosData);
									files2.innerHTML += axiosData.files.map(item => item.original !== null ?  `<a href="/ourmine/uploadAAA/\${item.uuid}" download="\${item.original}">\${item.original}<a><br>` : `<a></a>`).join('');
								});


						boardIdParam = JSON.stringify(boardIdParam);
                    	boardHitUpdate(boardIdParam);
                    	replyGetList(boardIdParam);


                    	// 화면 조회수증가
                        let boardVO = params.data;
                        let boTypeId = boardVO.boardTypeId;
                    	console.log("boTypeId",boTypeId);
                    	let boardId = boardVO.boardId;
                    	boNo = (boardVO.boardCount);
                    	console.log("boNo1",boNo);

                    	boNo = boNo + 1 ;
                    	console.log("boNo2",boNo);


                    	//상세조회 모달
                        $("#boardTypeId1").html(boardVO.boardTypeId);
                        $(".boardTitle").html(boardVO.boardTitle);
                        $("#boardId").html(boardId);
                        $("#boardId1").val(boardId);

                        $("#boardWriter").html(boardVO.boardWriter);
                        $("#boardWriteDate").html(boardVO.boardWriteDate);
                        $("#boardCount").html(boNo);
                        $("#boardContent").html(boardVO.boardContent);

                        JIModal.style.display="block";

                        // 삭제모달
                        let boIdData = params.data.boardId;
                        console.log("boIdData:{}",boIdData)
                        $('#JIDelete').on('click', function(){
                           jiDelete(boIdData);
                        });

              }
            //paginationPageSize:8,
        };



        // setup the grid after the page has finished loading
        headers['Content-Type'] = 'application/json'
	    headers['accept'] = 'application/json'


      let g_debug = false;  // 디버깅 여부 결정
		const handleSubmit = (e) => {
            e.preventDefault();

            let btid = document.querySelector("#boardTypeId3");
	       	let boardTitleClear = document.querySelector("#boardTitleClear");
	       	let boardContentClear = document.querySelector("#boardContentClear");

	  		let btidvalue = btid.value;
	      	console.log("btidvalue: {}", btidvalue);


            if(g_debug){
               console.log("boardTypeId",$("#boardTypeId3").val());
               console.log("boardTitle",$("#jiinsertModal [name=boardTitle]").val()); // css 선택자
            }

            let contextval = ("boardContent",$("#jiinsertModal [name=boardContent]").val());
//             alert(contextval);
            let boardContent = contextval.replaceAll("\n", "<br>");
               console.log("boardContent:{}",boardContent); // css 선택자

            let formData = new FormData(); // AJAX로 파일 보낼 땐 요거이 필요해
            formData.append("boardTypeId",$("#boardTypeId3").val());
            formData.append("boardTitle",$("#jiinsertModal [name=boardTitle]").val()); // css 선택자
            formData.append("boardContent",boardContent);
            // 여러개 담아어 돌러서

            let fileListDiv = document.querySelector("#fileListDiv");
            let files = $("#jiinsertModal [name=files]")[0].files;
            for(let i=0; i<files.length; i++){
               console.log("file",files[i].name);
               formData.append("files",files[i]);
            }

            $.ajax({
               method:"post",
               url:"/ourmine/company/${companyId}/project/${projectId}/board/boardForm",
               data:formData,
               dataType:"text",
               contentType: false,	// 파일 추가 시 필수. 'application/json'사용 불가
			      processData: false,	// 파일 추가 시 필수
			      cache: false,	// 파일 추가 시 선택사항
			      beforeSend:function(xhr){	// headers에 contentType='application/json'포함되어 있어 따로 적어줘야 함
					   xhr.setRequestHeader(headerName, headerValue);
			      },
               success:function(rdata){
            	    jiinsertClose();
            	    $('#insertjiModal')[0].reset();
	                fgetData(btidvalue);
               },
               error: function (request, status, error) {
                  console.log("code: " + request.status)
                 // console.log("message: " + request.responseText)
                 // console.log("error: " + error);
               }
            })


        }


        boardTypeList2();
        fgetData(${param.typeNumber});


    </script>
