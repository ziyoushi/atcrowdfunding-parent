package com.atguigu.atcrowdfunding.controller.permission;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.service.MenuService;
import com.atguigu.atcrowdfunding.service.PermissionService;

@RestController
@RequestMapping("/permission")
public class PermissionContentController {

	@Autowired
	PermissionService permissionService;
	
	/**
	 * 权限页面展示用的权限树
	 * @return
	 */
	@GetMapping("/getAllPermissions")
	public List<TPermission> getAllPermissions(){
		
		return permissionService.getAllPermissions();
	}
	
	//添加权限
	@PostMapping("/add")
	public String add(TPermission permissoion) {
		int count = permissionService.savePermission(permissoion);
		if(count>0) {
			return "ok";
		}else {
			return "fail";
		}
	}
	
	//修改权限
	@PostMapping("/update")
	public String update(TPermission permissoion) {
		int count = permissionService.updatePermission(permissoion);
		if(count>0) {
			return "ok";
		}else {
			return "fail";
		}
	}
	
	//删除权限
	@GetMapping("/delete")
	public String delete(@RequestParam("permissionId")Integer permissionId) {
		int count = permissionService.deletePermissionById(permissionId);
		if(count>0) {
			return "ok";
		}else {
			return "fail";
		}
	}
	
	//根据角色id获取已经选中的菜单树 做回显
	@GetMapping("/getMenusById")
	public List<TMenu> getMenusById(@RequestParam("permissionId")Integer permissionId) {
		
		List<TMenu> list = permissionService.getMenusById(permissionId);
		
		return list;
	}
	
	
	//根据permissionId查出权限 做数据回显
	@GetMapping("/get")
	public TPermission get(Integer permissionId) {
		
		TPermission permission = permissionService.getPermissionById(permissionId);
		
		return permission;
	}
	
	//分配菜单树 assignPermissionMenu
	@PostMapping("/assignPermissionMenu")
	public String assignPermissionMenu(@RequestParam("permissionId")Integer permissionId,@RequestParam("menuIds")String menuIds) {
		List<Integer> menuList = new ArrayList<Integer>();
		if(!StringUtils.isEmpty(menuIds)) {
			String[] split = menuIds.split(",");
			for (String str : split) {
				try {
					Integer menuId = Integer.parseInt(str);
					menuList.add(menuId);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
				
			}
		}
		
		int count = permissionService.assignPermissionMenu(permissionId,menuList);
		if(count>0) {
			return "ok";
		}else {
			return "fail";
		}
		
	}
		
}
