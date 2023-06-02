<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<style>
.todo-list li.active>span{
	 text-decoration:line-through;
	 color: var(--primary-color);
}
/* #memoDiv{
	margin-right: 85%;
}
#memoBody{
	margin-right: 85%;
} */

</style>

<!-- sidebar -->
<div class="d-flex flex-column h-100">
    <a href="/ourmine/index" class="mb-0 brand-icon">
        <span class="logo-icon" >	<!--  style="margin-left: 30px;" class="logo-icon" -->
            	<img width="80" height="80" src="${cPath}/resources/images/lg/마스코트_투명.png">
        </span>
        <span class="logo-text">OURmine</span>
    </a>

    <!-- Menu: main ul -->
    <ul class="menu-list flex-grow-1 mt-3">
    	<hr>
    	<!-- 프로젝트 -->
        <li  class="collapsed">
            <a class="m-link"  data-bs-toggle="collapse" data-bs-target="#project-Components" href="" >
                <i class="icofont-home fs-5"></i><span>프로젝트</span>
            </a>
             <ul class="sub-menu collapse" id="project-Components">
             <security:authentication property="principal" var="principal"/>

<%--              <c:forEach items="${principal.realUser.proAttendRole }" var="roleList"> --%>
<%--              	<c:set var="companyId" value="${roleList.companyId }"/> --%>
<%--              </c:forEach> --%>
			
				<c:set var="companyId" value="${principal.realUser.companyId }"/>
          	<script>
// 	         	let companyId = ${companyId}; 이거 회사 등록안되어있으면 에러뜸
// 	          	console.log("companyId : ", companyId) 
          	</script>
				<!-- 회사정보 등록되어있는지 체크 -->
				
				<c:if test="${companyId ne 0 }">
                	<li><a class="ms-link active" href="/ourmine/company/${companyId}/project/projectList"> <span>프로젝트</span></a></li>
				</c:if>
                
            </ul>
        </li>

        <hr>

         <!-- 파일함 -->
        <li class="collapsed">
            <a class="m-link" href="/ourmine/company/${companyId}/file/fileList">
                <i class="icofont-ui-folder"></i> <span>파일함</span>
            </a>
        </li>
        
                <!-- 메모장 -->
<!--         <li class="collapsed">
            <a class="m-link" href="/ourmine/memo">
                <i class="icofont-listing-number"></i> <span>메모장</span>
            </a>
        </li> -->
        

        <!-- GIT -->
<!--         <li class="collapsed"> -->
<!--             <a class="m-link" data-bs-toggle="collapse" data-bs-target="#git-Componentsone" href="#"> -->
<!--                 <i class="icofont-share-boxed"></i> <span>GIT</span> -->
<!--             </a> -->
<!--         </li> -->

      

        <!-- 구독 -->
        <c:if test="${companyId eq 0}">
	        <li class="collapsed">
	            <a class="m-link" href="/ourmine/subscribe/itemList.do">
	                <i class="icofont-pay"></i> <span>구독하기</span>
	            </a>
	        </li>
        </c:if>

        <!-- 게시판 -->
        <li class="collapsed">
            <a class="m-link" data-bs-toggle="collapse" data-bs-target="#board-Components" href="#">
                <i class="icofont-ui-clip-board"></i> <span>게시판</span> <span class="arrow icofont-dotted-down ms-auto text-end fs-5"></span>
            </a>
            <!-- Menu: Sub menu ul -->
            <ul class="sub-menu collapse" id="board-Components">
                <li><a class="ms-link active" href="/ourmine/noticeBoard/noticeBoardList"> <span>OURMINE 공지게시판</span></a></li>
                <li><a class="ms-link" href="/ourmine/boardCoNotice/boardCoNoticList"><span>사내공지게시판</span></a></li>
            </ul>
        </li>
    </ul>
    
    <hr>
    


       <!--  Body: Body -->
        <div class="body d-flex py-3" id="memoBody">
               <!--  <div class="row align-items-center">
                    <div class="border-0 mb-4">
                        <div id="memoDiv" class="card-header py-3 no-bg bg-transparent d-flex align-items-center px-0 justify-content-between border-bottom flex-wrap">
                            <h3 class="fw-bold mb-0">메모장</h3>
                            <div class="col-auto d-flex">
                                <button type="button" class="btn btn-secondary btn-todo-hide" onclick="toggleHide()">모두 지우기</button>
                            </div>
                        </div>
                    </div>
                </div> Row end  -->
                <div class="row mb-3">
                    <div class="col-12">
                        <div id="memoBody" class="card my-todo">
                            <div class="card-header border-bottom-0 todo-wrapper">
                                <h6>메모장</h6>
                                <hr>
                                <div class="input-group mb-2">
                                    <input style="font-size: 13px" type="text" class="form-control" id="TodoInput" >
                                    <button type="button" class="btn btn-primary btn-todo-add">추가</button>
                                </div>
                                <span class="todo-error text-danger small ms-3" style="display: none;">내용이 없습니다!</span>
                            </div>
                            <div class="card-body p-4">
                                <ul class="list-unstyled mb-0 todo-list">
									
                                </ul>
                            </div>
                        </div>
                    </div>
                </div><!--  Row end  -->
        </div>



    <!-- Theme: Switch Theme -->
    <ul class="list-unstyled mb-0">
        <li class="d-flex align-items-center justify-content-center">
            <div class="form-check form-switch theme-switch">
                <input class="form-check-input" type="checkbox" id="theme-switch">
                <label class="form-check-label" for="theme-switch">Enable Dark Mode!</label>
            </div>
        </li>
        <li class="d-flex align-items-center justify-content-center">
            <div class="form-check form-switch theme-rtl">
                <input class="form-check-input" type="checkbox" id="theme-rtl">
                <label class="form-check-label" for="theme-rtl">Enable RTL Mode!</label>
            </div>
        </li>
    </ul>

    <!-- Menu: menu collepce btn -->
    <button type="button" class="btn btn-link sidebar-mini-btn text-light">
        <span class="ms-2"><i class="icofont-bubble-right"></i></span>
    </button>
</div>
