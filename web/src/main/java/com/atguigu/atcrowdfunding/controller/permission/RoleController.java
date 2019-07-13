package com.atguigu.atcrowdfunding.controller.permission;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.common.AppConstant;
import com.atguigu.atcrowdfunding.service.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/role")
public class RoleController {

	@Autowired
	RoleService roleService;

	// 异步加载获取所有的角色信息
	@GetMapping("/getAllRoles")
	@ResponseBody
	public PageInfo<TRole> loadRoleData(Integer pageNum, Integer pageSize, String condition) {

		// 分页查询
		PageHelper.startPage(pageNum, pageSize);

		List<TRole> roles = roleService.loadRoles(condition);

		PageInfo<TRole> pageInfo = new PageInfo<TRole>(roles, AppConstant.SYSTEM_PAGE_NUM);

		return pageInfo;
	}

	// 添加角色
	@PostMapping("/add")
	@ResponseBody
	public String add(TRole role) {
		int count = roleService.saveRole(role);
		if (count > 0) {
			return "ok";
		} else {
			return "fail";
		}
	}

	// 删除角色
	@GetMapping("/delete")
	@ResponseBody
	public String delete(@RequestParam("ids") String ids) {

		List<Integer> idList = new ArrayList<Integer>();
		if (!StringUtils.isEmpty(ids)) {

			String[] split = ids.split(",");
			for (String str : split) {
				Integer id;
				try {
					id = Integer.parseInt(str);
					idList.add(id);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
		}

		int count = roleService.deleteRole(idList);

		if (count > 0) {
			return "ok";
		} else {

			return "fail";
		}

	}
	
	@ResponseBody
	@GetMapping("/get")
	public TRole get(@RequestParam("id")Integer id) {
		
		TRole role = roleService.getRoleById(id);
		return role;
	}
	
	//修改
	@ResponseBody
	@PostMapping("/update")
	public String update(TRole role) {
		
		int count = roleService.updateRole(role);
		if(count>0) {
			return "ok";
		}else {
			return "fail";
		}
	}
	
	//根据角色id获取权限菜单树
	@RequestMapping("/getPermssiionByRoleId")
	@ResponseBody
	public List<TPermission> getPermssiionByRoleId(@RequestParam("roleId")Integer roleId) {
		
		List<TPermission> list = roleService.getPermissionByRoleId(roleId);
		
		return list;
	}
	
	//根据角色id给角色分配权限
	@ResponseBody
	@RequestMapping("/assignRolePermission")
	public String assignRolePermission(@RequestParam("roleId")Integer roleId,@RequestParam("permissionIds")String permissionIds) {
		List<Integer> permissionList = new ArrayList<Integer>();
		if(!StringUtils.isEmpty(permissionIds)) {
			String[] split = permissionIds.split(",");
			for (String str : split) {
				try {
					Integer permissionId = Integer.parseInt(str);
					if(permissionId!=0) {
						permissionList.add(permissionId);
					}
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
				
			}
			
		};
		
		int count = roleService.assignRolePermission(roleId,permissionList);
		if(count>0) {
			return "ok";
		}else {
			return "fail";
		}
		
	}
	

}
