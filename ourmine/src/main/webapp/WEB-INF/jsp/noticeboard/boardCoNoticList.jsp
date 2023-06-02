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
	--ag-header-background-color: #484c7f;
	--ag-header-foreground-color: #ffffff;
}

/* 그리드 내용 가운데 정렬 */
.ag-row .ag-cell {
	display: flex;
	justify-content: center; /* align horizontal */
	align-items: center;
	/* 		align-content: center; */
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

#jiContent {
   margin: 15% auto;
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
#boardContent{
	height: 250px;
}
#quickFilter{
	width: 25%;
}
</style>
   <!-- Modal -->
   <div id="jiModal2">
      <div id="jiContent2">
         <div class="modal-dialog">
         <form name="jiModifyForm" id="jiModifyForm" enctype="multipart/form-data">
            <div class="modal-header">
            </div>

            <div class="modal-content">
               제목 :<input name="boardTitle" class="form-control" required></input>

               글번호	: <input name="boardId" class="form-control" readonly required></input>

               <hr>
               내용 :<textarea name="boardContent" class="form-control" required></textarea>
            </div>
         </form>
         </div>
         <div class="modal-footer">


            <button type="button" class="btn btn-primary" onclick="jiModify()">적용</button>
            <button type="button" class="btn btn-secondary" onclick="jiClose2()">닫기</button>
         </div>
      </div>
   </div>

   <!-- Button trigger modal -->
   <div class="col-auto">
      <div
         class="card-header py-3 no-bg bg-transparent d-flex align-items-center px-0 justify-content-between border-bottom flex-wrap">
         <h3 class="fw-bold mb-0">사내공지 게시판</h3>
         <div class="col-auto d-flex w-sm-100">
         <security:authorize access="hasRole('MANAGER')">
            <button type="button" class="btn btn-dark btn-set-task w-sm-100 m-1"
               id="boardAddBtn" data-bs-toggle="modal"
               data-bs-target="#jiinsertModal">
               <i class="icofont-plus-circle me-2 fs-6"></i> 글추가
            </button>
         </security:authorize>
         </div>
      </div>
   </div>

   <!-- Modal Modal Center-->
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
               <form action="" method="post">
                  <!-- 아이디, 비밀번호, 이름, 입력받기 -->
                  게시판 이름<br> <input type="text" name="boardType"><br>
                  <hr>
                  <div class="modal-footer">
                     <button type="submit" class="btn btn-primary">전송</button>
                     <button type="button" class="btn btn-secondary"
                        data-bs-dismiss="modal">Close</button>
                  </div>
               </form>
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
                  <form onsubmit="handleSubmit(event)" novalidate="novalidate">
                     <security:csrfInput />
                     <div class="row g-3 align-items-center">
                     <br>
                        <div class="col-md-12">
                           <span id="fail"></span>
                           <div class="form-group">
                              <label class="form-label">제목</label> <input type="text"
                                 name="boardTitle" onchange="handleChange(event)"
                                 class="form-control" required>
                           </div>
                        </div>
                        <div class="col-md-12">
                           <div class="form-group">
                              <label class="form-label">내용</label>
                              <textarea class="form-control" name="boardContent"
                                 onchange="handleChange(event)" rows="5" cols="30" required></textarea>
                           </div>
                        </div>
                     </div>
                     <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">등록</button>
                        <button type="button" class="btn btn-secondary" onclick="jiinsertClose()">닫기</button>
                     </div>
                  </form>
               </div>
            </div>
         </div>
      </div>
   </div>
