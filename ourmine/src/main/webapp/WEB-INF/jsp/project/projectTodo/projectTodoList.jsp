<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<style>
    #todoDiv {
        display: none;
    }
    .con {
    	margin-top: 7px;
    	text-decoration: none;
    }
    .btnMargin {
    	margin-right: 20px;
    }
    .modal {
    	display: none;
    }
    .insert {
    	float: right;
    }
    .newBtn {
    	margin-right: 30px;
    }
    #completeDiv {
    	float: right;
    }
</style>

<div class="body d-flex py-lg-3 py-md-2">
    <div class="container-xxl">
	    <div class="border-0 mb-4">
	        <div class="card-header py-3 no-bg bg-transparent d-flex align-items-center px-0 justify-content-between border-bottom flex-wrap">
	            <h3 class="fw-bold mb-0">나의 일감</h3>
	        </div>
	    </div>
        
        <!-- TodoList 목록 -->
        <div class="row mb-3" id="todoDiv" >
            <div class="col-12">
                <div class="card">
					<div class="card-header py-3 d-flex justify-content-between bg-transparent border-bottom-0">
						<h4 class="mb-0 fw-bold">Todo List</h4>
						<div class="col-auto d-flex">
							<button type="button" class="btn-close" aria-label="Close" onclick="todoDivHidden()"></button>
						</div> 
					</div>
					<div class="card-body p-2">
						<div class="btn-group me-2 insert">
							<button type="button" class="btn btn-dark newBtn" data-bs-toggle="modal" onclick="addModalOpen()">
								<i class="icofont-plus-circle me-2 fs-6"></i> 글등록
							</button>
						</div>
                    </div>
                    <div class="card-body p-4">
                        <ul class="list-unstyled mb-0" id="todoList" >
                        
                        </ul>
					</div>
                </div>
            </div>
        </div> 
        
	    <!-- todo 등록 모달-->
	    <form id="insertForm" method="post">
	        <div class="modal" id="todoAddModal" tabindex="-1" aria-hidden="true">
	            <div class="modal-dialog modal-dialog-centered modal-md modal-dialog-scrollable">
	                <div class="modal-content">
	                    <div class="modal-header">
	                        <h5 class="modal-title  fw-bold" id="leaveaddLabel"> 글등록 </h5>
	                    </div>
	                    <div class="modal-body">
	                        <div class="deadline-form">
                                <div class="row g-3 mb-3">
                                    <div class="col">
                                        <label class="form-label">제목</label>
                                        <input type="text" class="form-control" id="todoTitle" name="todoTitle" required>
                                    </div>
                                    <div class="col">
                                        <label class="form-label">작성자</label>
                                        <input type="text" class="form-control" id="todoWriter" name="todoWriter" value="" readonly>
                                    </div>
                                </div>
	                        </div>
	                        <div class="mb-3">
	                            <label for="todoContent" class="form-label">내용</label>
	                            <textarea rows="3" cols="50" class="form-control" id="todoContent" name="todoContent" required></textarea>
	                        </div>
	                        <div class="mb-3">
                            	<input type="hidden" class="form-control" id="projectWorkId" name="projectWorkId" value="">
                            	<input type="hidden" class="form-control" id="todoId" name="todoId" value="" >
                            </div>
	                    </div>
	                    <div class="modal-footer">
	                        <button type="button" class="btn btn-secondary" onclick="addModalClose()">취소</button>
	                        <button type="submit" class="btn btn-primary" id="addButton">등록</button>
	                    </div>
	                </div>
	            </div>
	        </div>
        </form>

		<!-- 나의 일감 리스트 -->
        <div class="row clearfix g-3">
            <div class="col-sm-12">
                <div class="card mb-3">
                    <div class="card-body">
                    <input type="text" class="form-control" placeholder="검색..." id="searchProjectWork" >
                        <table id="myProjectTable" class="table table-hover align-middle mb-0" style="width:100%">
                            <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>상태</th>
                                    <th>우선순위</th> 
                                    <th>제목</th> 
                                    <th>시작일</th>
                                    <th>마감일</th>  
                                </tr>
                                </thead>
                            <tbody id="pwList">
                            	<tr style="display: none;">
                                    <th>번호</th>
                                    <th>상태</th>
                                    <th>우선순위</th> 
                                    <th>제목</th> 
                                    <th>시작일</th>  
                                    <th>마감일</th>  
                                </tr>
                            </tbody>
                        </table>
                        <nav aria-label="Page navigation">
						    <div>
							    <ul style="display: flex" class="pagination justify-content-center">
							        <li class="page-item disabled" >  <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>  </li>
							        <li class="page-item" style="display: flex" id="pwContainer"><a class="page-link" href="#">1</a></li>
							        <li class="page-item">  <a class="page-link" href="#">Next</a> </li>
							    </ul>
						    </div>
						</nav>
                    </div>
                </div>
            </div>
        </div><!-- Row End -->

    </div>
