package com.foo.manage.modules.sys.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.support.json.JSONUtils;
import com.foo.manage.common.aop.NoRecordLog;
import com.foo.manage.common.base.BaseController;
import com.foo.manage.common.utils.PageRequest;
import com.foo.manage.common.utils.PageResult;
import com.foo.manage.common.utils.PageResultHelper;
import com.foo.manage.common.utils.StringUtils;
import com.foo.manage.modules.sys.entity.SysOperateLog;
import com.foo.manage.modules.sys.service.SysOperateLogService;

/**
 * 操作日志 Controller 无需记录日志
 * @author changzhongq
 */
@NoRecordLog
@Controller
@RequestMapping("/sysOperateLog")
public class SysOperateLogController extends BaseController<SysOperateLog> {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	private static final String PREFIX = "/modules/sys/";

	@Autowired
	private SysOperateLogService sysOperateLogService;

	@RequestMapping("/sysOperateLogListPage")
	public String sysOperateLogListPage() {
		return PREFIX + "sysOperateLogList";
	}

	@RequestMapping("/sysOperateLogForm")
	public String sysOperateLogForm() {
		return PREFIX + "sysOperateLogForm";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/sysOperateLogList")
	@ResponseBody
	public PageResult sysOperateLogList(HttpServletRequest request, PageRequest pageReq) {
		logger.info("the called method : sysOperateLogList");
		String param = (String) request.getParameter("param");
		if (StringUtils.isEmpty(param)) {
			throw new NullPointerException("请求参数" + param + "不能为空！");
		}
		Map<String, Object> paramMap = (Map<String, Object>) JSONUtils.parse(param);
		PageResultHelper.startPage(pageReq);
		return PageResultHelper.parseResult(sysOperateLogService.sysOperateLogList(paramMap));
	}
}
