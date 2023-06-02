<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<style>
	/* 그리드 헤더 색상 */
	.ag-theme-alpine {
		--ag-header-background-color: #484c7f;
		--ag-header-foreground-color: #ffffff;
	}

	/* 그리드 내용 가운데 정렬 */
 	.ag-row .ag-cell {
/*  		display: flex; */
/*  		justify-content: center; */
/*  		align-items: center; */
 	}

	.ag-header-cell-text {
 		margin-left: 20px;
 	}
 	
 	#quickFilter {
		width: 25%;
	}
</style>

<!-- ===================================================================================================================================== -->
<!-- 제목 & 추가버튼 -->
<div class="card-header py-3 no-bg bg-transparent d-flex align-items-center px-0 justify-content-between border-bottom flex-wrap">
	<h3 class="fw-bold mb-0">공지게시판</h3>
	<security:authorize access="hasRole('ADMIN')">
	<div class="col-auto d-flex w-sm-100">
		<button type="button" class="btn btn-dark btn-set-task w-sm-100" onclick="inModalOpen()">
			<i class="icofont-plus-circle me-2 fs-6"></i> 글작성
		</button>
	</div>
	</security:authorize>
</div>

<!-- ===================================================================================================================================== -->
<!-- 상세조회 모달 -->
<div class="modal" id="selectModal" >
	<div class="modal-dialog">
		<div class="modal-content card mb-3" id="selectContent">
			<div class="card-header py-3 d-flex justify-content-between bg-transparent border-bottom-0">
				<h6 class="myModal-title mb-0 fw-bold "></h6>
			</div>
			<div class="card-body">
				<div class="row g-3 align-items-center">
					<div class="col-md-12">
						<div class="form-group">
							<label>게시글번호</label>
							<input type="text" id="rnum" name="rnum" class="form-control" disabled>
							<input type="hidden" id="noticeBoardWriteId" name="noticeBoardWriteId" class="form-control">
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label>분류</label>
							<input type="text" id="category" name="category" class="form-control" disabled>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label>작성자</label>
							<input type="text" id="noticeBoardWriter" name="noticeBoardWriter" class="form-control" disabled>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label>작성일자</label>
							<input type="text" id="noticeBoardWriteDate" name="noticeBoardWriteDate" class="form-control" disabled>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label>조회수</label>
							<input type="text" id="noticeBoardCount" name="noticeBoardCount" class="form-control" disabled>
						</div>
					</div>
					<div class="row g-3 mb-3">
						<div class="col">
							<label for="datepickerded" class="form-label">시작기간</label>
							<input type="date" name="startDay" class="startDay form-control" id="datepickerded" disabled>
						</div>
						<div class="col">
							<label for="datepickerded" class="form-label">종료기간</label>
							<input type="date" name="endDay" class="endDay form-control" id="datepickerded" disabled>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label>내용</label><br>
							<textarea id="noticeBoardContent" name="noticeBoardContent" class="form-control" rows="5" cols="30" disabled></textarea>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label>첨부파일</label>
							<div id="files">

							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<security:authorize access="hasRole('ADMIN')">
					<button type="button" class="btn btn-primary" id="modifyBtn">수정</button>
					<button type="button" class="btn btn-primary" id="deleteBtn">삭제</button>
					</security:authorize>
					<button type="button" class="btn btn-secondary" onclick="modalClose()">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- ===================================================================================================================================== -->
<!-- 등록 모달 -->
<form id="insertForm" novalidate enctype="multipart/form-data" method="post"> <!-- novalidate -->
	<div class="modal" id="insertModal" >
		<div class="modal-dialog">
			<div class="modal-content card mb-3" id="insertContent">
				<div class="card-header py-3 d-flex justify-content-between bg-transparent border-bottom-0">
					<h6 class="mb-0 fw-bold ">글등록</h6>
				</div>
				<div class="card-body">
					<security:csrfMetaTags/>
					<div class="row g-3 align-items-center">
						<div class="col-md-12">
							<div class="form-group">
								<label class="form-label">제목</label>
								<input type="text" name="noticeBoardTitle" class="form-control" required>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label class="form-label">분류 [공지 / FNQ]</label>
								<select id="category" name="category" class="form-control" required>
									<option value="공지" selected>공지</option>
									<option value="FNQ">FNQ</option>
								</select>
							</div>
						</div>
						<div class="row g-3 mb-3">
							<div class="col">
								<label for="datepickerded" class="form-label">시작기간</label>
								<input type="date" name="startDay" class="startDay form-control" id="datepickerded">
							</div>
							<div class="col">
								<label for="datepickerded" class="form-label">종료기간</label>
								<input type="date" name="endDay" class="endDay form-control" id="datepickerded">
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label class="form-label">내용</label>
								<textarea class="form-control" name="noticeBoardContent" rows="5" cols="30" required></textarea>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label class="form-label">첨부파일</label>
								<input type="file" name="files" multiple="multiple" class="form-control" >
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">등록</button>
						<button type="button" class="btn btn-secondary" onclick="inModalClose()">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

