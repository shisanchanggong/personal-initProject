<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:include page="/WEB-INF/views/include/base-include.jsp">
	<jsp:param name="include" value="base,layer,ztree,app" />
</jsp:include>
<title>菜单树</title>
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
var roleId = "${param.roleId}";
var defaultMenuIds = "${param.menuIds}";
$(function(){
	loadTree();

	$("#save").click(function(){
		var treeObj = $.fn.zTree.getZTreeObj("treeObj");
		var nodes = treeObj.getCheckedNodes(true);
		var menuIds = [];
		for ( var i in nodes) {
			menuIds.push(nodes[i].menuId);
		}
		postAjax(_ctxRoot + "/menu/bindMenu?roleId="+roleId+"&menuIds="+menuIds , {}, function(msg){
			if (msg.isSuccess) {
				closeCurrentIframe();
				parent.layer.msg("权限设置成功！", {icon:1});
			} else {
				layer.msg("权限设置失败，请联系管理员！", {icon:2});
			}
		});
		closeCurrentIframe();
	});
});
//树选项配置
var treeOption = {
	check: {
		enable: true,
		chkStyle: "checkbox",
		chkboxType: { "Y": "ps", "N": "ps" }
	},
	view : {
		selectedMulti : false,
		showIcon : true,
		showLine : true
	},
	data : {
		key : {
			name : "menuName"
		},
		simpleData : {
			enable : true,
			idKey : "menuId",
			pIdKey : "parentId",
			rootPid : "0"
		}
	}
};
/*
 * 导入树形结构数据
 */
function loadTree() {
	var url = "/menu/menuList";
	var loadingIndex = layer.load(2) // 换了种风格
	$.post(_ctxRoot + url, {page:1,rows:9999}, function(msg) {
		var treeData = msg.rows;
		if (treeData.length == 0) {
			$("#treeObj").html("<div style='text-align:center;'>暂无数据</div>");
			layer.close(loadingIndex);
			return;
		}
		for ( var i in treeData) {
			treeData[i].url = "javascript:void(0);";
		}
		treeObj = $.fn.zTree.init($("#treeObj"), treeOption, treeData);
		var nodes = treeObj.transformToArray(treeObj.getNodes());
		for (var i=0, l=nodes.length; i < l; i++) {
			var defaultMenuIdArr = defaultMenuIds.split(",");
			var item = nodes[i];
			var menuId = item.menuId;
			if (!item.parentId && !item.isLastNode) {
				continue;
			}
			for ( var menuIndex in defaultMenuIdArr) {
				if (menuId == defaultMenuIdArr[menuIndex]) {
					treeObj.checkNode(item, true, true);
				}
			}
		}
		treeObj.expandAll(true);
		layer.close(loadingIndex);
	});
}
</script>
</html>