<!-- ===================================================================================================================================== -->
<!-- 상세조회 모달 -->
<div class="modal" id="coNoSelectModal" >
	<div class="modal-dialog">
		<div class="modal-content card mb-3" id="selectContent">
			<div class="card-header py-3 d-flex justify-content-between bg-transparent border-bottom-0">
				<h6 class="myModal-title mb-0 fw-bold "></h6>
			</div>
			<div class="card-body">
				<div class="row g-3 align-items-center">
					<div class="col-md-12">
						<div class="form-group">
							<label>글제목</label>
							<input type="text" id="boardTitle" name="boardTitle" class="form-control" disabled>
							<input type="hidden" id="noticeBoardWriteId" name="noticeBoardWriteId" class="form-control">
						</div>
					</div>
						<div class="form-group">
							<label>게시글번호</label>
							<input type="text" id="boardId" name="boardId" class="form-control" disabled>
							<input type="hidden" id="noticeBoardWriteId" name="noticeBoardWriteId" class="form-control">
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label>분류</label>
							<input type="text" id="category" name="category" class="form-control" value="사내공지" disabled>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label>작성자</label>
							<input type="text" id="boardWriter" name="boardWriter" class="form-control" disabled>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label>작성일자</label>
							<input type="text" id="boardWriteDate" name="boardWriteDate" class="form-control" disabled>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label>조회수</label>
							<input type="text" id="boardCount" name="boardCount" class="form-control" disabled>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label>내용</label><br>
							<textarea id="boardContent" name="boardContent" class="form-control" rows="5" cols="30" disabled></textarea>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label>첨부파일</label>
							<div id="files">

							</div>
                            <span id="files2"></span>
						</div>
					</div>
				</div>

				<div class="modal-footer">
					<security:authorize access="hasRole('MANAGER')">
						<button type="button" class="btn btn-primary" onclick="openJiModal2()">수정</button>
						<button type="button" class="btn btn-primary" id="JIDelete">삭제</button>
					</security:authorize>
					<button type="button" class="btn btn-secondary" onclick="coNoSeModalClose()">닫기</button>

				</div>
			</div>
		</div>
	</div>
	<br><br>

	<input type="text" class="form-control"  oninput="onQuickFilterChanged()"  id="quickFilter"   placeholder="검색..."/>
	<br>
	<div id="myGrid" style="height: 600px; width: 100%;" class="ag-theme-alpine"></div>


   <script>
        //스프링 security CSRF를  설정하면 아래 토큰 값을 get이외의 방식에는 전송해야 한당
          function onQuickFilterChanged() {

            gridOptions.api.setQuickFilter(document.getElementById('quickFilter').value);

          }

	    const header = '${_csrf.headerName}';
  		const token =  '${_csrf.token}';

        let fail   = document.querySelector("#fail");

        const JIModal = document.querySelector("#jiModal");

        const JIModal2 = document.querySelector("#jiModal2");

        const JIInsModal = document.querySelector("#jiinsertModal");

    	const coNoSelectModal = document.querySelector("#coNoSelectModal");

        const jiClose = () =>{
            JIModal.style.display="none"; // 안 보이겡
            location.href=location.href;
        }
        const jiClose2 = () =>{
            JIModal2.style.display="none"; // 안 보이겡
        }
    	const coNoSeModalOpen = () => {
    		coNoSelectModal.style.display = "block";
    	}
    	const coNoSeModalClose = () => {
    		coNoSelectModal.style.display = "none";    // 안보이게
    		fgetData();
    	}

		// 수정 모달
        const openJiModal2 = () =>{
           JIModal2.style.display="block";

         $("#jiContent2").find("[name=boardTitle]").val( $(coNoSelectModal).find("#boardTitle").val() );
         $("#jiContent2").find("[name=boardId]").val( $(coNoSelectModal).find("#boardId").val() );
         $("#jiContent2").find("[name=boardContent]").val( $(coNoSelectModal).find("#boardContent").val() );

        }


		let modiformdata = function(contentType, form){
   		let data = {};
   		$('#jiModifyForm').find(":input[name]").each(function(index, input){
   			let propertyName = this.name;
   			let propertyValue = $(this).val();
   			data[propertyName] = propertyValue;
   		});
   		if(contentType.indexOf("json") >= 0)
   			data = JSON.stringify(data);	// marshalling
   		console.log(data);
   		return data;
   		}

        const jiModify = (e) =>{
        	console.log("체킁2: {}","체킁2");

//     			e.preventDefault();
    			let form = this;

            $.ajax({
                url : '/ourmine/boardCoNotice/boardCoNoticView',
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
                    coNoSeModalClose();
                    location.href=location.href;
                },
                error : function(xhr){
                    alert("상태 : ", "실패");
                }

            });


        }



        const jiinsertClose = () =>{
           $('#jiinsertModal').modal('hide'); // 안 보이겡
        }

        // 삭제모달
        const jiDelete = (boIdData) => {
           console.log("boardId : {}", boIdData )
                 $.ajax({
                     url : '/ourmine/boardCoNotice/boardCoNoticDelete',
                     data : JSON.stringify(boIdData),   // data : {"bonum" : reply.bonum},
                     contentType : "application/json;charset=utf-8",
                     type : 'post',
                     dataType : 'json',  //   받아온 값에 JSON.parse
                     beforeSend : function(xhr){  // 헤더에 값 세팅, 항상 요따구로 씀
                         xhr.setRequestHeader(header, token);
                     },
                     success : function(res){
                         console.log("check: ", res);
                         coNoSeModalClose();
                         location.href=location.href;
                     },
                     error : function(xhr){
//                          alert("상태 : " + xhr.status);
                     }

                });
        }

        const boardHitUpdate = (boardIdParam) =>{
        	console.log("boardIdParam:{}",boardIdParam)
            $.ajax({
                url : '/ourmine/boardCoNotice/boardCoNoHitUpdate',
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



        const gridDiv = document.querySelector("#myGrid");

                const fgetData = () => {   // 데이터 가져오는 비동기처리
                    // gridOptions.api. 대부분의 유용한 메소드가 여기에 있다
                    const xhr = new XMLHttpRequest();
                    xhr.open("GET","/ourmine/boardCoNotice/boardCoNoticListJson", true);
                    xhr.onreadystatechange = () => {
                        if (xhr.readyState == 4 && xhr.status == 200) {
//                             console.log(JSON.parse(xhr.responseText));
                            console.log("responseText : ", xhr.responseText);
                            gridOptions.rowData = JSON.parse(xhr.responseText);
                            //gridOptions.api.setRowData(JSON.parse(xhr.responseText));
                            document.getElementById('myGrid').innerHTML="";
                            new agGrid.Grid(gridDiv, gridOptions);

                        }
                    }
                    xhr.send();
                }

                const columnDefs = [
                    { field: "boardId", headerName: "게시글번호" , cellStyle: {textAlign: 'center'}, maxWidth: 190 },
                    { field: "boardWriter", headerName: "작성자" , cellStyle: {textAlign: 'center'}, maxWidth: 200 },
                    { field: "boardTitle", headerName: "제목" , cellStyle: {textAlign: 'left'}, minWidth: 200 },
                    { field: "boardCount", headerName: "조회수" , cellStyle: {textAlign: 'center'}, maxWidth: 200 },
                    { field: "boardWriteDate", headerName: "작성일자" , cellStyle: {textAlign: 'center'}, maxWidth: 200 },
                    { field: "boardModifyDate", headerName: "수정일자" , cellStyle: {textAlign: 'center'}, maxWidth: 200 }
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
                        console.log('cell was clicked', params.data);
	                    let files2 = document.querySelector('#files2');

                        let boardIdParam = params.data.boardId;
	                    axios.get(`/ourmine/boardCoNotice/boardCoFile/\${boardIdParam}`, {headers:headers})
		                    .then(resp => {
			                    files2.innerHTML = '';
			                    console.log("resp.data =" ,resp.data);
			                    let axiosData = resp.data;
			                    console.log("엑시오스 데이터",axiosData);
			                    files2.innerHTML += axiosData.files.map(item => item.original !== null ?  `<a href="/ourmine/uploadAAA/\${item.uuid}" download="\${item.original}">\${item.original}<a><br>` : `<a>파일없음</a>`).join('');
		                    });

	                    boardIdParam = JSON.stringify(boardIdParam);
                    	boardHitUpdate(boardIdParam);

                    	let boardVO = params.data;
                    	boNo = (boardVO.boardCount);
                    	console.log("boNo1",boNo)

                    	boNo = boNo + 1 ;
                    	console.log("boNo2",boNo)

                        $("#boardTitle").val(boardVO.boardTitle);
                        $("#boardId").val(boardVO.boardId);
                        $("#boardWriter").val(boardVO.boardWriter);
                        $("#boardWriteDate").val(boardVO.boardWriteDate);
                        $("#boardCount").val(boNo);
                        $("#boardContent").val(boardVO.boardContent);

                        coNoSelectModal.style.display="block";

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

//         fgetData();  // 요기 있는게 그리 좋진 않지만, 가독성을 위해성 , 나중에 꺼내깅
        document.addEventListener('DOMContentLoaded', () => {
        });

        const board  = {
              boardTitle : '',
              boardContent : ''
        }

        const handleChange = (e) => {
           const {name,value} = e.target;
           add(name,value);
        }


        const add = (name,value) => {
           board[name] = value;
           console.log(name,value)
           console.log(board)
        }


        const handleSubmit = (e) => {

            e.preventDefault();
            fetch('/ourmine/boardCoNotice/boardCoNoticForm',{
                method : 'POST',
                headers : headers,
                body : JSON.stringify(board)
            }).then(resp => resp.json())
            .then(data => {
               console.log(data);
               if(data > 0){
                  jiinsertClose();
                  fgetData();
                  formReset();
               }else{
                  fail.innerHTML = '실패^^'
                  fail.style.color = 'red';
               }
            })

        }
        const formReset = () =>{
            $('form').each(function() {
                this.reset();
            });
        }

        fgetData();




    </script>
