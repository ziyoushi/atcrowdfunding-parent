package com.atguigu.atcrowdfunding.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.bean.TRoleExample;
import com.atguigu.atcrowdfunding.bean.TRolePermissionExample;
import com.atguigu.atcrowdfunding.mapper.TPermissionMapper;
import com.atguigu.atcrowdfunding.mapper.TRoleMapper;
import com.atguigu.atcrowdfunding.mapper.TRolePermissionMapper;
import com.atguigu.atcrowdfunding.service.RoleService;

@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	TRoleMapper roleMapper;
	
	@Autowired
	TPermissionMapper permissionMapper;
	
	@Autowired
	TRolePermissionMapper rolerPermissionMapper;
	
	@Override
	public List<TRole> loadRoles(String condition) {
		TRoleExample example = new TRoleExample();
		
		//根据条件进行查询
		if(!StringUtils.isEmpty(condition)) {
			example.createCriteria().andNameLike("%"+condition+"%");
		}
		
		return roleMapper.selectByExample(example);
	}

	@Override
	public int saveRole(TRole role) {
		
		return roleMapper.insertSelective(role);
	}

	@Override
	public int deleteRole(List<Integer> idList) {
		
		return roleMapper.deleteRoleByIds(idList);
	}

	@Override
	public TRole getRoleById(Integer id) {
		
		return roleMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateRole(TRole role) {
		
		return roleMapper.updateByPrimaryKey(role);
	}

	@Override
	public List<TRole> getAssignRolesById(Integer adminId) {
		
		return roleMapper.getAssignRolesById(adminId);
	}

	@Override
	public List<TRole> getUnassignRolesById(Integer adminId) {
		
		return roleMapper.getUnassignRolesById(adminId);
	}

	@Override
	public List<TPermission> getPermissionByRoleId(Integer roleId) {
		
		return permissionMapper.getPermissionByRoleId(roleId);
	}

	@Override
	public int assignRolePermission(Integer roleId, List<Integer> permissionList) {
		
		//先根据roleId删除t_role_permission表中的数据 再进行添加
		TRolePermissionExample example = new TRolePermissionExample();
		example.createCriteria().andRoleidEqualTo(roleId);
		rolerPermissionMapper.deleteByExample(example);
		
		return rolerPermissionMapper.assignRolePermission(roleId,permissionList);
	}

}
