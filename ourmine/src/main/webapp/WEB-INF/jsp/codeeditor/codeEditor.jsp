<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<style>
	#editor-container {
            width: 100%;
            height: 300px;
        }
</style>
<head>
    <meta charset="UTF-8">
    <meta name="_csrf_header" th:content="${_csrf.headerName}">
	<meta name="_csrf" th:content="${_csrf.token}">
    <title>RexTester API Test</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.63.1/codemirror.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.63.1/codemirror.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.63.1/mode/javascript/javascript.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.63.1/mode/python/python.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.63.1/mode/htmlmixed/htmlmixed.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.63.1/mode/clike/clike.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.63.1/mode/php/php.min.js"></script>
    
    <script>
    var header = $("meta[name='_csrf_header']").prop('content');
    var token = $("meta[name='_csrf']").prop('content');
    var memberId = ${memberId};
    var editor;

        $(document).ready(function() {
            // 코드 실행 버튼 클릭 시 이벤트 처리
		    console.log("memberId : ", memberId);
		    $(document).ready(function() {
	            // 초기화할 언어 설정
	            var defaultLanguage = "java";
	            initializeEditor(defaultLanguage);
	        });

	        function initializeEditor(language) {
	            // 기존의 에디터 삭제
	            if (editor) {
	                editor.toTextArea();
	            }
            
	            var editorContainer = document.getElementById("editor-container");
	            editor = CodeMirror(editorContainer, {
	                lineNumbers: true,
	                mode: language,
	            });
	        }    
            
            changeLanguage();
            $("#executeBtn").click(function() {
                executeCode();
            });

        	$("#showCodeListBtn").click(function() {
        	    // 버튼 클릭 시 코드 리스트를 가져와서 표시하는 함수 호출
        	    
        	    loadCodeList();v
        	    showSaveLocationOptions();
        	  });

        	// 코드 저장 버튼 클릭 시 이벤트 처리
            $("#saveBtn").click(function() {
                saveCode();
            });

        	// 코드 수정 버튼 클릭 시 이벤트 처리
            $("#editBtn").click(function() {
                updateCode();
            });

            $("#cancelBtn").click(function() {
                cancelModify();
            });

//             var textarea = document.getElementById('code');
//             // 에디터 설정
//             var editor = CodeMirror.fromTextArea(textarea, {
//             	lineNumbers: true,
//                 autoCloseTags: true,
//                 matchTags: { bothTags: true },
//                 mode: "text/html",
//                 theme: "default",
//                 indentUnit: 4,
//                 tabSize: 4,
//                 indentWithTabs: true,
//                 extraKeys: {
//                     "Ctrl-Space": "autocomplete"
//                 }
//             });

        });
				
	        function showSaveLocationOptions() {
	            $("#showCodeListBtn").hide();
	            $("#saveLocationContainer").show();
	            $("#editBtn").show();
	            $("#cancelBtn").show();
	        }
        
			function cancelModify(){
				$("#code").val('');
				changeLanguage();
				$("#codeList").hide();
				$("#saveLocationContainer").hide();
				$("#showCodeListBtn").show();
				$("#saveBtn").hide();
            	  $("#codeTitle").hide();
				$("#editBtn").hide();
				$("#cancelBtn").hide();
			}


            function loadCodeList() {
            	  // 코드 리스트를 가져오는 AJAX 요청
            	  $.ajax({
            	    url: "/ourmine/company/${companyId}/project/${projectId}/codeEditor/codeList?memberId=" + memberId,
            	    method: "GET",
                    contentType: "application/json",
                    dataType : "json",
            	    success: function(response) {
            	    	console.log("response : ", response);
                        // AJAX 요청이 성공하면 코드 리스트를 표시

            	    	console.log(typeof response);
                        // var codeList = JSON.parse(response);
                        // codeList.forEach(function (item) {
                        //     console.log(item);
                        // });
            	      displayCodeList(response);
            	    },
            	    error: function(xhr, status, error) {
            	      console.error("Error: " + error);
            	    }
            	  });
            	}

            	function displayCodeList(codeList) {
            		// 코드 내용이 표시되면 Save 버튼을 활성화
              	  $("#saveBtn").show();
              	  $("#codeTitle").show();
//               	  $("#editBtn").hide();

            	  // 코드 리스트를 표시할 엘리먼트 선택
            	  console.log("codeList : ", codeList);
            	  var codeListElement = $("#codeList");

            	  // 기존의 코드 리스트를 초기화
            	  codeListElement.empty();

            	  // 코드 리스트를 순회하며 각 코드를 리스트 아이템으로 추가
            	  codeList.forEach(function(code) {
            		  console.log("code : ", code);
            	    var listItem = $("<li>").text(code.CODE_TITLE);

            	    // 리스트 아이템을 클릭했을 때 해당 코드를 표시하는 이벤트 핸들러 등록
            	    listItem.click(function() {
            	      showCodeContent(code.CODE_CONTENT);
						let editorId = code.CODE_EDITOR_ID;
						console.log("editorId : ", editorId);
						$("#languageChoice option").each(function() {
					        if ($(this).val() === editorId) {
					          $(this).prop("selected", true);
					        } else {
					          $(this).prop("selected", false);
					        }
					     });

						$("#codeId").val(code.CODE_ID);
						$("#editBtn").show();
						$("#cancelBtn").show();
					      // 저장 버튼 비활성화
				      	$("#showCodeListBtn").hide();
				      	$("#codeTitle").hide();
				      	$("#saveBtn").hide();
            	    });
            	    // 리스트 아이템을 코드 리스트에 추가
            	    codeListElement.append(listItem);
            	  });

            	  // 코드 리스트를 표시
            	  $("#codeListContainer").show();
            	}

            	function showCodeContent(content) {
            	  // 코드 내용을 textarea에 표시
            	  $("#code").val(content);

            	}


		// 프로그래밍 언어 변환시 함수
		function changeLanguage(){
			var languageChoice = document.getElementById("languageChoice");
            var selectedOption = languageChoice.options[languageChoice.selectedIndex];

            var selectedValue = selectedOption.value;

            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    var response = xhr.responseText;
//                     var editor = CodeMirror.fromTextArea(document.getElementById("code"), {
//                         lineNumbers: true,
//                         autoCloseTags: true,
//                         matchTags: { bothTags: true },
//                         mode: "text/html",
//                         theme: "default",
//                         indentUnit: 4,
//                         tabSize: 4,
//                         indentWithTabs: true,
//                         extraKeys: {
//                           "Ctrl-Space": "autocomplete"
//                         }
//                       });
                    editor.setValue(response);
                    editor.setOption("mode", selectedValue);
//                     document.getElementById("code").value = response;
                } else {
                    console.error("Error: " + xhr.status);
                }
                }
            };

            xhr.open("GET", "/ourmine/company/${companyId}/project/${projectId}/codeEditor/getExampleCode?language=" + selectedValue, true);
            xhr.send();
        }

		function updateCode() {
			  var codeEditorId = $("#languageChoice").val();
			  var codeTitle = $("#codeTitle").val();
			  var codeId = $("#codeId").val();
			  var codeContent = $("#code").val();

			  $.ajax({
			    type: "POST",
			    dataType: "json",
			    contentType: "application/json; charset=utf-8",
			    url: "/ourmine/company/${companyId}/project/${projectId}/codeEditor/updateCode",
			    data: JSON.stringify({
			    	codeId: codeId,
			      codeTitle: codeTitle,
			      codeContent: codeContent,
			      codeEditorId: codeEditorId
			    }),
			    beforeSend: function(xhr) {
			      xhr.setRequestHeader(header, token);
			    },
			    success: function(response) {
			      $("#saveMessage").text("코드가 업데이트되었습니다.");
			      loadCodeList();
			    },
			    error: function(xhr, status, error) {
			      console.log("Error: ", error);
			    }
			  });
			}


		 function saveCode() {
			    var codeEditorId = document.getElementById("languageChoice").value;
	            var codeTitle = $("#codeTitle").val();
	            var codeContent = editor.getValue();
	            var saveLocation = $("input[name='saveLocation']:checked").val();
				
	            console.log("codeContent : ", codeContent);
	            console.log("saveLocation : ", saveLocation);
	            
	            let url = "/ourmine/company/${companyId}/project/${projectId}/codeEditor/" + saveLocation;

	            $.ajax({
	                type: "POST",
	                dataType: "text",
	                contentType: "application/json; charset=utf-8",
	                url: url,
	                data: JSON.stringify({
	                	memberId: memberId,
	                    codeTitle: codeTitle,
	                    codeContent: codeContent,
	                    codeEditorId: codeEditorId
	                }),
	                beforeSend: function(xhr) {
	                    xhr.setRequestHeader(header, token);
	                },
	                success: function(response) {
	                	$("#saveMessage").text("코드가 저장되었습니다.");
	                    loadCodeList();
	                },
	                error: function(xhr, status, error) {
	                    console.log("Error: ", error);
	                }
	            });
            }

        function executeCode() {
            // 사용자가 선택한 언어와 작성한 코드 가져오기
            var languageChoice = $("#languageChoice").val();
            var code = editor.getValue();
            console.log("code : ", code);
            console.log("data={}", JSON.stringify({
                languageChoice: languageChoice,
                code: code
            }))
            let url = "/ourmine/company/${companyId}/project/${projectId}/codeEditor/excuteCode";
			console.log("url : ", url);
//             let apiKey = "{apiKey}";
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



    </script>
</head>
<body>

	</script>
    <select id="languageChoice" onchange = "changeLanguage()">
        <option value="4" active>Java</option>
        <option value="5">Python</option>
        <option value="1">C#</option>
        <option value="8" >PHP</option>
        <option value="17">JavaScript</option>
        <option value="25">Node.js</option>
        <option value="28" >C++ (vc++)</option>
        <option value="37">Swift</option>
    </select>
	<div id="editor-container">
	</div>
	<input type="text" id="codeId" style="display: none;" placeholder="저장할 타이틀을 작성하세요">
    <button id="executeBtn">Execute</button>
    <button id="showCodeListBtn">저장</button>
	<input type="text" id="codeTitle" style="display: none;" placeholder="저장할 타이틀을 작성하세요">
	<button id="saveBtn" style="display: none;">Save</button>
		<div id="saveLocationContainer" style="display: none;">
		    <label for="saveLocation">저장 위치:</label>
		    <input type="radio" id="local" name="saveLocation" value="saveCode" checked>
		    <label for="local">코드에디터</label>
		    <input type="radio" id="server" name="saveLocation" value="codeWall/insertCodeWall">
		    <label for="server">코드에디터/코드게시판</label>
		</div>
	<button id="editBtn" style="display: none;">수정</button>
	<button id="cancelBtn" style="display: none;">취소</button>
	<div id="saveMessage"></div>

	<div id="codeListContainer" style="display: none;">
	  <h3>Code List : </h3>
	  <ul id="codeList"></ul>
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



</body>
</html>
