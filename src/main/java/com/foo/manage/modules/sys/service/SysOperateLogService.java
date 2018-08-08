package com.foo.manage.modules.sys.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foo.manage.common.base.BaseService;
import com.foo.manage.modules.sys.dao.SysOperateLogMapper;
import com.foo.manage.modules.sys.entity.SysOperateLog;

/**
 * 操作日志 Service
 * @author changzhongq
 * @time 2018年8月7日 下午3:26:02
 */
@Service
public class SysOperateLogService extends BaseService {

	@Autowired
	private SysOperateLogMapper sysOperateLogMapper;
	
	public List<SysOperateLog> sysOperateLogList(Map<String, Object> paramMap) {
		return sysOperateLogMapper.sysOperateLogList(paramMap);
	}

}
