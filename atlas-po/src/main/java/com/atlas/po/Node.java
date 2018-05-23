package com.atlas.po;


/**
 * 
 * @author 高伟鹏 原作 李文渊学姐
 * @email gaoweipeng3@gmail.com
 * @version 创建时间：2018年5月14日 下午7:14:32
 * @describe 代码阅读加修改命名（此类应对应于图谱中 图元树状管理的结点（node）表）
 *           jstree中的每个结点
 */
public class Node {
	private String nodeId;//jstree的结点id(主键）
	private String pageId;//图谱标号（外键）
	private String nodeName;//节点名字
	private String nodeIcon;// 图标
	private String parentId;// 父结点ID
	private String nodeProperty;//是否为叶子节点（是否展开
	/*
	 * private String li_attr; private String a_attr; private String state(){
	 * private boolean opened ; private boolean disabled ; private boolean selected
	 * ; }
	 */
	/**
	 * @describe getter，setter方法，以及toString的重写
	 * @return
	 */
	public String getNodeId() {
		return nodeId;
	}
	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}
	public String getPageId() {
		return pageId;
	}
	public void setPageId(String pageId) {
		this.pageId = pageId;
	}
	public String getNodeName() {
		return nodeName;
	}
	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}
	public String getNodeIcon() {
		return nodeIcon;
	}
	public void setNodeIcon(String nodeIcon) {
		this.nodeIcon = nodeIcon;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getNodeProperty() {
		return nodeProperty;
	}
	public void setNodeProperty(String nodeProperty) {
		this.nodeProperty = nodeProperty;
	}
	@Override
	public String toString() {
		return "Node [nodeId=" + nodeId + ", pageId=" + pageId + ", nodeName=" + nodeName + ", nodeIcon=" + nodeIcon
				+ ", parentId=" + parentId + ", nodeProperty=" + nodeProperty + "]";
	}

	

	

}
