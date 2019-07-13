package com.atguigu.atcrowdfunding.controller.index;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {

	//首页跳转
	@GetMapping("/index.html")
	public String index() {
		return "index";
	}
	
	//异常页面跳转
	@GetMapping("/unauth.html")
	public String unauth() {
		return "unauth";
	}
	
	
	
}
