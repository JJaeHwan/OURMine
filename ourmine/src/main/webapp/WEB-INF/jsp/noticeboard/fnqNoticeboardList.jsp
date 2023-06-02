<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
	/* 그리드 헤더 색상 */
	.ag-theme-alpine {
		--ag-header-background-color: #484c7f;
		--ag-header-foreground-color: #ffffff;
	}
	
	/* 그리드 내용 가운데 정렬 */
	.ag-row .ag-cell {
/* 		display: flex; */
/* 		justify-content: center; */
/* 		align-items: center; */
		/* 		align-content: center; */
	}
	.ag-header-cell-text {
		margin-left: 50px;
	}
	
	#quickFilter {
		width: 25%;
	}
</style>

<!-- ===================================================================================================================================== -->
<!-- 제목 & 추가버튼 -->
<div class="card-header py-3 no-bg bg-transparent d-flex align-items-center px-0 justify-content-between border-bottom flex-wrap">
	<h3 class="fw-bold mb-0">F&Q게시판</h3>
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
							<input type="text" id="rnum" name="rnum" class="form-control" readonly>
							<input type="hidden" id="noticeBoardWriteId" name="noticeBoardWriteId" class="form-control" readonly>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label>분류</label>
							<input type="text" id="category" name="category" class="form-control" readonly>
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
							<label>내용</label><br>
							<textarea id="noticeBoardContent" name="noticeBoardContent" class="form-control" rows="5" cols="30" readonly></textarea>
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
									<option value="공지">공지</option>
									<option value="FNQ" selected>FNQ</option>
								</select>
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
<!-- 검색창 -->
<input type="text" class="form-control"  oninput="onQuickFilterChanged()"  id="quickFilter"   placeholder="검색..."/>
<br>
	
<!-- ===================================================================================================================================== -->
<!-- ag그리드 크기 -->
<div id="fnqGrid" style="height: 600px; width: 100%;" class="ag-theme-alpine"></div>
	
<!-- ===================================================================================================================================== -->	
<script type="text/javascript">
	//검색
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

//	<!-- ===================================================================================================================================== -->
	// 그리드
	const gridDiv = document.querySelector("#fnqGrid");

    const fgetData = () => {   // 데이터 가져오는 비동기처리 
        // gridOptions.api. 대부분의 유용한 메소드가 여기에 있다
        const xhr = new XMLHttpRequest();
        xhr.open("get","/ourmine/noticeBoard/fnqNoticeBoardListJson", true);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log("responseText : ", xhr.responseText);
                gridOptions.rowData = JSON.parse(xhr.responseText);
					document.getElementById('fnqGrid').innerHTML="";
				new agGrid.Grid(gridDiv, gridOptions);
            }
        }
        xhr.send();
    }

    const columnDefs = [
        { field: "rnum", headerName: "번호", cellStyle: {textAlign: 'center'}, maxWidth: 150 },
        { field: "category", headerName: "분류", cellStyle: {textAlign: 'center'}, maxWidth: 150 },
        { field: "noticeBoardTitle", headerName: "제목", cellStyle: {textAlign: 'left'}, minWidth: 300 },
        { field: "noticeBoardWriter", headerName: "작성자", cellStyle: {textAlign: 'center'}, maxWidth: 180 },
        { field: "noticeBoardWriteDate", headerName: "작성일자", cellStyle: {textAlign: 'center'}, maxWidth: 180 }
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
            
            let noticeBoardVO = params.data;
            $(".myModal-title").html(noticeBoardVO.noticeBoardTitle);
            $("#noticeBoardWriteId").val(noticeBoardVO.noticeBoardWriteId);
            $("#rnum").val(noticeBoardVO.rnum);
    		$("#category").val(noticeBoardVO.category);
            $("#noticeBoardWriter").val(noticeBoardVO.noticeBoardWriter);
            $("#noticeBoardWriteDate").val(noticeBoardVO.noticeBoardWriteDate);
            $("#noticeBoardContent").html(noticeBoardVO.noticeBoardContent);
            $(".files").val(noticeBoardVO.files);
			
            modalOpen();	// 보이게
            
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
		$('#insertForm').submit(function(e) {
	        e.preventDefault();
			console.log("폼체크 : ", $('#insertForm')[0]);

			let jForm = $('#insertForm').serialize();
			console.log("값: ",jForm, headers);

			let formData = new FormData($('#insertForm')[0]);
			$.ajax({
				type: 'POST',
				url: '/ourmine/noticeBoard/noticeBoardForm',
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
	});
	
</script>