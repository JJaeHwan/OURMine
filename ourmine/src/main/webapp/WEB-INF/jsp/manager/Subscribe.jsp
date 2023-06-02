<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<security:authentication property="principal" var="principal"/>
<c:set var="memberId" value="${principal.realUser.memberId }"/>
<c:set var="memberName" value="${principal.realUser.memberName }"/>
<c:set var="memberTel" value="${principal.realUser.memberTel }"/>
<c:set var="memberMail" value="${principal.realUser.memberEmail }"/>

<meta charset="UTF-8">
<meta name="_csrf_header" th:content="${_csrf.headerName}">
<meta name="_csrf" th:content="${_csrf.token}">

<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<!-- Favicons -->
<link rel="apple-touch-icon" href="/docs/5.2/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.2/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/5.2/assets/img/favicons/safari-pinned-tab.svg" color="#712cf9">
<link rel="icon" href="/docs/5.2/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#712cf9">

<style>
	body {
	  background-image: linear-gradient(180deg, #eee, #fff 100px, #fff);
	}

	.container {
	  max-width: 960px;
	}

	.pricing-header {
	  max-width: 700px;
	}

	.bd-placeholder-img {
	  font-size: 1.125rem;
	  text-anchor: middle;
	  -webkit-user-select: none;
	  -moz-user-select: none;
	  user-select: none;
	}

	@media (min-width: 768px) {
	  .bd-placeholder-img-lg {
	    font-size: 3.5rem;
	  }
	}

	.b-example-divider {
	  height: 3rem;
	  background-color: rgba(0, 0, 0, .1);
	  border: solid rgba(0, 0, 0, .15);
	  border-width: 1px 0;
	  box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
	}

	.b-example-vr {
	  flex-shrink: 0;
	  width: 1.5rem;
	  height: 100vh;
	}

	.bi {
	  vertical-align: -.125em;
	  fill: currentColor;
	}
</style>



<!--------------------------------------------------------------------------- template --------------------------------------------------------------------------->
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
  <symbol id="check" viewBox="0 0 16 16">
    <path d="M13.854 3.646a.5.5 0 0 1 0 .708l-7 7a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6.5 10.293l6.646-6.647a.5.5 0 0 1 .708 0z"/>
  </symbol>
</svg>

<div class="container py-3">
  <header>
  <div class="pricing-header p-3 pb-md-4 mx-auto text-center">
      <h3 class="display-5 fw-normal">구독상품</h3>
      <p class="fs-5 text-muted">합리적인 요금의 OURmine으로 업무 효율을 높여보세요.</p>
    </div>
  </header>
  <main>
    <div class="row row-cols-1 row-cols-md-3 mb-3 text-center">

      <c:forEach items="${itemList}" var="item">
      <div class="col">
        <div class="card mb-4 rounded-3 shadow-sm">
          <div class="card-header py-3">
            <h4 class="my-0 fw-normal">${item.itemName}</h4>
          </div>
          <div class="card-body">
	      	<input type="hidden" name="itemRadios" class="item-radio" value="${item.itemId}">
            <h1 class="card-title pricing-card-title" id="itemPrice-${item.itemId}" data-item-price="${item.itemPrice}">
			<c:set value="${item.itemPrice / (item.itemDuration / 30)}" var = "priceByMonth"/>
            <fmt:formatNumber type="number" maxFractionDigits="0" value="${priceByMonth }" /><small class="text-muted fw-light">/월</small></h1>
            <ul class="list-unstyled mt-3 mb-4">
              <li id="itemDuration-${item.itemId}" data-item-duration="${item.itemDuration}">
              	${item.itemDuration}일
              </li>
              <li id="itemContent-${item.itemId}" data-item-content="${item.itemContent}">
              	${item.itemContent}
              </li>

            </ul>
            <button type="button" class="w-100 btn btn-lg btn-primary">Get started</button>
          </div>
        </div>
      </div>
      </c:forEach>

    </div>

    <h2 class="display-6 text-center mb-4"></h2>

    <div class="table-responsive">
      <table class="table text-center">
        <thead>
          <tr>
            <th style="width: 34%;"></th>
            <th style="width: 22%;">Basic</th>
            <th style="width: 22%;">Standard</th>
            <th style="width: 22%;">Premium</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th scope="row" class="text-start">프로젝트 협업</th>
            <td><svg class="bi" width="24" height="24"><use xlink:href="#check"/></svg></td>
            <td><svg class="bi" width="24" height="24"><use xlink:href="#check"/></svg></td>
            <td><svg class="bi" width="24" height="24"><use xlink:href="#check"/></svg></td>
          </tr>
        </tbody>
        <tbody>
          <tr>
            <th scope="row" class="text-start">메신저</th>
            <td><svg class="bi" width="24" height="24"><use xlink:href="#check"/></svg></td>
            <td><svg class="bi" width="24" height="24"><use xlink:href="#check"/></svg></td>
            <td><svg class="bi" width="24" height="24"><use xlink:href="#check"/></svg></td>
          </tr>
        </tbody>
        <tbody>
          <tr>
            <th scope="row" class="text-start">인원 무제한</th>
            <td><svg class="bi" width="24" height="24"><use xlink:href="#check"/></svg></td>
            <td><svg class="bi" width="24" height="24"><use xlink:href="#check"/></svg></td>
            <td><svg class="bi" width="24" height="24"><use xlink:href="#check"/></svg></td>
          </tr>
        </tbody>
        <tbody>
          <tr>
            <th scope="row" class="text-start">시스템 버전 관리</th>
            <td><svg class="bi" width="24" height="24"><use xlink:href="#check"/></svg></td>
            <td><svg class="bi" width="24" height="24"><use xlink:href="#check"/></svg></td>
            <td><svg class="bi" width="24" height="24"><use xlink:href="#check"/></svg></td>
          </tr>
        </tbody>
        <tbody>
        </tbody>
      </table>
    </div>
  </main>

<!--     <button onclick="requestPay()">결제하기</button> 결제하기 버튼 생성 -->



<script>
var header = $("meta[name='_csrf_header']").attr('content');
var token = $("meta[name='_csrf']").attr('content');
var IMP = window.IMP;
IMP.init("imp33542555");
var today = new Date();
var hours = today.getHours(); // 시
var minutes = today.getMinutes();  // 분
var seconds = today.getSeconds();  // 초
var milliseconds = today.getMilliseconds();
var makeMerchantUid = hours +  minutes + seconds + milliseconds;

let memberName = "${memberName}";
let memberId = "${memberId}";
let memberTel = "${memberTel}";
let memberEmail = "${memberMail}";
let itemId = "";
let itemPrice ="";
let itemDuration="";
let itemNaem = "";


//버튼 요소들을 선택
const buttons = document.querySelectorAll('.btn');

// 각 버튼에 클릭 이벤트를 추가
buttons.forEach(button => {
  button.addEventListener('click', () => {
    // 클릭한 버튼의 부모 요소에서 필요한 정보를 선택
    const parent = button.closest('.card');

    // itemId 가져오기
    const itemIdElement = parent.querySelector('.item-radio');
    itemId = itemIdElement.value;
    console.log(itemId);

    // itemPrice 가져오기
    const itemPriceElement = parent.querySelector(`#itemPrice-\${itemId}`);
    console.log(itemPriceElement);
    itemPrice = parseInt(itemPriceElement.dataset.itemPrice);

    // itemDuration 가져오기
    const itemDurationElement = parent.querySelector(`#itemDuration-\${itemId}`);
    itemDuration = parseInt(itemDurationElement.dataset.itemDuration);

    // itemName 가져오기
    const itemNameElement = parent.querySelector(`h4.my-0.fw-normal`);
    itemName = itemNameElement.textContent;

    // 가져온 값들을 활용하여 원하는 작업을 수행
    console.log('itemId:', itemId);
    console.log('itemPrice:', itemPrice);
    console.log('itemDuration:', itemDuration);
    console.log('itemName:', itemName);

    requestPay();
  });
});





function requestPay() {
  
  IMP.request_pay({ // param
	  pg: "nice.nictest00m",
      pay_method: "card",
      merchant_uid: "IMP"+makeMerchantUid,
      name: itemName,
      amount: itemPrice,                        // 숫자 타입
      buyer_email: memberEmail,
      buyer_name: memberName,
      buyer_tel: memberTel,
      buyer_addr: memberId,
      buyer_postcode: itemId,
      custom_data: itemDuration,
      display: {
          card_quota: [6]  // 할부개월 6개월까지만 활성화
         }
  }, function (rsp) { // callback
	  console.log("rsp : {}", rsp);
      if (rsp.success) {
    	// 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
          // jQuery로 HTTP 요청
          jQuery.ajax({
        	  url : "/ourmine/subscribe/verifyiamport/" + rsp.imp_uid,
        	  dataType : "Json",
  			method: "POST",
  			beforeSend: function(xhr){
                xhr.setRequestHeader(header, token);
            }
          }).done(function (rsp) {
        	  console.log("rsp : ", rsp);
        	  console.log("response : ", rsp.response);
        	  console.log("buyer_addr : ", rsp.response.buyerAddr);
        	  succeedPay(rsp.response.buyerAddr, rsp.response.customData, rsp.response.impUid, rsp.response.buyerPostcode);
          })
      } else {
    	  var msg = '결제에 실패하였습니다.';
          msg += '에러내용 : ' + rsp.error_msg;
          Swal.fire({
            	icon: 'error',
    			  title: '결제에 실패하였습니다.',
            })
      }
  });
}
	
	function succeedPay(buyerAddr, customData, impUid, buyerPostcode){
		console.log("buyer_addr : ", buyerAddr);
		console.log("custom_data : ", customData);
		console.log("imp_uid : ", impUid);
		console.log("buyer_postcode : ", buyerPostcode);
		$.ajax({
            type : 'POST',
            url : '/ourmine/subscribe/paySuccess',
            dataType : "Json",
            contentType: "application/json; charset=utf-8",
            data : JSON.stringify({
              memberId: buyerAddr,
              subDuration: customData,
              subscribeUmpId : impUid,
              itemId: buyerPostcode
            }),
            beforeSend: function(xhr){
                xhr.setRequestHeader(header, token);
            },
            success : function(rsp){
            	console.log("rsp:", rsp);
    			Swal.fire({
    	        	  icon: 'success',
    				  title: '결제 성공!',
    	          }).then(function (){
		   	          location.href = "${cPath}"
    	          })
            },
            error : function(rsp){
            	var msg = "결제 실패";
                msg += "에러 내용 : " + rsp.error_msg;
                Swal.fire({
                	icon: 'error',
        			  title: '결제에 실패하였습니다.',
                })
            }
            

          })
	}


</script>
