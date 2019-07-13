package com.atguigu.atcrowdfunding.exception;

/**
 * 用户添加异常类
 * @author Administrator
 *
 */
public class AddAdminException extends RuntimeException{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public AddAdminException(String message) {
		super(message);
	}

}
