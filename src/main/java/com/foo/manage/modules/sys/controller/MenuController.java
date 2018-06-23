package com.foo.manage.modules.sys.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foo.manage.common.aop.OperateClass;
import com.foo.manage.common.base.BaseController;
import com.foo.manage.common.utils.PageRequest;
import com.foo.manage.common.utils.PageResult;
import com.foo.manage.common.utils.PageResultHelper;
import com.foo.manage.common.utils.ServiceResult;
import com.foo.manage.modules.sys.entity.Menu;
import com.foo.manage.modules.sys.service.MenuService;

/**
 * 菜单 Controller
 * @author changzhongq
 * @time 2018年6月11日 下午5:10:04
 */
@OperateClass(Menu.class)
@Controller
@RequestMapping("/menu")
public class MenuController extends BaseController<Menu> {

	private static final Logger log = LoggerFactory.getLogger(MenuController.class);

	private static final String PREFIX = "/modules/sys/";

	@Autowired
	private MenuService menuService;

	@RequestMapping("/menuListPage")
	public String menuListPage() {
		return PREFIX + "menuList";
	}
	
	@RequestMapping("/menuForm")
	public String menuForm() {
		return PREFIX + "menuForm";
	}
	
	@RequestMapping("/menuTreePage")
	public String menuTreePage() {
		return PREFIX + "menuTree";
	}

	@RequestMapping("/menuList")
	@ResponseBody
	public PageResult menuList(HttpServletRequest request, PageRequest pageReq) {
		log.info("the called method : menuList");
//		PageResultHelper.startPage(pageReq);
//		return PageResultHelper.parseResult(menuService.menuList(pageReq));
		return new PageResultHelper().exeQuery(Menu.class, pageReq);
	}
	
	/**
	 * 角色设置菜单权限
	 * @param roleId 角色id
	 * @param menuIds 菜单id数组
	 */
	@RequestMapping("/bindMenu")
	@ResponseBody
	public ServiceResult bindMenu(String roleId, String[] menuIds) {
		log.info("the called method : menuList");
		return menuService.bindMenu(roleId, menuIds);
	}
}
