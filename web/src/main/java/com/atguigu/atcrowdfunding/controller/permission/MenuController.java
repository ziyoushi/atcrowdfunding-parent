package com.atguigu.atcrowdfunding.controller.permission;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.service.MenuService;

@RestController
@RequestMapping("/menu")
public class MenuController {
	
	@Autowired
	MenuService menuService;

	//加载菜单树 异步调用
	@GetMapping("/getAllMenus")
	public List<TMenu> getAllMenus(){
		
		return menuService.getAllMenus();
	}
	
	//新增
	@PostMapping("/add")
	public String add(TMenu menu) {
		int count = menuService.addMenu(menu);
		if(count>0) {
			return "ok";
		}else {
			return "fail";
		}
	}
	
	//修改
	@PostMapping("/update")
	public String update(TMenu menu) {
		int count = menuService.updateMenu(menu);
		if(count>0) {
			return "ok";
		}else {
			return "fail";
		}
	}
	
	//根据id查询菜单
	@GetMapping("/get")
	public TMenu get(@RequestParam("menuId")Integer menuId) {
		
		TMenu menu = menuService.getMenuById(menuId);
		
		return menu;
	}
	
	//根据id删除
	@GetMapping("/delete")
	public String delete(@RequestParam("menuId")Integer menuId) {
		int count = menuService.deleteMenuById(menuId);
		if(count>0) {
			return "ok";
		}else {
			return "fail";
		}
		
	}
	
}
