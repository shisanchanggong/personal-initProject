package com.foo.manage.modules.sys.realm;

import java.util.Set;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.foo.manage.common.utils.SubjectUtils;
import com.foo.manage.modules.sys.dao.UserMapper;
import com.foo.manage.modules.sys.entity.CurrentUser;
import com.foo.manage.modules.sys.service.MenuService;

/**
 * shiro realm 身份权限配置
 * @author quchangzhong
 * @time 2018年2月20日 下午6:56:13
 */
@Component
public class UserRealm extends AuthorizingRealm {

	@Autowired
	private UserMapper userMapper;

	@Autowired
	private MenuService menuService;
	
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		Set<String> set = menuService.listPerms(SubjectUtils.getUserId());
		SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
		info.setStringPermissions(set);
		return info;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		UsernamePasswordToken upToken = (UsernamePasswordToken) token;
		String username = upToken.getUsername();
		String password = SubjectUtils.md5Encrypt(username, new String((char[]) upToken.getCredentials()));
		CurrentUser user = userMapper.findByLoginNameAndPassword(username, password);
		// 账号不存在
		if (user == null) {
			throw new UnknownAccountException("账号或密码不正确");
		}

		// 密码错误
		if (!password.equals(user.getLoginPassword())) {
			throw new IncorrectCredentialsException("账号或密码不正确");
		}
		
		// 账号被锁定
		if ("0".equals(user.getLocked())) {
			throw new LockedAccountException("账号已被锁定,请联系管理员");
		}
		// 盐值
		ByteSource credentialsSalt = ByteSource.Util.bytes(username);
		SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user, password, credentialsSalt, getName());
		SubjectUtils.setUser(user);
		return info;
	}

}
