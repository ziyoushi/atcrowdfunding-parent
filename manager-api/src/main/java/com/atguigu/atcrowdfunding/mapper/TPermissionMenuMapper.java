package com.atguigu.atcrowdfunding.mapper;

import com.atguigu.atcrowdfunding.bean.TMenu;
import com.atguigu.atcrowdfunding.bean.TPermissionMenu;
import com.atguigu.atcrowdfunding.bean.TPermissionMenuExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TPermissionMenuMapper {
    long countByExample(TPermissionMenuExample example);

    int deleteByExample(TPermissionMenuExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TPermissionMenu record);

    int insertSelective(TPermissionMenu record);

    List<TPermissionMenu> selectByExample(TPermissionMenuExample example);

    TPermissionMenu selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TPermissionMenu record, @Param("example") TPermissionMenuExample example);

    int updateByExample(@Param("record") TPermissionMenu record, @Param("example") TPermissionMenuExample example);

    int updateByPrimaryKeySelective(TPermissionMenu record);

    int updateByPrimaryKey(TPermissionMenu record);

	List<TMenu> getMenuById(Integer permissionId);

	//给权限分配菜单
	int assignPermissionMenu(@Param("permissionId") Integer permissionId, @Param("menuList") List<Integer> menuList);
}