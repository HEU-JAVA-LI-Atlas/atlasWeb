package com.atlas.service;

import com.atlas.po.NodeTable;

/**
 * 
 * @author 高伟鹏 原作 李文渊学姐
 * @email gaoweipeng3@gmail.com
 * @version 创建时间：2018年5月14日 下午7:35:59
 * @describe 阅读以及修改结点列表的接口
 */
public interface TableService {
	/**
	 * @describe 添加结点表
	 * @param table
	 * @throws Exception
	 */
	public void add(NodeTable table) throws Exception;

	/**
	 * @describe 删除结点表
	 * @param table
	 * @throws Exception
	 */
	public void delete(NodeTable table) throws Exception;
	// public List<nodeTableAttr> listUserByAge(int age) throws Exception;

	/**
	 * @describe 根据id查询结点表
	 * @param tableid
	 * @return
	 * @throws Exception
	 */
	public NodeTable getTableById(String tableid) throws Exception;

	public void userJedisTest();

}