<!-- ===================================================================================================================================== -->
<!-- 수정 모달 -->
<form id="modifyForm" enctype="multipart/form-data" method="post">
	<div class="modal" id="modifyModal" >
		<div class="modal-dialog">
			<div class="modal-content card mb-3" id="modifyContent">
				<div class="card-body">
					<div class="row g-3 align-items-center">
						<div class="col-md-12">
							<div class="form-group">
								<label>제목</label>
								<input type="text" id="noticeBoardTitle" name="noticeBoardTitle" class="myModal-title form-control">
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label>게시글번호</label>
								<input type="text" id="rnum" name="rnum" class="form-control" readonly>
								<input type="hidden" id="noticeBoardWriteId2" name="noticeBoardWriteId" class="form-control">
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label>분류</label>
								<select id="category" name="category" class="form-control" disabled>
									<option value="공지" selected>공지</option>
									<option value="FNQ">FNQ</option>
								</select>
								<!-- <input type="text" id="category" name="category" class="form-control" readonly> -->
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label>작성자</label>
								<input type="text" id="noticeBoardWriter" name="noticeBoardWriter" class="form-control" readonly>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label>작성일자</label>
								<input type="text" id="noticeBoardWriteDate" name="noticeBoardWriteDate" class="form-control" readonly>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label>조회수</label>
								<input type="text" id="noticeBoardCount" name="noticeBoardCount" class="form-control" readonly>
							</div>
						</div>
						<div class="row g-3 mb-3">
							<div class="col">
								<label for="datepickerded" class="form-label">시작기간</label>
								<input type="date" name="startDay" class="startDay form-control" id="datepickerded">
							</div>
							<div class="col">
								<label for="datepickerded" class="form-label">종료기간</label>
								<input type="date" name="endDay" class="endDay form-control" id="datepickerded">
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label>내용</label><br>
								<textarea id="noticeBoardContent" name="noticeBoardContent" class="form-control" rows="5" cols="30"></textarea>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">등록</button>
						<button type="button" class="btn btn-secondary" onclick="modModalClose()">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

<!-- ===================================================================================================================================== -->
<!-- 검색창 -->
<input type="text" class="form-control"  oninput="onQuickFilterChanged()"  id="quickFilter"   placeholder="검색..."/>
<br>

<!-- ===================================================================================================================================== -->
<!-- ag그리드 크기 -->
<div id="myGrid" style="height: 600px; width: 100%;" class="ag-theme-alpine"></div>

<!-- ===================================================================================================================================== -->
<script type="text/javascript">
	// 검색
	function onQuickFilterChanged() {
		gridOptions.api.setQuickFilter(document.getElementById('quickFilter').value);
	}

    // 모달 열기 / 닫기
	// 조회
	const myModal = document.querySelector("#selectModal");
	let files = document.getElementById('files');
	const add = (a,b) => a + b;

	const noticeBoard = {
		noticeBoardWriteId : '',
	}
	const modalOpen = () => {
		myModal.style.display = "block";    // 보이게

		headers['Content-Type'] = 'application/json'
		headers['accept'] = 'application/json'
		console.log("JSON.stringify(noticeBoard) = ",JSON.stringify(noticeBoard))
		axios.get(`/ourmine/noticeBoard/noticeBoardSelect/\${noticeBoard.noticeBoardWriteId}`, {headers:headers})
				.then(resp => {
					files.innerHTML = '';
					let data = resp.data;
					console.log(data);
					files.innerHTML += data.files.map(item => item.original !== null ?  `<a href="/ourmine/uploadAAA/\${item.uuid}" download="\${item.original}">\${item.original}<a><br>` : `<a></a>`).join('');
				});
	}
	const modalClose = () => {
		myModal.style.display = "none";    // 안보이게
		fgetData();
	}

	// 등록
	const inModal = document.querySelector("#insertModal");
	const inModalClose = () => {
		inModal.style.display = "none";    // 안보이게
    }
	const inModalOpen = () => {
		$('#insertForm')[0].reset();
		inModal.style.display = "block";    // 보이게
    }

	// 수정
	const modModal = document.querySelector("#modifyModal");
	const modModalClose = () => {
		modModal.style.display = "none";    // 안보이게
	}
	const modModalOpen = () => {
		modalClose();
		modModal.style.display = "block";    // 보이게

		$("#modifyContent").find("[name=noticeBoardTitle]").val($(myModal).find(".myModal-title").html());
		$("#modifyContent").find("[name=noticeBoardWriteId]").val($(myModal).find("#noticeBoardWriteId").val());
		$("#modifyContent").find("[name=rnum]").val($(myModal).find("#rnum").val());
		$("#modifyContent").find("[name=category]").val($(myModal).find("#category").val());
		$("#modifyContent").find("[name=noticeBoardWriter]").val($(myModal).find("#noticeBoardWriter").val());
		$("#modifyContent").find("[name=noticeBoardWriteDate]").val($(myModal).find("#noticeBoardWriteDate").val());
		$("#modifyContent").find("[name=noticeBoardCount]").val($(myModal).find("#noticeBoardCount").val());
		$("#modifyContent").find("[name=startDay]").val($(myModal).find(".startDay").val());
		$("#modifyContent").find("[name=endDay]").val($(myModal).find(".endDay").val());
		$("#modifyContent").find("[name=files]").val($(myModal).find(".files").val());
		$("#modifyContent").find("[name=noticeBoardContent]").val($(myModal).find("#noticeBoardContent").html());
// 		console.log("ckk1: "+$(myModal).find("#noticeBoardWriteId").val());
// 		console.log("ckk2: "+$(modModal).find("#noticeBoardWriteId2").val());
    }

