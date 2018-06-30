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
<title>用户表单</title>
</head>
<body>
	<div id="formDiv" style="margin-top: 10px;">
		<div class="col-sm-12 text-right">
			<form action="javascript:void(0);" id="vueform" :rules="rules" @submit="onSubmit" @valid-error="onValid">
				<div>
					<table class="table table-bordered">
						<tr>
							<td style="width: 15%;"><label>用户名称：</label></td>
							<td style="width: 35%;"><input v-model="data.userName" id="userName" name="userName" required class="form-control"/></td>
							<td style="width: 15%;"><label>登录名：</label></td>
							<td style="width: 35%;">
								<input v-model="data.loginName" id="loginName" name="loginName" required class="form-control"/>
								<div id="loginNameInfo" style="display: none;"></div>
							</td>
						</tr>
						<tr>
							<td><label>性别：</label></td>
							<td>
								<select v-model="data.userSex" id="userSex" name="userSex" required class="form-control">
									<option value="M">男</option>
									<option value="F">女</option>
								</select>
							</td>
							<td><label>状态：</label></td>
							<td>
								<select v-model="data.locked" id="locked" name="locked" class="form-control">
									<option value="0">锁定</option>
									<option value="1">正常</option>
								</select>
							</td>
						</tr>
						<tr>
							<td><label>所属部门：</label></td>
							<td>
								<div class="input-group chooseDiv">
									<div><input v-model="data.departmentName" id="departmentName" name="departmentName" readonly class="form-control"></div>
									<div class="choose"><a id="btnChooseDepartment" @click="chooseDepartment" class="btn btn-success">选择部门</a></div>
								</div>
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
var validateStatus = true;// 验证状态
var oldLoginName = "";
var vmData = {
	data : {
		loginName : '',
		departmentId : '',
		departmentName : ''
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
		if (id) {
			vmData.data = postAjaxGet(_ctxRoot + "/user/data/" + id);
			vmData.data.createTime = new Date(vmData.data.createTime);
			vmData.data.updateTime = new Date(vmData.data.updateTime);
			oldLoginName = vmData.data.loginName;
		}
	},
	methods : {
		onSubmit : function() {
			if (!validateStatus) return false;
			var date = new Date();
			if (!id) {
				vmData.data.createTime = date;
				vmData.data.createUserId = _userId;
				vmData.data.createUserName = _userName;
			}
			vmData.data.updateUserId = _userId;
			vmData.data.updateUserName = _userName;
			vmData.data.updateTime = date;
			var data = getRequestParams();
			postAjaxSave(_ctxRoot + "/user/save", data, function(msg){
				if (!id) {
					Vue.set(vmData.data, "userId", id = msg.businessObject);
				}
			})
		},
		chooseDepartment : function() {
			openForm("选择部门", _ctxRoot + "/department/departmentTreePage?departmentId=" + vmData.data.departmentId, ["30%", "99%"]);
		},
		onValid : function(){
        	layer.msg('数据验证不通过，请参照页面提示核对数据是否正确！', {icon: 2});
        }
	},
	mounted : function() {
		
	},
	watch : {
		'data.loginName' : function(val, oldVal) {
			if (!val && val == oldLoginName) return;
			$.post(_ctxRoot + "/user/validateLoginName", {loginName:val}, function(msg){
				if (msg.isSuccess) {
					$("#loginNameInfo").hide();
					validateStatus = true;
				} else {
					$("#loginNameInfo").css("color","red").html(msg.message).show();
					validateStatus = false;
				}
			});
		}
	}
});

/*
 * 获取请求参数
 */
function getRequestParams() {
	var data = {};
	for ( var i in vmData.data) {
		var item = vmData.data[i];
		if (item || item == "0") {
			data[i] = item;
		}
	}
	return data;
}
</script>
</html>