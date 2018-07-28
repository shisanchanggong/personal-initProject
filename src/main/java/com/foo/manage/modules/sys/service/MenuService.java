package com.foo.manage.modules.sys.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.foo.manage.common.base.BaseService;
import com.foo.manage.common.utils.PageRequest;
import com.foo.manage.common.utils.ServiceResult;
import com.foo.manage.common.utils.StringUtils;
import com.foo.manage.common.utils.SubjectUtils;
import com.foo.manage.common.utils.UUIDUtils;
import com.foo.manage.modules.sys.dao.MenuMapper;
import com.foo.manage.modules.sys.entity.Menu;
import com.foo.manage.modules.sys.entity.RoleMenu;
import com.foo.manage.modules.sys.entity.Tree;

/**
 * 
 * @author changzhongq
 * @time 2018年6月10日 下午6:16:10
 */
@Service
@Primary
public class MenuService extends BaseService {

	@Autowired
	private MenuMapper mapper;

	public Set<String> listPerms(String userId) {
		return null;
	}

	/**
	 * 查询所有菜单数据
	 * @param pageReq
	 * @return
	 */
	public List<Menu> menuList(PageRequest pageReq) {
		return this.findAll(Menu.class, pageReq);
	}

	/**
	 * 首页菜单树数据
	 * @return
	 */
	public List<Tree> menuTreesData() {
		List<Tree> menus = mapper.menuList(SubjectUtils.getUserId());
		List<Tree> mostHeightNodes = new ArrayList<Tree>();// 顶级节点
		for (Tree menu : menus) {
			if ("0".equals(menu.getParentId())) {
				Tree tree = menu;
				tree.setHasParent(false);
				mostHeightNodes.add(tree);
			}
			// 如果没有设置菜单图标，展示默认菜单图标 fa fa-reorder
			if (StringUtils.isEmpty(menu.getIcon())) {
				menu.setIcon("fa fa-reorder");
			}
		}
		return buildTree(mostHeightNodes, menus);
	}

	public List<Tree> buildTree(List<Tree> trees, List<Tree> menus) {
		for (Tree tree : trees) {
			String parentId = tree.getId();
			List<Tree> childrens = new ArrayList<Tree>();
			for (Tree menu : menus) {
				if (parentId.equals(menu.getParentId())) {
					childrens.add(menu);
					tree.setHasChild(true);
				}
			}
			// 如果有子节点，执行递归查询
			if (childrens.size() > 0) {
				childrens = buildTree(childrens, menus);
			}
			tree.setChildrens(childrens);
		}
		return trees;
	}

	/**
	 * 角色设置菜单权限
	 * @param roleId 角色id
	 * @param menuIds 菜单id数组
	 */
	@Transactional
	public ServiceResult bindMenu(String roleId, String[] menuIds) {
		this.deleteBy(RoleMenu.class, "roleId", roleId);
		List<RoleMenu> roleMenus = new ArrayList<RoleMenu>();
		for (String menuId : menuIds) {
			RoleMenu roleMenu = new RoleMenu();
			roleMenu.setRoleMenuId(UUIDUtils.getUUID());
			roleMenu.setRoleId(roleId);
			roleMenu.setMenuId(menuId);
			roleMenus.add(roleMenu);
		}
		this.batchInsert(roleMenus.toArray());
		return ServiceResult.newOkInstance(null);
	}
}
