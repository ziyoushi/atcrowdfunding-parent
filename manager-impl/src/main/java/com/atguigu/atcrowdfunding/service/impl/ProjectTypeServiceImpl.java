package com.atguigu.atcrowdfunding.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.atguigu.atcrowdfunding.bean.TType;
import com.atguigu.atcrowdfunding.bean.TTypeExample;
import com.atguigu.atcrowdfunding.bean.TTypeExample.Criteria;
import com.atguigu.atcrowdfunding.mapper.TTypeMapper;
import com.atguigu.atcrowdfunding.service.ProjectTypeService;

@Service
public class ProjectTypeServiceImpl implements ProjectTypeService {

	@Autowired
	TTypeMapper typeMapper;
	
	@Override
	public List<TType> loadProjectTypes(String condition) {
		TTypeExample example = new TTypeExample();
		if(!StringUtils.isEmpty(condition)) {
			Criteria c1 = example.createCriteria();
			c1.andNameLike("%"+condition+"%");
			Criteria c2 = example.createCriteria();
			c2.andRemarkLike("%"+condition+"%");
			example.or(c1);
			example.or(c2);
		}
		return typeMapper.selectByExample(example);
	}

	@Override
	public int addType(TType type) {
		
		return typeMapper.insertSelective(type);
	}

	@Override
	public TType getProjectTypeById(Integer tid) {
		
		return typeMapper.selectByPrimaryKey(tid);
	}

	@Override
	public int updateType(TType type) {
		
		return typeMapper.updateByPrimaryKeySelective(type);
	}

	@Override
	public int deleteType(List<Integer> tidList) {
		TTypeExample example = new TTypeExample();
		example.createCriteria().andIdIn(tidList);
		return typeMapper.deleteByExample(example);
	}

	
}