</div>

<security:authentication property="principal" var="principal"/>

<input id="projectIdHidden" type="hidden" value="${projectId}">
<input id="companyIdHidden" type="hidden" value="${companyId}">

<!-- ================================================================================================= -->

<script type="text/javascript">
	// 검색
	let searchProjectWork = document.querySelector("#searchProjectWork");
	
	const selectPwList = {

	}
	
    let reset =  document.querySelector('.reset');
	let projectWorkId =  document.querySelector('#projectWorkId');
	let todoId =  document.querySelector('#todoId');
	let todoWriter =  document.querySelector('#todoWriter');

	const todo = {
	    projectWorkId : '',
        todoId : '',
	    memberName : '',
	}
	
	const add = (a,b) => a + b;
	
	let projectIdHidden = document.querySelector('#projectIdHidden');
	let projectIdHiddenValue = projectIdHidden.value;
	console.log("projectIdHiddenValue: ", projectIdHiddenValue);
    
	let companyIdHidden = document.querySelector('#companyIdHidden');
	let companyIdHiddenValue = companyIdHidden.value;
	console.log("companyIdHiddenValue: ", companyIdHiddenValue);
	
	
//<!-- ================================================================================================= -->	
	// 글작성 버튼 클릭 이벤트(모달)
    const addModal = document.querySelector("#todoAddModal");
	
	const addModalClose = () => {
		addModal.style.display = "none";    // 안보이게
	}
	
	const addModalOpen = () => {
		$('#insertForm')[0].reset();
		addModal.style.display = "block";    // 보이게
		
        projectWorkId.value = todo.projectWorkId;
        todoId.value = todo.todoId;
        todoWriter.value = todo.memberName;
    }
    
