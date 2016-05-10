<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
    pageContext.setAttribute("basePath", request.getContextPath()+"/") ;
%>

	<link href="${basePath}css/onsen-css-components.css" rel="stylesheet" type="text/css" />
	<link href="${basePath}css/onsenui.css" rel="stylesheet" type="text/css" />
	
	<link href="${basePath}css/MyCss.css" rel="stylesheet" type="text/css" />

	<script type="text/javascript" src="${basePath}js/angular/angular.js"></script>
	<script type="text/javascript" src="${basePath}js/onsenui.js"></script>
	<script type="text/javascript" src="${basePath}js/jquery-1.11.3.min.js"></script>
	
	<script type="text/javascript" src="${basePath}js/common.js"></script>
	<script type="text/javascript" src="${basePath}js/SuperMap.Include.js"></script>
	
	<script type="text/javascript">
		var global_path= "/nsff/";
	</script>