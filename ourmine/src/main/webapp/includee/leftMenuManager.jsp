<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<security:authentication property="principal" var="principal"/>
    <c:set var="companyId" value="${principal.realUser.companyId}" />

<!-- sidebar -->
<div class="d-flex flex-column h-100">
    <a href="/ourmine/index" class="mb-0 brand-icon">
        <span class="logo-icon" >	<!--  style="margin-left: 30px;" class="logo-icon" -->
            <img width="80" height="80" src="${cPath}/resources/images/sm/마스코트_투명.png">
        </span>
        <span class="logo-text">OURmine</span>
    </a>

    <!-- Menu: main ul -->
    <ul class="menu-list flex-grow-1 mt-3">
    	<hr>
        
        <!-- 회사정보 -->
        <!-- 회사정보 유무 체크 후 메뉴 출력 -->
        <c:set var="companyName" value="${principal.realUser.companyName }"/>
        <script>
        	let companyName = ${companyName};
        	console.log('companyName', companyName);
        </script>
               <c:if test="${empty companyName}">
			        <li class="collapsed">
			            <a class="m-link" href="/ourmine/company/companyForm">
			                <i class="icofont-contact-add"></i> <span>회사정보입력</span>
			            </a>
			        </li>
	           </c:if>
    
        <hr>
        
        <!-- 프로젝트 -->
        <li class="collapsed">
            <a class="m-link" data-bs-toggle="collapse" data-bs-target="#project-Components" href="#">
            	<security:authorize access="T(kr.or.ddit.commons.auth.AutorityUtils).inCompany(authentication, request)">
                <i class="icofont-home fs-5"></i> <span>프로젝트</span> <span class="arrow icofont-dotted-down ms-auto text-end fs-5"></span>
            	</security:authorize>
            </a>
            <!-- Menu: Sub menu ul -->
            <ul class="sub-menu collapse" id="project-Components">
                <li><a class="ms-link active" href="/ourmine/company/${companyId}/project/projectList"> <span>프로젝트</span></a></li>
                <li><a class="ms-link" href="#"> <span>통계</span></a></li>
            </ul>
        </li>

        <hr>

        <!-- 직원관리 -->
        <li  class="collapsed">
            <a class="m-link"  data-bs-toggle="collapse" data-bs-target="#employee-Components" href="#">
                <i class="icofont-users-alt-5"></i><span>직원관리</span> <span class="arrow icofont-dotted-down ms-auto text-end fs-5"></span>
            </a>
            <!-- Menu: Sub menu ul -->
            <ul class="sub-menu collapse" id="employee-Components">
                <li><a class="ms-link active" href="/ourmine/member/memberManagerList"><span>팀원</span></a></li>
                <li><a class="ms-link" href="/ourmine/company/companyMemberList"><span>가입신청자</span></a></li>
                <li><a class="ms-link" href="/ourmine/member/memberDelete"><span>퇴사자</span></a></li>
                <li><a class="ms-link" href="/ourmine/company/${companyId}/orgchart/orgchartList"><span>조직도</span></a></li>
            </ul>
        </li>
        
        <hr>

        <!-- 게시판 -->
        <li class="collapsed">
            <a class="m-link" data-bs-toggle="collapse" data-bs-target="#emp-Components" href="#">
                <i class="icofont-ui-clip-board"></i> <span>게시판</span> <span class="arrow icofont-dotted-down ms-auto text-end fs-5"></span>
            </a>
            <!-- Menu: Sub menu ul -->
            <ul class="sub-menu collapse" id="emp-Components">
                <li><a class="ms-link active" href="/ourmine/noticeBoard/noticeBoardList"> <span>OURMINE 공지게시판</span></a></li>
                <li><a class="ms-link" href="/ourmine/boardCoNotice/boardCoNoticList"> <span>사내공지게시판</span></a></li>
            </ul>
        </li>
        
        </ul>

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