<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<!-- axios -->
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

	<!-- jquery -->
	<script type="text/javascript" src="${cPath}/resources/js/jquery-3.6.3.min.js"></script>
	<script type="text/javascript" src="${cPath}/resources/js/jquery.serializeObject.min.js"></script>
	<!-- jquery UI -->
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
	<!-- Fancytree -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.fancytree/2.33.0/jquery.fancytree-all.min.js"></script>




<!-- ag-grid -->
	<script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.js"></script>

    <!-- plugin css file  -->
    <link rel="stylesheet" href="${cPath}/resources/css/jquery-nestable.css"/>
	<link rel="stylesheet" href="${cPath}/resources/js/sweetalert2/sweetalert2.min.css">

	<!-- project css file  -->
    <link rel="stylesheet" href="${cPath}/resources/css/my-task.style.min.css">

	<!-- projectIssue plugin css file   -->
	<link rel="stylesheet" href="${cPath}/resources/css/responsive.dataTables.min.css">
	<link rel="stylesheet" href="${cPath}/resources/css/dataTables.bootstrap5.min.css">
	<!-- jquery UI -->
	<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css" />
	<!-- Fancytree -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery.fancytree/2.33.0/skin-win8/ui.fancytree.min.css" />
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