//	<!-- ===================================================================================================================================== -->
	// 조회수 증가
    const updateCount = (nboIdData) => {
    	console.log("nboIdData : ", nboIdData);
    	console.log("headers", headers)
    	$.ajax({
			type: 'POST',
			url: '/ourmine/noticeBoard/noticeBoardCnt',
			data: JSON.stringify(nboIdData),
			dataType: 'text',
			headers : headers,
			success: function(res) {
				console.log("확인 : ", res);
			},
			error: function(xhr, status, error) {
		        console.log("error: " + error);
			},
			global: true
		});
    };

//	<!-- ===================================================================================================================================== -->
    // 글삭제
	const delContent = (nboIdData) => {
		$.ajax({
			type: 'POST',
			url: '/ourmine/noticeBoard/noticeBoardDelete',
			data: JSON.stringify(nboIdData),
			headers : headers,
			success: function(res) {
				console.log("확인 : ", res);
				alert('게시글을 삭제하였습니다.');
				modalClose();	// 모달 닫기
				reload();
			},
			error: function(xhr, status, error) {
				alert('게시글 삭제에 실패하였습니다.');
		        console.log("error: " + error);
			}
		});
	}

//	<!-- ===================================================================================================================================== -->
	// 그리드
	const gridDiv = document.querySelector("#myGrid");

    function fgetData () {   // 데이터 가져오는 비동기처리
        // gridOptions.api. 대부분의 유용한 메소드가 여기에 있다
        const xhr = new XMLHttpRequest();
        xhr.open("get","/ourmine/noticeBoard/noticeBoardListJson", true);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log("responseText : ", xhr.responseText);
                gridOptions.rowData = JSON.parse(xhr.responseText);
//                 gridOptions.api.setRowData(JSON.parse(xhr.responseText));	// 덮어쓰는것
				document.getElementById('myGrid').innerHTML="";
                new agGrid.Grid(gridDiv, gridOptions);
            }
        }
        xhr.send();
    }

    // 수정 후 데이타만 덮어쓰깅
	function reload() {
		const xhr = new XMLHttpRequest();
		xhr.open("get", "/ourmine/noticeBoard/noticeBoardListJson", true);
		xhr.onreadystatechange = () => {
			if (xhr.readyState == 4 && xhr.status == 200) {
				gridOptions.api.setRowData(JSON.parse(xhr.responseText)); // 여기가 포인트
			}
		}
		xhr.send();
	}

    const columnDefs = [
        { field: "rnum", headerName: "번호", cellStyle: {textAlign: 'center'}, maxWidth: 100 },
        { field: "category", headerName: "분류", cellStyle: {textAlign: 'center'}, maxWidth: 100 },
        { field: "noticeBoardTitle", headerName: "제목", cellStyle: {textAlign: 'left'}, maxWidth: 300 },
        { field: "noticeBoardWriter", headerName: "작성자", cellStyle: {textAlign: 'center'}, maxWidth: 130 },
        { field: "noticeBoardContent", headerName: "내용", cellStyle: {textAlign: 'left'}, minWidth: 300 },
        { field: "noticeBoardCount", headerName: "조회수", cellStyle: {textAlign: 'center'}, maxWidth: 120 },
        { field: "noticeBoardWriteDate", headerName: "작성일자", cellStyle: {textAlign: 'center'}, maxWidth: 130 }
    ];

    // let the grid know which columns and what data to use
    const gridOptions = {
        defaultColDef: {    // 일일이 컬럼에 정의하지 않고 한번에 기본 옵션 설정!
            sortable: true,
            filter: true,
            resizable: true,
            editable: false
        },
		columnDefs: columnDefs,
        pagination: true,
        paginationAutoPageSize: true,
        onGridReady: function (event) {		// 열 자동 조절 기능
            event.api.sizeColumnsToFit();
        },
        rowSelection: 'single',
        onCellClicked: params => { // example event handler
        	console.log("클릭", params.data);
			noticeBoard.noticeBoardWriteId = params.data.noticeBoardWriteId;
			console.log("noticeBoard.noticeBoardWriteId = params.data.noticeBoardWriteId = ", noticeBoard.noticeBoardWriteId);

        	// DB 조회수 증가
			let nboIdData = params.data.noticeBoardWriteId;
			nboIdData = JSON.stringify(nboIdData);
			updateCount(nboIdData);

			// 화면 조회수 증가
            let noticeBoardVO = params.data;

			count = noticeBoardVO.noticeBoardCount;
			console.log("count1 : ", count);
			cnt = count + 1;
			console.log("count2 : ", cnt);

            $(".myModal-title").html(noticeBoardVO.noticeBoardTitle);
            $("#noticeBoardWriteId").val(noticeBoardVO.noticeBoardWriteId);
            $("#rnum").val(noticeBoardVO.rnum);
    		$("#category").val(noticeBoardVO.category);
            $("#noticeBoardWriter").val(noticeBoardVO.noticeBoardWriter);
            $("#noticeBoardWriteDate").val(noticeBoardVO.noticeBoardWriteDate);
            $("#noticeBoardCount").val(cnt);
            $(".startDay").val(noticeBoardVO.startDay);
            $(".endDay").val(noticeBoardVO.endDay);
            $(".files").val(noticeBoardVO.files);
            $("#noticeBoardContent").html(noticeBoardVO.noticeBoardContent);

            modalOpen();	// 보이게

         	// 삭제버튼 클릭
        	$('#deleteBtn').on('click', function() {
        		delContent(nboIdData);
        	});
        }

    };

