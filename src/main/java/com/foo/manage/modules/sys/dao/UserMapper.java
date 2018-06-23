package com.foo.manage.modules.sys.dao;

import org.apache.ibatis.annotations.Param;

import com.foo.manage.modules.sys.entity.CurrentUser;

/**
 * 
 * @author changzhongq
 * @time 2018年6月10日 下午6:16:27
 */
public interface UserMapper {

	CurrentUser findByLoginNameAndPassword(@Param("loginName") String loginName, @Param("loginPassword") String loginPassword);
}
