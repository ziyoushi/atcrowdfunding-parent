package com.atguigu.atcrowdfunding.controller.serviceauth;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ServiceAuthController {

	//实名认证审核
	@GetMapping("auth_cert/index.html")
	public String cert() {
		
		return "serviceauth/cert";
	}
	
	//广告审核
	@GetMapping("auth_adv/index.html")
	public String adv() {
		
		return "serviceauth/adv";
	}

	//项目审核
	@GetMapping("auth_project/index.html")
	public String project() {
		
		return "serviceauth/project";
	}
	
}
