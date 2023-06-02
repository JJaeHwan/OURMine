<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
.contextmenu {
  display: none;
  position: absolute;
  width: 200px;
  margin: 0;
  padding: 0;
  background: #FFFFFF;
  border-radius: 5px;
  list-style: none;
  box-shadow:
    0 15px 35px rgba(50,50,90,0.1),
    0 5px 15px rgba(0,0,0,0.07);
  overflow: hidden;
  z-index: 999999;
}

.contextmenu li {
  border-left: 3px solid transparent;
  transition: ease .2s;
}

.contextmenu li a {
  display: block;
  padding: 10px;
  color: #B0BEC5;
  text-decoration: none;
  transition: ease .2s;
}

.contextmenu li:hover {
  background: #484c7f;
  border-left: 3px solid #9C27B0;
}

.contextmenu li:hover a {
  color: #FFFFFF;
}
</style>

<div>
	<br>
	<ul class="nav nav-tabs tab-card" role="tablist">
	    <li class="nav-item"><a class="nav-link" href="/ourmine/company/${companyId}/project/${projectId}/dashBoard">대쉬보드</a></li>
	    <li class="nav-item"><a class="nav-link" href="/ourmine/company/${companyId}/project/${projectId}/projectWork">일감</a></li>
	    <li class="nav-item"><a class="nav-link" href="/ourmine/company/${companyId}/project/${projectId}/projectTodoList">TODO</a></li>
	    <li class="nav-item"><a class="nav-link" href="/ourmine/company/${companyId}/project/${projectId}/projectGantt">간트차트</a></li>
	    <li class="nav-item"><a class="nav-link" href="/ourmine/company/${companyId}/project/${projectId}/calendar">캘린더</a></li>
	    <li class="nav-item"><a class="nav-link" href="/ourmine/company/${companyId}/project/${projectId}/projectIssue">이슈</a></li>
	    <li class="nav-item"><a class="nav-link" href="/ourmine/company/${companyId}/project/${projectId}/codeWall">코드게시판</a></li>
	    <li class="nav-item"><a class="nav-link" href="/ourmine/company/${companyId}/project/${projectId}/git/gitList">GIT</a></li>
	    <li class="nav-item"><a class="nav-link" href="/ourmine/company/${companyId}/project/${projectId}/projectStatistics">통계</a></li>
		<li class="nav-item" >
			<select name="jidisp" style="border:none;position:relative;top:9px;" id="jidisp" onchange="fselChange(this)">
				<option value="0" selected>게시판</option>
			</select>
	    </li>
	</ul>
</div>


<script>

const jiDisp = document.querySelector("#jidisp");

function fselChange(p_this){

    if(p_this.value == 0) return; // 선택을 안함
	let boardTypeNum = p_this.value;
	if($("#myGrid").length>0){
	    fgetData(boardTypeNum);
	}else{
// 		$.ajax({
// 			url : "${cPath}/company/${companyId}/project/${projectId}/board/boardList",
// 			method : "",
// 			data : {typeNumber:boardTypeNum},
// 			dataType : "html"
// 		}).done(function(resp, textStatus, jqXHR) {
// 			$("#contentBody").html(resp);
// 		}).fail(function(jqXHR, status, error) {
// 			console.log(`상태코드 : \${status}, 에러메시지 : \${error}`);
// 		});;
	location.href="${cPath}/company/${companyId}/project/${projectId}/board/boardList?typeNumber="+boardTypeNum;
	}

}

const fboardList = function(resp){
	for(let i=0; i<resp.length; i++){
		let jOption = document.createElement("option");
		jOption.value = `\${resp[i].boardTypeId}`;
		jOption.innerHTML = `\${resp[i].boardType}`;
// 		if(jOption.value == ${param.typeNumber})
// 			jOption.selected="selected";
		jiDisp.appendChild(jOption);
	}
}
const boardTypeList =function(){
	$.ajax({
	  type:"get",
	  url:"/ourmine/company/${companyId}/project/${projectId}/boardType/boardTypeList",
	  async:true,
	  dataType:"json",
	  success:function(resp){
	      console.log("결과확인",resp);  // 요기 코드가 길어지면  별도 함수로 처리/ 그래야 가독성이 유지됨
	      fboardList(resp);
	  },
	  error: function (request, status, error) {
	      console.log("code: " + request.status)
	      console.log("message: " + request.responseText)
	      console.log("error: " + error);
	  }

	})
}

boardTypeList();   // 바로 실행하기 위해서 ㅣ호출

$(document).ready(function() {
	  // 현재 페이지 URL 가져오기
	  var currentUrl = window.location.pathname;

	  // 모든 링크 검사하여 현재 URL과 일치하는 링크에 active 클래스 추가
	  $('.nav-link').each(function() {
	    var linkUrl = $(this).attr('href');

	    if (linkUrl === currentUrl) {
	      $(this).addClass('active');
	    }
	  });
	});
</script>