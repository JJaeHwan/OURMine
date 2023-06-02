<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />

<title>OURmine</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="#" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${cPath}/resources/homepage/css/styles.css" rel="stylesheet" />

<!-- slider -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<!-- 그리드 -->
<script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.js"></script>

<script type="text/javascript" src="${cPath}/resources/js/jquery.serializeObject.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<!-- 토큰 -->
<script>
	$("meta[name='_csrf_parameter']").attr("content");
	headerName = $("meta[name='_csrf_header']").attr("content");
	headerValue = $("meta[name='_csrf']").attr("content");
	headers = {};
	headers[headerName] = headerValue;
	headers['Content-Type'] = 'application/json';
// 	headers['accept'] = 'application/json';

	const globalBeforeSend = function(xhr) {
		for(let name in headers){
			xhr.setRequestHeader(name, headers[name]);
		}
	}
</script>
	
<style type="text/css">
	#slider {
		position:relative;
		overflow: hidden;
		margin-left: -20px;
	}

	#slider .slides {
		width: 100%;
		margin:0;
		padding: 0;
	}

	#slider .slide {
		float: left;
		list-style-type: none;
	}

	#slider-nav {
		position:absolute;
		height:2em;
		bottom:0em;
		width:100%;
		cursor:default;
	}

	#slider-nav-prv {
		height:1.5em;
		line-height:1.5em;
		width:1.5em;
		text-align:center;
		position:absolute;
		left:0.5em;
		background:white;
	}

	#slider-nav-nxt {
		height:1.5em;
		line-height:1.5em;
		width:1.5em;
		text-align:center;
		position:absolute;
		right:0.5em;
		background:white;
	}

	#slider-nav-prv:hover, #slider-nav-nxt:hover {
		color:white;
		background:#484c7f;
	}

	#slider-nav-dot-con {
		text-align:center;
	}

	.slider-nav-dot {
		list-style:none;
		border: 0.15em solid #484c7f;
		box-sizing:border-box;
		width:1em;
		height:1em;
		display:inline-block;
		border-radius:50%;
		vertical-align:middle;
	}

	.slider-nav-dot:hover {
		background:#484c7f;
	}
	
	/* 공지게시판 */
	.notice {
		margin-top: 50px;		
		margin-bottom: 50px;
	}
	
	.noTitle {
		text-align: left;
		padding-bottom: 20px;
	}
	
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
		margin-left: 20px;
	}

	.topBtn {
		position: fixed;
		bottom: 8%; right: 1.3%;
	}
</style>

<!-- Responsive navbar-->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container px-lg-5">
        <a class="navbar-brand" href="#!">OURmine</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="#fnqNoticeboard">F&Q</a></li>
                <li class="nav-item"><a class="nav-link" href="#noticeboard">공지게시판</a></li>
                <li class="nav-item"><a class="nav-link" href="/ourmine/login">로그인</a></li>
                <li class="nav-item"><a class="nav-link active" href="/ourmine/member/memberJoin">회원가입</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Header-->
