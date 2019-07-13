package com.atguigu.atcrowdfunding.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 自定义监听器
 * 	实现ServletContextListener
 *  并在web.xml中配置
 * @author Administrator
 *
 */
public class AppStartListener implements ServletContextListener {

	Logger logger = LoggerFactory.getLogger(AppStartListener.class);
	
	//项目初始化
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext servletContext = sce.getServletContext();
		String contextPath = servletContext.getContextPath();
		servletContext.setAttribute("PATH", contextPath);
		logger.info("监听到的上下文路径{}"+contextPath);
		
	}

	//项目销毁
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		ServletContext servletContext = sce.getServletContext();
	}

}
