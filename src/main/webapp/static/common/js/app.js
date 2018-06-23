Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
$(function() {
	if ($("#pager").length > 0) {
		// 更改jqgrid默认配置
		jQuery.extend(jQuery.jgrid.defaults, {
			mtype : "post",
			pager : "#pager",
			datatype : 'json',
			rowNum : _rowNum,
			rowList : _rowList,
			autowidth : true,
			shrinkToFit : true,
			viewrecords : true,
			rownumbers : true,
			hidegrid : true,
			multiselect : true,// 复选框
//			jsonReader : {// pagehelper 所对应分页参数名称设置
//				root : "list",
//				records : "total",
//				total : "pages"
//			},
			loadComplete : function(xhr) {
				updateStyle();
			}
		});
	}
	
	// layer关闭当前窗口
	$(".closeNowLayer").click(function(){
		closeCurrentIframe();
	});
	
	// 防止表单自动提交
	$("form").attr("onsubmit","return false;");
});
function closeCurrentIframe(){
	var index = parent.layer.getFrameIndex(window.name); // 获取窗口索引
	parent.layer.close(index);
}

/*
 * 修改样式
 */
function updateStyle() {
	// 复选框样式
	$("input[type=checkbox]").each(function() {
		// 只加载一次
		if ($(this).parent("div.checkbox.checkbox-success").length == 0) {
			$(this).wrap("<div class='checkbox checkbox-success'></div").parent().css("margin", "0").append("<label for='" + $(this).attr("id") + "'></label>");
		}
	});
	
	// 标题居中
	$(".ui-jqgrid-caption").css("text-align", "center");
}

/*
 * 通用的ajax保存方法（post）
 * url 请求路径
 * data 传递参数
 * success 成功回调函数（可以为空）
 */
function postAjaxSave(url, data, success) {
	layer.load();
	$.post(url, data, function(msg){
		layer.closeAll();
		if (msg.isSuccess) {
			layer.msg("保存成功！", {icon:1});
			if (success) {
				success(msg);
			}
		} else {
			layer.msg("保存失败！", {icon:2});
		}
	});
}

function postAjax(url, data, success) {
	layer.load();
	$.post(url, data, function(msg){
		layer.closeAll();
		success(msg);
	});
}

/*
 * 通用的ajax查询单条数据方法（post）
 * id 表单id
 * url 查询路径
 * data vue表单数据
 */
function postAjaxGet(url) {
	var result = null;
	layer.load();
	$.ajax({
		type : 'post',
		url : url,
		async : false,
		success : function(msg){
			layer.closeAll();
			result = msg;
		}
	});
	return result;
}

/*
 * 打开表单
 * title 标题
 * url 请求路径
 */
function openForm(title, url, area){
	layer.open({
		type : 2,
		title : title,
		content : url,
		area : area ? area : [ "80%", "80%" ],
		skin : 'layui-layer-molv',
		shade : 0.3,
		maxmin : true,
		resize : true,
		moveOut : true,
		zIndex : layer.zIndex, //多窗口模式，层叠打开
		end : function() {
			$("#dataTable").trigger("reloadGrid");
		}
	});
}


/*
 * 批量删除
 * module 模块名，即调用controller类上的@RequestMapping的值
 */
function batchDelete(module) {
	var ids = $("#dataTable").jqGrid('getGridParam','selarrrow');
	var idsLength = ids.length;
	if (idsLength == 0) {
		layer.msg("请选择要删除的数据...", {icon:2});
	} else {
		layer.confirm("删除后将不能恢复，你确定要删除选中的 <span style='color:red;'>" + idsLength + "</span> 条数据吗？", function(){
			layer.load();
			$.post(_ctxRoot + "/"+ module +"/batchDelete?ids="+ids , {}, function(msg) {
				layer.closeAll();
				if (msg) {
					layer.msg("删除成功", {icon:1});
					$("#dataTable").trigger("reloadGrid");
				} else {
					layer.msg("删除失败", {icon:2});
				}
			});
		});
	}
}

/*
 * 单条删除
 */
function deleteItem(id,name,module){
	layer.confirm("您将删除【<span class='text-success'>"+name+"</span>】，确定删除吗？<p class='text-danger' >(删除后将无法恢复)<p>",{skin:"red-skin"},function(index){
		layer.close(index);
		var loadingIndex=layer.load();
		$.post(_ctxRoot + "/"+ module +"/delete/" + id, {}, function(msg) {
			layer.close(loadingIndex);
			if (msg) {
				layer.msg("已经成功删除：" + name, {icon:1});
				$("#dataTable").trigger("reloadGrid");
			} else {
				layer.msg("删除失败：" + msg.message, {icon:1});
			}
		});
	});
}