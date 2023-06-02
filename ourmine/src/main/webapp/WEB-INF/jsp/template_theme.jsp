<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	    <meta charset="utf-8">
	
	<security:csrfMetaTags/>
	<title><tiles:getAsString name="title" /></title>
	
	<tiles:insertAttribute name="preScript"/>
	
	<c:if test="${not empty message }">
	<script type="text/javascript">
	  window.addEventListener("DOMContentLoaded", function(){
	    Swal.fire({
	      icon: 'error',
	      title: 'Oops...',
	      text: '${message}'
	    })
	  });
	
	  $(document).ready(function(){
	    fn_changeBody("첫화면");
	  });
	
	  function fn_changeBody(url){
	    $("#bodyDiv").load(url);
	  };
	</script>
	</c:if>
	</head>

	<body id="page-top">
	
	  	<!-- Page Wrapper -->
		<div id="mytask-layout" class="theme-indigo">
	
		    <!-- Sidebar -->
		    <security:authorize access="hasRole('ADMIN')">
		        <div class="sidebar px-4 py-4 py-md-5 me-0">
		          <tiles:insertAttribute name="leftMenuAdmin" />
		        </div>
		    </security:authorize>
		    
		    <security:authorize access="hasRole('MANAGER')">
		        <div class="sidebar px-4 py-4 py-md-5 me-0">
		          <tiles:insertAttribute name="leftMenuManager" />
		        </div>
		    </security:authorize>
		    
		    <security:authorize access="hasRole('MEMBER')">
		        <div class="sidebar px-4 py-4 py-md-5 me-0">
		          <tiles:insertAttribute name="leftMenu" />
		        </div>
		    </security:authorize>
		    <!-- End of Sidebar -->
		
		    <!-- Content Wrapper -->
		    <!-- Main Content -->
		    <div class="main px-lg-4 px-md-4" id="content">
		
				<!-- Topbar -->
				<security:authorize access="hasRole('ADMIN')">
					<div class="header">
						<nav class="navbar py-4">
							<tiles:insertAttribute name="headerMenuAdmin" />
						</nav>
					</div>
				</security:authorize>
			
				<security:authorize access="hasAnyRole('MANAGER', 'MEMBER')">
					<div class="header">
						<nav class="navbar py-4">
							<tiles:insertAttribute name="headerMenu" />
						</nav>
					</div>
				</security:authorize>
				<!-- End of Topbar -->
				
				<!-- Begin Page Content -->
				<!-- Main Content -->
				<div>
					<nav>
						<tiles:insertAttribute name="bodynav" />
					</nav>
				</div>
				
				<div id="contentBody">
					<tiles:insertAttribute name="body" />
				</div>
		
		    </div>
		</div>
	
	<tiles:insertAttribute name="postScript" />
	</body>
</html>