<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<head>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.63.1/codemirror.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.63.1/codemirror.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.63.1/mode/javascript/javascript.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.63.1/mode/python/python.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.63.1/mode/htmlmixed/htmlmixed.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.63.1/mode/clike/clike.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.63.1/mode/php/php.min.js"></script>
</head>
    	
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
 	#editor-container {
            width: 1200px;
            height: 300px;
        }
</style>
<!-- ===================================================================================================================================== -->
<!-- 제목 & 추가버튼 -->
<div class="card-header py-3 no-bg bg-transparent d-flex align-items-center px-0 justify-content-between border-bottom flex-wrap">
	<h3 class="fw-bold mb-0">코드게시판</h3>
	<div class="col-auto d-flex w-sm-100">
		<button type="button" class="btn btn-dark btn-set-task w-sm-100" onclick="inModalOpen()">
			<i class="icofont-plus-circle me-2 fs-6"></i> 코드작성
		</button>
	</div>
</div>

<!-- ===================================================================================================================================== -->
<!-- 상세조회 모달 -->
<div class="modal" id="selectCodeModal" >
	<div class="modal-dialog">
		<div class="modal-content card mb-3" id="selectContent">
			<div class="card-header py-3 d-flex justify-content-between bg-transparent border-bottom-0">
				<h6 class="insertCodeForm-title mb-0 fw-bold "></h6>
			</div>
			<div class="card-body">
				<div class="row g-3 align-items-center">
					<div class="col-md-12">
						<div class="form-group">
							<label>코드번호</label>
							<input type="text" id="rnum" name="rnum" class="form-control" disabled>
							<input type="hidden" id="codewallId" name="codewallId" class="form-control">
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label>작성자</label>
							<input type="text" id="codeWallWriter" name="codeWallWriter" class="form-control" disabled>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label>언어</label>
							<input type="text" id="codeLanguage" name="codeLanguage" class="form-control" disabled>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label>작성일자</label>
							<input type="text" id="codewallWriteDate" name="codewallWriteDate" class="form-control" disabled>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label>내용</label><br>
							<textarea id="codeContent" name="codeContent" class="form-control code-textarea" rows="5" cols="30" disabled></textarea>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="modifyBtn">수정</button>
					<button type="button" class="btn btn-primary" id="deleteBtn">삭제</button>
					<button type="button" class="btn btn-secondary" onclick="modalClose()">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- ===================================================================================================================================== -->
<!-- 등록 모달 -->
<form id="insertCodeForm" novalidate method="post"> <!-- novalidate -->
	<div class="modal" id="insertModal" >
		<div class="modal-dialog modal-xl">
			<div class="modal-content card mb-3" id="insertContent">
				<div class="card-header py-3 d-flex justify-content-between bg-transparent border-bottom-0">
					<h6 class="mb-0 fw-bold ">코드 등록</h6>
				</div>
				<div class="card-body">
					<security:csrfMetaTags/>
					<div class="row g-3 align-items-center">
						<div class="col-md-12">
							<div class="form-group">
								<label class="form-label">제목</label>
								<input type="text" name="codeTitle" class="form-control" id="insertCodeTitle" required>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label class="form-label">분류 </label>
								<select id="insertLanguageChoice" name="languageChoice" class="form-control" required onchange = "changeLanguage()">
							        <option value="4" active>Java</option>
							        <option value="5">Python</option>
							        <option value="1">C#</option>
							        <option value="8" >PHP</option>
							        <option value="17">JavaScript</option>
							        <option value="25">Node.js</option>
							        <option value="28" >C++ (vc++)</option>
							        <option value="37">Swift</option>
							    </select>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label class="form-label">내용</label>
								<div id="insertEditorContainer"></div>
														
