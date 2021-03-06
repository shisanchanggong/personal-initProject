<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:include page="/WEB-INF/views/include/base-include.jsp">
	<jsp:param name="include" value="base,layer,vuejs2,app" />
</jsp:include>
<style type="text/css">
</style>
<title>菜单表单</title>
</head>
<body>
	<div id="formDiv" style="margin-top: 10px;">
		<div class="col-sm-12 text-right">
			<form action="javascript:void(0);" id="vueform" :rules="rules" @submit="onSubmit" @valid-error="onValid">
				<div>
					<table class="table table-bordered">
						<tr>
							<td style="width: 15%;"><label>菜单名称：</label></td>
							<td style="width: 35%;"><input v-model="data.menuName" required id="menuName" name="menuName" class="form-control"/></td>
							<td style="width: 15%;"><label>url：</label></td>
							<td style="width: 35%;"><input v-model="data.url" id="url" name="url" class="form-control"/></td>
						</tr>
						<tr>
							<td><label>图标：</label></td>
							<td><input v-model="data.icon" id="icon" name="icon" class="form-control"/></td>
							<td><label>上级菜单：</label></td>
							<td>
								<input v-model="data.parentName" id="parentName" name="parentName" readonly class="form-control"/>
<!-- 								<div class="input-group" style="width: 100%;position: relative;"> -->
<!-- 									<div><input v-model="data.parentName" id="parentName" name="parentName" readonly class="form-control"></div> -->
<!-- 									<div class="choose"><a id="btnChooseParent" @click="chooseParent" class="btn btn-success">选择上级</a></div> -->
<!-- 								</div> -->
							</td>
						</tr>
						<tr>
							<td><label>备注：</label></td>
							<td colspan="3"><textarea v-model="data.remark" id="remark" class="form-control"></textarea></td>
						</tr>
					</table>
				</div>
				<div style="height: 50px;"></div>
				<div id="operator">
					<button class="btn btn-info" type="submit">保存</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="btn btn-warning closeNowLayer">关闭</a>
				</div>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript">
var id = "${param.id}";
var menuName = "${param.name}";// 不要命名为name，系统有name这个默认属性，会出问题
var op = "${param.op}";

var vmData = {
	data : {
		
	},
	code : {
		
	},
	rules : {
		
	}
}

var vm = new Vue({
	el : "#vueform",
	data : vmData,
	created : function() {
		if (op == "edit") {
			vmData.data = postAjaxGet(_ctxRoot + "/menu/data/" + id);
		} else if (op == "add") {
			if (id) {// 添加子节点
				vmData.data.parentId = id;
				vmData.data.parentName = menuName;
			} else {// 添加父节点
				vmData.data.parentId = "0";
			}
		}
	},
	methods : {
		onSubmit : function() {
			var data = getRequestParams();
			postAjaxSave(_ctxRoot + "/menu/save", data, function(msg){
				if (op == "add") {
					op = "edit";
					Vue.set(vmData.data, "menuId", id = msg.businessObject);
					layer.title("编辑菜单", parent.layer.getFrameIndex(window.name));
// 					window.location.href = _ctxRoot + "/menu/menuForm?id=" + msg.businessObject + "&name=" + "&op=edit";
				}
			})
		},
		onValid : function(){
        	layer.msg('数据验证不通过，请参照页面提示核对数据是否正确！', {icon: 2});
        }
	},
	mounted : function() {
		
	},
	watch : {
		
	}
});

/*
 * 获取请求参数
 */
function getRequestParams() {
	var data = {};
	for ( var i in vmData.data) {
		data[i] = vmData.data[i];
	}
	return data;
}
</script>
</html>