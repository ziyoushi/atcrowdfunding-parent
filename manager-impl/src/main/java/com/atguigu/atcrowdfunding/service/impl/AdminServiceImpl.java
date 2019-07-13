package com.atguigu.atcrowdfunding.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.bean.TAdminRoleExample;
import com.atguigu.atcrowdfunding.bean.TAdminExample.Criteria;
import com.atguigu.atcrowdfunding.common.AppConstant;
import com.atguigu.atcrowdfunding.exception.AddAdminException;
import com.atguigu.atcrowdfunding.mapper.TAdminMapper;
import com.atguigu.atcrowdfunding.mapper.TAdminRoleMapper;
import com.atguigu.atcrowdfunding.service.AdminService;
import com.atguigu.atcrowdfunding.utils.AppDateUtil;
import com.atguigu.atcrowdfunding.utils.AppUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Service
public class AdminServiceImpl implements AdminService{

	@Autowired
	TAdminMapper adminMapper;
	
	@Autowired
	TAdminRoleMapper adminRoleMaper;

	@Override
	public TAdmin login(String loginacct, String userpswd) {
		//根据用户名 密码查询用户
		TAdminExample example = new TAdminExample();
		Criteria criteria = example.createCriteria();
		criteria.andLoginacctEqualTo(loginacct).andUserpswdEqualTo(userpswd);
		
		List<TAdmin> list = adminMapper.selectByExample(example);
		
		return list!=null&&list.size()==1?list.get(0):null;
	}

	@Override
	public List<TAdmin> loadAdmins(String condition) {
		
		TAdminExample example = new TAdminExample();
		if(!StringUtils.isEmpty(condition)) {
			Criteria c1 = example.createCriteria();
			c1.andLoginacctLike("%"+condition+"%");
			
			Criteria c2 = example.createCriteria();
			c2.andEmailLike("%"+condition+"%");
			
			Criteria c3 = example.createCriteria();
			c3.andUsernameLike("%"+condition+"%");
			example.or(c1);
			example.or(c2);
			example.or(c3);
			
		}
		
		List<TAdmin> list = adminMapper.selectByExample(example);
		
		return list;
	}

	@Override
	public TAdmin getAdminById(Integer id) {
		
		return adminMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateAdmin(TAdmin admin) {
		adminMapper.updateByPrimaryKeySelective(admin);
	}

	@Override
	public void deleteAdminById(Integer id) {
		adminMapper.deleteByPrimaryKey(id);
	}

	@Override
	public void saveAdmin(TAdmin admin) {
		// TODO Auto-generated method stub
		//校验账号是否存在
		boolean checkLoginacct = checkLoginacct(admin);
		if(checkLoginacct) {
			throw new AddAdminException(AppConstant.LOGINACCT_EXIT_EXCEPTION);
		}
		
		boolean checkEmail = checkEmail(admin);
		if(checkEmail) {
			throw new AddAdminException(AppConstant.EMAIL_EXIT_EXCEPTION);
		}
		
		admin.setUserpswd(AppUtil.getDigestPwd("123456"));
		admin.setCreatetime(AppDateUtil.getCurrentTimeStr());
		
		//执行save
		adminMapper.insertSelective(admin);
		
	}

	@Override
	public boolean checkLoginacct(TAdmin admin) {
		
		TAdminExample example = new TAdminExample();
		example.createCriteria().andLoginacctEqualTo(admin.getLoginacct());
		
		long count = adminMapper.countByExample(example);
		
		return count>0?true:false;
	}

	@Override
	public boolean checkEmail(TAdmin admin) {
		
		TAdminExample example = new TAdminExample();
		example.createCriteria().andEmailEqualTo(admin.getEmail());
		
		long count = adminMapper.countByExample(example);
		
		return count>0?true:false;
		
	}

	@Override
	public void batchDelete(List<Integer> idList) {
		adminMapper.batchDelete(idList);
	}

	@Override
	public void assignRoles(Integer adminId, List<Integer> roleIdList) {
		
		adminRoleMaper.assignRole(adminId,roleIdList);
	}

	@Override
	public void unAssingnRole(Integer adminId, List<Integer> roleIdList) {
		TAdminRoleExample example = new TAdminRoleExample();
		example.createCriteria().andAdminidEqualTo(adminId).andRoleidIn(roleIdList);
		adminRoleMaper.deleteByExample(example);
	}
	
	
}
