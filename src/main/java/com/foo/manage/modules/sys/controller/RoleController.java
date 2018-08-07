package com.foo.manage.modules.sys.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.support.json.JSONUtils;
import com.foo.manage.common.aop.OperateClass;
import com.foo.manage.common.aop.OperateLog;
import com.foo.manage.common.base.BaseController;
import com.foo.manage.common.utils.Constants;
import com.foo.manage.common.utils.PageRequest;
import com.foo.manage.common.utils.PageResult;
import com.foo.manage.common.utils.PageResultHelper;
import com.foo.manage.common.utils.ServiceResult;
import com.foo.manage.modules.sys.entity.Role;
import com.foo.manage.modules.sys.entity.UserRole;
import com.foo.manage.modules.sys.service.RoleService;

/**
 * 角色 Controller
 * @author changzhongq
 * @time 2018年6月11日 下午5:10:04
 */
@OperateClass(Role.class)
@Controller
@RequestMapping("/role")
public class RoleController extends BaseController<Role> {

	private static final Logger logger = LoggerFactory.getLogger(RoleController.class);

	private static final String PREFIX = "/modules/sys/";

	@Autowired
	private RoleService roleService;

	@RequestMapping("/roleListPage")
	public String roleListPage() {
		return PREFIX + "roleList";
	}

	@RequestMapping("/roleForm")
	public String roleForm() {
		return PREFIX + "roleForm";
	}

	@RequestMapping("/chooseRolePage")
	public String chooseRolePage() {
		return PREFIX + "chooseRole";
	}

	/**
	 * 绑定角色
	 * @param userId 用户ID
	 * @param roles 要绑定的角色ID
	 */
	@RequestMapping("/bindRole")
	@ResponseBody
	public ServiceResult bindRole(String userId, String[] roles) {
		logger.info("the called method : bindRole");
		return roleService.bindRole(userId, roles);
	}

	/**
	 * 根据用户id获取用户角色关系
	 * @param userId 用户ID
	 */
	@RequestMapping("/getRoleByUserId")
	@ResponseBody
	public List<UserRole> getRoleByUserId(String userId) {
		logger.info("the called method : getRoleByUserId");
		return roleService.getRoleByUserId(userId);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/roleList")
	@ResponseBody
	@OperateLog(operationType = Constants.OPERATE_TYPE_GET, operationName = "角色列表")
	public PageResult roleList(HttpServletRequest request, PageRequest pageReq) {
		logger.info("the called method : roleList");
		String param = (String) request.getParameter("param");
		Map<String, Object> paramMap = (Map<String, Object>) JSONUtils.parse(param == null ? "{}" : param);
		PageResultHelper.startPage(pageReq);
		return PageResultHelper.parseResult(roleService.roleList(paramMap));
	}
}
