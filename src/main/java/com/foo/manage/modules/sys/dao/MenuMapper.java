package com.foo.manage.modules.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.foo.manage.modules.sys.entity.Tree;

/**
 * 菜单 Mapper
 * @author changzhongq
 * @time 2018年6月15日 下午10:02:21
 */
public interface MenuMapper {

	List<Tree> menuList(@Param("userId") String userId);

}
