package com.atlas.po;

import java.util.List;

public class node {
	  private String id  ;  
	  private String text  ;
	  private String icon  ;
	  private String type ;
	  private String parentId;
	  private List<nodeTable> tablelist;
	 /* private String li_attr;
	  private String a_attr;
	  private String state(){
		  private boolean opened ;
		  private boolean disabled ;
		  private boolean selected ;
	}*/
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	} 
	
	public String getParentId() {
		return parentId;
	}
	public void setParentid(String parentId) {
		this.parentId = parentId;
	}
	public List<nodeTable> getTablelist() {
		return tablelist;
	}
	public void setTablelist(List<nodeTable> tablelist) {
		this.tablelist = tablelist;
	}
	@Override
	public String toString() {
	return "node [id=" + id+ ", text=" + text + ", icon="
	+ icon + ",type="+type+",parentid=" + parentId+ ",tablelist="+tablelist+"]";
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
}

