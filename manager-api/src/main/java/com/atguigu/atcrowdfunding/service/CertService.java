package com.atguigu.atcrowdfunding.service;

import java.util.List;

import com.atguigu.atcrowdfunding.bean.TCert;

public interface CertService {

	/**
	 * 列表展示 分页查询
	 * @param condition
	 * @return
	 */
	List<TCert> getAllCerts(String condition);

	/**
	 * 根据id查出资质
	 * @param certId
	 * @return
	 */
	TCert getCertById(Integer certId);

	/**
	 * 修改资质
	 * @param cert
	 * @return
	 */
	int updateCert(TCert cert);

	/**
	 * 新增资质
	 * @param cert
	 * @return
	 */
	int addCert(TCert cert);

	/**
	 * 删除 
	 * @param certList
	 * @return
	 */
	int deleteCert(List<Integer> certList);

}