<header class="py-5">
    <div class="container px-lg-5">
        <div class="p-4 p-lg-5 bg-light rounded-3 text-center">
		    <div id="slider">
		        <ul class="slides">
		        	<!-- 구독 상품 -->
		            <li class="slide slide3">
		            	<div class="m-4 m-lg-5">
			            	<img src="https://flow.team/flow-renewal/homepage/flow/ko/assets/images/price/payment-3.png" />
			                <h1 class="display-6 fw-bold">Premium Plan</h1>
			                <p class="fs-4">장기적인 관리와 데이터 연동을 필요로 하는 기업을 위한 12개월 요금제</p>
			                <a href="/ourmine/subscribe/itemList.do" class="btn btn-primary btn-lg">SUBSCRIBE</a>
			            </div>
		            </li>
		            <li class="slide slide1">
		            	<div class="m-4 m-lg-5">
				            <img src="https://flow.team/flow-renewal/homepage/flow/ko/assets/images/price/payment-1.png" />
			                <h1 class="display-6 fw-bold">Basic Plan</h1>
			                <p class="fs-4">프로젝트에 초대받아 협업을 경험할 수 있는 1개월 체험용 요금제</p>
			                <a href="/ourmine/subscribe/itemList.do" class="btn btn-primary btn-lg">SUBSCRIBE</a>
			            </div>
		            </li>
		            <li class="slide slide2">
		            	<div class="m-4 m-lg-5">
				            <img src="https://flow.team/flow-renewal/homepage/flow/ko/assets/images/price/payment-2.png" />
			                <h1 class="display-6 fw-bold">Standard Plan</h1>
			                <p class="fs-4">업무 효율 향상과 비대면 근무 환경구축을 위한 합리적인 6개월 요금제</p>
			                <a href="/ourmine/subscribe/itemList.do" class="btn btn-primary btn-lg">SUBSCRIBE</a>
			            </div>
		            </li>
		            <li class="slide slide3">
		            	<div class="m-4 m-lg-5">
				            <img src="https://flow.team/flow-renewal/homepage/flow/ko/assets/images/price/payment-3.png" />
			                <h1 class="display-6 fw-bold">Premium Plan</h1>
			                <p class="fs-4">장기적인 관리와 데이터 연동을 필요로 하는 기업을 위한 12개월 요금제</p>
			                <a href="/ourmine/subscribe/itemList.do" class="btn btn-primary btn-lg">SUBSCRIBE</a>
			            </div>
		            </li>
		            <li class="slide slide1">
		            	<div class="m-4 m-lg-5">
				            <img src="https://flow.team/flow-renewal/homepage/flow/ko/assets/images/price/payment-1.png" />
			                <h1 class="display-6 fw-bold">Basic Plan</h1>
			                <p class="fs-4">프로젝트에 초대받아 협업을 경험할 수 있는 1개월 체험용 요금제</p>
			                <a href="/ourmine/subscribe/itemList.do" class="btn btn-primary btn-lg">SUBSCRIBE</a>
			            </div>
		            </li>
		        </ul>
		    
		        <div id="slider-nav">
		            <div id="slider-nav-prv">&#10094;</div> <!-- 이전 이미지 보기 버튼 -->
		            <div id="slider-nav-nxt">&#10095;</div> <!-- 다음 이미지 보기 버튼 -->
		            <div id="slider-nav-dot-con">
		                <span class="slider-nav-dot" style="background:white" id="nav-dot1"></span>
		                <span class="slider-nav-dot" id="nav-dot2"></span>
		                <span class="slider-nav-dot" id="nav-dot3"></span>
		            </div>
		        </div>
		    </div>
        </div>
    </div>
</header>

