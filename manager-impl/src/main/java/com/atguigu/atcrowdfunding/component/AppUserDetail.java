package com.atguigu.atcrowdfunding.component;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Component;

import com.atguigu.atcrowdfunding.bean.TAdmin;

public class AppUserDetail  extends User {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//封装TAmin
	private TAdmin admin;

	public AppUserDetail(String username, String password, boolean enabled, boolean accountNonExpired,
			boolean credentialsNonExpired, boolean accountNonLocked,
			Collection<? extends GrantedAuthority> authorities,TAdmin admin) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		this.admin = admin;
	}

	public TAdmin getAdmin() {
		return admin;
	}

	public void setAdmin(TAdmin admin) {
		this.admin = admin;
	}
	
	


}
