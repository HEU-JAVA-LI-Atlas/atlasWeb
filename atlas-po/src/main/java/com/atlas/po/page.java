package com.atlas.po;

import java.util.List;

import javax.xml.bind.annotation.XmlRootElement;
@XmlRootElement(name="map")
public class page {
  private String id;
  private String title;
  private List<people> people;
  private List<connection> connect;
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
public List<people> getPeople() {
	return people;
}
public void setPeople(List<people> people) {
	this.people = people;
}
public List<connection> getConnect() {
	return connect;
}
public void setConnect(List<connection> connect) {
	this.connect = connect;
}

}
