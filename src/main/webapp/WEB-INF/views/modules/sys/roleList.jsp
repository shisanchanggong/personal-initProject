<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:include page="/WEB-INF/views/include/base-include.jsp">
	<jsp:param name="include" value="base,layer,jqgrid,select2,app" />
</jsp:include>

<title>角色管理</title>
</head>
<script type="text/javascript">
	var module = "role";
	var tableObj = null;
	$(document).ready(function() {
		tableObj = $("#dataTable").jqGrid({
			caption : "角色列表",
			url : _ctxRoot + "/role/roleList",
			sortname : "ROLE_NAME",
			colModel : [ 
				{label : "id", name : "ROLE_ID", hidden : true, key : true}, 
				{label : "角色名称", name : "ROLE_NAME", index : "ROLE_NAME", align : 'center'}, 
				{label : "操作", name : "operator", align : 'center', sortable : false, formatter: operatorFormaater}
			],
			postData : {}
		});
		//初始化加载调整宽度和注册宽度时间
		resizeWindow();

		// 搜索
		$("#searchForm").submit(function(e){
			e.preventDefault();
			tableObj.setGridParam({postData:getParams(),page:1});
			tableObj.trigger("reloadGrid");
		});
	});

	function getParams() {
		var param = {
				roleName : $("#roleName").val()
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
		var id = rowObject.ROLE_ID;
		var name = rowObject.ROLE_NAME;
		var bindMenuBtn = "<button class='btn btn-warning btn-xs' title='权限设置' onclick=\"bindMenu('"+id+"','"+rowObject.menuIds+"')\"><i class='fa fa-paste'></i>&nbsp;权限设置</button>&nbsp;&nbsp;";
		var editBtn = "<button class='btn btn-primary btn-xs' title='修改' onclick=\"openCurForm('"+id+"')\"><i class='fa fa-paste'></i>&nbsp;修改</button>&nbsp;&nbsp;";
		var deleteBtn = "<button class='btn btn-danger btn-xs' title='删除' onclick=\"deleteItem('"+id+"','"+name+"','"+module+"')\"><i class='fa fa-times'></i>&nbsp;删除</button>";
		return bindMenuBtn + editBtn + deleteBtn;
	}
	/*********************************formatter end**********************************/
	
	/*********************************crud start**********************************/
	/*
	 * 添加记录
	 */
	 function openCurForm(id){
		var title = (id ? "编辑" : "新建") + "角色";
		var url = _ctxRoot + "/role/roleForm?id=" + (id ? id : "");
		openForm(title, url);
	}
		
	 /*
	 * 权限设置
	 */
	function bindMenu(id, menuIds){
		openForm("权限设置", _ctxRoot + "/menu/menuTreePage?roleId=" + id + "&menuIds=" + menuIds, ["30%","90%"]);
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
				<label class="control-label">角色名称：</label> 
				<input class="form-control" name="roleName" id="roleName"> 
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