<!-- 								<textarea class="form-control code-textarea" id="insertCodeContent" name="codeContent" rows="5" cols="30" required></textarea> -->
							</div>
						</div>
					    <div id="resultContainer" style="display: none;">
					        <h3>Result:</h3>
					        <pre id="result"></pre>
					    </div>
					    <br>
					    <div id="errorsContainer" style="display: none;">
					        <h3>Errors:</h3>
					        <pre id="errors"></pre>
					    </div>
					    <br>
					    <div id="warningsContainer" style="display: none;">
					        <h3>Warnings:</h3>
					        <pre id="warnings"></pre>
					    </div>
					    <br>
					    <div id="statsContainer" style="display: none;">
					        <h3>Stats:</h3>
					        <pre id="stats"></pre>
					    </div>
					    <br>
					    <div id="filesContainer" style="display: none;">
					        <h3>Files:</h3>
					        <pre id="files"></pre>
					    </div>
					</div>
					<div class="modal-footer">
						<button id="insertExecuteBtn" class="btn btn-primary">컴파일</button>
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
<form id="modifyCodeForm" method="post">
	<div class="modal" id="updateCodeModal" >
		<div class="modal-dialog modal-xl">
			<div class="modal-content card mb-3" id="updateCodeContent">
				<div class="card-body">
					<div class="row g-3 align-items-center">
						<div class="col-md-12">
							<div class="form-group">
								<label>코드번호</label>
								<input type="text" id="rnum" name="rnum" class="form-control" disabled>
								<input type="hidden" id="updateCodewallId" name="codewallId" class="form-control">
							</div>
							<div class="form-group">
								<label>제목</label>
								<input type="text" id="updateCodeTitle" name="codeTitle" class="myModal-title form-control">
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label>분류</label>
								<select id="updateLanguageChoice" name="languageChoice2" class="form-control" required diabled>
									<option value="4" active>Java</option>
							        <option value="5">Python</option>
							        <option value="1">C#</option>
							        <option value="8" >PHP</option>
							        <option value="17">JavaScript</option>
							        <option value="25">Node.js</option>
							        <option value="28" >C++ (vc++)</option>
							        <option value="37">Swift</option>
								</select>
								<!-- <input type="text" id="category" name="category" class="form-control" readonly> -->
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label>내용</label><br>
								<div id="updateEditorContainer"></div>
<!-- 								<textarea id="updateCodeContent" name="codeContent" class="form-control code-textarea" rows="5" cols="30"></textarea> -->
							</div>
						</div>
					</div>
					<div id="resultContainer2" style="display: none;">
					        <h3>Result:</h3>
					        <pre id="result2"></pre>
				    </div>
				    <br>
				    <div id="errorsContainer2" style="display: none;">
				        <h3>Errors:</h3>
				        <pre id="errors2"></pre>
				    </div>
				    <br>
				    <div id="warningsContainer2" style="display: none;">
				        <h3>Warnings:</h3>
				        <pre id="warnings2"></pre>
				    </div>
				    <br>
				    <div id="statsContainer2" style="display: none;">
				        <h3>Stats:</h3>
				        <pre id="stats2"></pre>
				    </div>
				    <br>
				    <div id="filesContainer2" style="display: none;">
				        <h3>Files:</h3>
				        <pre id="files2"></pre>
				    </div>
					</div>
					<div class="modal-footer">
						<button id="updateExecuteBtn" class="btn btn-primary">컴파일</button>
						<button type="submit" class="btn btn-primary">등록</button>
						<button type="button" class="btn btn-secondary" onclick="modModalClose()">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

<!-- ===================================================================================================================================== -->
<!-- ag그리드 크기 -->
<div id="myCodeGird" style="height: 600px; width: 100%;" class="ag-theme-alpine"></div>

