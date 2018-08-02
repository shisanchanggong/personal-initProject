<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:include page="/WEB-INF/views/include/base-include.jsp">
	<jsp:param name="include" value="base,layer,jqgrid,jquery-menu" />
</jsp:include>

<title>qcz - 初始化框架</title>

<style type="text/css">
* {
	box-sizing: border-box;
	-moz-box-sizing: border-box;
	-webkit-box-sizing: border-box;
}

html {
	background-size: 100% 100%;
	background-repeat: no-repeat;
	height: 100%;
}

body {
	height: 100%;
}

.content {
	width: 100%;
	height: 88%;
}

.jquery-accordion-menu {
	width: 18%;
	height: 100%;
	overflow-y: auto;
	background: #414956;
}

.filterinput {
	background-color: rgba(249, 244, 244, 0);
	border-radius: 15px;
	width: 90%;
	height: 30px;
	border: thin solid #FFF;
	text-indent: 0.5em;
	font-weight: bold;
	color: #FFF;
}

#demo-list a {
	overflow: hidden;
	text-overflow: ellipsis;
	-o-text-overflow: ellipsis;
	white-space: nowrap;
	width: 100%;
}

.header {
	width: 100%;
	height: 10%;
	min-width: 10%;
	min-height: 76px;
	background: #08a2ba;
	color: white;
}

.iframe {
	width: 80%;
	height: 97%;
	margin-left: 19%;
}

.title {
	width: 241px;
	font-size: 30px;
	padding: 5px;
	height: 100%;
}

.title img {
	width: 100%;
	height: 100%;
}

.loginInfo {
	position: absolute;
	top: -7px;
	right: 30px;
}

.loginInfo a {
	color: white;
}

.loginInfo ul li {
	text-align: center;
}

.nav>li>a:hover {
	background-color: #927a79;
}

.glyphicon {
	font-size: 232%;
	line-height: 1.5;
}

.current-site {
	height: 4.5%;
	width: 82%;
	margin-left: 18%;
	padding: 5px 0 5px 10px;
}
</style>
</head>
<body>
	<div class="header">
		<div class="title"><img src="${ctxStatic }/common/images/logo6.png"></div>
		<div class="loginInfo">
			<ul class="nav nav-pills">
				<li><a href="#"> <span class="glyphicon glyphicon-user" aria-hidden="true"></span><br> <span>用户：管理员</span>
				</a></li>
				<li><a href="exit" class="exitUser"> <span class="glyphicon glyphicon-off" aria-hidden="true"></span><br> <span>退出</span>
				</a></li>
			</ul>
		</div>
	</div>
	<div class="content">
		<div id="jquery-accordion-menu" class="jquery-accordion-menu red">
			<ul id="demo-list">
				<c:forEach items="${menuTrees }" var="item">
					<c:choose>
						<c:when test="${item.hasChild }">
							<li class="menuli" data-title="${item.name }"><a href="#" class="menua"><i class="${item.icon }"></i>${item.name } </a>
								<ul class="submenu">
									<c:forEach items="${item.childrens }" var="item">
										<c:choose>
											<c:when test="${item.hasChild }">
												<li class="menuli" data-title="${item.name }"><a href="#" class="menua"><i class="${item.icon }"></i>${item.name } </a>
													<ul class="submenu">
														<c:forEach items="${item.childrens }" var="item">
															<li class="menuli" data-title="${item.name }"><a class="J_menuItem menua" href="${ctx}${item.url }"><i class="${item.icon }"></i>${item.name }  </a></li>
														</c:forEach>
													</ul>
												</li>
											</c:when>
											<c:otherwise>
												<li class="menuli" data-title="${item.name }"><a class="J_menuItem menua" href="${ctx}${item.url }"><i class="${item.icon }"></i>${item.name } </a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</ul>
							</li>
						</c:when>
						<c:otherwise>
							<li class="menuli" data-title="${item.name }"><a class="J_menuItem menua" href="${ctx}${item.url }"><i class="${item.icon }"></i>${item.name } </a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
			<div class="jquery-accordion-menu-footer"></div>
		</div>
		<div class="current-site">当前位置：<span id="site" class="text-danger"></span></div>
		<hr style="margin: 0;">
		<div class="iframe">
			<iframe id="J_iframe" height="100%" width="100%" frameborder="0" seamless=""></iframe>
		</div>
	</div>

	<script type="text/javascript">
		(function($) {
			$.expr[":"].Contains = function(a, i, m) {
				return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
			};
			function filterList(header, list) {
				var form = $("<form>").attr({
					"class" : "filterform",
					action : "#",
					style : "padding-top:10px;"
				}), input = $("<input>").attr({
					"class" : "filterinput",
					type : "text"
				});
				$(form).append(input).appendTo(header);
				$(input).change(function() {
					var filter = $(this).val();
					if (filter) {
						$matches = $(list).find("a:Contains(" + filter + ")").parent();
						$("li", list).not($matches).slideUp();
						$matches.slideDown();
					} else {
						$(list).find("li").slideDown();
					}
					return false;
				}).keyup(function() {
					$(this).change();
				});
			}
			$(function() {
				filterList($("#form"), $("#demo-list"));
				//菜单点击
				$(".J_menuItem").on('click', function() {
					var url = $(this).attr('href');
					$("#J_iframe").attr('src', url);
					return false;
				});
				$(".menua").click(function(event) {
					if ($(this).attr("href") == "#") {
						return;
					}
					var thisTitle = "";
					$(this).parents("li").each(function(){
						thisTitle = $(this).attr("data-title") + " > " + thisTitle;
					});
					$("#site").text(thisTitle.substring(0,thisTitle.length-2));
				});
			});
		})(jQuery);
	</script>

	<script type="text/javascript">
		jQuery("#jquery-accordion-menu").jqueryAccordionMenu();
	</script>

</body>
</html>
