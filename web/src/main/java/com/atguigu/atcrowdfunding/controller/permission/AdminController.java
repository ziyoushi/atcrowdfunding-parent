package com.atguigu.atcrowdfunding.controller.permission;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.common.AppConstant;
import com.atguigu.atcrowdfunding.exception.AddAdminException;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.atguigu.atcrowdfunding.service.RoleService;

/**
 * 负责用户维护crud
 * 
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;
	
	@Autowired
	RoleService roleService;

	// 去修改页面
	@RequestMapping("/toUpdate")
	public String toUpdate(@RequestParam("id") Integer id, Model model) {

		// 根据id查询admin并返回给页面
		TAdmin admin = adminService.getAdminById(id);

		model.addAttribute(AppConstant.PAGE_DATA, admin);

		return "permission/user-edit";
	}

	@PostMapping("/update")
	public String upate(TAdmin admin, HttpSession session, Model model) {

		adminService.updateAdmin(admin);
		// 从session中获取pageNum condition
		Integer pageNum = (Integer) session.getAttribute(AppConstant.CURRENT_PAGE_NUM);
		String condition = (String) session.getAttribute(AppConstant.QUERY_ADMIN_CONDITION);

		// 修改完成后跳转到修改前的页面 index.html就会根据 pageNum condition到指定的页面

		model.addAttribute(AppConstant.CURRENT_PAGE_NUM, pageNum);
		model.addAttribute(AppConstant.QUERY_ADMIN_CONDITION, condition);

		return "redirect:/admin/index.html";
	}

	@GetMapping("/delete.html")
	public String delete(Integer id, Integer pageNum) {

		adminService.deleteAdminById(id);
		return "redirect:/admin/index.html?pageNum=" + pageNum;

	}
	
	//批量删除
	@GetMapping("/batchDelete.html")
	public String batchDelete(HttpSession session,Model model,@RequestParam("ids")String ids) {
		Integer pageNum = (Integer)session.getAttribute(AppConstant.CURRENT_PAGE_NUM);
		String condition = (String)session.getAttribute(AppConstant.QUERY_ADMIN_CONDITION);
		
		List<Integer> idList = new ArrayList<Integer>();
		
		String[] split = ids.split(",");
		for (String i : split) {
			Integer id;
			try {
				id = Integer.parseInt(i);
				idList.add(id);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		//批量删除
		adminService.batchDelete(idList);
		
		
		model.addAttribute(AppConstant.QUERY_ADMIN_CONDITION, condition);
		
		return "redirect:/admin/index.html?pageNum="+pageNum;
	}
	
	//去add页面
	@GetMapping("/add.html")
	public String toAdd() {
		return "permission/user-add";
	}
	
	//add
	@PostMapping("/add")
	public String add(TAdmin admin,Model model) {
		
		//业务实现
		try {
			adminService.saveAdmin(admin);
			//新增成功后跳转到列表页面 
			return "redirect:/admin/index.html?pageNum="+Integer.MAX_VALUE;
			
		} catch (AddAdminException e) {
			//新增失败 还在add页面将错误信息 放在
			model.addAttribute(AppConstant.MESSAGE,e.getMessage());
			return "permission/user-add";
		}
		
	}
	
	//去权限分配页面
	@GetMapping("/toAssign.html")
	public String toAssign(@RequestParam("adminId")Integer adminId,Model model) {
		
		//进入权限分配页面 先将未分配的角色 已经分配的角色查询出来 存到域中
		//根据用户id查询出已分配的角色
		List<TRole> assigns = roleService.getAssignRolesById(adminId);
		
		//根据用户id查出未分配的角色
		List<TRole> unassigns = roleService.getUnassignRolesById(adminId);
		
		model.addAttribute("assigns", assigns);
		model.addAttribute("unassigns", unassigns);
		
		return "permission/user-role";
	}
	
	//user:assign:role
	@PreAuthorize("hasAuthority('user:assign:role')")
	//给用户分配角色
	@GetMapping("/assignRole")
	public String assignRole(@RequestParam("adminId")Integer adminId,@RequestParam("roleIds")String roleIds) {
		List<Integer> roleIdList = new ArrayList<Integer>();
		//给用户分配角色
		if(!StringUtils.isEmpty(roleIds)) {
			String[] split = roleIds.split(",");
			for (String str : split) {
				Integer roleId = Integer.parseInt(str);
				roleIdList.add(roleId);
			}
		}
		
		//操作中间表 t_admin_role
		 adminService.assignRoles(adminId,roleIdList);
		
		return "redirect:/admin/toAssign.html?adminId="+adminId;
	}
	
	@PreAuthorize("hasAuthority('user:assign:role')")
	//取消用户的角色分配
	@GetMapping("/unAssignRole")
	public String unAssingnRole(@RequestParam("adminId")Integer adminId,@RequestParam("roleIds")String roleIds) {
		List<Integer> roleIdList = new ArrayList<Integer>();
		//给用户分配角色
		if(!StringUtils.isEmpty(roleIds)) {
			String[] split = roleIds.split(",");
			for (String str : split) {
				Integer roleId = Integer.parseInt(str);
				roleIdList.add(roleId);
			}
		}
		
		//分配操作
		//操作中间表 t_admin_role
		 adminService.unAssingnRole(adminId,roleIdList);
		
		return "redirect:/admin/toAssign.html?adminId="+adminId;
	}

}
