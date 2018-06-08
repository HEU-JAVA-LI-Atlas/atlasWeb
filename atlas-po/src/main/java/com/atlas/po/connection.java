package com.atlas.po;

public class connection {
	//还有线条样式 粗细 颜色
   private String sourceId;
   private String targetId;
   private String text;
   private String lineStyle;
   private String lineColor;
   private String lineWidth;
public String getText() {
	return text;
}
public void setText(String text) {
	this.text = text;
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
public String getLineWidth() {
	return lineWidth;
}
public void setLineWidth(String lineWidth) {
	this.lineWidth = lineWidth;
}
@Override
public String toString() {
return "connection[sourceid=" + sourceId + ", targetid="+targetId+",text=" + text + ",lineStyle=" + lineStyle + ",lineColor=" + lineColor + ",lineWidth=" + lineWidth + "]";
}
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
}
