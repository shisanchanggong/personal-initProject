package com.foo.manage.common.utils;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

import com.foo.manage.common.redis.RedisCache;
import com.foo.manage.modules.sys.entity.CurrentUser;

/**
 * shiro 工具类，主要用于获取session中的当前人信息及设置当前人信息，以及加密方法
 * @author quchangzhong
 * @time 2018年2月20日 下午8:11:30
 */
public class SubjectUtils {

	@SuppressWarnings("unchecked")
	public static RedisCache<String, Object> getRedisCache() {
		return (RedisCache<String, Object>) SpringContextUtil.getBean(RedisCache.class);
	}

	public static CurrentUser getUser() {
		RedisCache<String, Object> redisCache = getRedisCache();
		Object currentUser = redisCache.get("currentUser");
		if (currentUser == null) {
			currentUser = SecurityUtils.getSubject().getPrincipal();
			redisCache.put("currentUser", currentUser);
		}
		return currentUser == null ? new CurrentUser() : (CurrentUser) currentUser;
	}

	public static void setUser(Object user) {
		SecurityUtils.getSubject().getSession().setAttribute("currentUser", user);
		getRedisCache().put("currentUser", user);
	}

	public static String getUserId() {
		return getUser().getUserId();
	}

	public static String getUserName() {
		return getUser().getUserName();
	}

	public static String md5Encrypt(String name, String password) {
		String hashAlgorithmName = "MD5";
		Object salt = ByteSource.Util.bytes(name);
		int hashIterations = 1024;// 加密次数

		Object result = new SimpleHash(hashAlgorithmName, password, salt, hashIterations);
		return result.toString();
	}

	public static void main(String[] args) {
		String a = "t";
		String b = new String("t");
		System.out.println(a == b);
	}
}
