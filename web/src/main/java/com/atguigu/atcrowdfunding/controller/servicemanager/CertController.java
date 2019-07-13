package com.atguigu.atcrowdfunding.controller.servicemanager;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.atguigu.atcrowdfunding.bean.TCert;
import com.atguigu.atcrowdfunding.common.AppConstant;
import com.atguigu.atcrowdfunding.service.CertService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@RestController
@RequestMapping("/cert")
public class CertController {

	@Autowired
	CertService certService;
	
	//loadCertData
	//列表展示 使用异步查询
	//分页查询
	@GetMapping("/loadCertData")
	public PageInfo<TCert> loadCertData(@RequestParam(value="pageNum",defaultValue="1")Integer pageNum,
									@RequestParam(value="pageSize",defaultValue="3")Integer pageSize,
									@RequestParam(value="condition",defaultValue="")String condition){
		//开启分页
		PageHelper.startPage(pageNum, pageSize);
		
		List<TCert> list = certService.getAllCerts(condition);
		
		PageInfo<TCert> pageInfo = new PageInfo<TCert>(list,AppConstant.SYSTEM_PAGE_NUM);
		
		return pageInfo;
	}
	
	//根据id查询出资质
	@GetMapping("/get")
	public TCert get(@RequestParam("certId")Integer certId) {
		
		TCert cert = certService.getCertById(certId);
		
		return cert;
	}
	
	//修改
	@PostMapping("/update")
	public String update(TCert cert) {
		
		int count = certService.updateCert(cert);
		if(count>0) {
			return "ok";
		}else {
			return "fail";
		}
	}
	

	//新增
	@PostMapping("/add")
	public String add(TCert cert) {
		int count = certService.addCert(cert);
		if(count>0) {
			return "ok";
		}else {
			return "fail";
		}
	}
	
	//删除
	@PostMapping("/delete")
	public String delete(@RequestParam("certIds")String certIds) {
		List<Integer> certList = new ArrayList<Integer>();
		if(!StringUtils.isEmpty(certIds)) {
			String[] split = certIds.split(",");
			for (String string : split) {
				try {
					Integer certId = Integer.parseInt(string);
					certList.add(certId);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
				
			}
		}
		
		int count = certService.deleteCert(certList);
		if(count>0) {
			return "ok";
		}else {
			return "fail";
		}
		
	}
	
	
	
	
	
	
}
