<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:include page="/WEB-INF/views/include/base-include.jsp">
	<jsp:param name="include" value="base,layer,jqgrid,select2" />
</jsp:include>

<title>测试</title>
</head>
<script type="text/javascript">
	var tableObj = null;
	$(document).ready(function() {
		tableObj = $("#dataTable").jqGrid({
			caption : "列表",
			datatype : 'json',
			url : _ctxRoot + "/static/test.json",
			colModel : [ 
				{label : "name1", name : "name1", align : 'center'}, 
				{label : "name2", name : "name2", align : 'center'},
				{label : "操作", name : "operator", align : 'center', formatter: operatorFormaater}
			],
			pager : "#pager",
			rowNum : _rowNum,
			rowList : _rowList,
			autowidth : true,
			shrinkToFit : true,
			viewrecords : true,
			rownumbers : true,
			hidegrid : true,
			loadComplete : function(xhr) {

			},
			postData : {}
		});
		//初始化加载调整宽度和注册宽度时间
		resizeWindow();

		$("#select").select2();
	});

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
		var id = rowObject.id;
		var updateBtn = "<button class='btn btn-primary btn-xs' title='修改' click='update('"+id+"')'><i class='fa fa-paste'></i>&nbsp;修改</button>&nbsp;&nbsp;";
		var deleteBtn = "<button class='btn btn-danger btn-xs' title='删除' click='delete('"+id+"')'><i class='fa fa-times'></i>&nbsp;删除</button>";
		return updateBtn + deleteBtn;
	}
	/*********************************formatter end**********************************/
</script>
<body>
	<div>
		<form action="javascript:void(0);" class="form form-inline " id="searchForm">
			<div class="form-group">
				<label class="control-label">文本框1：</label> 
				<input class="form-control" name="input1" id="input1"> 
			</div>
			<div class="form-group">
				<label class="control-label">文本框2：</label> 
				<input class="form-control" name="input2" id="input2"> 
			</div>
			<div class="form-group">
				<label class="control-label">下拉框：</label> 
				<select class="form-control input-sm" name="select" id="select">
					<option value="">全部</option>
					<option value="1">是</option>
					<option value="0">否</option>
				</select>
			</div>

			<button id="search" type="submit" class="btn btn-outline btn-info ">
				<span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;搜索
			</button>
			<button type="button" class="btn btn-outline btn-success " onclick="jqGridExportExcel('dataTable',0,1)">
				<span class="glyphicon glyphicon-download"></span>&nbsp;&nbsp;导出
			</button>
		</form>
		<div class="col-xs-12 ">
			<div class="jqGrid_wrapper">
				<table id="dataTable" class=""></table>
				<div id="pager"></div>
			</div>
		</div>
	</div>
</body>
</html>