package com.atlas.po;

import java.util.List;

public class people {
	//还有字体 大小 颜色  
      private String id;
      private String title;
      private String name;
      private String idCardNum;
      private String photo; 
      private String x;
      private String y;
      private String width;
      private String height;
      private List<nodeTable> infoTableList;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIdCardNum() {
		return idCardNum;
	}
	public void setIdCardNum(String idCardNum) {
		this.idCardNum = idCardNum;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getX() {
		return x;
	}
	public void setX(String x) {
		this.x = x;
	}
	public String getY() {
		return y;
	}
	public void setY(String y) {
		this.y = y;
	}
	public String getWidth() {
		return width;
	}
	public void setWidth(String width) {
		this.width = width;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public List<nodeTable> getInfoTableList() {
		return infoTableList;
	}
	public void setInfoTableList(List<nodeTable> infoTableList) {
		this.infoTableList = infoTableList;
	}
	@Override
	public String toString() {
		return "people [id=" + id + ", title=" + title + ", name=" + name + ", idCardNum=" + idCardNum + ", photo="
				+ photo + ", x=" + x + ", y=" + y + ", width=" + width + ", height=" + height + ", infoTableList="
				+ infoTableList + "]";
	}

	



	
}
