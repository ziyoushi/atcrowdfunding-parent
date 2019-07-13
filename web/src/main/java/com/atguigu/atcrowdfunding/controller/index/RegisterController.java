package com.atguigu.atcrowdfunding.controller.index;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class RegisterController {

	//去注册页面
	@GetMapping("/reg.html")
	public String toRegister() {
		return "register";
	}
	
	//注册
	@PostMapping("/doReg")
	public String doReg() {
		return "ok";
	}
	
	
}