<!-- ===================================================================================================================================== -->
<script type="text/javascript">
    // 모달 열기 / 닫기
	var editor;
	var modifyEditor;
	var header = $("meta[name='_csrf_header']").prop('content');
    var token = $("meta[name='_csrf']").prop('content');
    
	$(document).ready(function() {
		var defaultLanguage = "java";
        initializeEditor(defaultLanguage);
        
        $("#insertExecuteBtn").click(function(e) {
        	e.preventDefault();
            executeCode();
        });

        $("#updateExecuteBtn").click(function(e) {
        	e.preventDefault();
            updateExecuteCode();
        });

        changeLanguage();
	});
    
	function updateExecuteCode() {
        // 사용자가 선택한 언어와 작성한 코드 가져오기
        var languageChoice = $("select[name=languageChoice2]").val();
        var code = modifyEditor.getValue();
        console.log("code : ", code);
        console.log("data={}", JSON.stringify({
            languageChoice: languageChoice,
            code: code
        }))
        let url = "/ourmine/company/${companyId}/project/${projectId}/codeEditor/excuteCode";
		console.log("url : ", url);
//         let apiKey = "{apiKey}";
        // API 호출 및 결과 처리
        $.ajax({
            type: "POST",
            dataType : "json",
			contentType: "application/json; charset=utf-8",
            url: url,

            data: JSON.stringify({
                languageChoice: languageChoice,
                code: code
            }),
            beforeSend: function(xhr){
                xhr.setRequestHeader(header, token);
            },
            success: function(response) {
                // 컴파일 결과를 화면에 출력
                console.log("response : ", response);
                if (response.Result !== null && response.Result !== undefined) {
                    $("#resultContainer2").show();
                    $("#result2").html(response.Result);
                } else {
                    $("#resultContainer2").hide();
                    $("#result2").html("");
                }
                if (response.Errors !== null && response.Errors !== undefined) {
                    $("#errorsContainer2").show();
                    $("#errors2").text(response.Errors);
                } else {
                    $("#errorsContainer2").hide();
                    $("#errors2").text("");
                }
                if (response.Warnings !== null && response.Warnings !== undefined) {
                    $("#warningsContainer2").show();
                    $("#warnings2").text(response.Warnings);
                } else {
                    $("#warningsContainer2").hide();
                    $("#warnings2").text("");
                }
                if (response.Stats !== null && response.Stats !== undefined) {
                    $("#statsContainer2").show();
                    $("#stats2").text(response.Stats);
                } else {
                    $("#statsContainer2").hide();
                    $("#stats2").text("");
                }
                if (response.Files !== null && response.Files !== undefined) {
                    $("#filesContainer2").show();
                    $("#files2").text(response.Files);
                } else {
                    $("#filesContainer2").hide();
                    $("#files2").text("");
                }
            },
            error: function(xhr, status, error) {
            	console.log("xhr : ", xhr);
            	console.log("status: ", status);
                console.log("Error: ", error);
            }
        });
    }
	
	function executeCode() {
        // 사용자가 선택한 언어와 작성한 코드 가져오기
        var languageChoice = $("select[name=languageChoice]").val();
        var code = editor.getValue();
        console.log("code : ", code);
        console.log("data={}", JSON.stringify({
            languageChoice: languageChoice,
            code: code
        }))
        let url = "/ourmine/company/${companyId}/project/${projectId}/codeEditor/excuteCode";
		console.log("url : ", url);
//         let apiKey = "{apiKey}";
        // API 호출 및 결과 처리
        $.ajax({
            type: "POST",
            dataType : "json",
			contentType: "application/json; charset=utf-8",
            url: url,

            data: JSON.stringify({
                languageChoice: languageChoice,
                code: code
            }),
            beforeSend: function(xhr){
                xhr.setRequestHeader(header, token);
            },
            success: function(response) {
                // 컴파일 결과를 화면에 출력
                console.log("response : ", response);
                if (response.Result !== null && response.Result !== undefined) {
                    $("#resultContainer").show();
                    $("#result").html(response.Result);
                } else {
                    $("#resultContainer").hide();
                    $("#result").html("");
                }
                if (response.Errors !== null && response.Errors !== undefined) {
                    $("#errorsContainer").show();
                    $("#errors").text(response.Errors);
                } else {
                    $("#errorsContainer").hide();
                    $("#errors").text("");
                }
                if (response.Warnings !== null && response.Warnings !== undefined) {
                    $("#warningsContainer").show();
                    $("#warnings").text(response.Warnings);
                } else {
                    $("#warningsContainer").hide();
                    $("#warnings").text("");
                }
                if (response.Stats !== null && response.Stats !== undefined) {
                    $("#statsContainer").show();
                    $("#stats").text(response.Stats);
                } else {
                    $("#statsContainer").hide();
                    $("#stats").text("");
                }
                if (response.Files !== null && response.Files !== undefined) {
                    $("#filesContainer").show();
                    $("#files").text(response.Files);
                } else {
                    $("#filesContainer").hide();
                    $("#files").text("");
                }
            },
            error: function(xhr, status, error) {
            	console.log("xhr : ", xhr);
            	console.log("status: ", status);
                console.log("Error: ", error);
            }
        });
    }
	
	function initializeEditor(language) {
        // 기존의 에디터 삭제
        if (editor) {
            editor.toTextArea();
        }
    
        var insertEditorContainer = document.getElementById("insertEditorContainer");
        var updateEditorContainer = document.getElementById("updateEditorContainer");
        editor = CodeMirror(insertEditorContainer, {
            lineNumbers: true,
            mode: language,
        });
        modifyEditor = CodeMirror(updateEditorContainer, {
            lineNumbers: true,
            mode: language,
        });
   	 }    
    
	function changeLanguage(){
		var languageChoice = document.getElementById("insertLanguageChoice");
        var selectedOption = languageChoice.options[languageChoice.selectedIndex];

        var selectedValue = selectedOption.value;

        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                var response = xhr.responseText;
                editor.setValue(response);
                editor.setOption("mode", selectedValue);
//                 document.getElementById("code").value = response;
            } else {
                console.error("Error: " + xhr.status);
            }
            }
        };

        xhr.open("GET", "/ourmine/company/${companyId}/project/${projectId}/codeEditor/getExampleCode?language=" + selectedValue, true);
        xhr.send();
    }
	
	// 조회
	const myCodeModal = document.querySelector("#selectCodeModal");
	const add = (a,b) => a + b;

	const codeWall = {
		codewallId : '',
	}
	const modalOpen = () => {
		myCodeModal.style.display = "block";    // 보이게

		headers['Content-Type'] = 'application/json'
		headers['accept'] = 'application/json'
// 		console.log("JSON.stringify(noticeBoard) = ",JSON.stringify(noticeBoard))
		axios.get(`/ourmine/company/${companyId}/project/${projectId}/codeWall/article?codewallId=\${codeWall.codewallId}`, {headers:headers})
		.then(response => {
            const data = response.data; // Assuming the response contains the retrieved data
            // Update the textarea value with the retrieved code content
//             codeContentEditor.setValue(data.codeContent);
            // Show the modal
            myCodeModal.style.display = "block";
        })
        .catch(error => {
            console.log(error);
        });
	}
	const modalClose = () => {
		myCodeModal.style.display = "none";    // 안보이게
		getCodeData();
	}

	// 등록
	const inModal = document.querySelector("#insertModal");
	const inModalClose = () => {
		inModal.style.display = "none";    // 안보이게
    }
	const inModalOpen = () => {
		$('#insertCodeForm')[0].reset();
		inModal.style.display = "block";    // 보이게
    }

	// 수정
	const modModal = document.querySelector("#updateCodeModal");
	const modModalClose = () => {
		modModal.style.display = "none";    // 안보이게
	}
	const modModalOpen = () => {
		modalClose();
		modModal.style.display = "block";    // 보이게

		$("#updateCodeContent").find("[name=codeTitle]").val($(myCodeModal).find(".myModal-title").html());
		$("#updateCodeContent").find("[name=codewallId]").val($(myCodeModal).find("#codewallId").val());
		$("#updateCodeContent").find("[name=rnum]").val($(myCodeModal).find("#rnum").val());
// 		$("#modifyContent").find("[name=languageChoice]").val($(myCodeModal).find("#codeLanguage").val()).prop("selected", true);

		var selectedLanguage = $(myCodeModal).find("#codeLanguage").val();
		
		var targetVal= $("#updateCodeContent option:contains(" + selectedLanguage + ")").val();
		
// 		var queryModalSelectBox = 
		$("#updateCodeContent").find("[name=languageChoice2]").val(targetVal);	
// 		queryModalSelectBox.find("option").each(function() {
// 		  if ($(this).text() == selectedLanguage) {
// 		    $(this).prop("selected", true);
// 		    return false; // 해당 옵션을 찾으면 반복문을 종료합니다.
// 		  }
// 		});
		
		$("#updateCodeContent").find("[name=codeWallWriter]").val($(myCodeModal).find("#codeWallWriter").val());
		$("#updateCodeContent").find("[name=codewallWriteDate]").val($(myCodeModal).find("#codewallWriteDate").val());
		modifyEditor.setValue($(myCodeModal).find("#codeContent").val());
		console.log("codeContent : ", $(myCodeModal).find("#codeContent").val())
// 		console.log("ckk1: "+$(myCodeModal).find("#noticeBoardWriteId").val());
// 		console.log("ckk2: "+$(modModal).find("#noticeBoardWriteId2").val());
    } 


