package com.foo.manage.modules.sys.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foo.manage.common.aop.OperateClass;
import com.foo.manage.common.base.BaseController;
import com.foo.manage.common.utils.PageRequest;
import com.foo.manage.common.utils.PageResult;
import com.foo.manage.common.utils.PageResultHelper;
import com.foo.manage.modules.sys.entity.Department;

/**
 * 部门 Controller
 * @author changzhongq
 * @time 2018年6月11日 下午5:10:04
 */
@OperateClass(Department.class)
@Controller
@RequestMapping("/department")
public class DepartmentController extends BaseController<Department> {

	private static final Logger log = LoggerFactory.getLogger(DepartmentController.class);

	private static final String PREFIX = "/modules/sys/";

	@RequestMapping("/departmentListPage")
	public String departmentListPage() {
		return PREFIX + "departmentList";
	}

	@RequestMapping("/departmentForm")
	public String departmentForm() {
		return PREFIX + "departmentForm";
	}
	
	@RequestMapping("/departmentTreePage")
	public String departmentTreePage() {
		return PREFIX + "departmentTree";
	}

	@RequestMapping("/departmentList")
	@ResponseBody
	public PageResult departmentList(HttpServletRequest request, PageRequest pageReq) {
		log.info("the called method : departmentList");
		return new PageResultHelper().exeQuery(Department.class, pageReq);
	}
}
