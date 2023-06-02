<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
        <!-- OURmine 소개 -->
        <li class="collapsed">
            <a class="m-link" href="/ourmine/homepage">    <!-- active : 선택된 상황 -->
                <i class="icofont-monitor fs-5"></i> <span>OURmine</span>
            </a>
        </li>

        <hr>

        <!-- 구독상품 -->
        <li  class="collapsed">
            <a class="m-link"  data-bs-toggle="collapse" data-bs-target="#item-Components" href="/ourmine/item/itemList">
                <i class="icofont-credit-card"></i><span>구독상품</span>
            </a>
        </li>

        <hr>

        <!-- 회원정보 -->
        <li class="collapsed">
            <a class="m-link" data-bs-toggle="collapse" data-bs-target="#membership-Components" href="#">
                <i class="icofont-address-book"></i> <span>회원정보</span> <span class="arrow icofont-dotted-down ms-auto text-end fs-5"></span>
            </a>
            <!-- Menu: Sub menu ul -->
            <ul class="sub-menu collapse" id="membership-Components">
                <li><a class="ms-link" href="/ourmine/company/companyList"> <span>회사</span></a></li>
                <li><a class="ms-link" href="/ourmine/member/memberList"> <span>회원</span></a></li>
            </ul>
        </li>

        <hr>

        <!-- 공지게시판 -->
        <li class="collapsed">
            <a class="m-link" data-bs-toggle="collapse" data-bs-target="#notice-Components" href="#">
                <i class="icofont-ui-clip-board"></i> <span>공지게시판</span> <span class="arrow icofont-dotted-down ms-auto text-end fs-5"></span>
            </a>
            <!-- Menu: Sub menu ul -->
            <ul class="sub-menu collapse" id="notice-Components">
                <li><a class="ms-link" href="/ourmine/noticeBoard/noticeBoardList"> <span>공지게시판</span></a></li>
                <li><a class="ms-link" href="/ourmine/noticeBoard/fnqNoticeboardList" > <span>F&Q</span></a></li>	<!-- FNQ내용 -->
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