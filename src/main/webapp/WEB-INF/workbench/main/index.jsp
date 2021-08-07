<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+
            request.getServerPort()+request.getContextPath();
%>
<%
    String Path = request.getScheme()+"://"+"www.nginx.com";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<%=Path%>jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=Path%>jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="<%=Path%>jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

</head>
<body>
	<img src="<%=Path%>/image/home.png" style="position: relative;top: -10px; left: -10px;"/>
</body>
</html>