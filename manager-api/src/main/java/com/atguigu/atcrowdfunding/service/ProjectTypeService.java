package com.atguigu.atcrowdfunding.service;

import java.util.List;

import com.atguigu.atcrowdfunding.bean.TType;

public interface ProjectTypeService {

	/**
	 * 列表展示 分页查询
	 * @param conditon
	 * @return
	 */
	List<TType> loadProjectTypes(String condition);

	/**
	 * 新增项目分类
	 * @param type
	 * @return
	 */
	int addType(TType type);

	/**
	 * 根据id查出分类
	 * @param tid
	 * @return
	 */
	TType getProjectTypeById(Integer tid);

	/**
	 * 修改分类
	 * @param type
	 * @return
	 */
	int updateType(TType type);

	/**
	 * 删除分类
	 * @param tidList
	 * @return
	 */
	int deleteType(List<Integer> tidList);

}
