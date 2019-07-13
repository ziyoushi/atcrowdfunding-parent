package com.atguigu.atcrowdfunding.component;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.atguigu.atcrowdfunding.utils.AppUtil;

@Component
public class AppPasswordEncoder implements PasswordEncoder {

	@Override
	public String encode(CharSequence rawPassword) {
		String digestPwd = AppUtil.getDigestPwd(rawPassword.toString());
		return digestPwd;
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		String md5Password = encode(rawPassword);
		return md5Password.equalsIgnoreCase(encodedPassword);
	}

}
