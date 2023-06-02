<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<style>
    /* Add your styles for the modal here. */
    #modal {
        display: none;
        position: fixed;
        z-index: 1;
        padding-top: 100px;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgb(0, 0, 0);
        background-color: rgba(0, 0, 0, 0.4);
    }

    .modal-content {
        background-color: #fefefe;
        margin: auto;
        padding: 20px;
        border: 1px solid #888;
        width: 30%;
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        animation-name: animatetop;
        animation-duration: 0.4s
    }

    @keyframes animatetop {
        from {top: -300px; opacity: 0}
        to {top: 0; opacity: 1}
    }

    .close {
        color: #aaaaaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: #000;
        text-decoration: none;
        cursor: pointer;
    }
    .pretty-button {
    color: #fff;
    background-color: #007BFF;
    border: none;
    padding: 10px 20px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    transition-duration: 0.4s;
    cursor: pointer;
    border-radius: 12px;
    margin-bottom: 20px;
}

.pretty-button:hover {
    background-color: #008CBA;
    color: white;
}
    .modal-content {
        background-color: #fefefe;
        margin: auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
    }

</style>
<security:authorize access="hasRole('MANAGER')">
<button id="addOrgChartButton" class="pretty-button">부서 추가</button>
<button id="addOrgChartDeleteButton" class="pretty-button">부서 삭제</button>
<button id="addMemberOrgInsert" class="pretty-button">직원 부서 배치</button>
</security:authorize>
<div id="chart_div" style="width: 100%; height: 80vh; display: flex; justify-content: center; align-items: center; margin-top: 50px;"></div>

<div id="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <p id="orgName"></p>
        <p id="manager"></p>
    </div>
</div>


<!--부서 추가하기 -->
<div id="addOrgModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>부서 추가 하기</h2>
        <form id="addOrgForm" method="post" action="/ourmine/orgchart/orgchartInsert">
            <label for="org">부서 이름:</label>
            <input type="text" id="org" name="orgName"><br>
            <label for="seniorOrg"></label>
            <span>상급부서 선택 : </span> <select id="seniorOrg">

            </select>
            <button type="submit" class="pretty-button">추가</button>
            <button type="button" class="pretty-button cancel">취소</button>
        </form>
    </div>
</div>


<!--부서 삭제하기 -->
<div id="deleteOrgModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>부서 삭제하기</h2>
        <form id="deleteOrgForm" method="post" action="/ourmine/orgchart/orgchartDelete">
            <label for="deleteOrg">부서 이름:</label>
            <select id="deleteOrg">

            </select><br>
            <button type="submit" class="pretty-button">삭제</button>
            <button type="button" class="pretty-button deleteCancel">취소</button>
            <span id="deleteOrgSpan"></span>
        </form>
    </div>
</div>


<!-- 수정모달 -->
<!-- Edit Department Modal -->
<div id="editDepartmentModal" class="modal">
    <div class="modal-content">
        <span class="close" id="editModalClose">&times;</span>
        <h2>부서 수정하기</h2>
        <form id="editDepartmentForm" method="post">
            <label for="org">부서 이름:</label>
            <input type="text" id="updateOrg" name="orgName"><br>
            <label for="superiorDepartment">상급 부서:</label>
            <select id="superiorDepartment">
                <!-- Options will be filled by JavaScript -->
            </select>
            <button type="submit" class="pretty-button" id="saveChanges">저장</button>
            <button type="button" class="pretty-button" id="editCancel">취소</button><br>
                    <span id="orgchartMemberList">

                    </span>

        </form>
    </div>
</div>


<!-- 회원추가 -->

<div id="memberInsert" class="modal">
    <div class="modal-content">
        <span class="close" id="editMemberModalClose">&times;</span>
        <h2>직원 부서 배치</h2>
        <form id="memberInsertForm" method="post" action=`/ourmine/company/${companyId}/orgchart/orgchartMember`>
            <label for="addMemberList">직원 이름:</label>
           <select id="addMemberList">

            </select>
            <label for="departmentList">부서 :</label>
            <select id="departmentList">
                <!-- Options will be filled by JavaScript -->
            </select><br>
            <security:authorize access="hasRole('MANAGER')">            
            <button type="submit" class="pretty-button" id="saveMember">저장</button>
            <button type="button" class="pretty-button" id="saveCancel">취소</button><br>
			</security:authorize>

        </form>
    </div>
</div>