//<!-- ================================================================================================= -->	
	// 글등록
	$(function() {
	    $('#insertForm').submit(function(e){
	        console.log("todo 등록");
	        e.preventDefault();
	
	        let data = {
	        	todoId: this.todoId.value,
	            todoTitle: this.todoTitle.value,
	            todoContent: this.todoContent.value,
	            todoWriter: this.todoWriter.value,
                projectWorkId : this.projectWorkId.value,
	        }
	        console.log("데이터 확인 : ", data);
	        
	        headers['accept'] = 'application/json';
	
	        $.ajax({
	            type: 'POST',
	            url: '/ourmine/company/${companyId}/project/${projectId}/projectTodoList/projectTodoListForm',
	            data: JSON.stringify(data),
	            contentType: 'application/json;charset=UTF-8',
	            headers: headers,
	            success: function(res) {
	                console.log("확인 : ", res);
	                
	                addModalClose();  // 모달 닫기
	                reload();
	            },
	            error: function(error) {
	                console.log("error : ", error);
	            }
	        })
	    });
	  
// <!-- ================================================================================================= -->	
	// todo 삭제
    $(document).on("click", "#deleteRow", function(e) {
        console.log("삭제버튼 클릭");
        
        e.preventDefault();
        
        let projectTodoList = document.querySelector('#todoList');
        
        let todoId = $(this).data("todoid");
        console.log("todoId :" , todoId);
        
        headers['accept'] = 'application/json';

        axios.post(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/projectTodoList/projectTodoListDelete`, todoId, {headers: headers})
            .then(resp => {
            	console.log('DB 업데이트 성공');
            	projectTodoList.innerHTML = ''; // todoList 목록 비우기
                reload();
            })
            .catch(error => {
				console.log('DB 업데이트 실패 : ', error);
			});
    });
	
// <!-- ================================================================================================= -->	
		// todoList 다시 불러오는 함수
		function reload() {
			console.log("확인!");
			
			const projectTodoList = document.querySelector('#todoList');
			const todoDiv = document.querySelector('#todoDiv');
			
			let workId = todo.projectWorkId;
			console.log("workId: ", workId);
			
			headers['accept'] = 'application/json';
			
			$.ajax({
				url: `/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/projectTodoList/todoList`,
				type: 'GET',
				dataType: 'json',
				data: {
	                projectWorkId: workId
	            },
				headers:headers,
				success: function(data){
					projectTodoList.innerHTML = '';
					console.log("todoData : ", data);
					
					if(data.length === 0) {
						projectTodoList.innerHTML = '<li class="noDataMsg">등록된 글이 없습니다.</li>';
					} else {
						projectTodoList.innerHTML = '';	// 이전 내용 초기화
						projectTodoList.innerHTML += data.map(item =>
							`
							<li class="d-flex justify-content-between delCont" data-todoid=\${item.todoId} >
								<div class="content con">
									\${item.completeWhether === null ? `<span class="todoCon todoContent" id="todoCon_\${item.todoId}" style="text-decoration: none;" data-todocontent=\${item.todoContent} data-completewhether=\{item.completeWhether}>\${item.todoContent}</span>`
									: `<span class="todoCon todoContent" id="todoCon_\${item.todoId}" style="text-decoration: line-through;" data-todocontent=\${item.todoContent} data-completewhether=\{item.completeWhether}>\${item.todoContent}</span>`}
								</div>
								<div class="btnMargin">
									\${item.completeWhether === null ? 
										`<button type="button" class="btn checkBtn checkRow" id="checkRow" data-todoid =\${item.todoId} data-todocontent=\${item.todoContent} >
											<i class="icofont-checked text-success"></i>
										</button>` : 
										`<button type="button" class="btn checkBtn checkRow" id="checkRow" data-todoid =\${item.todoId} data-todocontent=\${item.todoContent} >
											<i class="icofont-checked text-secondary"></i>
										</button>`}
									<button type="button" class="btn checkBtn deleteRow" id="deleteRow" data-todoid =\${item.todoId} >
										<i class="icofont-ui-delete text-danger"></i>
									</button>
								</div>
							</li>
							<hr>
							`
						).reduce(add);
					}
				},
				error: function (error) {
					console.log("error : ", error);
				}
			});
		}
	});
        
//<!-- ================================================================================================= -->
	// todoDiv닫기 버튼 
	let todoDiv = document.querySelector("#todoDiv");
	
	const todoDivHidden = () => {
		todoDiv.style.display = "none";
	}

//<!-- ================================================================================================= -->	
	// tr클릭 이벤트
	function clickTrEvent(trObj) {
		console.log("trObj : ", trObj);
		
		let todoDiv = document.querySelector("#todoDiv");
		let todoDivDisplayStyle = todoDiv.style.display;
		
		let newWorkId = trObj.dataset.workid;
		console.log("newWorkId : ", newWorkId)
		
		if(todoDivDisplayStyle === "block") {
			let currentWorkId = todo.projectWorkId;
			
			if(currentWorkId !== newWorkId) {
				// todoDiv가 열려있는 경우
				Swal.fire({
		            title: '알림',
		            text: '현재 창을 닫으시겠습니까?',
		            icon: 'question',
		            showCancelButton: true,
		            confirmButtonText: '닫기',
		            cancelButtonText: '취소'
		        }).then((result) => {
		        	if(result.isConfirmed) {
		        		// todoDiv 닫기
		        		todoDiv.style.display = "none";
		        		
		        		// todoList 가져오기
		        		getTodoList(newWorkId);
		        	}
		        });
			}
		} else {
			// todoDiv 열기
			todoDiv.style.display = "block";
			
			// todoList 가져오기
    		getTodoList(newWorkId);
		}
	}
	
	function getTodoList(newWorkId) {
	   	let projectTodoList = document.querySelector('#todoList');
		
        let workId = newWorkId;
		console.log("workId: ", workId);
		
	   	headers['accept'] = 'application/json';
	   	
		$.ajax({
			url: '/ourmine/company/${companyId}/project/${projectId}/projectTodoList/todoList',
            type: 'GET',
            dataType: 'json',
            data: {
                projectWorkId: workId
            },
            headers: headers,
            success: function(data) {
            	let projectTodoList = document.querySelector('#todoList');
            	
            	projectTodoList.innerHTML = '';
                console.log("todoData : ", data);	
	   	
				if(data.length === 0 ) {
					projectTodoList.innerHTML = '<li class="noDataMsg">등록된 글이 없습니다.</li>';
				} else {
					projectTodoList.innerHTML += data.map(item => 
						`
						<li class="d-flex justify-content-between delCont" data-todoid=\${item.todoId} >
							<div class="content con">
			             		\${item.completeWhether === null ? `<span class="todoCon todoContent" id="todoCon_\${item.todoId}" style="text-decoration: none;" data-todocontent=\${item.todoContent} data-completewhether=\{item.completeWhether}>\${item.todoContent}</span>`
			             		: `<span class="todoCon todoContent" id="todoCon_\${item.todoId}" style="text-decoration: line-through;" data-todocontent=\${item.todoContent} data-completewhether=\{item.completeWhether}>\${item.todoContent}</span>`}
		                	</div>
		                	<div class="btnMargin">
		                		\${item.completeWhether === null ? 
		              			`<button type="button" class="btn checkBtn checkRow" id="checkRow" data-todoid =\${item.todoId} data-todocontent=\${item.todoContent} >
		                			<i class="icofont-checked text-success"></i>
		                		</button>` : 
		                		`<button type="button" class="btn checkBtn checkRow" id="checkRow" data-todoid =\${item.todoId} data-todocontent=\${item.todoContent} >
		               				<i class="icofont-checked text-secondary"></i>
		               			</button>`}
		                	<button type="button" class="btn checkBtn deleteRow" id="deleteRow" data-todoid =\${item.todoId} >
		                		<i class="icofont-ui-delete text-danger"></i>
		               		</button>
		                </div>
		             </li>
		             <hr>
		             `
		           	).reduce(add)
				}
           	},
           	error: function (error) {
				console.log("error : ", error);
			}
		});
	}

// <!-- ================================================================================================= -->	
    // todo 체크
	$(document).on("click", ".checkRow",function (e) {
	    console.log("체크버튼 홀수 클릭");
	    e.preventDefault();
	    
	    let projectTodoList = document.querySelector('#todoList');
		
		let todoId = $(this).data("todoid");
		let todoContent = $(this).data("todocontent");
		console.log("todoId: ", todoId);
		console.log("todoContent: ", todoContent);

		let schId = `#todoCon_\${todoId}`;
		let con = $(this).closest("li").find(schId)[0];
		console.log("selectLi : ", con);
		
		headers['accept'] = 'application/json';

		let axiosPromise;
		let button = $(this);
		let icon = button.find('i');

		if (icon.hasClass('text-success')) {
		    console.log("체크버튼 클릭");
		    axiosPromise = axios.post(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/projectTodoList/projecTodoListComplete`, todoId, {headers: headers});
		    icon.removeClass('text-success').addClass('text-secondary');
		    con.style.textDecoration = 'line-through'; // 취소선 추가
		}else if(icon.hasClass('text-secondary')) {
		    console.log("체크버튼 클릭");
		    axiosPromise = axios.post(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/projectTodoList/projecTodoListReturn`, todoId, {headers: headers});
		    icon.removeClass('text-secondary').addClass('text-success');
		    con.style.textDecoration = 'none'; // 취소선 제거 
		}
		
		axiosPromise
			.then(resp => {
				console.log('DB 업데이트 성공');
				
				createCompleteButton();

	            // 모든 체크된 목록이 completeWhether = 'C'인지 확인
	            let allCompleted = true;
	            $("#todoList").find(".checkRow").each(function() {
	                if (!$(this).find('i').hasClass('text-secondary')) {
	                    allCompleted = false;
	                    return false; // 반복문 종료
	                }
	            });

	            // 모든 체크된 목록이 completeWhether = 'C'일 경우 완료 버튼 유지, 그렇지 않은 경우 제거
	            if (!allCompleted) {
	                $("#completeButton").remove();
	            }
				
			})
			.catch(error => {
				console.log('DB 업데이트 실패 : ', error);
			});
		
	});	
		
// <!-- ================================================================================================= -->
	// 완료버튼 클릭
	$(document).on("click", ".completeButton", function(){
		console.log('완료 버튼 클릭');
	        
		let pwList = document.querySelector('#pwList');
	      
		let workId = todo.projectWorkId;
		console.log("workId: ", workId);
	      
		headers['accept'] = 'application/json';
	
		axios.post(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/projectTodoList/updateStatus`, workId, {headers: headers})
			.then(resp => {
				console.log('DB 업데이트 성공');
				pwList.innerHTML=''; // pwList 목록 비우기
				projectWorkList();
			})
			.catch(error => {
				console.log('DB 업데이트 실패 : ', error);
			});
	})

// <!-- ================================================================================================= -->
	// 완료버튼 생성
	function createCompleteButton() {
	    // 이미 완료 버튼이 존재하는 경우 중복 생성 방지
	    if ($("#completeButton").length > 0) {
	        return;
	    }
	
	    let completeDiv = document.createElement('div');
	    completeDiv.id = 'completeDiv';
	    completeDiv.classList.add('btnMargin');
	    
	    let completeButton = document.createElement('button');
	    completeButton.textContent = '완료';
	    completeButton.id = 'completeButton';
	    completeButton.classList.add('completeButton');
	    completeButton.classList.add('btn');
	    completeButton.classList.add('btn-outline-success');
	    completeDiv.appendChild(completeButton);
	    
	    // 완료 버튼을 원하는 위치에 추가 (예: todoList 밑에 추가)
	    document.querySelector('#todoList').parentElement.appendChild(completeDiv);
	}

// <!-- ================================================================================================= -->	
	// 나의 일감 리스트
	let pwList = document.querySelector('#pwList');

    headers['accept'] = 'application/json';

	async function projectWorkList() {
		await axios.get(`/ourmine/company/\${companyIdHiddenValue}/project/\${projectIdHiddenValue}/projectTodoList/projectWorkList`, {headers: headers})
            .then(resp => {
                let data = resp.data;
                console.log("data: ", data);

                todo.memberName = data[0].projectWorkPic; // todo.memberName에 pwdata의 projectWorkPic넣어주기(글 등록 시 이름 넣어주기 위해서)

//                 pwList.innerHTML = '';
                
                pwList.innerHTML += data.map(item => 
                    `
					<tr class="clickTr" onclick="clickTrEvent(this)"   
							data-workid=\${item.projectWorkId} data-pwstatus=\${item.projectWorkStatus} data-pwstatusid=\${item.projectWorkStatusId}
							data-ppname=\${item.projectPriorityName} data-pwtitle=\${item.projectWorkTitle} 
							data-pwsdate=\${item.projectWorkStartDate} data-pwedate=\${item.projectWorkEndDate}>
                        <td data-workid=\${item.projectWorkId}>
                            <span class="fw-bold text-secondary" id="projectWorkId">\${item.projectWorkId}</span>
                        </td>
                        <td data-workid=\${item.projectWorkId}>
                        	\${item.projectWorkStatusId===1 ? `<span class="badge bg-warning" id="projectWorkStatus" data-pwstatusid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>` :item.projectWorkStatusId===2
								? `<span class="badge bg-primary" id="projectWorkStatus" data-pwstatusid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:item.projectWorkStatusId===3
	 							? `<span class="badge bg-info" id="projectWorkStatus" data-pwstatusid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:item.projectWorkStatusId===4
	 							? `<span class="badge bg-success" id="projectWorkStatus" data-pwstatusid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:`<span class="badge bg-danger" id="projectWorkStatus" data-pwstatusid=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`}
                        </td>
                        <td data-workid=\${item.projectWorkId}>
                        	\${item.projectPriorityName}
                        </td>
                        <td data-workid=\${item.projectWorkId}>
                            \${item.projectWorkTitle}
                        </td>
                        <td data-workid=\${item.projectWorkId}>
                    		\${item.projectWorkStartDate}
	                    </td>
	                    <td data-workid=\${item.projectWorkId}>
	                    	\${item.projectWorkEndDate}
	                    </td>
					</tr>
                    `
                ).reduce(add)
                
                // 페이징
				let totalItems = data[0].totalWorkData; // 총 데이터 개수
				console.log("totalItems", totalItems);
				
				let pageSize = 5; // 한 페이지에 보여줄 데이터 개수
				let totalPages = Math.ceil(totalItems / pageSize); // 총 페이지 개수
				let pageCon = document.querySelector('#pwContainer');
				let pagesArray = Array.from({length: totalPages}, (_, i) => i + 1); // 페이지 번호 배열을 생성
				let paginationHTML = pagesArray.map(pageNumber => `<a href="#" data-page="\${pageNumber}" class="page-link">\${pageNumber}</a>`).join('');
				document.querySelector('#pwContainer').innerHTML = paginationHTML;

				let pageLinks = document.querySelectorAll('.page-link');
				pageLinks.forEach((link, index) => {
					link.addEventListener('click', function(event){
						console.log("클릭이벤트")

						event.preventDefault();
						
						let pageNumber = this.dataset.page; 
						axios.get(`/ourmine/company/${companyId}/project/${projectId}/projectTodoList/projectWorkList`,{
							params: {
								page: pageNumber
							}
						},{headers : headers})
							.then(resp => {
								let data = resp.data;
								console.log("pwData",data);
								pwList.innerHTML='';	// 이전의 내용 초기화
								pwList.innerHTML+= data.map(item =>
									`
									<tr class="clickTr" onclick="clickTrEvent(this)"  
										data-workid=\${item.projectWorkId} data-pwstatus=\${item.projectWorkStatus}
										data-ppname=\${item.projectPriorityName} data-pwtitle=\${item.projectWorkTitle} 
										data-pwsdate=\${item.projectWorkStartDate} data-pwedate=\${item.projectWorkEndDate}>
										<td data-workid=\${item.projectWorkId}>
											<span class="fw-bold text-secondary" id="projectWorkId">\${item.projectWorkId}</span>
										</td>
										<td data-workid=\${item.projectWorkId}>
											\${item.projectWorkStatusId===1 ? `<span class="badge bg-warning" id="projectWorkStatus" data-pwstatus=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>` :item.projectWorkStatusId===2
												? `<span class="badge bg-primary" id="projectWorkStatus" data-pwstatus=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:item.projectWorkStatusId===3
												? `<span class="badge bg-info" id="projectWorkStatus" data-pwstatus=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:item.projectWorkStatusId===4
												? `<span class="badge bg-success" id="projectWorkStatus" data-pwstatus=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:`<span class="badge bg-danger" id="projectWorkStatus" data-pwstatus=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`}
										</td>
										<td data-workid=\${item.projectWorkId}>
											\${item.projectPriorityName}
										</td>
										<td data-workid=\${item.projectWorkId}>
											\${item.projectWorkTitle}
										</td>
										<td data-workid=\${item.projectWorkId}>
											\${item.projectWorkStartDate}
										</td>
										<td data-workid=\${item.projectWorkId}>
											\${item.projectWorkEndDate}
										</td>
									</tr>
									`
								).reduce(add)
							})
					})

				})
            })
    }
	
// <!-- =============================================================================================== -->
	// 검색
	searchProjectWork.addEventListener('input', () => {
		console.log('실행되나?');
		
		let pwList = document.getElementById('pwList');

		headers['accept'] = 'application/json'

		let search = searchProjectWork.value;
		if (search.trim() === '') {
			console.log("트림트림")
			pwList.innerHTML='';
			projectWorkList();
			return false;
		} else {
			axios.get(`/ourmine/company/${companyId}/project/${projectId}/projectTodoList/projectWorkList`, {
				params: {
					search: search
				}
			}, {headers: headers})
				.then(resp => {
					let data = resp.data;
					console.log("searchData", data);
					pwList.innerHTML='';
	
					pwList.innerHTML+= data.map(item =>
						`
						<tr class="clickTr" onclick="clickTrEvent(this)"  
							data-workid=\${item.projectWorkId} data-pwstatus=\${item.projectWorkStatus}
							data-ppname=\${item.projectPriorityName} data-pwtitle=\${item.projectWorkTitle} 
							data-pwsdate=\${item.projectWorkStartDate} data-pwedate=\${item.projectWorkEndDate}>
							<td data-workid=\${item.projectWorkId}>
								<span class="fw-bold text-secondary" id="projectWorkId">\${item.projectWorkId}</span>
							</td>
							<td data-workid=\${item.projectWorkId}>
								\${item.projectWorkStatusId===1 ? `<span class="badge bg-warning" id="projectWorkStatus" data-pwstatus=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>` :item.projectWorkStatusId===2
									? `<span class="badge bg-primary" id="projectWorkStatus" data-pwstatus=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:item.projectWorkStatusId===3
									? `<span class="badge bg-info" id="projectWorkStatus" data-pwstatus=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:item.projectWorkStatusId===4
									? `<span class="badge bg-success" id="projectWorkStatus" data-pwstatus=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`:`<span class="badge bg-danger" id="projectWorkStatus" data-pwstatus=\${item.projectWorkStatusId}>\${item.projectWorkStatus}</span>`}
							</td>
							<td data-workid=\${item.projectWorkId}>
								\${item.projectPriorityName}
							</td>
							<td data-workid=\${item.projectWorkId}>
								\${item.projectWorkTitle}
							</td>
							<td data-workid=\${item.projectWorkId}>
								\${item.projectWorkStartDate}
							</td>
							<td data-workid=\${item.projectWorkId}>
								\${item.projectWorkEndDate}
							</td>
						</tr>
						`
					).reduce(add)
				})
			pwList.innerHTML='';
		}	
	})

// <!-- ================================================================================================= -->	
    // 일감 목록 조회 성공 시
    projectWorkList().then((e) => {
        let click =  document.querySelectorAll('.clickTr');
        console.log("클릭클릭 = ", click);

        click.forEach(item => {
            item.addEventListener('click', (e) => {
                todo.projectWorkId = e.target.dataset.workid;
                
                console.log("todo.projectWorkId = ",todo.projectWorkId);
                console.log("todo.memberName = ",todo.memberName);
               
                clickTrEvent();  // tr태그 클릭이벤트 실행
            })
        })
	})

</script>