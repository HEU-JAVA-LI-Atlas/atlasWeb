package com.atlas.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atlas.po.Connection;
import com.atlas.po.Node;
import com.atlas.po.NodeTable;
import com.atlas.po.Page;
import com.atlas.po.People;
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
	List<People> p = new ArrayList<People>();
	List<Connection> connect = new ArrayList<Connection>();
	List<Node> nodeList = new ArrayList<Node>();
	// List<nodeTable> tablelist=new ArrayList<nodeTable>();
	Map<String, List<NodeTable>> nodeMap = new HashMap<String, List<NodeTable>>();// 用于将子节点的id与父结点的id进行关联
	Map<String, List<NodeTable>> peopleInfoMap = new HashMap<String, List<NodeTable>>();

	// 接收目录新增节点的数据
	@RequestMapping("/nodePost.do")
	@ResponseBody
	/**
	 * @result 增加目录节点
	 * @param changedata
	 */
	public void nodePost(String changeData) {

		// System.out.println(changedata);

		String nodeStr = changeData;// 接收前台传来的数据

		JSONObject jsonObject = JSONObject.fromObject(nodeStr);// 将前台数据转化为Json格式
		Node node = (Node) JSONObject.toBean(jsonObject, Node.class);// 转化为Node实体类
		nodeList.add(node);// 向Node列表中添加新的node结点
		// 初始化nodeMap中一个节点的数据
		nodeMap.put(node.getNodeId(), null);
		// 通过nodeid得到node的parentid，通过parentid得到父节点的tablist
		if (node.getParentId() != null) {

			if (nodeMap.get(node.getParentId()) != null) {
				// nodeMap.put(node.getId(), null);
				nodeMap.put(node.getNodeId(), nodeMap.get(node.getParentId()));// 将子节点的id与父结点的id进行关联
			}
		}

		// System.out.println("node:"+node);

	}

	// 保存表格中的数据
//	@RequestMapping("/tablePost.do")
//	@ResponseBody
//	/**
//	 * @describe 此处应是保存表单数据，可是为什么只保存到map集合中而不写入xml（未实现功能）
//	 * @param nodeid
//	 * @param tableid
//	 * @param tabletitle
//	 * @param changetabledata
//	 */
//	public void tablePost(String nodeId, String tableId, String tableTitle, String changeTableData) {
//		// System.out.println(nodeId);
//		NodeTable t = new NodeTable(tableId, tableTitle, changeTableData);
//		List<NodeTable> nodeT = new ArrayList<NodeTable>();
//		if (nodeMap.get(nodeId) == null) {
//			nodeT.add(t);
//			nodeMap.put(nodeId, nodeT);
//		} else {
//			nodeMap.get(nodeId).add(t);
//		}
//		// 遍历nodelist获取nodeid对应的node实体类
//		for (Node node : nodeList) {
//			if (node.getNodeId().equals(nodeId)) {
//
//				// System.out.println(t.getData());
//				node.setTableList(nodeMap.get(nodeId));
//			}
//		}
//
//		System.out.println(nodeMap);
//		// attr.setId(nodeId);
//	}

	// 加载表格数据
	// 如果tab已经存在在list中就加载数据 如果不存在就把new一个nodetable
//	@RequestMapping(value = "loadTableData.do", produces = { "application/text;charset=UTF-8" })
//	@ResponseBody
//	/**
//	 * @describe 此处应该是显示数据
//	 * @param tabtitle 表明名
//	 * @param nodeid 所属结点id?
//	 * @return
//	 */
//	public String loadTableData(String tabTitle, String nodeId) {
//		String data = null;
//		List<NodeTable> tList = new ArrayList<NodeTable>();
//		if (nodeMap.get(nodeId) != null) {
//			tList = nodeMap.get(nodeId);
//		}
//		for (NodeTable t : tList) {
//			// 存在该表格
//			if (t.getTableId().equals(tabTitle)) {
//
//				if (t.getData() != null) {
//					data = t.getData();
//				}
//			}
//		}
//		// System.out.println("load:"+data);
//		return data;
//
//	}

	// 返回节点信息表格的标签页名称
