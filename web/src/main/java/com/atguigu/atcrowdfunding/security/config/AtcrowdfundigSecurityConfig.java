package com.atguigu.atcrowdfunding.security.config;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.atguigu.atcrowdfunding.bean.TAdmin;
import com.atguigu.atcrowdfunding.common.AppConstant;
import com.atguigu.atcrowdfunding.component.AppUserDetail;
import org.springframework.util.StringUtils;

@EnableGlobalMethodSecurity(prePostEnabled=true)
@EnableWebSecurity
@Configuration
public class AtcrowdfundigSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	UserDetailsService userDetailsService;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService)
		.passwordEncoder(passwordEncoder);
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		//放行静态资源
		http.authorizeRequests()
		.antMatchers("/static/**","/index.html","/login.jsp","/welcome.jsp").permitAll()
		.anyRequest().authenticated();//除了上面的 其余的请求都要进行认证
		
		//设置登录页
		http.formLogin().loginPage("/login")
		.usernameParameter("loginacct")
		.passwordParameter("userpswd")
		.successHandler(new AuthenticationSuccessHandler() {
			
			@Override
			public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
					Authentication authentication) throws IOException, ServletException {
				
				//authentication当前登录的对象
				UsernamePasswordAuthenticationToken token = (UsernamePasswordAuthenticationToken) authentication;
				AppUserDetail principal = (AppUserDetail)token.getPrincipal();
				TAdmin admin = principal.getAdmin();
				
				//存放到session中
				request.getSession().setAttribute(AppConstant.LOGIN_KEY, admin);
				//登录成功后 去主页面
				response.sendRedirect(request.getContextPath()+"/main.html");
				
			}
		}).failureHandler(new AuthenticationFailureHandler() {
			
			@Override
			public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
					AuthenticationException exception) throws IOException, ServletException {
				request.setAttribute("msg", "账号密码错误，请重试");
				request.getRequestDispatcher("/login.jsp").forward(request, response);
				
			}
		}).permitAll();
		
		//配置异常页面
		http.exceptionHandling().accessDeniedHandler(new AccessDeniedHandler() {
			
			@Override
			public void handle(HttpServletRequest request, HttpServletResponse response,
					AccessDeniedException accessDeniedException) throws IOException, ServletException {
				//ajax请求控制
				String headers = request.getHeader("X-Requested-With");
				if (!StringUtils.isEmpty(headers)&&"".equals("XMLHttpRequest")){

					response.sendRedirect("/error.html");
				}else {
					//转发到提示页面
					request.getRequestDispatcher("/unauth.html").forward(request, response);

				}

			}
		});
		
		
		//登出
		http.logout();
		
		//关闭csrf
		http.csrf().disable();
		
	}
	
}