<script>
    const companyId = ${companyId};
	console.log("companyId", companyId);
    let modal = document.getElementById('editDepartmentModal');
    let closeBtn = document.getElementById('editModalClose');
    let orgNameInput = document.getElementById('updateOrg');
    let superiorDepartmentSelect = document.getElementById('superiorDepartment');
    let editDepartmentForm = document.querySelector('#editDepartmentForm');
	let editCancel = document.getElementById('editCancel');
	let editModalClose = document.getElementById('editModalClose');
    let orgchartMemberList = document.querySelector('#orgchartMemberList');
    let addMemberOrgInsert = document.querySelector('#addMemberOrgInsert');
    let memberInsert = document.querySelector('#memberInsert');
    let saveCancel = document.querySelector('#saveCancel');
    let addMemberList = document.querySelector('#addMemberList');
    let departmentList = document.querySelector('#departmentList');
    let memberInsertForm = document.querySelector('#memberInsertForm');
    let deleteOrgSpan = document.querySelector('#deleteOrgSpan');






    let org = [];
    google.charts.load('current', {packages: ['orgchart']});
    google.charts.setOnLoadCallback(drawChart);




	async function drawChart() {
		let orgData = [];
		await axios.get(`/ourmine/company/\${companyId}/orgchart/orgchartListJson`, {headers: headers})
			.then(resp => {
				org = [...resp.data];
				console.log("org = ", org);
				orgData = resp.data;
			});

		let data = new google.visualization.DataTable();
		data.addColumn('string', 'Name');
		data.addColumn('string', 'Manager');
		data.addColumn('string', 'ToolTip');

		orgData.forEach((item) => {
			data.addRow([
				{'v': item.orgchartId.toString(), 'f': item.departmentName.toString()},
				item.seniorDepartmentId ? item.seniorDepartmentId.toString() : null,
				item.departmentCreateDate.toString(),
			]);
		});

		let chart = new google.visualization.OrgChart(document.getElementById('chart_div'));
		chart.draw(data, {
			allowHtml: true,
			size: 'large'
		});

//  수정 모달
		const updateOrgObj ={
			orgchartId : '',
			seniorDepartmentId : '',
			departmentName : '',
			companyId : '',
		}
		google.visualization.events.addListener(chart, 'select',   function() {
            let selectedItem = chart.getSelection()[0];
            console.log("selectItem",selectedItem)
            if (selectedItem) {
                let departmentId = data.getValue(selectedItem.row, 0);
				updateOrgObj.orgchartId = departmentId;  // updateOrgObj 에 departmentId 세팅

                // 상급 부서 select 요소를 초기화
                superiorDepartmentSelect.innerHTML = '';
	            headers['Content-Type'] = 'application/json'
	            headers['accept'] = 'application/json'
			 axios.post(`/ourmine/company/\${companyId}/orgchart/orgchartMemberListJson`, updateOrgObj,{headers:headers})
                    .then(resp => {
						let data = resp.data;
	                    orgchartMemberList.innerHTML = '';
						if(data.length ===0) {
							orgchartMemberList.innerHTML = '소속 된 인원이 없습니다. <br>';
						}else{
							orgchartMemberList.innerHTML = '소속 인원 <br>';
                        }

	                    console.log("부서 참여자",data);
						data.map(item => {
							orgchartMemberList.innerHTML += `<span>\${item.memberName && item.memberName}</span><br>`
                        })
                    })
                // 누른것이 departmentId 랑 같으면 그 해당부서 이름이 나옴
                orgData.filter(item => item.orgchartId == departmentId).forEach(item =>  {
                        orgNameInput.value = item.departmentName;
                    }
                )

                orgData.forEach((item) => {
                    if (item.orgchartId !== departmentId) { // 선택된 부서를 제외한 모든 부서를 옵션으로 추가
                        let option = document.createElement('option');
                        option.text = item.departmentName;
                        option.value = item.orgchartId; // 부서 코드를 value로 설정
	                    option.dataset.departmentId = item.orgchartId;
	                    superiorDepartmentSelect.add(option);
                    }
                });
            }
            // 모달을 보이게 설정
            modal.style.display = 'block';
        });

		superiorDepartment.addEventListener('change', (e) => {
			let option = e.target.options[e.target.selectedIndex];
            updateOrgObj.seniorDepartmentId = option.dataset.departmentId;
			console.log(updateOrgObj);
		})

		editDepartmentForm.addEventListener('submit', (e) => {
            e.preventDefault();
			updateOrgObj.departmentName = orgNameInput.value;
			updateOrgObj.companyId = companyId;
			console.log("orgNameInput.value",orgNameInput.value)
			headers['Content-Type'] = 'application/json'
			headers['accept'] = 'application/json'
			if(updateOrgObj.seniorDepartmentId === ''){
				delete updateOrgObj.seniorDepartmentId;
            }
			console.log(JSON.stringify(updateOrgObj))
			axios.post(`/ourmine/company/\${companyId}/orgchart/orgchartUpdate`,JSON.stringify(updateOrgObj),{headers:headers})
                .then(resp => {
					let data = resp.data
                    if(data > 0){
	                    editCancel.click();
	                    drawChart();
                    }
                })
        })


		// x 버튼을 누르면꺼짐
		editModalClose.addEventListener('click', () => {
			document.getElementById('editDepartmentModal').style.display = "none";
        })


        // 취소버튼을 누르면 꺼짐
       editCancel.addEventListener('click', () => {
	       document.getElementById('editDepartmentModal').style.display = "none";
	   });

		let span = document.getElementsByClassName("close")[0];

		span.onclick = function() {
			let modal = document.getElementById('modal');
			modal.style.display = "none";
		}

		window.onclick = function(event) {
			let modal = document.getElementById('modal');
			if (event.target == modal) {

				modal.style.display = "none";
			}
		}
	}

	drawChart();


