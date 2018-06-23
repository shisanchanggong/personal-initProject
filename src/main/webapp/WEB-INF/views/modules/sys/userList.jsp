<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:include page="/WEB-INF/views/include/base-include.jsp">
	<jsp:param name="include" value="base,layer,jqgrid,select2,app" />
</jsp:include>

<title>用户管理</title>
</head>
<script type="text/javascript">
	var module = "user";
	var tableObj = null;
	$(document).ready(function() {
		tableObj = $("#dataTable").jqGrid({
			caption : "用户列表",
			url : _ctxRoot + "/user/list?like",
			sortname : "USER_NAME",
			colModel : [ 
				{label : "id", name : "userId", hidden : true, key : true}, 
				{label : "用户名称", name : "userName", index : "USER_NAME", align : 'center', width : 100,}, 
				{label : "登录名", name : "loginName", index : "LOGIN_NAME", align : 'center', width : 100,},
				{label : "性别", name : "userSex", index : "USER_SEX", align : 'center', width : 100, formatter : userSexFormatter},
				{label : "所属部门", name : "departmentName", index : "DEPARTMENT_NAME", align : 'center', width : 100,},
				{label : "状态", name : "locked", index : "LOCKED", align : 'center', width : 100, formatter : lockedFormatter},
				{label : "操作", name : "operator", align : 'center', width : 200, sortable : false, formatter: operatorFormaater}
			],
			postData : {}
		});
		//初始化加载调整宽度和注册宽度时间
		resizeWindow();

		$("#select").select2();

		// 搜索
		$("#searchForm").submit(function(e){
			e.preventDefault();
			tableObj.setGridParam({postData:getParams(),page:1});
			tableObj.trigger("reloadGrid");
		});
	});

	function getParams() {
		var param = {
				userName : $("#userName").val()
		};
		return {'param':JSON.stringify(param)};
	}
	
	/*
	 * 重新调整jqgrid高度与宽度
	 */
	function resizeWindow() {
		var height = $(document).height() - $("#searchForm").height() - 126;
		tableObj.setGridHeight(height);
		$(window).on("resize", resizeWindow);
	}

	/*********************************formatter start**********************************/
	function operatorFormaater(cellValue, options, rowObject){
		var id = rowObject.userId;
		var name = rowObject.userName;
		var bindRoleBtn = "<button class='btn btn-warning btn-xs' title='绑定角色' onclick=\"bindRole('"+id+"')\"><i class='fa fa-paste'></i>&nbsp;绑定角色</button>&nbsp;&nbsp;";
		var editBtn = "<button class='btn btn-primary btn-xs' title='修改' onclick=\"openCurForm('"+id+"')\"><i class='fa fa-paste'></i>&nbsp;修改</button>&nbsp;&nbsp;";
		var deleteBtn = "<button class='btn btn-danger btn-xs' title='删除' onclick=\"deleteItem('"+id+"','"+name+"','"+module+"')\"><i class='fa fa-times'></i>&nbsp;删除</button>";
		return bindRoleBtn + editBtn + deleteBtn;
	}
	function lockedFormatter(cellValue, options, rowObject){
		return cellValue == "0" ? "锁定" : "正常";
	}
	function userSexFormatter(cellValue, options, rowObject){
		return cellValue == "M" ? "男" : (cellValue == "F" ? "女" : "数据错误");
	}
	/*********************************formatter end**********************************/
	
	/*********************************crud start**********************************/
	/*
	 * 添加记录
	 */
	function openCurForm(id){
		var title = (id ? "编辑" : "新建") + "用户";
		var url = _ctxRoot + "/user/userForm?id=" + (id ? id : "");
		openForm(title, url);
	}
	/*
	 * 绑定角色
	 */
	function bindRole(id){
		openForm("请选择要绑定的角色", _ctxRoot + "/role/chooseRolePage?userId=" + id);
	}

	/*批量删除记录*/
	function removeRecord() {
		batchDelete(module);
	}
	/*********************************crud end**********************************/
</script>
<body>
	<div>
		<form action="javascript:void(0);" class="form form-inline " id="searchForm">
			<div class="form-group">
				<label class="control-label">用户名称：</label> 
				<input class="form-control" name="userName" id="userName"> 
			</div>

			<button id="search" type="submit" class="btn btn-info">
				<span class="glyphicon glyphicon-search"></span>&nbsp;搜索
			</button>
			<a class='btn btn-success' onClick="openCurForm()">
				<span class="glyphicon glyphicon-plus"></span>&nbsp;添加
			</a>
			<a class='btn btn-danger' onClick="removeRecord()">
				<span class="glyphicon glyphicon-remove"></span>&nbsp;删除
			</a>
		</form>
		<div class="col-xs-12">
			<div>
				<table id="dataTable"></table>
				<div id="pager"></div>
			</div>
		</div>
	</div>
</body>
</html>