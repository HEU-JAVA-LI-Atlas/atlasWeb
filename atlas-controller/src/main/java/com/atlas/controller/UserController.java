package com.atlas.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atlas.po.connection;
import com.atlas.po.node;
import com.atlas.po.nodeTable;
import com.atlas.po.page;
import com.atlas.po.people;
import com.atlas.utils.XmlUtil;

import net.sf.json.JSONObject;

/**
 * 
 * @author 高伟鹏 原作 李文渊学姐
 * @email gaoweipeng3@gmail.com
 * @version 创建时间：2018年5月14日 下午8:13:39
 * @describe 代码阅读与修改命名
 */

@Controller
@RequestMapping("lwy")

public class UserController {
	
	/**
	 * 这里设置成全局的,做缓存
	 */
	 List<people> p=new ArrayList<people>();
	   List<connection> connect=new ArrayList<connection>();   
	   List<node> nodelist=new ArrayList<node>();
	   //List<nodeTable> tablelist=new ArrayList<nodeTable>();
	   Map<String,List<nodeTable>> nodemap=new HashMap<String, List<nodeTable> >();	   
	   Map<String,List<nodeTable>> peopleInfomap=new HashMap<String, List<nodeTable> >();
public void IninJstree(){
	
}
//新增节点
@RequestMapping("/createNode.do")
@ResponseBody
public void changedata(String changedata) {
 
	    //System.out.println(changedata);
	
		String nodeStr=changedata;
		
		JSONObject jsonObject=JSONObject.fromObject(nodeStr);
		node node=(node)JSONObject.toBean(jsonObject, node.class);
		nodelist.add(node);
		//初始化nodemap中一个节点的数据
		nodemap.put(node.getId(), null);
		//通过nodeid得到node的parentid，通过parentid得到父节点的tablist  
		if(node.getParentId() != null){
			
			if(nodemap.get(node.getParentId())!=null){
				//nodemap.put(node.getId(), null);
				nodemap.put(node.getId(),nodemap.get(node.getParentId()));
			}
		}
		
		System.out.println(nodelist);
		
}
//重命名节点
	@RequestMapping("/renameNode.do")
	@ResponseBody
	public void renameNode(String changedata,String nodeid){
		for(node n:nodelist){
			if(n.getId().equals(nodeid)){
				n.setText(changedata);
				System.out.println(changedata);
			}
		}
		
	}
@RequestMapping("/removeNode.do")
@ResponseBody
	public void removeNode(String nodeid){
		for(node n:nodelist){
			if(n.getId().equals(nodeid)){
				
			}
		}
		
	}
//保存表格中的数据
@RequestMapping("/tablePost.do")
@ResponseBody
public void changetabledata(String nodeid,String tableid,String tabletitle,String changetabledata) {
	  //System.out.println(nodeid);
	  nodeTable t=new nodeTable(tableid,tabletitle,changetabledata);
	  List<nodeTable> nt=new ArrayList<nodeTable>();
	  if(nodemap.get(nodeid)==null){
		  nt.add(t);
		  nodemap.put(nodeid,nt);
	  }
	  else {
		  nodemap.get(nodeid).add(t);
	  }
	//遍历nodelist获取nodeid对应的node实体类
	 for (node node: nodelist) {
     if(node.getId().equals(nodeid)){
  	   
         //System.out.println(t.getData());
         node.setTablelist(nodemap.get(nodeid));        
     }
 }
	
 System.out.println(nodemap);
 //attr.setId(nodeid);
}

//加载表格数据
//如果tab已经存在在list中就加载数据 如果不存在就把new一个nodetable
@RequestMapping(value="loadtabledata.do",produces = {"application/text;charset=UTF-8"})
@ResponseBody
public String changedata(String tabtitle,String nodeid) {
	 String data=null;
	 
	 List<nodeTable> tlist=new ArrayList<nodeTable>();
	

	 
	 if(nodemap.get(nodeid)!=null)
	 {
		 //节点已经有属性表
		 tlist=nodemap.get(nodeid);
	 }else{
		 //父节点是否有属性表
		 for(node node:nodelist){
			 if(node.getId().equals(nodeid)){
				 
				nodemap.put(nodeid, nodemap.get(node.getParentId())) ;
				if(nodemap.get(node.getParentId())!=null){
					tlist=nodemap.get(node.getParentId());
				}			
			 }
		 }
	 }
	 
	 for (nodeTable t: tlist) {
		 //存在该表格
		 if(t.getTabletitle().equals(tabtitle)){
			 
			if(t.getData()!=null){
				data=t.getData();
			}
		 }
	 }
  //System.out.println("load:"+data);
	return data;
	
}

//返回节点信息表格的标签页名称
@RequestMapping("loadpeopletab.do")
@ResponseBody
public List<String>  loadTab(String nodeid) {
	 List<String> tabtitle=new ArrayList();
	 //遍历list
	 if(nodemap.get(nodeid)!=null){
		 int len=nodemap.get(nodeid).size();
		 for(int i=0;i<len;i++)
		 {
			 String tabt=nodemap.get(nodeid).get(i).getTabletitle();
			 tabtitle.add(tabt);
		 }
	 }	 
	 //System.out.println(tabtitle);
	 return tabtitle;
}

//保存人员节点的信息
@RequestMapping("/peoplePost.do")
@ResponseBody
public void savePeople(String data,String nodeid) {
   
	    //System.out.println(data);	
		String nodeStr=data;		
		JSONObject jsonObject=JSONObject.fromObject(nodeStr);
		
		people people=(people)JSONObject.toBean(jsonObject, people.class);
		
		p.add(people);
		
		peopleInfomap.put(people.getId(), nodemap.get(nodeid));
		//people.setInfoTableList(nodemap.get(nodeid));
		//System.out.println(peopleInfomap);
		
}

//保存人员infotable
@RequestMapping("/infotablePost.do")
@ResponseBody
public void saveinfoTable(String pid,String tabletitle,String changetabledata) {
	    //修改map里的数据
	    System.out.println(changetabledata);
	    
	    for(nodeTable nt:peopleInfomap.get(pid)){
	    	if(nt.getTabletitle().equals(tabletitle)){
	    		nt.setData(changetabledata);
	    	}
	    }
	    peopleInfomap.put(pid,peopleInfomap.get(pid));
	   //保存到people实体中
	    for(people p:p){
	    	if(p.getId().equals(pid)){
	    		p.setInfoTableList(peopleInfomap.get(pid));
	    	}
	    }
}


//加载人员infotable
@RequestMapping(value="loadinfotable.do",produces = {"application/text;charset=UTF-8"})
@ResponseBody
public String loadinfotable(String tabtitle,String pid) {
	 //System.out.println(peopleInfomap.get(pid));
	 //System.out.println("----------------------------");
	 String data=null;
	 for(nodeTable t:peopleInfomap.get(pid)){
		 if(t.getTabletitle().equals(tabtitle)){
	    		data=t.getData();
	    	}
	 }
	
  //System.out.println("load:"+data);
	return data;
	
}

//加载人员信息的tab
@RequestMapping("/loadinfotab.do")
@ResponseBody
public List<String> loadinfotab(String pid) {
	 List<String> peopletab=new ArrayList();
	 int len=peopleInfomap.get(pid).size();
	 for(int i=0;i<len;i++)
	 {
		 String tabt=peopleInfomap.get(pid).get(i).getTabletitle();
		 peopletab.add(tabt);
	 }
  return peopletab;
}

//保存人员关系的信息
@RequestMapping("/connectPost.do")
@ResponseBody
public void saveConnection(String data) {
 
	    //System.out.println(data);	
		String nodeStr=data;		
		JSONObject jsonObject=JSONObject.fromObject(nodeStr);
		
		connection connection=(connection)JSONObject.toBean(jsonObject,connection.class);
		connect.add(connection);
		//System.out.println("connection:"+connection);
		
}
@RequestMapping("/pagePost.do")
@ResponseBody
public void savepagedata(String pageid,String pagetitle) throws IOException {
	   //把tree和page存入map后将map转化为xml
     page page;
     page=new  page();
     page.setId(pageid);
     page.setTitle(pagetitle);
     page.setPeople(p);
     page.setConnect(connect);
     // System.out.println(pageid);
     //将得到的page转为xml
     
     String s=XmlUtil.getBeanXml(page);
     
     //System.out.println(XmlUtil.getBeanXml(page));
     XmlUtil.strChangeXML(s,pagetitle);
     //String xmlPath = "E:/tupu/test/nodes1.xml";
     //保存到本地文件中
  
}

//图谱前台显示
Map<String,Map<String,Object>> pageMap=new HashMap<String, Map<String,Object>>();	   
@RequestMapping("/xmlPost.do")
@ResponseBody
public Map<String,Object> peopleArray(String data,String fileName,String associateMethod) throws Exception {
	//System.out.println(fileName);
	people p=new people();
	connection c=new connection();
	Map<String,Object> map=new HashMap<String, Object>();
	Map<String,Object> associateMap=new HashMap<String, Object>();
	map=XmlUtil.readpeopleXml(data,p,c);
  //加载两次得到两个map
	//放到一个pageMap中
	/*pageMap.put(fileName, map);
	if(pageMap.size()==2){
		//调用函数取出人员节点的list并做相交
	    Set<Entry<String, Map<String, Object>>> entrySet=pageMap.entrySet();  
	    Iterator<Entry<String, Map<String, Object>>> it=entrySet.iterator();  
	    
	    List<String> pList_1=new ArrayList<String>();
      List<people> firstPeopleList=new ArrayList<people>();
      List<connection> firstConnectList=new ArrayList<connection>();
      firstPeopleList=null;
  
	List<String> pList_2=new ArrayList<String>();
  List<people> secondPeopleList=new ArrayList<people>();
  List<connection> secondConnectList=new ArrayList<connection>();
  secondPeopleList=null;
  
	while(it.hasNext())  
	{  
	    Entry<String, Map<String, Object>> me=it.next();  
	    String key=me.getKey();  
	    Map<String, Object> value =me.getValue();
	    List<people> peopleList=(List<people>) value.get("people");
	    List<connection> connectList=(List<connection>) value.get("connection");
	    if(firstPeopleList==null){
	    	firstPeopleList=peopleList;
	    	firstConnectList=AssociateUtil.transformIdToIdCardNum(connectList,peopleList);//将sourceid targetid都改为身份证号
	    	pList_1=AssociateUtil.getPeopleIdCardNumCollect(firstPeopleList);
	    }else{
	    	if(secondPeopleList==null){
	    	secondPeopleList=peopleList;
	    	secondConnectList=AssociateUtil.transformIdToIdCardNum(connectList,peopleList);;
	        pList_2=AssociateUtil.getPeopleIdCardNumCollect(secondPeopleList);
	    	}
	    }	      
	}  
	switch(associateMethod){
  case "intersection":
  	associateMap=AssociateUtil.getIntersection(firstPeopleList,firstConnectList,secondPeopleList,secondConnectList,pList_1,pList_2);break;
  case "substract":
  	associateMap=AssociateUtil.getSubtract(firstPeopleList,firstConnectList,secondPeopleList,secondConnectList,pList_1,pList_2);break;
  case "union":
  	associateMap=AssociateUtil.getUnion(firstPeopleList,firstConnectList,secondPeopleList,secondConnectList,pList_1,pList_2);break;
  case "disjunction":
  	associateMap=AssociateUtil.getDisjunction(firstPeopleList,firstConnectList,secondPeopleList,secondConnectList,pList_1,pList_2);break; 
  default:
      associateMap=map; break;
  }
	}
	//System.out.println(pageMap);*/
	return map;
	
	//return associateMap;
	
}

}


	     