//     fgetData(); // 게시판 전체조회 ajax 바로 실행

    // setup the grid after the page has finished loading
    document.addEventListener('DOMContentLoaded', () => {
    	fgetData(); // 가독성을 위해성 , 나중에 꺼내기
    });

//	<!-- ===================================================================================================================================== -->
	$(function() {
		// 글 등록
	    // let data = $('#insertForm').serialize();
		$('#insertForm').submit(function(e) {
	        e.preventDefault();
			console.log("폼체크 : ", $('#insertForm')[0]);

			let jForm = $('#insertForm').serialize();
			console.log("값: ",jForm, headers);

			let formData = new FormData($('#insertForm')[0]);
	      //   let form = this;
			$.ajax({
				type: 'POST',
				url: '/ourmine/noticeBoard/noticeBoardForm',
// 				data: generateSendData('json', form),
				data: formData,
				contentType: false,	// 파일 추가 시 필수. 'application/json'사용 불가
				processData: false,	// 파일 추가 시 필수
				cache: false,	// 파일 추가 시 선택사항
				beforeSend:function(xhr){	// headers에 contentType='application/json'포함되어 있어 따로 적어줘야 함
					xhr.setRequestHeader(headerName, headerValue);
				},
				success: function(res) {
					console.log("확인 : ", res);
					$('#insertModal').hide();
					$('#insertForm')[0].reset();
					fgetData();
				},
				error: function(xhr, status, error) {
					alert('게시글 등록에 실패하였습니다.');
			        console.log("error: " + error);
				}
			});
		});

//	<!-- ===================================================================================================================================== -->
		// 글수정
		$('#modifyBtn').on('click', function() {
			modModalOpen();
		});

		$('#modifyForm').submit(function(e) {
			e.preventDefault();
			console.log("수정 폼체크 : ", $('#modifyForm')[0]);

			let modiForm = $('#modifyForm').serialize();
			console.log("수정 값: ",  modiForm , headers);

			let formData = new FormData($('#modifyForm')[0]);
// 			let form = this;
			$.ajax({
				type: 'POST',
				url: '/ourmine/noticeBoard/noticeBoardUpdate',
				data: formData,
// 				data: generateSendData('json', form),
				dataType: 'text',
// 				headers : headers,
				contentType: false,	// 파일 추가 시 필수. 'application/json'사용 불가
				processData: false,	// 파일 추가 시 필수
				cache: false,	// 파일 추가 시 선택사항
				beforeSend:function(xhr){	// headers에 contentType='application/json'포함되어 있어 따로 적어줘야 함
					xhr.setRequestHeader(headerName, headerValue);
				},
				success: function(res) {
					console.log("확인 : ", res);
					$('#modifyModal').hide();
					reload();
				},
				error: function(xhr, status, error) {
					alert('게시글 수정에 실패하였습니다.');
					console.log("error: " + error);
				}
			});
		});
	});	// function()끝

</script>