package com.atguigu.atcrowdfunding.service;


import java.util.List;

import com.atguigu.atcrowdfunding.bean.TAdmin;

public interface AdminService {

	TAdmin login(String loginacct, String userpswd);

	/**
	 * 根据添加进行查询 分页
	 * @param condition
	 * @return
	 */
	List<TAdmin> loadAdmins(String condition);

	/**
	 * 根据id查询Admin
	 * @param id
	 * @return
	 */
	TAdmin getAdminById(Integer id);

	/**
	 * 修改admin
	 * @param admin
	 */
	void updateAdmin(TAdmin admin);

	/**
	 * 根据id删除admin
	 * 
	 * @param id
	 * @return
	 */
	void deleteAdminById(Integer id);

	/**
	 * 新增admin
	 * 
	 * @param admin
	 */
	void saveAdmin(TAdmin admin);
	
	/**
	 * 检查账号是否存在
	 * 
	 * @param admin
	 * @return
	 */
	boolean checkLoginacct(TAdmin admin);

	/**
	 * 检查邮箱是否存在
	 * 
	 * @param admin
	 * @return
	 */
	boolean checkEmail(TAdmin admin);
	

	/**
	 * 批量删除
	 * @param idList
	 */
	void batchDelete(List<Integer> idList);

	/**
	 * 给用户分配角色
	 * @param adminId
	 * @param roleIdList
	 */
	void assignRoles(Integer adminId, List<Integer> roleIdList);

	/**
	 * 取消用户的角色分配
	 * @param adminId
	 * @param roleIdList
	 */
	void unAssingnRole(Integer adminId, List<Integer> roleIdList);
	
}
