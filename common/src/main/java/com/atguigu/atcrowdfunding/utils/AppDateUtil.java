package com.atguigu.atcrowdfunding.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/*
 * 时间格式化工具
 */
public class AppDateUtil {

	public static String getCurrentTimeStr() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(new Date());
	}
	
	public static String getCurrentTimeStr(Date date) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(date);
	}
	
	public static String getCurrentTimeStr(Date date,String pattern) {
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		return format.format(date);
	}
	
}
