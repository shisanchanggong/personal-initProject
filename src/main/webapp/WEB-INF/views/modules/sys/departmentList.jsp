<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:include page="/WEB-INF/views/include/base-include.jsp">
	<jsp:param name="include" value="base,layer,jqgrid,select2,app" />
</jsp:include>

<title>部门管理</title>
</head>
<script type="text/javascript">
	var module = "department";
	var tableObj = null;
	$(document).ready(function() {
		tableObj = $("#dataTable").jqGrid({
			caption : "部门列表",
			url : _ctxRoot + "/department/list?like",
			sortname : "PARENT_NAME,DEPARTMENT_NAME",
			colModel : [ 
				{label : "id", name : "departmentId", hidden : true, key : true}, 
				{label : "部门名称", name : "departmentName", index : "DEPARTMENT_NAME", align : 'center'}, 
				{label : "上级部门", name : "parentName", index : "PARENT_NAME", align : 'center'},
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
				departmentName : $("#departmentName").val()
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
		var id = rowObject.departmentId;
		var name = rowObject.departmentName;
		var addBtn = "<button class='btn btn-success btn-xs' title='添加子节点' onclick=\"openCurForm('add','"+id+"','"+name+"')\"><i class='fa fa-plus'></i>&nbsp;添加子节点</button>&nbsp;&nbsp;";
		var editBtn = "<button class='btn btn-primary btn-xs' title='修改' onclick=\"openCurForm('edit','"+id+"')\"><i class='fa fa-paste'></i>&nbsp;修改</button>&nbsp;&nbsp;";
		var deleteBtn = "<button class='btn btn-danger btn-xs' title='删除' onclick=\"deleteItem('"+id+"','"+name+"','"+module+"')\"><i class='fa fa-times'></i>&nbsp;删除</button>";
		return addBtn + editBtn + deleteBtn;
	}
	/*********************************formatter end**********************************/
	
	/*********************************crud start**********************************/
	/*
	 * 添加记录
	 */
	function openCurForm(op, id, name){
		var title = id ? (op == "add" ? "新建部门（上级部门："+ name +"）" : "编辑部门") : "新建父节点";
		var url = _ctxRoot + "/department/departmentForm?id=" + (id ? id : "") + "&name=" + (name ? name : "") + "&op=" + op;
		openForm(title, url);
	}

	/*批量删除记录*/
	function removeRecord() {
		batchDelete(module);
	}
	/*********************************crud end**********************************/
</script>
<body>
	<div>
		<form action="javascript:void(0);" class="form form-inline" id="searchForm">
			<div class="form-group">
				<label class="control-label">部门名称：</label> 
				<input class="form-control" name="departmentName" id="departmentName"> 
			</div>

			<button id="search" type="submit" class="btn btn-info">
				<span class="glyphicon glyphicon-search"></span>&nbsp;搜索
			</button>
			<a class='btn btn-success' onClick="openCurForm('add')">
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