<!-- Page Content-->
<section class="pt-4">
    <div class="container px-lg-5">
        <!-- Page Features-->
        <div class="row gx-lg-5">
        	<!-- 기능 설명 -->
        	<!-- 캘린더 -->
        	<div class="col-lg-6 col-xxl-4 mb-5">
                <div class="card bg-light border-0 h-100">
                    <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                        <div class="feature bg-dark bg-gradient text-white rounded-3 mb-4 mt-n4"><i class="bi bi-calendar2-week"></i></div>
                        <h2 class="fs-4 fw-bold">캘린더</h2>
                        <p class="mb-0">회의・미팅・출장 등 일정을 쉽고 빠르게 공유할 수 있습니다.</p>
                    </div>
                </div>
            </div>
            <!-- 파일함 -->
            <div class="col-lg-6 col-xxl-4 mb-5">
                <div class="card bg-light border-0 h-100">
                    <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                        <div class="feature bg-dark bg-gradient text-white rounded-3 mb-4 mt-n4"><i class="bi bi-folder"></i></div>
                        <h2 class="fs-4 fw-bold">파일함</h2>
                        <p class="mb-0">프로젝트 별 파일과 자료를 무기한 보관하고 신속히 검색해 찾아볼 수 있습니다.</p>
                    </div>
                </div>
            </div>
            <!-- 채팅 -->
            <div class="col-lg-6 col-xxl-4 mb-5">
                <div class="card bg-light border-0 h-100">
                    <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                        <div class="feature bg-dark bg-gradient text-white rounded-3 mb-4 mt-n4"><i class="bi bi-chat"></i></div>
                        <h2 class="fs-4 fw-bold">채팅</h2>
                        <p class="mb-0">조직 구성원의 연락처・이메일을 확인 후 보다 빠르고 정확한 업무 소통을 할 수 있습니다.</p>
                    </div>
                </div>
            </div>
            <!-- 간트차트 -->
            <div class="col-lg-6 col-xxl-4 mb-5">
                <div class="card bg-light border-0 h-100">
                    <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                        <div class="feature bg-dark bg-gradient text-white rounded-3 mb-4 mt-n4"><i class="bi bi-bar-chart-steps"></i></div>
                        <h2 class="fs-4 fw-bold">간트차트(WBS)</h2>
                        <p class="mb-0">직관적인 차트와 그리드 형태를 기반으로 프로젝트 계획, 실행을 유연하게 관리할 수 있습니다.</p>
                    </div>
                </div>
            </div>
            <!-- 코드에디터 -->
            <div class="col-lg-6 col-xxl-4 mb-5">
                <div class="card bg-light border-0 h-100">
                    <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                        <div class="feature bg-dark bg-gradient text-white rounded-3 mb-4 mt-n4"><i class="bi bi-code"></i></div>
                        <h2 class="fs-4 fw-bold">코드에디터</h2>
                        <p class="mb-0">효율적으로 코드를 작성하고 프로젝트를 완성할 수 있습니다.</p>
                    </div>
                </div>
            </div>
            <!-- 알림 -->
            <div class="col-lg-6 col-xxl-4 mb-5">
                <div class="card bg-light border-0 h-100">
                    <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                        <div class="feature bg-dark bg-gradient text-white rounded-3 mb-4 mt-n4"><i class="bi bi-bell"></i></div>
                        <h2 class="fs-4 fw-bold">알림</h2>
                        <p class="mb-0">동일 프로젝트 구성원들의 업무 진행 상태가 실시간 알림으로 전달되어 업무 공유가 편리해집니다.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- F&Q 게시판 -->
<div class="container px-lg-5 fnqNotice">
    <div class="p-4 p-lg-5 bg-light rounded-3 text-center" id="fnqNoticeboard">
        <div class="m-2 m-lg-2" >
            <h3 class="fw-bold noTitle">F&Q게시판</h3>
			<div id="fnqGrid" style="height: 400px; width: 100%;" class="ag-theme-alpine"></div>
        </div>
    </div>
</div>

<!-- 공지 게시판 -->
<div class="container px-lg-5 notice">
    <div class="p-4 p-lg-5 bg-light rounded-3 text-center" id="noticeboard">
        <div class="m-2 m-lg-2" >
            <h3 class="fw-bold noTitle">공지게시판</h3>
			<div id="noticeGrid" style="height: 400px; width: 100%;" class="ag-theme-alpine"></div>
        </div>
    </div>
</div>

<!-- top 버튼 -->
<div class="topBtn">
	<a class="feature text-secondary" href="#">
		<i class="bi bi-arrow-bar-up"></i>
	</a>
</div>

<!-- 문의채팅 -->
<script type="text/javascript">
	var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
	(function(){
	var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
	s1.async=true;
	s1.src='https://embed.tawk.to/644f9bb74247f20fefeeb661/1gvbfghce';
	s1.charset='UTF-8';
	s1.setAttribute('crossorigin','*');
	s0.parentNode.insertBefore(s1,s0);
	})();
</script>

<!-- 상세조회 모달 -->
<!-- F&Q게시판 -->
<form id="fnqSelectForm">
	<div class="modal" id="fnqSelectModal" >
		<div class="modal-dialog">
			<div class="modal-content card mb-3" id="fnqSelectContent">
				<div class="card-body">
					<div class="row g-3 align-items-center">
						<div class="col-md-12">
							<div class="form-group">
								<label>게시글번호</label>
								<input type="text" id="rnum" name="rnum" class="form-control" disabled>
								<input type="hidden" id="noticeBoardWriteId" name="noticeBoardWriteId" class="form-control" disabled>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label>제목</label>
								<input type="text" id="noticeBoardTitle" name="noticeBoardTitle" class="myModal-title form-control" disabled>
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
						<button type="button" class="btn btn-secondary" onclick="fnqModalClose()">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

