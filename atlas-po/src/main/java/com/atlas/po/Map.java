package com.atlas.po;

import java.util.List;

/**
 * 
 * @author 高伟鹏 原作 李文渊学姐
 * @email gaoweipeng3@gmail.com
 * @version 创建时间：2018年5月14日 下午6:53:28
 * @describe @describe 阅读加修改命名 (??此类应为前台生成jsTree的辅助类)
 */
public class Map {
	private Page page;
	private List<Node> nodeList;// 结点链表

	/**
	 * @describe 下面是getter，setter方法
	 * @return
	 */
	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public List<Node> getNodeList() {
		return nodeList;
	}

	public void setNodeList(List<Node> nodeList) {
		this.nodeList = nodeList;
	}

}