//	<!-- ===================================================================================================================================== -->
    // 글삭제
// 	const delContent = (nboIdData) => {
// 		$.ajax({
// 			type: 'POST',
// 			url: '/ourmine/noticeBoard/noticeBoardDelete',
// 			data: JSON.stringify(nboIdData),
// 			headers : headers,
// 			success: function(res) {
// 				console.log("확인 : ", res);
// 				alert('게시글을 삭제하였습니다.');
// 				modalClose();	// 모달 닫기
// 				reload();
// 			},
// 			error: function(xhr, status, error) {
// 				alert('게시글 삭제에 실패하였습니다.');
// 		        console.log("error: " + error);
// 			}
// 		});
// 	}

//	<!-- ===================================================================================================================================== -->
	// 그리드
	const gridDiv = document.querySelector("#myCodeGird");

    function getCodeData () {   // 데이터 가져오는 비동기처리
        // gridOptions.api. 대부분의 유용한 메소드가 여기에 있다
        const xhr = new XMLHttpRequest();
//         let url = "/ourmine/company/${companyId}/project/${projectId}/codeWall/codeWallListJson";
        xhr.open("get", "/ourmine/company/${companyId}/project/${projectId}/codeWall/codeWallListJson", true);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log("responseText : ", xhr.responseText);
                gridOptions.rowData = JSON.parse(xhr.responseText);
//                 gridOptions.api.setRowData(JSON.parse(xhr.responseText));	// 덮어쓰는것
				document.getElementById('myCodeGird').innerHTML="";
                new agGrid.Grid(gridDiv, gridOptions);
            }
        }
        xhr.send();
    }

    // 수정 후 데이타만 덮어쓰깅
	function reload() {
		const xhr = new XMLHttpRequest();
		xhr.open("get", "/ourmine/company/${companyId}/project/${projectId}/codeWall/codeWallListJson", true);
		xhr.onreadystatechange = () => {
			if (xhr.readyState == 4 && xhr.status == 200) {
				gridOptions.api.setRowData(JSON.parse(xhr.responseText)); // 여기가 포인트
			}
		}
		xhr.send();
	}

    const columnDefs = [
        { field: "rnum", headerName: "번호", cellStyle: {textAlign: 'center'}, maxWidth: 100},
        { field: "codeLanguage", headerName: "언어", cellStyle: {textAlign: 'center'}, maxWidth: 100 },
        { field: "codeTitle", headerName: "제목", cellStyle: {textAlign: 'left'}, maxWidth: 300 },
        { field: "codeWallWriter", headerName: "작성자", cellStyle: {textAlign: 'center'}, maxWidth: 130 },
        { field: "codeContent", headerName: "내용", cellStyle: {textAlign: 'left'}, minWidth: 300 },
        { field: "codewallWriteDate", headerName: "작성일자", cellStyle: {textAlign: 'center'}, maxWidth: 130}
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
        	codeWall.codewallId = params.data.codewallId;
			console.log("codeWall.memberId : ", codeWall.codewallId);


			// 화면 조회수 증가
            let codeWallVo = params.data;


            $(".myModal-title").html(codeWallVo.codeTitle);
            $("#codewallId").val(codeWallVo.codewallId);
            $("#rnum").val(codeWallVo.rnum);
    		$("#codeLanguage").val(codeWallVo.codeLanguage);
            $("#codeWallWriter").val(codeWallVo.codeWallWriter);
            $("#codewallWriteDate").val(codeWallVo.codewallWriteDate);
            $("#codeContent").html(codeWallVo.codeContent);

            modalOpen();	// 보이게

         	// 삭제버튼 클릭
        	$('#deleteBtn').on('click', function() {
        		delContent(nboIdData);
        	});
        }

    };

    getCodeData(); // 게시판 전체조회 ajax 바로 실행

    // setup the grid after the page has finished loading
    document.addEventListener('DOMContentLoaded', () => {
    	getCodeData(); // 가독성을 위해성 , 나중에 꺼내기
    });

