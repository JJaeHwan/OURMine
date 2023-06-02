<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<style>
    .pagination {
        display: flex;
        justify-content: center;
    }
</style>
<!-- 설렉트박스 -->
<div class="d-flex justify-content-end">
    <div class="dropdown">
        <button class="btn btn-primary dropdown-toggle companySelect" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
            전체
        </button>
        <ul class="dropdown-menu border-0 shadow p-3 companyList">

        </ul>
    </div>
</div>


<div class="row clearfix">
    <div class="col-md-12">
        <div class="card border-0 mb-4 no-bg">
            <div class="card-header py-3 px-0 d-flex align-items-center  justify-content-between border-bottom">
                <h3 class=" fw-bold flex-fill mb-0">직원 관리</h3>
            </div>
        </div>
    </div>
</div><!-- Row End -->

<div id="memberList" class="row g-3 row-cols-1 row-cols-sm-1 row-cols-md-1 row-cols-lg-2 row-cols-xl-2 row-cols-xxl-2 row-deck py-1 pb-4">


</div>

<nav aria-label="Page navigation example">
    <ul class="pagination">
        <li class="page-item" id="previousPage"><a class="page-link" href="#">Previous</a></li>
        <li class="page-item" style="display: flex" id="pageContainer"><a class="page-link" href="#">1</a></li>
        <li class="page-item" id="nextPage"><a class="page-link" href="#">Next</a></li>
    </ul>
</nav>


