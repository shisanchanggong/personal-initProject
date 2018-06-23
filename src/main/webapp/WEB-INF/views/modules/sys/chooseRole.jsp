<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:include page="/WEB-INF/views/include/base-include.jsp">
	<jsp:param name="include" value="base,layer,jqgrid,app" />
</jsp:include>

<title>角色管理</title>
</head>
<script type="text/javascript">
	var userId = "${param.userId}";
	var tableObj = null;
	$(document).ready(function() {
		tableObj = $("#dataTable").jqGrid({
			caption : "请选择要绑定的角色",
			url : _ctxRoot + "/role/list?like",
			sortname : "ROLE_NAME",
			colModel : [ 
				{label : "id", name : "roleId", hidden : true, key : true}, 
				{label : "角色名称", name : "roleName", index : "ROLE_NAME", align : 'center'}
			],
			postData : {},
			loadComplete : function(xhr) {
				updateStyle();
				$.get(_ctxRoot + "/role/getRoleByUserId?userId="+userId, function(msg){
					for ( var i in msg) {
						var itemId = msg[i].roleId;
						tableObj.jqGrid('setSelection',itemId, false);
					}
				});
			}
		});
		//初始化加载调整宽度和注册宽度时间
		resizeWindow();

		// 搜索
		$("#searchForm").submit(function(e){
			e.preventDefault();
			tableObj.setGridParam({postData:getParams(),page:1});
			tableObj.trigger("reloadGrid");
		});

		$("#save").click(function(){
			var ids = $("#dataTable").jqGrid('getGridParam','selarrrow');
			var idsLength = ids.length;
			if (idsLength == 0) {
				layer.msg("请选择要绑定的角色...", {icon:2});
				return;
			}
			postAjax(_ctxRoot + "/role/bindRole?userId="+userId+"&roles="+ids , {}, function(msg){
				if (msg.isSuccess) {
					closeCurrentIframe();
					parent.layer.msg("绑定成功！", {icon:1});
				} else {
					layer.msg("绑定失败，请联系管理员！", {icon:2});
				}
			});
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
		</form>
		<div class="col-xs-12">
			<div>
				<table id="dataTable"></table>
				<div id="pager"></div>
			</div>
		</div>
		<div id="operator" style="width: 100%;">
			<button class="btn btn-info" id="save">保存</button>&nbsp;&nbsp;&nbsp;&nbsp;
			<a class="btn btn-warning closeNowLayer">关闭</a>
		</div>
	</div>
</body>
</html>