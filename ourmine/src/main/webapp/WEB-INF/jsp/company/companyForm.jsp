<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>회원가입</title>
<style>
    #nextBtn{
        width: 380px;
    }
    .error {
        color: red;
    }
</style>
<script type="text/javascript">


$(document).ready(function(){
		$("#btnRegist").bind("click", function(){
			$("#frmRegist").submit();
		});
	})
</script>


<div id="mytask-layout" class="theme-indigo">

    <!-- main body area -->
    <div class="main p-2 py-3 p-xl-2">

        <!-- Body: Body -->
        <div class="body d-flex p-0 p-xl-2">
            <div class="container-xxl">

                <div class="row g-0">
                    <div class="col-lg-6 d-none d-lg-flex justify-content-center align-items-center rounded-lg auth-h100">
                        <div style="max-width: 40rem;">
                        	<img src="${cPath }/resources/images/interview.svg" alt="interview-img" style="max-width: 40rem;">
                        </div>
                    </div>

                    <div class="col-lg-6 d-flex justify-content-center align-items-center border-0 rounded-lg auth-h100">
                        <div class="w-100 p-3 p-md-5 card border-0 bg-dark text-light" style="max-width: 32rem;">
                            <!-- Form -->
                            <form id="frmRegist" class="row g-1 p-3 p-md-4" onsubmit="handleSubmit(event)">
                                <div class="col-12 text-center mb-1 mb-lg-5">
                                    <h1>회사 등록</h1>
                                </div>
                                <div class="col-12">
                                    <div class="mb-2">
                                        <label class="form-label">회사 이름</label>
                                        <input name="companyName" type="text" class="form-control form-control-lg" placeholder="주(삼성전자)" />
                                        <span id="companyName"></span>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="mb-2">
                                        <label class="form-label">회사 주소</label>
                                        <input name="companyAddr" type="text" class="form-control form-control-lg" placeholder="대전광역시 중구 오류동" />
                                        <span id="companyAddr"></span>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="mb-2">
                                        <label class="form-label">회사 전화번호</label>
                                        <input name="companyTel" type="tel" class="form-control form-control-lg" placeholder="042-628-0452" />
                                        <span id="companyTel"></span>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault" onchange="handelCheckChange()">
                                        <label class="form-check-label" for="flexCheckDefault">
                                            <a href="#" title="Terms and Conditions" class="text-secondary">서비스 이용약관, 개인정보 처리방침</a>을 확인하였고,이에 동의합니다.
                                        </label>
                                        <span id="termsCheck"></span>
                                    </div>
                                </div>
                                <div class="col-12 text-center mt-4">
                                    <button type="button" class="btn btn-lg btn-block btn-light lift text-uppercase" alt="SIGNUP" id="btnRegist">등록</button>
                                </div>
                            </form>
                            <!-- End Form -->
                        </div>
                    </div>
                </div> <!-- End Row -->
            </div>
        </div>
    </div>
</div>

<script>
    let companyName =  $('#companyName');
	let companyAddr =   $('#companyAddr');
    let companyTel =   $('#companyTel');
    let termsCheck =  $('#termsCheck');
    let isCheck = false
    const handelCheckChange = () => isCheck =!isCheck;

	const company = {
		companyName : '',
		companyAddr : '',
		companyTel : '',
    }
    const handleSubmit = (e) => {
	    e.preventDefault();
	    companyName.html('');
	    companyAddr.html('');
	    companyTel.html('');
	    $('#termsCheck').html('');
		let companyNameValue = $("input[name='companyName']").val();
		let companyAddrValue = $("input[name='companyAddr']").val();
		let companyTelValue = $("input[name='companyTel']").val();
		let isSubmit = true;
	    if(companyNameValue === ''){
		    companyName.html('회사 이름을 입력해주세요').css('color', 'red');
			isSubmit = false;
        }
	    if(companyAddrValue === ''){
		    companyAddr.html('회사 이름을 입력해주세요').css('color', 'red');
		    isSubmit = false;
        }
	    if(companyTelValue === ''){
		    companyTel.html('회사 이름을 입력해주세요').css('color', 'red');
		    isSubmit = false;
        }
		if( ! isCheck ){
			termsCheck.html('약관 체크를 해주세요').css('color','red');
			isSubmit = false;
        }

		if(isSubmit === false) return false;
        company.companyName = companyNameValue;
        company.companyTel = companyTelValue;
        company.companyAddr = companyAddrValue;
		console.log(company);
		console.log(JSON.stringify(company))

	    headers['Content-Type'] = 'application/json'
	    headers['accept'] = 'application/json'
	    fetch('/ourmine/company/companyForm',{
		    method : 'POST',
		    headers : headers,
		    body : JSON.stringify(company)
	    }).then(resp => resp.json())
		    .then(data => {
			    console.log(data)
			    if(data === -2){
				    termsCheck.html('이미 회사를 등록하셨습니다').css('color', 'red');
				    return false;
			    }
			    if(data > 0){
				    location.href = '/ourmine/member/memberView';
			    }
		    })
    }

</script>
