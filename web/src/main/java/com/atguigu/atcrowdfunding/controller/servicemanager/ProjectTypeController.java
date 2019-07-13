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

import com.atguigu.atcrowdfunding.bean.TProjectType;
import com.atguigu.atcrowdfunding.bean.TType;
import com.atguigu.atcrowdfunding.common.AppConstant;
import com.atguigu.atcrowdfunding.service.ProjectTypeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@RestController
@RequestMapping("/project")
public class ProjectTypeController {

	@Autowired
	ProjectTypeService projectTypeService;
	
	//异步查询项目分类数据
	@GetMapping("/loadProjectTypes")
	public PageInfo<TType> loadProjectTypes(@RequestParam(value="pageNum",defaultValue="1")Integer pageNum,
								   @RequestParam(value="pageSize",defaultValue="3")Integer pageSize,
			                       @RequestParam(value="condition",defaultValue="")String condition) {
		PageHelper.startPage(pageNum, pageSize);
		
		List<TType> list = projectTypeService.loadProjectTypes(condition);
		PageInfo<TType> pageInfo = new PageInfo<TType>(list,AppConstant.SYSTEM_PAGE_NUM);
		
		return pageInfo;
	}
	
	//新增
	@PostMapping("/add")
	public String add(TType type) {
		int count = projectTypeService.addType(type);
		if(count>0) {
			return "ok";
		}else {
			return "fail";
		}
	}
	
	//根据id获取分类
	@GetMapping("/get")
	public TType get(@RequestParam("tid")Integer tid) {
		TType type = projectTypeService.getProjectTypeById(tid);
		return type;
	}
	
	//修改分类
	@PostMapping("/update")
	public String update(TType type) {
		int count = projectTypeService.updateType(type);
		if(count>0) {
			return "ok";
		}else {
			return "fail";
		}
	}
	
	//删除分类
	@GetMapping("/delete")
	public String delete(@RequestParam("tids")String tids) {
		List<Integer> tidList = new ArrayList<Integer>();
		if(!StringUtils.isEmpty(tids)) {
			String[] split = tids.split(",");
			for (String string : split) {
				try {
					Integer tid = Integer.parseInt(string);
					tidList.add(tid);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
		}
		
		int count = projectTypeService.deleteType(tidList);
		if(count>0) {
			return "ok";
		}else {
			return "fail";
		}
	}
	
}
