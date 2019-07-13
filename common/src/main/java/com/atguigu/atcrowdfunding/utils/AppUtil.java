package com.atguigu.atcrowdfunding.utils;

import org.springframework.util.DigestUtils;

public class AppUtil {

	public static String getDigestPwd(String str) {
		String string = str;
		for(int i = 0;i<100;i++) {
			string = DigestUtils.md5DigestAsHex(string.getBytes());
		}
		return string;
	}
	
	public static void main(String[] args) {
		String passwd = getDigestPwd("123456");
		System.out.println(passwd);
	}

}