<script>
	headers['accept'] = 'application/json';
	headers['Content-Type'] = 'application/json';
	let companyList = document.querySelector('.companyList');
	let memberList = document.querySelector('#memberList');
	let companySelect = document.querySelector('.companySelect');

	let selectedCompanyId = 0;
 async   function adminCompanyList(){
	await 	axios.get('/ourmine/member/adminCompanyList',{headers:headers})
            .then(resp => {
				let data = resp.data;
	            console.log("companyList = ",data)
                companyList.innerHTML+= `<li><button class="dropdown-item py-2 rounded companyListItem" href="#">전체</button></li>`
                data.map(item => {
					companyList.innerHTML += `<li><button data-company=\${item.companyId} class="dropdown-item py-2 rounded companyListItem" href="#">\${item.companyName}</button></li>`
                })
            })
    }

	let currentPageIndex = 0; // 페이지 번호 배열의 시작 인덱스를 표시
	let pageSize = 6; // 한 페이지에 표시되는 데이터의 개수
	let displayPageCount = 5; // 한 번에 표시되는 페이지 번호의 개수
	let pagesArray = []; // 페이지 번호 배열을 전역 변수로 선언

	async function adminCompanyMemberList(){
		await axios.get('/ourmine/member/adminCompanyMemberList', {headers: headers})
			.then(resp => {
				let data = resp.data;
				console.log("adminCompanyMemberList = ", data)
				let totalItems = data[0].totalData; // 총 데이터 개수
				let totalPages = Math.ceil(totalItems / pageSize); // 총 페이지 개수
				pagesArray = Array.from({length: totalPages}, (_, i) => i + 1); // 페이지 번호 배열 생성
				memberList.innerHTML += createMemberCards(data);

				displayPages();
			})
	}

	function displayPages() {
		// 시작 인덱스부터 표시할 페이지 개수만큼의 페이지 번호를 가져옴
		let pagesToDisplay = pagesArray.slice(currentPageIndex, currentPageIndex + displayPageCount);
		document.querySelector('#previousPage').style.visibility = (currentPageIndex > 0) ? 'visible' : 'hidden';
		document.querySelector('#nextPage').style.visibility = (currentPageIndex + displayPageCount < pagesArray.length) ? 'visible' : 'hidden';
		document.querySelector('#pageContainer').innerHTML = pagesToDisplay
			.map(pageNumber => `<a href="#" data-page="\${pageNumber}" class="page-link pageItems">\${pageNumber}</a>`)
			.join('');
		setPageItemsEvent(); // 페이지 아이템들에 이벤트 리스너 설정
	}

	document.querySelector('#nextPage').addEventListener('click', () => {
		currentPageIndex += displayPageCount; // 페이지 번호 배열의 시작 인덱스를 변경
		displayPages(); // 다음 페이지 번호들을 표시
		setPageItemsEvent(); // 페이지 아이템들에 이벤트 리스너 설정
	    // 버튼 그룹
		fetchDataForPage(pagesArray[currentPageIndex]);
	});

	document.querySelector('#previousPage').addEventListener('click', () => {
		currentPageIndex -= displayPageCount; // 페이지 번호 배열의 시작 인덱스를 변경
		if(currentPageIndex < 0) { // 시작 인덱스가 0보다 작아지는 것을 방지
			currentPageIndex = 0;
		}
		displayPages(); // 이전 페이지 번호들을 표시
		setPageItemsEvent(); // 페이지 아이템들에 이벤트 리스너 설정
		// 버튼 그룹
		fetchDataForPage(pagesArray[currentPageIndex + displayPageCount - 1]);
	});

	function setPageItemsEvent() {
		let pageItems = document.querySelectorAll('.pageItems');
		console.log("pageItems = ", pageItems);
		pageItems.forEach(item => {
			item.addEventListener('click', (e) => {
				let {page} = e.target.dataset;
				console.log("page = ", page)
				fetchDataForCompany(selectedCompanyId, page);
			});
		});
	}
	function fetchDataForPage(pageNumber) {
		fetchDataForCompany(selectedCompanyId, pageNumber); // 선택된 회사의 특정 페이지 데이터 가져오기
	}
	function companyListMember(){
		let companyListItem = document.querySelectorAll('.companyListItem');
		companyListItem.forEach(item => {
			item.addEventListener('click', (e) => {
				companySelect.innerHTML =  e.target.innerHTML
				selectedCompanyId = e.target.dataset.company;
				console.log("selectedCompanyId = ", selectedCompanyId);
				currentPageIndex = 0; // 페이지 번호 배열의 시작 인덱스를 0으로 재설정
				fetchDataForCompany(selectedCompanyId, 1); // 첫 페이지의 회사 데이터 가져오기
            })
        })
    }
	function fetchDataForCompany(companyId, pageNumber) {
		axios.get('/ourmine/member/adminCompanyMemberList',{
			params : {
				companyId,
				page: pageNumber,
			}
		},{headers:headers})
			.then(resp => {
				let data = resp.data;
				memberList.innerHTML = createMemberCards(data);

				// 총 데이터 개수를 기반으로 페이지 수 다시 계산
				let totalItems = data[0].totalData;
				let totalPages = Math.ceil(totalItems / pageSize);
				pagesArray = Array.from({length: totalPages}, (_, i) => i + 1);

				// 페이지네이션 업데이트
				displayPages();
			})
	}

	// 첫 페이지 로딩시 이벤트 핸들러 설정
	adminCompanyList().then(adminCompanyMemberList).then(setPageItemsEvent).then(companyListMember)






    // 회원 html 그려주는 메소드
	function createMemberCards(data) {
		let content = '';
		data.map(item => {
			content += `
            <div class="col">
                <div class="card teacher-card">
                    <div class="card-body  d-flex">
                        <div class="profile-av pe-xl-4 pe-md-2 pe-sm-4 pe-4 text-center w220">
                            <img src="assets/images/lg/avatar3.jpg" alt="" class="avatar xl rounded-circle img-thumbnail shadow-sm">
                            <div class="about-info d-flex align-items-center mt-1 justify-content-center flex-column">
                                <h6 class="mb-0 fw-bold d-block fs-6 mt-2">\${item.companyName}</h6>
                            </div>
                        </div>
                        <div class="teacher-info border-start ps-xl-4 ps-md-3 ps-sm-4 ps-4 w-100">
                            <h6  class="mb-0 mt-2  fw-bold d-block fs-6">\${item.memberName}</h6>
                            <span class="py-1 fw-bold small-11 mb-0 mt-1 text-muted">\${item.memberName}</span>
                            <div class="video-setting-icon mt-3 pt-3 border-top">
                                <p>이메일: \${item.memberEmail}</p>
                            </div>
                            <div class="d-flex flex-wrap align-items-center ct-btn-set">
                                <a href="chat.html" class="btn btn-dark btn-sm mt-1 me-1"><i class="icofont-ui-text-chat me-2 fs-6"></i>\${item.subscribeEndDate}</a>
                                <a href="profile.html" class="btn btn-dark btn-sm mt-1"><i class="icofont-invisible me-2 fs-6"></i>D-\${item.subDay}</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `;
		})
		return content;
	}



</script>