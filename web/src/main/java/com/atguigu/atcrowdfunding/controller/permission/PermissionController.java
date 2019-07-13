package com.atguigu.atcrowdfunding.controller.permission;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.common.AppConstant;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 权限管理
 * @author Administrator
 *
 */
@Controller
public class PermissionController {
	
	@Autowired
	AdminService adminService;
	
	//点击用户维护跳转到 页面
	@GetMapping("/admin/index.html")
	public String user(Model model,
			@RequestParam(value="pageNum",defaultValue="1")Integer pageNum,
			@RequestParam(value="pageSize",defaultValue="3")Integer pageSize,
			@RequestParam(value="condition",defaultValue="")String condition,
			HttpSession session) {
		
		//把当前页设置到session中
		session.setAttribute(AppConstant.CURRENT_PAGE_NUM, pageNum);
		
		//将condition设置到session中
		session.setAttribute(AppConstant.QUERY_ADMIN_CONDITION, condition);
		
		//查询用户信息返回
		//PageInfo<TAdmin> admins = adminService.loadAdmins(pageNum,pageSize);
		
		//model.addAttribute(AppConstant.ALL_ADMINS, admins);
		PageHelper.startPage(pageNum, pageSize);
		//查询用户信息
		List<TAdmin> list = adminService.loadAdmins(condition);
		
		//将查询到的数据封装到PageInfo中
		PageInfo<TAdmin> pageInfo = new PageInfo<>(list, AppConstant.SYSTEM_PAGE_NUM);
		
		model.addAttribute("pageInfo", pageInfo);
		
		return "permission/user";
	}

	//到角色维护页面
	@GetMapping("role/index.html")
	public String role() {
		return "permission/role";
	}
	
	//到许可页面
	@GetMapping("permission/index.html")
	public String permission() {
		return "permission/permission";
	}
	
	//菜单页面
	@GetMapping("menu/index.html")
	public String menu() {
		return "permission/menu";
	}
	
	
}
