package com.atguigu.atcrowdfunding.service;

import java.util.List;

import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.bean.TRole;

public interface RoleService {

	/**
	 * 异步加载获取所有角色信息
	 * @return
	 */
	List<TRole> loadRoles(String condition);

	/**
	 * 异步添加角色
	 * @param role
	 * @return
	 */
	int saveRole(TRole role);

	/**
	 * 删除角色 将批量删和单个删除整合
	 * @param idList
	 * @return
	 */
	int deleteRole(List<Integer> idList);

	/**
	 * 根据id查询角色 做回显
	 * @param id
	 * @return
	 */
	TRole getRoleById(Integer id);

	/**
	 * 根据id修改角色
	 * @param role
	 * @return
	 */
	int updateRole(TRole role);

	/**
	 * 根据用户id获取已经分配的角色
	 * @param adminId
	 * @return
	 */
	List<TRole> getAssignRolesById(Integer adminId);

	/**
	 * 根据用户id查询未分配的角色
	 * @param adminId
	 * @return
	 */
	List<TRole> getUnassignRolesById(Integer adminId);

	/**
	 * 根据角色id查询出权限
	 * @param roleId
	 * @return
	 */
	List<TPermission> getPermissionByRoleId(Integer roleId);

	/**
	 * 根据角色id修改权限
	 * @param roleId
	 * @param permissionList
	 * @return
	 */
	int assignRolePermission(Integer roleId, List<Integer> permissionList);

}
