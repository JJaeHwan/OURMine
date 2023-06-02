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
/*  		display: flex; */
/*  		justify-content: center; */
/*  		align-items: center; */
 	}

	.ag-header-cell-text {
 		margin-left: 20px;
 	}

 	.center-align-header {
	  text-align: center;
	}

	#quickFilter{
		width: 80%;
	}
	#fdiv{
		margin-right: 20%;
	}

</style>



<!-- ag그리드 크기 -->
<div id="mytask-layout" class="theme-indigo">

    <!-- main body area -->
    <div class="main px-lg-4 px-md-4">

        <!-- Body: Body -->
        <div class="body d-flex py-3">
            <div class="container-xxl">
                <div class="row align-items-center">
                    <div class="border-0 mb-4" >
                        <div id="fdiv" class="card-header py-3 no-bg bg-transparent d-flex align-items-center px-0 justify-content-between border-bottom flex-wrap">
                            <h3 class="fw-bold mb-0">파일함</h3>
                            <div class="col-auto d-flex w-sm-100">
								<button type="button" id="fdownloadBtn" class="btn btn-dark btn-set-task w-sm-100" data-bs-toggle="modal" data-bs-target="#pwInsertModal">
									다운로드 <i class="icofont-plus-circle me-2 fs-6"></i>
								</button>
							</div>
                        </div>
                    </div>
                </div> <!-- Row end  -->
                <div class="row mb-3">
                    <div class="col-12">
                            <input type="text" class="form-control" oninput="onQuickFilterChanged()" id="quickFilter" placeholder="파일명을 입력해주세요" />
							<div id="fileGrid" style="height: 600px; width: 80%;" class="ag-theme-alpine"></div>
                    </div>
                </div> <!-- Row end  -->
            </div>
        </div>

    </div>

</div>



<input id="companyIdHidden" type="hidden" value="${companyId }">

<security:authentication property="principal" var="principal"/>
<c:forEach items="${principal.realUser.proAttendRole }" var="roleList">
    <c:set var="companyId" value="${roleList.companyId }"/>
</c:forEach>


<script>
//<!-- ===================================================================================================================================== -->
	let companyIdHidden = document.querySelector('#companyIdHidden');
	let companyIdHiddenValue = companyIdHidden.value;
	console.log("companyIdHiddenValue:",companyIdHiddenValue)

function onQuickFilterChanged() {

    gridOptions.api.setQuickFilter(document.getElementById('quickFilter').value);
}


// 그리드
const gridDiv = document.querySelector("#fileGrid");

function fgetData (companyId) {   // 데이터 가져오는 비동기처리
	const xhr = new XMLHttpRequest();
	xhr.open("get",`/ourmine/company/${companyId}/file/fileListJson/`, true);
	xhr.onreadystatechange = () => {
		if (xhr.readyState == 4 && xhr.status == 200) {
			console.log("responseText : ", xhr.responseText);
			gridOptions.rowData = JSON.parse(xhr.responseText);
			document.getElementById('fileGrid').innerHTML = "";
			new agGrid.Grid(gridDiv, gridOptions);
		}
	}
	xhr.send();
}

const columnDefs = [
	{ headerCheckboxSelection: true, checkboxSelection: true, cellStyle: {textAlign: 'center'},headerClass: 'center-align-header',maxWidth: 50},
	{ field: "boardFileId", headerName: "번호", cellStyle: {textAlign: 'center'},headerClass: 'center-align-header',maxWidth: 100},
	{ field: "originalFileName", headerName: "제목", cellStyle: {textAlign: 'center'},headerClass: 'center-align-header', maxWidth: 950},
	{ field: "boardWriter", headerName: "등록자", cellStyle: {textAlign: 'center'},headerClass: 'center-align-header', maxWidth: 150},
	{ field: "fileCreateDate", headerName: "등록일", cellStyle: {textAlign: 'center'},headerClass: 'center-align-header', maxWidth: 250}
];

const gridOptions = {
	defaultColDef: {
		sortable: true,
		filter: true,
		resizable: true,
		editable: false
	},
	columnDefs: columnDefs,
	pagination: true,
	paginationAutoPageSize: true,
	headerClass: 'center-align-header',
	getRowHeight: function(params) {
		return 45;
	},
	onGridReady: function (event) {
		event.api.sizeColumnsToFit();
	},
	rowSelection: 'multiple'
};

function handleDownload() {
	const selectedRows = gridOptions.api.getSelectedRows();

	selectedRows.forEach(row => {
		let link = document.createElement('a');
		link.href = `/ourmine/uploadAAA/\${row.saveFileName}`;
		link.download = `\${row.originalFileName}`;
		document.body.appendChild(link);
		link.click();
		document.body.removeChild(link);
	});
}

let fdownloadBtn = document.getElementById('fdownloadBtn');
fdownloadBtn.addEventListener('click', handleDownload);

let companyId = ${companyId};
console.log("companyId@@@@@@@@", companyId);
fgetData(companyId);


// 그리드 안에 버튼 추가
/* function buttonCellRenderer(params) {
    return `<input type="button" class="btn btn-outline-primary" value="Click" onclick="buttonClicked(${params.node.data.id})"/>`;
}

function buttonClicked(id) {
    // Handle button click event here
    console.log('Button clicked for ID:', id);
} */

</script>