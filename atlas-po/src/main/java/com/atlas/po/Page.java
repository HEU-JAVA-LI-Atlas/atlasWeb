package com.atlas.po;


import javax.xml.bind.annotation.XmlRootElement;

/**
 * 
 * @author 高伟鹏 原作 李文渊学姐
 * @email gaoweipeng3@gmail.com
 * @version 创建时间：2018年5月14日 下午7:17:52
 * @describe 代码阅读加修改命名规范 （此类应对应于图谱中的 图谱描述（Page）表）
 * 
 *           一个图谱，用来展示属性与属性之间的联系以及编辑
 *           
 */

@XmlRootElement(name = "map")
public class Page {
	private String pageId;// 图谱ID（主键）
	private String pageName;// 图谱的名字（==id）	
	private String pageCaption;//图谱标题
	private String pageIcon;//图谱图标
	private int multiple;//倍数
	private String pageMain;//是否为主图

	/**
	 * @describe 下面是一系列的getter，setter方法
	 * @return
	 */
	
	public String getPageId() {
		return pageId;
	}
	public void setPageId(String pageId) {
		this.pageId = pageId;
	}
	public String getPageName() {
		return pageName;
	}
	public void setPageName(String pageName) {
		this.pageName = pageName;
	}
	public String getPageCaption() {
		return pageCaption;
	}
	public void setPageCaption(String pageCaption) {
		this.pageCaption = pageCaption;
	}
	public String getPageIcon() {
		return pageIcon;
	}
	public void setPageIcon(String pageIcon) {
		this.pageIcon = pageIcon;
	}
	public int getMultiple() {
		return multiple;
	}
	public void setMultiple(int multiple) {
		this.multiple = multiple;
	}
	public String getPageMain() {
		return pageMain;
	}
	public void setPageMain(String pageMain) {
		this.pageMain = pageMain;
	}

}
