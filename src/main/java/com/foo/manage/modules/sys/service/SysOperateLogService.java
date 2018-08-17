package com.foo.manage.modules.sys.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.alibaba.druid.support.json.JSONUtils;
import com.foo.manage.common.base.BaseService;
import com.foo.manage.common.base.DatabaseColumnExplain;
import com.foo.manage.common.redis.RedisCache;
import com.foo.manage.common.utils.StringUtils;
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

	@Autowired
	private RedisCache<String, Object> redisCache;

	@Value("${database.name}")
	private String databaseName;

	@SuppressWarnings("unchecked")
	public List<SysOperateLog> sysOperateLogList(Map<String, Object> paramMap) {
		List<SysOperateLog> sysOperateLogList = sysOperateLogMapper.sysOperateLogList(paramMap);

		for (SysOperateLog sysOperateLog : sysOperateLogList) {
			String tableName = sysOperateLog.getTableName();
			String updateParams = sysOperateLog.getUpdateParams();
			if (!StringUtils.isEmpty(tableName) && !StringUtils.isEmpty(updateParams)) {
				Object params = JSONUtils.parse(updateParams);
				Object newUpdateParams = null;
				String cacheKey = databaseName + tableName;
				Map<String, String> columnMap = (Map<String, String>) redisCache.get(cacheKey);
				if (columnMap == null) {
					columnMap = toMap(this.findColumnByTable(tableName, databaseName));
					redisCache.put(cacheKey, columnMap);
				}
				if (params instanceof List<?>) {
					List<Map<String, Object>> mapList = (List<Map<String, Object>>) params;
					List<Map<String, Object>> updateMapList = new ArrayList<Map<String, Object>>();
					for (Map<String, Object> map : mapList) {
						updateMapList.add(updateMapKey(map, columnMap));
					}
					newUpdateParams = updateMapList;
				} else {
					Map<String, Object> map = (Map<String, Object>) params;
					newUpdateParams = updateMapKey(map, columnMap);
				}
				sysOperateLog.setUpdateParams(JSONUtils.toJSONString(newUpdateParams));
			}
		}
		return sysOperateLogList;
	}

	public Map<String, String> toMap(List<DatabaseColumnExplain> columnExplains) {
		if (columnExplains != null && columnExplains.size() <= 0) {
			return null;
		}
		Map<String, String> columnMap = new HashMap<String, String>();
		for (DatabaseColumnExplain databaseColumnExplain : columnExplains) {
			columnMap.put(StringUtils.camelCaseName(databaseColumnExplain.getColumnName()), databaseColumnExplain.getColumnComment());
		}
		return columnMap;
	}

	public Map<String, Object> updateMapKey(Map<String, Object> map, Map<String, String> referenceMap) {
		Map<String, Object> updateMap = new HashMap<String, Object>();
		for (String key : map.keySet()) {
			updateMap.put(referenceMap.get(key), map.get(key));
		}
		return updateMap;
	}

}
