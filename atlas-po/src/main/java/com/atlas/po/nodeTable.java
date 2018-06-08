package com.atlas.po;

import java.io.Serializable;
import java.lang.reflect.Array;
import java.util.Arrays;

public class nodeTable {
	private String tableid;
	private String tabletitle;	
	private String data;
	public String getTabletitle() {
		return tabletitle;
	}
	public void setTabletitle(String tabletitle) {
		this.tabletitle = tabletitle;
	}
	public String getTableid() {
		return tableid;
	}
	public void setTableid(String tableid) {
		this.tableid = tableid;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	
	public nodeTable(String tableid,String tabletitle,String changetabledata){
		this.tabletitle = tabletitle;
		this.tableid = tableid;
		this.data = changetabledata;
	}
	@Override
	public String toString() {
	return "nodeTable [id=" + tableid+ ", title=" + tabletitle + ", data="
	+ data + "]";
	}
}