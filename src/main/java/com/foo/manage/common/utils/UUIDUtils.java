package com.foo.manage.common.utils;

import java.util.UUID;

/**
 * UUID字符串处理
 * @author quchangzhong
 * @time 2018年1月24日 下午1:53:46
 */
public class UUIDUtils {

	public static String getUUID() {
		return UUID.randomUUID().toString();
	}
}
