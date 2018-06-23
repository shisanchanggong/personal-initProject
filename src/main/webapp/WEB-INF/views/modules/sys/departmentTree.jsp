<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:include page="/WEB-INF/views/include/base-include.jsp">
	<jsp:param name="include" value="base,layer,ztree,app" />
</jsp:include>
<title>部门树</title>
</head>
<body>
	<div id="treeFrame" class="col-md-3">
		<div id="treeObjDiv" class="col-xs-12">
			<ul id="treeObj" class="ztree"></ul>
		</div>
		<div id="operator" style="width: 100%;">
			<button class="btn btn-info" id="save">保存</button>&nbsp;&nbsp;&nbsp;&nbsp;
			<a class="btn btn-warning closeNowLayer">关闭</a>
		</div>
	</div>
</body>
<script type="text/javascript">
var defaultDepartmentId = "${param.departmentId}";
$(function(){
	loadTree();

	$("#save").click(function(){
		var treeObj = $.fn.zTree.getZTreeObj("treeObj");
		var nodes = treeObj.getCheckedNodes(true);
		parent.vmData.data.departmentId = nodes[0].departmentId;
		parent.vmData.data.departmentName = nodes[0].departmentName;
		closeCurrentIframe();
	});
});
//树选项配置
var treeOption = {
	check: {
		enable: true,
		chkStyle: "radio",
		chkboxType: { "Y": "ps", "N": "ps" }
	},
	callback : {
		onClick : function(event, treeId, treeNode) {

		}
	},
	view : {
		selectedMulti : false,
		showIcon : true,
		showLine : true
	},
	data : {
		key : {
			name : "departmentName"
		},
		simpleData : {
			enable : true,
			idKey : "departmentId",
			pIdKey : "parentId",
			rootPid : "0"
		}
	}
};
/*
 * 导入树形结构数据
 */
function loadTree() {
	var url = "/department/departmentList";
	var loadingIndex = layer.load(2) // 换了种风格
	$.post(_ctxRoot + url, {page:1,rows:9999}, function(msg) {
		var treeData = msg.rows;
		if (treeData.length == 0) {
			$("#treeObj").html("<div style='text-align:center;'>暂无数据</div>");
			layer.close(loadingIndex);
			return;
		}
		
		treeObj = $.fn.zTree.init($("#treeObj"), treeOption, treeData);
		var nodes = treeObj.transformToArray(treeObj.getNodes());
		for (var i=0, l=nodes.length; i < l; i++) {
			if (nodes[i].departmentId == defaultDepartmentId) {
				treeObj.checkNode(nodes[i], true, true);
			}
		}
		treeObj.expandAll(true);
		layer.close(loadingIndex);
	});
}
</script>
</html>