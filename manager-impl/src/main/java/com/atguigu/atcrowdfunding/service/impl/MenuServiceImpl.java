package com.atguigu.atcrowdfunding.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.bean.TMenuExample;
import com.atguigu.atcrowdfunding.mapper.TMenuMapper;
import com.atguigu.atcrowdfunding.service.MenuService;

@Service
public class MenuServiceImpl implements MenuService {

	@Autowired
	TMenuMapper menuMapper;
	
	@Override
	public List<TMenu> listMenu() {
		TMenuExample example = new TMenuExample();
		example.createCriteria().andPidEqualTo(0);
		List<TMenu> parentMenu = menuMapper.selectByExample(example);
		
		for (TMenu menu : parentMenu) {
			TMenuExample example2 = new TMenuExample();
			example2.createCriteria().andPidEqualTo(menu.getId());
			List<TMenu> childMenu = menuMapper.selectByExample(example2);
			menu.setChilds(childMenu);
		}
		
		return parentMenu;
	}

	@Override
	public List<TMenu> getAllMenus() {
		TMenuExample example = new TMenuExample();
		return menuMapper.selectByExample(example);
	}

	@Override
	public int addMenu(TMenu menu) {
		return menuMapper.insert(menu);
	}

	@Override
	public int updateMenu(TMenu menu) {
		
		return menuMapper.updateByPrimaryKey(menu);
	}

	@Override
	public TMenu getMenuById(Integer menuId) {
		
		return menuMapper.selectByPrimaryKey(menuId);
	}

	@Override
	public int deleteMenuById(Integer menuId) {
		
		return menuMapper.deleteByPrimaryKey(menuId);
	}

	@Override
	public TMenu getMenuByPermissionId(Integer permissionId) {
		
		return menuMapper.getMenuByPermissionId(permissionId);
	}

	@Override
	public List<TMenu> getLoginUserMenusByAdminId(Integer id) {
		
		//进行数据封装
		List<TMenu> list = menuMapper.getLoginUserMenusByAdminId(id);
		
		List<TMenu> parenMenu = new ArrayList<TMenu>();
		
		//遍历list
		for (TMenu menu : list) {
			if(menu.getPid()==0) {
				parenMenu.add(menu);
			}
		}
		
		//遍历父菜单
		for (TMenu pMenu : parenMenu) {
			
			for (TMenu childMenu : list) {
				if(childMenu.getPid()==pMenu.getId()) {
					pMenu.getChilds().add(childMenu);
				}
			}
		}
		//返回parent
		return parenMenu;
	}

}
