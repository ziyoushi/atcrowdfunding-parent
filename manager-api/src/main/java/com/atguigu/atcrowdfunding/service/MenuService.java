package com.atguigu.atcrowdfunding.service;

import java.util.List;

import com.atguigu.atcrowdfunding.bean.TMenu;

public interface MenuService {

	/**
	 * 左侧导航栏数据
	 * 
	 * @return
	 */
	List<TMenu> listMenu();

	/**
	 * 菜单页面需要的数据
	 * @return
	 */
	List<TMenu> getAllMenus();

	/**
	 * 新增菜单
	 * @param menu
	 * @return
	 */
	int addMenu(TMenu menu);

	/**
	 * 修改菜单
	 * @param menu
	 * @return
	 */
	int updateMenu(TMenu menu);

	/**
	 * 根据id查找菜单 回显
	 * @param menuId
	 * @return
	 */
	TMenu getMenuById(Integer menuId);

	/**
	 * 根据id删除菜单
	 * @param menuId
	 * @return
	 */
	int deleteMenuById(Integer menuId);

	/**
	 * 根据权限id查询菜单
	 * @param permissionId
	 * @return
	 */
	TMenu getMenuByPermissionId(Integer permissionId);

	/**
	 * 根据amdinId查询到该用户拥有的菜单
	 * @param id
	 * @return
	 */
	List<TMenu> getLoginUserMenusByAdminId(Integer id);
	
	
	
}