//	@RequestMapping("loadPeopleTab.do")
//	@ResponseBody
//	public List<String> loadPeopleTab(String nodeId) {
//		List<String> tabTitle = new ArrayList<>();
//		// 遍历list
//		if (nodeMap.get(nodeId) != null) {
//			int len = nodeMap.get(nodeId).size();
//			for (int i = 0; i < len; i++) {
//				String tabT = nodeMap.get(nodeId).get(i).getTableId();
//				tabTitle.add(tabT);
//			}
//		}
//		// System.out.println(tabTitle);
//		return tabTitle;
//	}

	// 保存人员节点的信息
	@RequestMapping("/peoplePost.do")
	@ResponseBody
	/**
	 * @describe 新增人员结点
	 * @param data
	 * @param nodeid
	 */
	public void peoplePost(String data, String nodeId) {

		// System.out.println(data);
		String nodeStr = data;
		JSONObject jsonObject = JSONObject.fromObject(nodeStr);

		People people = (People) JSONObject.toBean(jsonObject, People.class);

		p.add(people);

		peopleInfoMap.put(people.getPeopleId(), nodeMap.get(nodeId));
		// people.setInfoTableList(nodeMap.get(nodeId));
		// System.out.println(peopleInfoMap);

	}

	// 保存人员infotable
//	@RequestMapping("/infoTablePost.do")
//	@ResponseBody
//	/**
//	 * @describe 保存人员infotable(最下方的表格)
//	 * @param pid
//	 * @param tabletitle
//	 * @param changetabledata
//	 */
//	public void infoTablePost(String pId, String tableTitle, String changeTableData) {
//		// 修改map里的数据
//		System.out.println(changeTableData);
//
//		for (NodeTable nt : peopleInfoMap.get(pId)) {
//			if (nt.getTableId().equals(tableTitle)) {
//				nt.setData(changeTableData);
//			}
//		}
//		peopleInfoMap.put(pId, peopleInfoMap.get(pId));
//		// 保存到people实体中
//		for (People p : p) {
//			if (p.getPeopleId().equals(pId)) {
//				p.setInfoTableList(peopleInfoMap.get(pId));
//			}
//		}
//	}

	// 加载人员infotable
//	@RequestMapping(value = "loadInfoTable.do", produces = { "application/text;charset=UTF-8" })
//	@ResponseBody
//	public String loadInfoTable(String tabTitle, String pId) {
//		
//		String data = null;
//		for (NodeTable t : peopleInfoMap.get(pId)) {
//			if (t.getTableId().equals(tabTitle)) {
//				data = t.getData();
//			}
//		}
//
//		// System.out.println("load:"+data);
//		return data;
//
//	}

	// 加载人员信息的tab
//	@RequestMapping("/loadInfoTab.do")
//	@ResponseBody
//	public List<String> loadinfotab(String pid) {
//		List<String> peopletab = new ArrayList<>();
//		int len = peopleInfoMap.get(pid).size();
//		for (int i = 0; i < len; i++) {
//			String tabt = peopleInfoMap.get(pid).get(i).getTableId();
//			peopletab.add(tabt);
//		}
//		return peopletab;
//	}
//
//	// 保存人员关系的信息
//	@RequestMapping("/connectPost.do")
//	@ResponseBody
//	public void saveConnection(String data) {
//
//		// System.out.println(data);
//		String nodeStr = data;
//		JSONObject jsonObject = JSONObject.fromObject(nodeStr);
//
//		Connection connection = (Connection) JSONObject.toBean(jsonObject, Connection.class);
//		connect.add(connection);
//		// System.out.println("connection:"+connection);
//
//	}

	@RequestMapping("/pagePost.do")
	@ResponseBody
	public void pagePost(String pageId, String pageTitle) throws IOException {
		// 把tree和page存入map后将map转化为xml
		Page page;
		page = new Page();
		page.setPageId(pageId);
		page.setPageName(pageTitle);
		//page.setPeople(p);
		//page.setConnect(connect);
		// System.out.println(pageId);
		// 将得到的page转为xml

		String s = XmlUtil.getBeanXml(page);

		// System.out.println(XmlUtil.getBeanXml(page));
		XmlUtil.strChangeXML(s, pageTitle);
		// String xmlPath = "E:/tupu/test/nodes1.xml";
		// 保存到本地文件中

	}

	// 将xml字符串转换在前台显示

	@RequestMapping("/xmlPost.do")
	@ResponseBody
	public Map<String, Object> xmlPost(String data) throws Exception {
		// System.out.println(data);
		People p = new People();
		Connection c = new Connection();
		Map<String, Object> map = new HashMap<String, Object>();
		map = XmlUtil.readPeopleXml(data, p, c);

		// System.out.println(map);
		return map;

	}

}