//	<!-- ===================================================================================================================================== -->
	$(function() {
		// 글 등록
	    // let data = $('#insertCodeForm').serialize();
		$('#insertCodeForm').submit(function(e) {
	        e.preventDefault();
			console.log("폼체크 : ", $('#insertCodeForm')[0]);

			let jForm = $('#insertCodeForm').serialize();
			console.log("값: ",jForm, headers);
			var codeEditorId = document.getElementById("insertLanguageChoice").value;
            var codeTitle = $("#insertCodeTitle").val();
            var codeContent = editor.getValue();
			
            let url = "/ourmine/company/${companyId}/project/${projectId}/codeWall/insertCodeWall"
            
// 			let formData = new FormData($('#insertCodeForm')[0]);
	      //   let form = this;
			$.ajax({
				type: 'POST',
				url: url,
				contentType: 'application/json',
// 				data: generateSendData('json', form),
				data: JSON.stringify({
					codeEditorId: codeEditorId,
					codeTitle: codeTitle,
					codeContent: codeContent
				}),
				beforeSend:function(xhr){	// headers에 contentType='application/json'포함되어 있어 따로 적어줘야 함
					xhr.setRequestHeader(headerName, headerValue);
				},
				success: function(res) {
					console.log("확인 : ", res);
					$('#insertModal').hide();
					$('#insertCodeForm')[0].reset();
					getCodeData();
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

		$('#modifyCodeForm').submit(function(e) {
			e.preventDefault();
			console.log("수정 폼체크 : ", $('#modifyCodeForm')[0]);

// 			let modiForm = $('#modifyCodeForm').serialize();
// 			console.log("수정 값: ",  modiForm , headers);
			
			var codeEditorId = document.getElementById("updateLanguageChoice").value;
            var codeTitle = $("#updateCodeTitle").val();
            var codeContent = modifyEditor.getValue();
            var codewallId = $('#updateCodewallId').val();
			let url = "/ourmine/company/${companyId}/project/${projectId}/codeWall/updateCodeWall"
// 			let form = this;
			$.ajax({
				type: 'POST',
				url: url,
				contentType: 'application/json',
// 				data: generateSendData('json', form),
				data: JSON.stringify({
					codeEditorId: codeEditorId,
					codeTitle: codeTitle,
					codeContent: codeContent,
					codewallId: codewallId
				}),
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