// ----------------------------- 추가 모달 ---------------------------------
	let addOrgChartButton = document.getElementById('addOrgChartButton');
	let addOrgModal = document.getElementById('addOrgModal');
	let close = document.getElementsByClassName('close')[0];
	let addOrgForm = document.getElementById('addOrgForm');
    let cancel = document.querySelector('.cancel');
    let seniorOrg = document.querySelector('#seniorOrg');
	const orgInput = document.getElementById('org');



  addOrgChartButton.addEventListener('click', () => {
		 addOrgModal.style.display = "block";
		 console.log(org);
	    seniorOrg.innerHTML  = '';
	  axios.get(`/ourmine/company/\${companyId}/orgchart/orgchartListJson`,{headers:headers})
		  .then(resp => {
			  let data = resp.data
			  data.map(item => seniorOrg.innerHTML += `<option class="departmentName" data-department=\${item.orgchartId}>\${item.departmentName}</option>`)
		  })

 })

	close.onclick = function() {
	    addOrgModal.style.display = "none";
	}

	window.onclick = function(e) {
	    if (e.target === addOrgModal) addOrgModal.style.display = "none";
    }

    const orgObj = {
	    departmentName : '',
	    seniorDepartmentId : '',
    }

	 cancel.addEventListener('click', () => {
		addOrgModal.style.display = 'none';
    })
    seniorOrg.addEventListener('change', (e) => {
	    let option = e.target.options[e.target.selectedIndex];
	    orgObj.seniorDepartmentId = option.getAttribute('data-department');

    })


	addOrgForm.addEventListener('submit', (e) => {
		headers['Content-Type'] = 'application/json'
		headers['accept'] = 'application/json'
		e.preventDefault();
		console.log("orgObj.seniorDepartmentId =" , orgObj.seniorDepartmentId );
		console.log("seniorOrg?.options?.[0]?.dataset?.department : ", seniorOrg?.options?.[0]?.dataset?.department);
        if( (orgObj.seniorDepartmentId === null || orgObj.seniorDepartmentId === '') && seniorOrg?.options?.[0]?.dataset?.department){
			orgObj.seniorDepartmentId = seniorOrg.options[0].dataset.department;
	        console.log("orgObj.seniorDepartmentId = ",orgObj.seniorDepartmentId)
	        console.log('옵셔널체이닝');
        }
		if(orgInput.value.trim() === ''){
			console.log('input값 공백')
			return false;
        }
		orgObj.departmentName  = orgInput.value;
		console.log (orgObj.departmentName)
		if(orgObj.seniorDepartmentId === ''){
			console.log('널값 들어감');
			orgObj.seniorDepartmentId = null;
			console.log(orgObj);
        }
        console.log(JSON.stringify(orgObj));
		axios.post(`/ourmine/company/${companyId}/orgchart/orgchartInsert`,orgObj,{headers: headers})
            .then(resp => {
				let data  = resp.data;
				if(data > 0){
					orgInput.value = '';
					drawChart();
					cancel.click();

                }
            })
	})

    const deleteOrgId = {
        orgchartId : '',
    }
    // ----------------------------- 삭제 모달 ---------------------------------
    let addOrgChartDeleteButton = document.querySelector('#addOrgChartDeleteButton');
    let deleteOrgModal = document.querySelector('#deleteOrgModal');
    let deleteCancel = document.querySelector('.deleteCancel');
    let deleteOrg = document.querySelector('#deleteOrg');
    let deleteOrgForm = document.querySelector('#deleteOrgForm');

  addOrgChartDeleteButton.addEventListener('click', () => {
	  deleteOrgModal.style.display = 'block';
	  deleteOrg.innerHTML = '';
	  deleteOrgSpan.innerHTML = '';

	  console.log('딜리트 클릭함');
	  axios.get(`/ourmine/company/\${companyId}/orgchart/orgchartListJson`,{headers:headers})
          .then(resp => {
			 let data = resp.data
              data.map(item => deleteOrg.innerHTML += `<option class="departmentName" data-department=\${item.orgchartId}>\${item.departmentName}</option>`)
          })
  })

    deleteOrg.addEventListener('change', (e) => {
        let option = e.target.options[e.target.selectedIndex];
        deleteOrgId.orgchartId = option.getAttribute('data-department');
        console.log("deleteOrgId.orgchartId",deleteOrgId.orgchartId);
    })

  deleteCancel.addEventListener('click', () => {
	  deleteOrgModal.style.display = 'none';
  })

    deleteOrgForm.addEventListener('submit', (e) => {
		e.preventDefault();
		if(deleteOrgId.orgchartId === ''){
			deleteOrgSpan.innerHTML = '부서를 선택하시지 않으셨습니다. 부서를 선택해주세요';
			deleteOrgSpan.style.color = '#000080';
			return false;
        }
	    headers['Content-Type'] = 'application/json';
	    headers['accept'] = 'application/json';
        console.log("삭제할때의 json 데이터 ",JSON.stringify(deleteOrgId));
        axios.post(`/ourmine/company/\${companyId}/orgchart/orgchartDelete`,JSON.stringify(deleteOrgId),{headers : headers})
            .then(resp => {
                let data  = resp.data;
                if(data > 0){
                    drawChart();
	                addOrgChartDeleteButton.click();
                    deleteCancel.click();
                }
            })
    })