<!-- 공지게시판 -->
<form id="selectForm">
	<div class="modal" id="selectModal" >
		<div class="modal-dialog">
			<div class="modal-content card mb-3" id="selectContent">
				<div class="card-body">
					<div class="row g-3 align-items-center">
						<div class="col-md-12">
							<div class="form-group">
								<label>게시글번호</label>
								<input type="text" id="rnum" name="rnum" class="rnum form-control" disabled>
								<input type="hidden" id="noticeBoardWriteId" name="noticeBoardWriteId" class="form-control" disabled>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label>제목</label>
								<input type="text" id="noticeBoardTitle" name="noticeBoardTitle" class="myModal-title form-control" disabled>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label>작성자</label>
								<input type="text" id="noticeBoardWriter" name="noticeBoardWriter" class="noticeBoardWriter form-control" disabled>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label>작성일자</label>
								<input type="text" id="noticeBoardWriteDate" name="noticeBoardWriteDate" class="noticeBoardWriteDate form-control" disabled>
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
								<textarea id="noticeBoardContent" name="noticeBoardContent" class="noticeBoardContent form-control" rows="5" cols="30" disabled></textarea>
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
</form>

<!-- Footer-->
<footer class="py-5 bg-dark">
    <div class="container"><p class="m-0 text-center text-white">Copyright &copy; OURmine Galaxy[5] 2023</p></div>
</footer>

<!-- ========================================================================================= -->    
<script>
$(function() {
	// 이미지 슬라이더
	var width = 1160; //슬라이드 한 개의 폭
	var height = 450; //슬라이드 높이
	var animationSpeed = 2000; //화면전환 속도
	var pause = 5000; //화면전환 후 일시 정지 속도
	var totalSlides = 5; //복제 슬라이드를 포함한 전체 슬라이드 개수

	var currentSlide = 2; //이 항목은 수정하지 않음
	var interval;
	var action;
	var dotNum;
	var dMinusC;

	//cache DOM elements
	var $slideCon = $('#slider');
	var $slideUl = $('.slides');
	var $slides = $('.slide');
	var $dots = $('.slider-nav-dot');
	var $sliderNavPrv = $('#slider-nav-prv');
	var $sliderNavNxt = $('#slider-nav-nxt');

	function initSlider(){
		$slideCon.css('width',width);
		$slideCon.css('height',height);
		$slideUl.css('margin-left',-width);
		$slideUl.css('width',totalSlides*width);
		$slides.css('width',width);
		$slides.css('height',height);
	}

	function startSlider(action, dotNum) {
		if(action == 'prv'){
			$slideUl.animate({'margin-left': '+='+width}, animationSpeed, function() {
				if (--currentSlide === 1) {
					currentSlide = $slides.length-1;
					$slideUl.css('margin-left', -($slides.length-2)*width);
				}else{}

				for(var i=0; i<$dots.length; i++){$dots[i].style.background = "";}
				$dots[currentSlide-2].style.background = "#484c7f";
			});
		} else if(action == 'nxt') {
			$slideUl.animate({'margin-left': '-='+width}, animationSpeed, function() {
				if (++currentSlide === $slides.length) {
					currentSlide = 2;
					$slideUl.css('margin-left', -width);
				}else{}

				for(var i=0; i<$dots.length; i++){$dots[i].style.background = "";}
				$dots[currentSlide-2].style.background = "#484c7f";
			});
		} else if(action == 'dot') {
			dMinusC = dotNum-currentSlide;
			currentSlide = dotNum;

			for(var i=0; i<$dots.length; i++){$dots[i].style.background = "";}
			$dots[currentSlide-2].style.background = "#484c7f";

			$slideUl.animate({'margin-left': '-='+(dMinusC*width)}, animationSpeed);

		} else {
			// setInterval(function,milliseconds)
			// 지정한 시간에 한번씩 함수를 실행
			// 5초 마다 $slideUl 의 왼쪽 마진을 -width 함. 에니메이션 속도는 2초.
			interval = setInterval(function() {

				//.animate( CSS properties [, duration ] [, complete ] )
				$slideUl.animate({'margin-left': '-='+width}, animationSpeed, function() {
					if (++currentSlide === $slides.length) { // $slides.length == 5
						currentSlide = 2;
						$slideUl.css('margin-left', -width);
					}

					for(var i=0; i<$dots.length; i++){$dots[i].style.background = "";}
					$dots[currentSlide-2].style.background = "#484c7f";
				});	

			}, pause);
		}
	}

	function pauseSlider() {
		clearInterval(interval);
	}

	function prvSlide(){
		startSlider('prv');
	}

	function nxtSlide(){
		startSlider('nxt');
	}

	function dotSelected(){
		dotNum = $(this).attr('id');
		dotNum = parseInt(dotNum.substring(7))+1;
		startSlider('dot', dotNum);
	}

	$slideUl
		.on('mouseenter', pauseSlider)
		.on('mouseleave', startSlider);

	$sliderNavPrv
		.on('click',prvSlide)
		.on('mouseenter', pauseSlider)
		.on('mouseleave', startSlider);

	$sliderNavNxt
		.on('click',nxtSlide)
		.on('mouseenter', pauseSlider)
		.on('mouseleave', startSlider);

	$dots
		.on('click', dotSelected)
		.on('mouseenter', pauseSlider)
		.on('mouseleave', startSlider);		

	initSlider();
	startSlider();
});
	
