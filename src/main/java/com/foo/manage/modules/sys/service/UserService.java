package com.foo.manage.modules.sys.service;

import org.springframework.stereotype.Service;

import com.foo.manage.common.base.BaseService;
import com.foo.manage.common.utils.ServiceResult;
import com.foo.manage.common.utils.StringUtils;
import com.foo.manage.common.utils.SubjectUtils;
import com.foo.manage.modules.sys.entity.User;

/**
 * 用户 Service
 * @author changzhongq
 * @time 2018年6月17日 下午3:27:55
 */
@Service
public class UserService extends BaseService {

	public ServiceResult save(User user) {
		if (StringUtils.isEmpty(user.getLoginPassword())) {
			String loginPassword = SubjectUtils.md5Encrypt(user.getUserName(), "111111");
			user.setLoginPassword(loginPassword);
		}
		return this.insertOrUpdate(User.class, user);
	}

	/**
	 * 验证用户名唯一性
	 */
	public ServiceResult validateLoginName(String loginName) {
		if (this.findBy(User.class, "loginName", loginName) == null) {// 用户名不存在，可以使用
			return ServiceResult.newOkInstance("恭喜您，此登录名可以使用。", null);
		} else {// 用户名存在，验证失败
			return ServiceResult.newErrorInstance("登录名已经存在，请更换！");
		}
	}

}
