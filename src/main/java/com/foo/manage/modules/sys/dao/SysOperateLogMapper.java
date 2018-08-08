package com.foo.manage.modules.sys.dao;

import java.util.List;
import java.util.Map;

import com.foo.manage.modules.sys.entity.SysOperateLog;

/**
 * 操作日志Mapper
 * @author changzhongq
 * @time 2018年8月7日 下午3:31:05
 */
public interface SysOperateLogMapper {

	List<SysOperateLog> sysOperateLogList(Map<String, Object> paramMap);

}