//<!-- ========================================================================================= -->
	//모달 열기 / 닫기
	// fnq게시판
	const fnqModal = document.querySelector("#fnqSelectModal");
	let fnqFiles = document.getElementById('files');
	const fnqAdd = (a,b) => a + b;

	// const noticeBoard = {
	// 	noticeBoardWriteId : '',
	// }

	const fnqModalOpen = () => {
		fnqModal.style.display = "block";    // 보이게

		headers['Content-Type'] = 'application/json'
		headers['accept'] = 'application/json'
		console.log("JSON.stringify(noticeBoard) = ",JSON.stringify(noticeBoard))
		axios.get(`/ourmine/noticeBoard/noticeBoardSelect/\${noticeBoard.noticeBoardWriteId}`, {headers:headers})
				.then(resp => {
					let data = resp.data;
					console.log(data);
					files.innerHTML += data.files.map(item => item.original !== null ?  `<a href="/ourmine/uploadAAA/\${item.uuid}" download="\${item.original}">\${item.original}<a><br>` : `<a></a>`).join('');
				});
	}
	const fnqModalClose = () => {
		fnqModal.style.display = "none";    // 안보이게
		fgetData();
	}
	
	// 공지게시판
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
					let data = resp.data;
					console.log(data);
					files.innerHTML += data.files.map(item => item.original !== null ?  `<a href="/ourmine/uploadAAA/\${item.uuid}" download="\${item.original}">\${item.original}<a><br>` : `<a></a>`).join('');
				});
	}
	const modalClose = () => {
		myModal.style.display = "none";    // 안보이게
		fgetData();
	}

