package com.atguigu.atcrowdfunding.controller.index;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.common.AppConstant;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.atguigu.atcrowdfunding.service.MenuService;

@Controller
public class LoginController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	MenuService menuService;

	//去登录页面
	@GetMapping("/login")
	public String toLogin() {
		return "forward:/login.jsp";
	}
	
	/*@PostMapping("/doLogin")
	public String doLogin(String loginacct,String userpswd,HttpSession session,Model model) {
		
		String password = AppUtil.getDigestPwd(userpswd);
		
		//登录成功后 重定向到main.html
		//登录
		TAdmin admin= adminService.login(loginacct,password);
		
		if(admin!=null) {
			//跳转到main 将用户存放到session
			session.setAttribute(AppConstant.LOGIN_KEY, admin);
		}else {
			model.addAttribute(AppConstant.MESSAGE, "用户名 密码不正确，请重新登录");
			return "redirect:/login.html";
		}
		
		return "redirect:/main.html";
	}*/
	
	@GetMapping("/main.html")
	public String toMain(HttpSession session,Model model) {
		//进行校验
		TAdmin loginUser = (TAdmin)session.getAttribute(AppConstant.LOGIN_KEY);
		if(loginUser != null) {
			
			//查询菜单 返回
			//List<TMenu> list = menuService.listMenu();
			
			//根据给用户查询出其对应的菜单
			List<TMenu> list = menuService.getLoginUserMenusByAdminId(loginUser.getId());
			
			session.setAttribute(AppConstant.MENUS, list);
			
			return "main";
		}else {
			model.addAttribute(AppConstant.MESSAGE, "您还没登录，请先登录");
			//return "redirect:/login.html";
			return "forward:/login.jsp";
		}
		
	}
	
	//退出
	//@GetMapping("/logout.html")
	public String logout(HttpSession session) {
		//销毁
		session.invalidate();
		//先简单到登录页面
		return "forward:/login.jsp";
	}
	
	
}
