package com.atguigu.atcrowdfunding.service;

import java.util.List;

import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.bean.TPermission;

public interface PermissionService {

	/**
	 * 查询权限树
	 * @return
	 */
	List<TPermission> getAllPermissions();

	/**
	 * 新增权限
	 * @param permissoion
	 * @return
	 */
	int savePermission(TPermission permissoion);

	/**
	 * 修改权限
	 * @param permissoion
	 * @return
	 */
	int updatePermission(TPermission permissoion);

	/**
	 * 删除权限
	 * @param permissionId
	 * @return
	 */
	int deletePermissionById(Integer permissionId);

	/**
	 * 根据roleId获取菜单
	 * @param roleId
	 * @return
	 */
	List<TMenu> getMenusById(Integer permissionId);

	/**
	 * 根据permissionId获取权限
	 * @param permissionId
	 * @return
	 */
	TPermission getPermissionById(Integer permissionId);

	/**
	 * 给权限分配菜单
	 * @param permissionId
	 * @param menuList
	 * @return
	 */
	int assignPermissionMenu(Integer permissionId, List<Integer> menuList);

}
