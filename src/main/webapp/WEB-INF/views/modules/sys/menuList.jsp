<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:include page="/WEB-INF/views/include/base-include.jsp">
	<jsp:param name="include" value="base,layer,jqgrid,select2,app" />
</jsp:include>

<title>菜单管理</title>
</head>
<script type="text/javascript">
	var module = "menu";
	var tableObj = null;
	$(document).ready(function() {
		tableObj = $("#dataTable").jqGrid({
			caption : "菜单列表",
			url : _ctxRoot + "/menu/list?like",
			sortname : "PARENT_NAME,MENU_NAME",
			colModel : [ 
				{label : "id", name : "menuId", hidden : true, key : true}, 
				{label : "菜单名称", name : "menuName", index : "MENU_NAME", align : 'center'}, 
				{label : "url", name : "url", index : "URL", align : 'center'},
				{label : "图标", name : "icon", index : "ICON", align : 'center'},
				{label : "上级菜单", name : "parentName", index : "PARENT_NAME", align : 'center'},
				{label : "操作", name : "operator", align : 'center', sortable : false, formatter: operatorFormaater}
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
				menuName : $("#menuName").val(),
				url : $("#url").val()
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
		var id = rowObject.menuId;
		var name = rowObject.menuName;
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
		var title = id ? (op == "add" ? "新建菜单（上级菜单："+ name +"）" : "编辑菜单") : "新建父节点";
		var url = _ctxRoot + "/menu/menuForm?id=" + (id ? id : "") + "&name=" + (name ? name : "") + "&op=" + op;
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
		<form action="javascript:void(0);" class="form form-inline " id="searchForm">
			<div class="form-group">
				<label class="control-label">菜单名称：</label> 
				<input class="form-control" name="menuName" id="menuName"> 
			</div>
			<div class="form-group">
				<label class="control-label">url：</label> 
				<input class="form-control" name="url" id="url"> 
			</div>
<!-- 			<div class="form-group"> -->
<!-- 				<label class="control-label">下拉框：</label>  -->
<!-- 				<select class="form-control input-sm" name="select" id="select"> -->
<!-- 					<option value="">全部</option> -->
<!-- 					<option value="1">是</option> -->
<!-- 					<option value="0">否</option> -->
<!-- 				</select> -->
<!-- 			</div> -->

			<button id="search" type="submit" class="btn btn-info">
				<span class="glyphicon glyphicon-search"></span>&nbsp;搜索
			</button>
			<a class='btn btn-success' onClick="openCurForm('add')">
				<span class="glyphicon glyphicon-plus"></span>&nbsp;添加父节点
			</a>
			<a class='btn btn-danger' onClick="removeRecord()">
				<span class="glyphicon glyphicon-remove"></span>&nbsp;删除
			</a>
<!-- 			<a type="button" class="btn btn-outline btn-success " onclick="jqGridExportExcel('dataTable',0,1)"> -->
<!-- 				<span class="glyphicon glyphicon-download"></span>&nbsp;导出 -->
<!-- 			</a> -->
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