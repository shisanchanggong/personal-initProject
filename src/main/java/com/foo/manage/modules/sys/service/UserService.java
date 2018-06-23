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

}
