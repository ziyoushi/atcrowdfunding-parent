package com.atguigu.atcrowdfunding.component;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.bean.TAdminExample;
import com.atguigu.atcrowdfunding.bean.TPermission;
import com.atguigu.atcrowdfunding.bean.TRole;
import com.atguigu.atcrowdfunding.mapper.TAdminMapper;
import com.atguigu.atcrowdfunding.mapper.TPermissionMapper;
import com.atguigu.atcrowdfunding.mapper.TRoleMapper;

@Component
public class AppUserDetailsService implements UserDetailsService {

	public AppUserDetailsService() {
		System.out.println("AppUserDetailsService....初始化了。。。。");
	}
	
	//查询出admin对应的角色和权限
	@Autowired
	TAdminMapper adminMapper;
	
	@Autowired
	TRoleMapper roleMapper;
	
	@Autowired
	TPermissionMapper permissionMapper;
	
	@SuppressWarnings("null")
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		//根据username查出admin
		TAdminExample example = new TAdminExample();
		example.createCriteria().andLoginacctEqualTo(username);
		List<TAdmin> list = adminMapper.selectByExample(example);
		if(list==null && list.size()==0) {
			//没有该用户不存在
			return null;
		}
		
		if(list.size() != 1) {
			return null;
		}else {
			TAdmin admin = list.get(0);
			List<GrantedAuthority> authoritys = new ArrayList<GrantedAuthority>();
			
			//将查询到的角色 权限 封装
			List<TRole> roles = roleMapper.getAssignRolesById(admin.getId());
			for (TRole role : roles) {
				authoritys.add(new SimpleGrantedAuthority("ROLE_"+role.getName()));
			}
			
			//根据adminId查询出该用户对应的权限
			List<TPermission> permissions = permissionMapper.getPermissionsByAdminId(admin.getId());
			for (TPermission permission : permissions) {
				String name = permission.getName();
				if(!StringUtils.isEmpty(name)) {
					authoritys.add(new SimpleGrantedAuthority(permission.getName()));
				}
			}
			
			AppUserDetail user = new AppUserDetail(admin.getLoginacct(), admin.getUserpswd(), true, true, true, true, authoritys, admin);
			return user;
		}
		
		
	}

}
