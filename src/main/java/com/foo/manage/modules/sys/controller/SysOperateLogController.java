package com.foo.manage.modules.sys.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.foo.manage.common.aop.NoRecordLog;
import com.foo.manage.common.base.BaseController;
import com.foo.manage.modules.sys.entity.SysOperateLog;

/**
 * 操作日志 Controller
 * @author changzhongq
 */
@NoRecordLog
@Controller
@RequestMapping("/sysOperateLog")
public class SysOperateLogController extends BaseController<SysOperateLog> {

	private static final String PREFIX = "/modules/sys/";

	@RequestMapping("/sysOperateLogListPage")
	public String sysOperateLogListPage() {
		return PREFIX + "sysOperateLogList";
	}

	@RequestMapping("/sysOperateLogForm")
	public String sysOperateLogForm() {
		return PREFIX + "sysOperateLogForm";
	}
}
