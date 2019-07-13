package com.atguigu.atcrowdfunding.controller.servicemanager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ServiceManagerController {

	@GetMapping("cert/index.html")
	public String cert() {
		return "servicemanager/cert";
	}
	
	@GetMapping("certtype/index.html")
	public String type() {
		return "servicemanager/type";
	}
	@GetMapping("advert/index.html")
	public String adv() {
		return "servicemanager/adv";
	}
	
	@GetMapping("message/index.html")
	public String message() {
		return "servicemanager/message";
	}
	@GetMapping("process/index.html")
	public String process() {
		return "servicemanager/process";
	}
	@GetMapping("tag/index.html")
	public String tag() {
		return "servicemanager/tag";
	}
	
	@GetMapping("projectType/index.html")
	public String projectType() {
		return "servicemanager/projectType";
	}
}
