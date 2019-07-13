package com.atguigu.atcrowdfunding.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.atguigu.atcrowdfunding.bean.TCert;
import com.atguigu.atcrowdfunding.bean.TCertExample;
import com.atguigu.atcrowdfunding.mapper.TCertMapper;
import com.atguigu.atcrowdfunding.service.CertService;

@Service
public class CertServiceImpl implements CertService {

	@Autowired
	TCertMapper certMapper;
	
	@Override
	public List<TCert> getAllCerts(String condition) {
		
		//if(StringU)
		TCertExample example = new TCertExample();
		if(!StringUtils.isEmpty(condition)) {
			example.createCriteria().andNameLike("%"+condition+"%");
		}
		
		List<TCert> list = certMapper.selectByExample(example);
		
		return list;
	}

	@Override
	public TCert getCertById(Integer certId) {
		
		return certMapper.selectByPrimaryKey(certId);
	}

	@Override
	public int updateCert(TCert cert) {
		
		return certMapper.updateByPrimaryKeySelective(cert);
	}

	@Override
	public int addCert(TCert cert) {
		
		return certMapper.insertSelective(cert);
	}

	@Override
	public int deleteCert(List<Integer> certList) {
		TCertExample example = new TCertExample();
		example.createCriteria().andIdIn(certList);
		return certMapper.deleteByExample(example);
	}

}
