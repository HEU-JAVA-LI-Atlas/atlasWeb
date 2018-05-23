package com.atlas.po;


/**
 * 
 * @author 高伟鹏 原作 李文渊学姐
 * @email gaoweipeng3@gmail.com
 * @describe  人员节点的约束
 * 
 */

public class Constraint {
	private String peopleId;//人员标号（外键）
	private int x;// 坐标x
	private int y;// 坐标y
	private int width;// 宽度（左上角点取值）
	private int height;// 高度（左上角点取值）
	/**
	 * @describe 属性的setter，getter方法。以及toString的重写
	 * @return
	 */
	public int getX() {
		return x;
	}
	public void setX(int x) {
		this.x = x;
	}
	public int getY() {
		return y;
	}
	public void setY(int y) {
		this.y = y;
	}
	public int getWidth() {
		return width;
	}
	public void setWidth(int width) {
		this.width = width;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}

	
}