// 직원 부서배치
    addOrgMember = {
	  memberId  : '',
       orgchartId : '',
    }


		addMemberOrgInsert.addEventListener('click', async () => {
			headers['Content-Type'] = 'application/json'
			headers['accept'] = 'application/json'
			memberInsert.style.display = 'block';
			addMemberList.innerHTML = '';
			departmentList.innerHTML = '';

		await 	axios.get(`/ourmine/company/\${companyId}/orgchart/orgchartAddMemberListJson`,{headers:headers})
				.then(resp => {
					let data  = resp.data;
					console.log(data);
					data.map(item => {
						if(item.departmentName !== null){
							addMemberList.innerHTML += `<option data-memberid=\${item.memberId}>\${item.memberName} (  \${item.departmentName} )</option>`
						}else {
							let newVar = item.departmentName ?? '소속된부서가 없습니다.';
							addMemberList.innerHTML += `<option data-memberid=\${item.memberId}>\${item.memberName} ( \${newVar} )</option>`
						}
					})
				})
		await 	 axios.get(`/ourmine/company/\${companyId}/orgchart/orgchartListJson`,{headers:headers})
				.then(resp => {
					let data = resp.data;
					console.log("orgchartListJson = ",data);
					data.map(item => departmentList.innerHTML += `<option data-orgchartid=\${item.orgchartId}>\${item.departmentName}</option>`)
				})
		})



    addMemberList.addEventListener('change', (e) => {
	    let option = e.target.options[e.target.selectedIndex];
	    let select = option.getAttribute('data-memberid');
	    addOrgMember.memberId = select;
	    console.log("addOrgMember.memberId  = ",addOrgMember.memberId );
    })
    departmentList.addEventListener('change', (e) => {
	    let option = e.target.options[e.target.selectedIndex];
	    let select = option.getAttribute('data-orgchartid');
	    addOrgMember.orgchartId = select;
	    console.log("addOrgMember.orgchartId  = ",addOrgMember.orgchartId );
    })
    saveCancel.addEventListener('click', () => {
	    memberInsert.style.display = 'none';

	    addMemberList.innerHTML = '';
	    departmentList.innerHTML = '';

    })

    memberInsertForm.addEventListener('submit', (e) => {
		e.preventDefault();
		if(addOrgMember.memberId === ''){
			addMemberList.options[0].value;
			addOrgMember.memberId = addMemberList.options[0].dataset.memberid;
			console.log("addOrgMember.memberId = ",addOrgMember.memberId);
        }
		if(addOrgMember.orgchartId === ''){
			addOrgMember.orgchartId = departmentList.options[0].dataset.orgchartid;
			console.log("addOrgMember.orgchartId = ",addOrgMember.orgchartId);
        }
	    headers['Content-Type'] = 'application/json'
	    headers['accept'] = 'application/json'
		axios.post(`/ourmine/company/${companyId}/orgchart/orgchartMember`,addOrgMember,{headers:headers})
            .then(resp => {
	            saveCancel.click();
				let data = resp.data;
				console.log("멤버추가데이터",data);
	            if(data > 0){
		            addMemberList.innerHTML = '';
		            departmentList.innerHTML = '';
		           addMemberOrgInsert.click();
		            saveCancel.click();
                }else{
		            addMemberList.innerHTML = '';
		            departmentList.innerHTML = '';
                }
            })
    })






</script>