//<!-- ========================================================================================= -->
	// F&Q게시판 리스트
	const fnqGridDiv = document.querySelector("#fnqGrid");

    const fnqColumnDefs = [
        { field: "rnum", headerName: "번호", maxWidth: 100, cellStyle: {textAlign: 'center'} },
        { field: "noticeBoardTitle", headerName: "제목", maxWidth: 230, cellStyle: {textAlign: 'left'} },
        { field: "noticeBoardContent", headerName: "내용", minWidth: 200, cellStyle: {textAlign: 'left'} },
        { field: "noticeBoardWriter", headerName: "작성자", maxWidth: 130, cellStyle: {textAlign: 'center'} },
        { field: "noticeBoardWriteDate", headerName: "작성일자", maxWidth: 130, cellStyle: {textAlign: 'center'} }
    ];
    
    const fnqGridOptions = {
        defaultColDef: {    // 일일이 컬럼에 정의하지 않고 한번에 기본 옵션 설정!
            sortable: true,
            filter: true,
            resizable: true,
            editable: false
        }, 
        columnDefs: fnqColumnDefs, 
        pagination: true,
//         paginationPageSize: 5,
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
            $(".myModal-title").val(noticeBoardVO.noticeBoardTitle);
            $("#noticeBoardWriteId").val(noticeBoardVO.noticeBoardWriteId);
            $("#rnum").val(noticeBoardVO.rnum);
    		$("#category").val(noticeBoardVO.category);
            $("#noticeBoardWriter").val(noticeBoardVO.noticeBoardWriter);
            $("#noticeBoardWriteDate").val(noticeBoardVO.noticeBoardWriteDate);
            $("#noticeBoardContent").html(noticeBoardVO.noticeBoardContent);
			$(".files").val(noticeBoardVO.files);
			
            fnqModalOpen();	// 보이게

        }
    };
    
    const fnqFgetData = () => {   // 데이터 가져오는 비동기처리 
        const xhr = new XMLHttpRequest();
        xhr.open("get","/ourmine/noticeBoard/fnqNoticeBoardListJson", true);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log("responseText 지현 : ", xhr.responseText);
                fnqGridOptions.rowData = JSON.parse(xhr.responseText);
				document.getElementById('fnqGrid').innerHTML="";
                new agGrid.Grid(fnqGridDiv, fnqGridOptions);
            }
        }
        xhr.send();
    }

    document.addEventListener('DOMContentLoaded', () => {
    	fnqFgetData(); // 가독성을 위해성 , 나중에 꺼내기
    });
    
//<!-- ========================================================================================= -->
	// 공지게시판 리스트
	const gridDiv = document.querySelector("#noticeGrid");

    const columnDefs = [
        { field: "rnum", headerName: "번호", maxWidth: 100, cellStyle: {textAlign: 'center'} },
        { field: "noticeBoardTitle", headerName: "제목", maxWidth: 230, cellStyle: {textAlign: 'left'} },
        { field: "noticeBoardContent", headerName: "내용", minWidth: 200, cellStyle: {textAlign: 'left'} },
        { field: "noticeBoardWriter", headerName: "작성자", maxWidth: 130, cellStyle: {textAlign: 'center'} },
        { field: "noticeBoardWriteDate", headerName: "작성일자", maxWidth: 130, cellStyle: {textAlign: 'center'} }
    ];
    
    const gridOptions = {
        defaultColDef: {    // 일일이 컬럼에 정의하지 않고 한번에 기본 옵션 설정!
            sortable: true,
            filter: true,
            resizable: true,
            editable: false
        },
		columnDefs: columnDefs,
        pagination: true,
//         paginationPageSize: 5,
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
            $(".rnum").val(noticeBoardVO.rnum);
        	$(".noticeBoardWriteId").val(noticeBoardVO.noticeBoardWriteId);
            $(".myModal-title").val(noticeBoardVO.noticeBoardTitle);
            $(".noticeBoardWriter").val(noticeBoardVO.noticeBoardWriter);
            $(".noticeBoardWriteDate").val(noticeBoardVO.noticeBoardWriteDate);
            $(".startDay").val(noticeBoardVO.startDay);
            $(".endDay").val(noticeBoardVO.endDay);
            $(".noticeBoardContent").html(noticeBoardVO.noticeBoardContent);
			$(".files").val(noticeBoardVO.files);
			
            modalOpen();	// 보이게

        }
    };
    
    const fgetData = () => {   // 데이터 가져오는 비동기처리 
        const xhr = new XMLHttpRequest();
        xhr.open("get","/ourmine/noticeBoard/noticeBoardListJson", true);
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 && xhr.status == 200) {
                console.log("responseText 지현 : ", xhr.responseText);
                gridOptions.rowData = JSON.parse(xhr.responseText);
//                 gridOptions.api.setRowData(JSON.parse(xhr.responseText));	// 덮어쓰는것
				document.getElementById('noticeGrid').innerHTML="";
                new agGrid.Grid(gridDiv, gridOptions);
            }
        }
        xhr.send();
    }

//     fgetData(); // 게시판 전체조회 ajax 바로 실행
    
    // setup the grid after the page has finished loading
    document.addEventListener('DOMContentLoaded', () => {
    	fgetData();
    });
    
</script>

<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="${cPath}/resources/homepage/js/scripts.js"></script>
