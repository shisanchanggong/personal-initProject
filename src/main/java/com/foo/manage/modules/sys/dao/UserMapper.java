package com.foo.manage.modules.sys.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.foo.manage.modules.sys.entity.CurrentUser;
import com.foo.manage.modules.sys.entity.User;

/**
 * 用户Mapper
 * @author changzhongq
 * @time 2018年6月10日 下午6:16:27
 */
public interface UserMapper {

	CurrentUser findByLoginNameAndPassword(@Param("loginName") String loginName, @Param("loginPassword") String loginPassword);

	List<User> exportUserData(Map<String, Object> paramMap);
}
