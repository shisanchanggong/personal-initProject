<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:include page="/WEB-INF/views/include/base-include.jsp">
	<jsp:param name="include" value="base" />
</jsp:include>
</head>
<body class="gray-bg">
	<div class="middle-box text-center animated fadeInDown">
		<h1>500</h1>
		<h3 class="font-bold">服务器内部错误</h3>
		<div class="error-desc">
			服务器好像出错了...<br /> 您可以返回主页看看<br /> <a href="/" class="btn btn-primary m-t">主页</a>
		</div>
	</div>
</body>
</html>