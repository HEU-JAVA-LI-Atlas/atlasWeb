package com.atlas.po;

/**
 * 
 * @author 高伟鹏 原作 李文渊学姐
 * @email gaoweipeng3@gmail.com
 * @version 创建时间：2018年5月14日 下午6:48:49
 * @describe 代码阅读，加修改（此类应对应为图谱中的关系（Connection）表）
 *           最基本属性之间的关系
 */
public class Connection {
	// 还有线条样式 粗细 颜色
	private String sourceId;//源节点ID
	private String targetId;//目标结点ID
	private String text;//关系之间信息
	private String sourceText;//源节点信息
	private String targetText;//目标节点信息
	private int fontSize;//字体大小
	private String fontColor;//字体颜色
	private String arrowType;//箭头样式
	private String lineStyle;// 线的样式
	private String lineColor;// 线的颜色
	private int lineWidth;// 线的粗细
	
	
	/**
	 * @describe 下面是一系列的get，set方法，还有重写了toString
	 * @return
	 */
	
	public String getSourceId() {
		return sourceId;
	}
	public void setSourceId(String sourceId) {
		this.sourceId = sourceId;
	}
	public String getTargetId() {
		return targetId;
	}
	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getSourceText() {
		return sourceText;
	}
	public void setSourceText(String sourceText) {
		this.sourceText = sourceText;
	}
	public String getTargetText() {
		return targetText;
	}
	public void setTargetText(String targetText) {
		this.targetText = targetText;
	}
	public int getFontSize() {
		return fontSize;
	}
	public void setFontSize(int fontSize) {
		this.fontSize = fontSize;
	}
	public String getFontColor() {
		return fontColor;
	}
	public void setFontColor(String fontColor) {
		this.fontColor = fontColor;
	}
	public String getArrowType() {
		return arrowType;
	}
	public void setArrowType(String arrowType) {
		this.arrowType = arrowType;
	}
	public String getLineStyle() {
		return lineStyle;
	}
	public void setLineStyle(String lineStyle) {
		this.lineStyle = lineStyle;
	}
	public String getLineColor() {
		return lineColor;
	}
	public void setLineColor(String lineColor) {
		this.lineColor = lineColor;
	}
	public int getLineWidth() {
		return lineWidth;
	}
	public void setLineWidth(int lineWidth) {
		this.lineWidth = lineWidth;
	}
	@Override
	public String toString() {
		return "Connection [sourceId=" + sourceId + ", targetId=" + targetId + ", text=" + text + ", sourceText="
				+ sourceText + ", targetText=" + targetText + ", fontSize=" + fontSize + ", fontColor=" + fontColor
				+ ", arrowType=" + arrowType + ", lineStyle=" + lineStyle + ", lineColor=" + lineColor + ", lineWidth="
				+ lineWidth + "]";
	}

	
	

	
}
