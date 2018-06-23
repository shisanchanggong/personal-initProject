package com.foo.manage.modules.sys.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foo.manage.common.aop.OperateClass;
import com.foo.manage.common.aop.OperateLog;
import com.foo.manage.common.base.BaseController;
import com.foo.manage.common.utils.Constants;
import com.foo.manage.common.utils.ServiceResult;
import com.foo.manage.modules.sys.entity.User;
import com.foo.manage.modules.sys.service.UserService;

/**
 * 用户 Controller
 * @author changzhongq
 * @time 2018年6月11日 下午5:10:04
 */
@OperateClass(User.class)
@Controller
@RequestMapping("/user")
public class UserController extends BaseController<User> {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	private static final String PREFIX = "/modules/sys/";

	@Autowired
	private UserService userService;

	@RequestMapping("/userListPage")
	public String userListPage() {
		return PREFIX + "userList";
	}

	@RequestMapping("/userForm")
	public String userForm() {
		return PREFIX + "userForm";
	}

	@RequestMapping("/save")
	@ResponseBody
	@Override
	@OperateLog(operationType = Constants.OPERATE_TYPE_SAVE, operationName = "保存（新增或更新）")
	public ServiceResult insertOrUpdate(User data) {
		logger.info("the called method : save");
		return userService.save(data);
	}
}
