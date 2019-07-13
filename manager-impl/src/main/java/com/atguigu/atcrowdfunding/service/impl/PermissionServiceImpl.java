package com.atguigu.atcrowdfunding.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.bean.TPermissionExample;
import com.atguigu.atcrowdfunding.bean.TPermissionMenuExample;
import com.atguigu.atcrowdfunding.mapper.TPermissionMapper;
import com.atguigu.atcrowdfunding.mapper.TPermissionMenuMapper;
import com.atguigu.atcrowdfunding.service.PermissionService;

@Service
public class PermissionServiceImpl implements PermissionService {

	@Autowired
	TPermissionMapper permissionMapper;
	
	@Autowired
	TPermissionMenuMapper permissionMenuMapper;
	
	@Override
	public List<TPermission> getAllPermissions() {
		
		TPermissionExample example = new TPermissionExample();
		
		return permissionMapper.selectByExample(example);
	}

	@Override
	public int savePermission(TPermission permissoion) {
		
		return permissionMapper.insertSelective(permissoion);
	}

	@Override
	public int updatePermission(TPermission permissoion) {
		
		return permissionMapper.updateByPrimaryKeySelective(permissoion);
	}

	@Override
	public int deletePermissionById(Integer permissionId) {
		
		return permissionMapper.deleteByPrimaryKey(permissionId);
	}

	@Override
	public List<TMenu> getMenusById(Integer permissionId) {
		//操作中间表
		return permissionMenuMapper.getMenuById(permissionId);
	}

	@Override
	public TPermission getPermissionById(Integer permissionId) {
		
		return permissionMapper.selectByPrimaryKey(permissionId);
	}

	@Override
	public int assignPermissionMenu(Integer permissionId, List<Integer> menuList) {
		
		TPermissionMenuExample example = new TPermissionMenuExample();
		example.createCriteria().andPermissionidEqualTo(permissionId);
		//先将permissionId删除中间表
		permissionMenuMapper.deleteByExample(example);
		
		return permissionMenuMapper.assignPermissionMenu(permissionId,menuList);
	}

	
}
