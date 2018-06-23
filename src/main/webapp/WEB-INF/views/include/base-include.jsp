<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="0"> 
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0">

<script type="text/javascript">
var _ctxRoot="${ctx}";
var _ctxStatic="${ctxStatic}";
var _userId="${currentUser.userId}";
var _userName="${currentUser.userName}";
var _rowList=[10, 20, 50, 100, 300];
var _rowNum=20;

</script>
<c:forEach items="${param.include.split(',')}" var="item" varStatus="itemId">
	<c:choose>
		<c:when test="${'base' eq item}">
			<meta http-equiv="Expires" content="0" />
			<meta http-equiv="X-UA-Compatible" content="IE=edge" />
			<meta charset="utf-8">
    		<meta name="viewport" content="width=device-width, initial-scale=1.0">
    		<script src="${ctxStatic}/plugin/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
    		<script  type="text/javascript">
    			$.ajaxSetup({cache:false}); 
    		</script>
			<!-- font-awsome -->
			<link rel="stylesheet" href="${ctxStatic}/plugin/font-awesome/css/font-awesome.min.css" />
			<!-- boostrap -->
			<link href="${ctxStatic}/plugin/bootstrap/3.3.6/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
			<link href="${ctxStatic}/plugin/bootstrap/3.3.6/css/build.css" type="text/css" rel="stylesheet" />
			<!-- other -->
			
			<script src="${ctxStatic}/plugin/bootstrap/3.3.6/js/bootstrap.min.js" type="text/javascript"></script>
           	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
			<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
			<!--[if lt IE 9]>
        		<script src="${ctxStatic}/plugin/html5shiv/html5shiv.min.js"></script>
        		<script src="${ctxStatic}/plugin/common/respond.min.js"></script>
    		<![endif]-->
			
			<!-- date -->
			<script src="${ctxStatic}/plugin/laydate/laydate.js" type="text/javascript"></script>
			<!-- other -->
			
		</c:when>
		<c:when test="${'select2' eq item}">
			<!-- select 2 -->
			<script src="${ctxStatic}/plugin/select2/4.0.5/js/select2.min.js" type="text/javascript"></script>
			<script src="${ctxStatic}/plugin/select2/4.0.5/js/i18n/zh-CN.js" type="text/javascript"></script>
			<link href="${ctxStatic}/plugin/select2/4.0.5/css/select2.min.css" type="text/css" rel="stylesheet" />
		</c:when>
		
		<c:when test="${'slimscroll' eq item}">
			<script src="${ctxStatic}/plugin/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
		</c:when>
		
		<c:when test="${'iCheck' eq item}">
			<!-- icheck -->
			<link href="${ctxStatic}/plugin/iCheck/skins/square/blue.css" type="text/css" rel="stylesheet" />
			<script src="${ctxStatic}/plugin/iCheck/icheck.min.js" type="text/javascript"></script>
			<script type="text/javascript">
				$(document).ready(function(){
					$("input[type='checkbox'],input[type='radio']").each(function(){
						$(this).iCheck({
						    checkboxClass: 'icheckbox_square-blue',
						    radioClass: 'iradio_square-blue',
						    increaseArea: '20%' // optional
						});
						
						$(this).change(function(){
							$(this).iCheck('update');
							$(this).trigger("ifChanged");
						});
					});
				});
			</script>
		</c:when>
		<c:when test="${'layer' eq item}">
			<link href="${ctxStatic}/plugin/layer/layer-v3.1.0/theme/default/layer.css" type="text/css" rel="stylesheet" />
			<script src="${ctxStatic}/plugin/layer/layer-v3.1.0/layer.js" type="text/javascript"></script>
		</c:when>		
		<c:when test="${'app' eq item}">
			<link type="text/css" rel="stylesheet" href="${ctxStatic}/common/css/app.css" />
			<script src="${ctxStatic}/common/js/app.js" type="text/javascript"></script>
		</c:when>		
		<c:when test="${'jquery-validation' eq item}">
			<!-- jquery-validation -->
			<link href="${ctxStatic}/plugin/jquery-validation/1.11.1/jquery.validate.min.css" type="text/css"
				rel="stylesheet" />
			<script src="${ctxStatic}/plugin/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
			<script src="${ctxStatic}/plugin/jquery-validation/1.11.1/jquery.validate.method.min.js"
				type="text/javascript"></script>
		</c:when>
		<c:when test="${'ace' eq item}">
			<!-- ace styles -->
		<link rel="stylesheet" href="${ctxStatic}/plugin/ace/css/ace.min.css" />
		<link rel="stylesheet" href="${ctxStatic}/plugin/ace/css/ace-rtl.min.css" />
		<link rel="stylesheet" href="${ctxStatic}/plugin/ace/css/ace-skins.min.css" />
		
		<script src="${ctxStatic}/plugin/ace/js/ace-extra.min.js"></script>
		<script src="${ctxStatic}/plugin/ace/js/ace-elements.min.js"></script>
		<script src="${ctxStatic}/plugin/ace/js/ace.min.js"></script>
		</c:when>
		<c:when test="${'metronic' eq item}">
        	<link href="${ctxStatic}/plugin/metronic/4.7.1/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
        	<link href="${ctxStatic}/plugin/metronic/4.7.1/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        	<link href="${ctxStatic}/plugin/metronic/4.7.1/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
		
			<link href="${ctxStatic}/plugin/metronic/4.7.1/global/css/components.css" id="style_components" rel="stylesheet" type="text/css"/>
			<link href="${ctxStatic}/plugin/metronic/4.7.1/global/css/plugins.css" rel="stylesheet" type="text/css"/>
			<link href="${ctxStatic}/plugin/metronic/4.7.1/layout/css/layout.css" rel="stylesheet" type="text/css"/>
			<link href="${ctxStatic}/plugin/metronic/4.7.1/layout/css/themes/light2.min.css" rel="stylesheet" type="text/css" id="style_color"/>
			<link href="${ctxStatic}/plugin/metronic/4.7.1/layout/css/custom.css" rel="stylesheet" type="text/css"/>
		</c:when>
		<c:when test="${'backstretch' eq item}">
			<script src="${ctxStatic}/plugin/backstretch/jquery.backstretch.min.js" type="text/javascript"></script>
		</c:when>
		<c:when test="${'vuejs' eq item}">
			<script src="${ctxStatic}/plugin/vuejs/vue-v1.0.28/vue.js" type="text/javascript"></script>
			<script type="text/javascript">Vue.config.debug = false;</script>	
		</c:when>
		<c:when test="${'vuejs2' eq item}">
			<script src="${ctxStatic}/plugin/vuejs/vue-2.1.10/vue.min.js" type="text/javascript"></script>
			
			<script src="${ctxStatic}/plugin/vue-spinner/vue-spinner.min.js" type="text/javascript"></script>
		</c:when>
		<c:when test="${'element' eq item}">
			<link href="${ctxStatic}/plugin/element-ui/lib/theme-default/index.css" rel="stylesheet" />
			<link href="${ctxStatic}/plugin/element-ui/add_index.css" rel="stylesheet" />
			<script src="${ctxStatic}/plugin/vuejs/vue-2.1.10/vue.js" type="text/javascript"></script>
			<script src="${ctxStatic}/plugin/element-ui/lib/index.js" type="text/javascript"></script>
		</c:when>
		<c:when test="${'angular' eq item}">
			 <script src="${ctxStatic}/plugin/angularjs/angular.min.js" type="text/javascript"></script>
 			 <script src="${ctxStatic}/plugin/angularjs/angular-touch.min.js" type="text/javascript"></script>		</c:when>
		<c:when test="${'leaflet-angular' eq item}">
			<script src="${ctxStatic}/plugin/angular-leaflet-directive/angular-leaflet-directive2.js" type="text/javascript"></script>
		</c:when>
		<c:when test="${'gridster' eq item}">
				<script src="${ctxStatic}/plugin/gridster/v0.5.6/jquery.gridster.min.js" type="text/javascript"></script>
				<link type="text/css" rel="stylesheet" href="${ctxStatic}/plugin/gridster/v0.5.6/jquery.gridster.min.css" />
		</c:when>
		<c:when test="${'jquery-fileupload' eq item}">
			<script src="${ctxStatic}/plugin/jquery-fileupload/js/vendor/jquery.ui.widget.js"></script>
			<script src="${ctxStatic}/plugin/jquery-fileupload/js/tmpl.min.js"></script>
			<script src="${ctxStatic}/plugin/jquery-fileupload/js/load-image.all.min.js"></script>
			<script src="${ctxStatic}/plugin/jquery-fileupload/js/canvas-to-blob.min.js"></script>
			<script src="${ctxStatic}/plugin/jquery-fileupload/js/jquery.iframe-transport.js"></script>
			<script src="${ctxStatic}/plugin/jquery-fileupload/js/jquery.fileupload.js"></script>
			
			<script src="${ctxStatic}/plugin/jquery-fileupload/js/jquery.fileupload-process.js"></script>
			<script src="${ctxStatic}/plugin/jquery-fileupload/js/jquery.fileupload-image.js"></script>
			<script src="${ctxStatic}/plugin/jquery-fileupload/js/jquery.fileupload-audio.js"></script>
			<script src="${ctxStatic}/plugin/jquery-fileupload/js/jquery.fileupload-video.js"></script>
			<script src="${ctxStatic}/plugin/jquery-fileupload/js/jquery.fileupload-validate.js"></script>
			<script src="${ctxStatic}/plugin/jquery-fileupload/js/jquery.fileupload-ui.js"></script>
			
			<script src="${ctxStatic}/plugin/jquery-fileupload/js/qunit-1.15.0.js"></script>

			<link rel="stylesheet" href="${ctxStatic}/plugin/jquery-fileupload/css/jquery.fileupload.css">
			<link rel="stylesheet" href="${ctxStatic}/plugin/jquery-fileupload/css/jquery.fileupload-ui.css">
		</c:when>
		<c:when test="${'mustache' eq item}">
			<script src="${ctxStatic}/plugin/common/mustache.min.js" type="text/javascript"></script>
		</c:when>
		<c:when test="${'ztree' eq item}">
			<link href="${ctxStatic}/plugin/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle.min.css" type="text/css"
				rel="stylesheet" />
			<script src="${ctxStatic}/plugin/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.min.js" type="text/javascript"></script>
		</c:when>
		<c:when test="${'echarts' eq item}">
			<script src="${ctxStatic}/plugin/echarts2/echarts-all.js" type="text/javascript"></script>
		</c:when>
		<c:when test="${'echarts-require' eq item}">
			<script src="${ctxStatic}/plugin/echarts2/echarts.js" type="text/javascript"></script>
		</c:when>
		<c:when test="${'inspinia' eq item}">
			<link href="${ctxStatic}/plugin/inspinia/css/animate.css" type="text/css" rel="stylesheet" />
			<link href="${ctxStatic}/plugin/inspinia/css/style.css" type="text/css" rel="stylesheet" />
		</c:when>
		<c:when test="${'bootstrap-editable' eq item}">
			<link href="${ctxStatic}/plugin/bootstrap3-editable/css/bootstrap-editable.css" type="text/css"
				rel="stylesheet" />
			<script src="${ctxStatic}/plugin/bootstrap3-editable/js/bootstrap-editable.js" type="text/javascript"></script>
		</c:when>
		<c:when test="${'bootstrap-doc' eq item}">
			<link href="${ctxStatic}/plugin/bootstap-doc/css/path.css" type="text/css" rel="stylesheet" />
			<link href="${ctxStatic}/plugin/bootstap-doc/css/doc.min.css" type="text/css" rel="stylesheet" />
			<script src="${ctxStatic}/plugin/bootstap-doc/js/ie10-viewport-bug-workaround.js" type="text/javascript"></script>
		</c:when>
		<c:when test="${'jquery' eq item}">
		<!-- jquery -->
			<script src="${ctxStatic}/plugin/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
			<script src="${ctxStatic}/plugin/jquery/jquery-migrate-1.1.1.min.js" type="text/javascript"></script>
		</c:when>
		<c:when test="${'tree-table' eq item}">
			<link href="${ctxStatic}/plugin/treeTable/themes/vsStyle/treeTable.min.css" rel="stylesheet" type="text/css" />
			<script src="${ctxStatic}/plugin/treeTable/jquery.treeTable.min.js" type="text/javascript"></script>
		</c:when>
		<c:when test="${'fancybox' eq item}">
			<link href="${ctxStatic}/plugin/fancyBox/source/jquery.fancybox.css" type="text/css" rel="stylesheet" />
			<script src="${ctxStatic}/plugin/fancyBox/source/jquery.fancybox.js" type="text/javascript"></script>
		</c:when>
		<c:when test="${'noiframe' eq item}">
			<script type="text/javascript" src="${ctxStatic}/common/js/not-permit-iframe.js"></script>
		</c:when>
		
		<c:when test="${'jqgrid' eq item}">
			<!-- jqgrid -->
			<link href="${ctxStatic}/plugin/jqgrid/css/ui.jqgrid.css" rel="stylesheet">
			<script src="${ctxStatic}/plugin/jqgrid/js/i18n/grid.locale-cn.js" type="text/javascript"></script>
			<script src="${ctxStatic}/plugin/jqgrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>
			<script src="${ctxStatic}/plugin/jqgrid/js/grid.treegrid.js" type="text/javascript"></script>
			<script type="text/javascript">$.jgrid.defaults.styleUI = "Bootstrap";</script>
		</c:when>
		<c:when test="${'ckeditor' eq item }">
			<script src="${ctxStatic}/plugin/ckeditor/4.5.10/ckeditor.js?v=4.5.10"></script>
		</c:when>
		
		<c:when test="${'plupload' eq item}">
			<link href="${ctxStatic}/plugin/plupload/css/jquery-ui.min.css" rel="stylesheet" />
			<link href="${ctxStatic}/plugin/plupload/js/jquery.ui.plupload/css/jquery.ui.plupload.css" rel="stylesheet" />
			<script src="${ctxStatic}/plugin/plupload/js/jquery-ui.min.js" type="text/javascript"></script>
			<script src="${ctxStatic}/plugin/plupload/js/plupload.full.min.js" type="text/javascript"></script>
			<script src="${ctxStatic}/plugin/plupload/js/i18n/zh_CN.js" type="text/javascript"></script>
			<script src="${ctxStatic}/plugin/plupload/js/jquery.ui.plupload/jquery.ui.plupload.min.js" type="text/javascript"></script>
		</c:when>
		<c:when test="${'ueditor' eq item }">
		    <link href="${ctxStatic}/plugin/ueditor/ueditor1_4_3_3/themes/default/css/ueditor.css" type="text/css" rel="stylesheet" />
			<script src="${ctxStatic}/plugin/ueditor/ueditor1_4_3_3/ueditor.config.js"></script>
			<script src="${ctxStatic}/plugin/ueditor/ueditor1_4_3_3/ueditor.all.min.js"></script>
			<script src="${ctxStatic}/plugin/ueditor/ueditor1_4_3_3/lang/zh-cn/zh-cn.js"></script>
		</c:when>
		<c:when test="${'codemirror' eq item }">
		    <link href="${ctxStatic}/plugin/codemirror-5.30.0/lib/codemirror.css" type="text/css" rel="stylesheet" />
			<script src="${ctxStatic}/plugin/codemirror-5.30.0/lib/codemirror.js"></script>
			<script src="${ctxStatic}/plugin/codemirror-5.30.0/mode/javascript/javascript.js"></script>
			<script src="${ctxStatic}/plugin/codemirror-5.30.0/xml/xml.js"></script>
			<script src="${ctxStatic}/plugin/codemirror-5.30.0/addon/mode/multiplex.js"></script>
			<script src="${ctxStatic}/plugin/codemirror-5.30.0/mode/htmlembedded/htmlembedded.js"></script>
		</c:when>
		<c:when test="${'jquery-menu' eq item }">
			<script src="${ctxStatic}/plugin/jquery-3d-menu-with-search/js/jquery-accordion-menu.js"></script>
			<link href="${ctxStatic}/plugin/jquery-3d-menu-with-search/css/jquery-accordion-menu.css" type="text/css" rel="stylesheet"/>
			<link href="${ctxStatic}/plugin/jquery-3d-menu-with-search/css/font-awesome.css" type="text/css" rel="stylesheet"/>
		</c:when>
	</c:choose>

</c:forEach>