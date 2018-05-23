package com.atlas.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.atlas.po.NodeTable;
import com.atlas.service.TableService;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

/**
 * 
 * @author 高伟鹏 原作 李文渊学姐
 * @email gaoweipeng3@gmail.com
 * @version 创建时间：2018年5月14日 下午7:38:06
 * @describe 阅读以及修改结点列表的实现类
 */
@Service
@Transactional
public class TableServiceImpl implements TableService {
    
	
	
	@Autowired
    private JedisPool jedisPool;
    
    public void userJedisTest(){
    	Jedis jedis = jedisPool.getResource();
        jedis.set("userNum", "11");
        System.out.println("长度是:" + jedis.strlen("userNum"));
    }
	/**
	 * 添加结点
	 */
	public void add(NodeTable table) throws Exception {
		// TODO Auto-generated method stub
        
	}

	/**
	 * 删除结点，还是删除结点表？
	 */
	public void delete(NodeTable table) throws Exception {
		// TODO Auto-generated method stub

	}

	/**
	 * 查询结点表
	 */
	public NodeTable getTableById(String tableid) throws Exception {
		// TODO Auto-generated method stub
		NodeTable table = null;
		// table=mapper.findById(tableid);
		if (table == null) {
			throw new Exception("table is not existed");
		}
		return table;
	}

}
