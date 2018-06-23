package com.foo.manage.modules.sys.dao;

import java.util.List;
import java.util.Map;

/**
 * 
 * @author changzhongq
 */
public interface RoleMapper {

	List<Map<String, Object>> roleList(Map<String, Object> paramMap);

}
