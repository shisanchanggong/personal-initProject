package com.foo.manage.modules.sys.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.foo.manage.common.base.BaseService;
import com.foo.manage.common.utils.ServiceResult;
import com.foo.manage.common.utils.UUIDUtils;
import com.foo.manage.modules.sys.dao.RoleMapper;
import com.foo.manage.modules.sys.entity.UserRole;

/**
 * 角色 Service
 * @author changzhongq
 * @time 2018年6月17日 下午3:27:55
 */
@Service
public class RoleService extends BaseService {

	@Autowired
	private RoleMapper roleMapper;
	
	/**
	 * 绑定角色，先删除所有相关角色，在绑定所选角色
	 * @param userId 用户ID
	 * @param roles 要绑定的角色ID
	 */
	@Transactional
	public ServiceResult bindRole(String userId, String[] roles) {
		this.deleteBy(UserRole.class, "userId", userId);
		List<UserRole> userRoles = new ArrayList<UserRole>();
		for (String roleId : roles) {
			UserRole userRole = new UserRole();
			userRole.setUserRoleId(UUIDUtils.getUUID());
			userRole.setUserId(userId);
			userRole.setRoleId(roleId);
			userRoles.add(userRole);
		}
		this.batchInsert(userRoles.toArray());
		return ServiceResult.newOkInstance(null);
	}

	/**
	 * 根据用户id获取用户角色关系
	 * @param userId 用户ID
	 */
	public List<UserRole> getRoleByUserId(String userId) {
		return this.findBy(UserRole.class, "userId", userId);
	}

	public List<Map<String, Object>> roleList(Map<String, Object> paramMap) {
		return roleMapper.roleList(paramMap);
	}

}
