<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:include page="/WEB-INF/views/include/base-include.jsp">
	<jsp:param name="include" value="base,layer" />
</jsp:include>

<title>登录</title>

<script type="text/javascript">
	$(function() {
		$("#btnLogin").click(function() {
			if ($("#loginName").val() != "" && $("#loginPassword").val() != "") {
				$.get(_ctxRoot + "/login", $("#loginForm").serialize(), function(returnVal) {
					if (returnVal.isSuccess) {
						window.location = _ctxRoot;
					} else {
						layer.msg(returnVal.message, {
							icon : 2
						});
					}
				});
			}
		});
	});
</script>
<style type="text/css">
html {
	background: #f0efef;
}

body {
	background: none;	
}

.content {
	width: 26%;
	margin-top: 12%;
	margin-left: 37%;
	text-align: center;
}

.logo-name {
	margin-bottom: 13px;
}

.logo-name img {
	width: 88%;
	height: 88px;
}

#btnLogin {
	width: 100%;
}

.user {
	position: absolute;
	z-index: 999;
	left: 38%;
	margin-top: 6px;
	font-size: 20px;
}

#loginForm input {
	padding-left: 48px;
}
</style>
</head>
<body>
	<div class="content">
		<div class="logo-name">
			<img src="${ctxStatic }/common/images/logo-login.png"/>
		</div>
		<form id="loginForm" action="javascript:void(0);">
			<div class="form-group">
				<div class="user"><span class="glyphicon glyphicon-user"></span></div>
				<div><input type="text" id="loginName" name="loginName" class="form-control" placeholder="登录名" required/></div>
			</div>
			<div class="form-group">
				<div class="user"><span class="glyphicon glyphicon-lock"></span></div>
				<input type="password" id="loginPassword" name="loginPassword" class="form-control" placeholder="密码" required/>
			</div>
			<div class="form-group">
				<button id="btnLogin" class="btn btn-success">登 录</button>
			</div>
		</form>
	</div>

</body>

</html>
