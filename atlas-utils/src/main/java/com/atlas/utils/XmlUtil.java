package com.atlas.utils;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringWriter;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.swing.JFileChooser;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

import com.atlas.po.Connection;
import com.atlas.po.People;

/**
 * 
 * @author 高伟鹏 原作 李文渊学姐
 * @email gaoweipeng3@gmail.com
 * @version 创建时间：2018年5月14日 下午8:15:03
 * @describe 代码阅读与命名修改
 */
public class XmlUtil {
    /**
     * @describe 采用jaxb将实体bean转化为xml类型数据
     * @param object
     * @return
     */
	public static String getBeanXml(Object object) {
		String xml = null;
		try {
			JAXBContext context = JAXBContext.newInstance(object.getClass());//获取jaxb入口，获得一个新的 JAXBContext类的实例。
			Marshaller marshaller = context.createMarshaller();//创建一个可用于将java内容树转换为XML数据的 Marshaller对象。
			marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);//指定编组的XML数据使用换行符和缩进格式化的属性的名称。
			marshaller.setProperty(Marshaller.JAXB_ENCODING, "UTF-8");//在底层实现中设置编码格式属性 Marshaller 。
			StringWriter writer = new StringWriter();
			marshaller.marshal(object, writer);
			xml = writer.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		// System.out.println(xml);
		return xml;
	}
    /**
     * @describe 创建XML文件
     * @param 文件内容str
     * @param pageTitle 文件名
     */
	public static void strChangeXML(String str, String pageTitle){
		SAXReader saxReader = new SAXReader();
		Document document = null;

		try {
			document = saxReader.read(new ByteArrayInputStream(str.getBytes("UTF-8")));//读取XML文件,获得document对象
			OutputFormat format = OutputFormat.createPrettyPrint();//获取默认的打印格式
			/** 将document中的内容写入文件中 */
			// 自定义导出路径 统一在一个文件夹下 名字是page的title
			JFileChooser jf = new JFileChooser();
			jf.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);//设置 JFileChooser以允许用户只需选择目录
			jf.showDialog(null, null);//使用自定义批准按钮弹出自定义文件选择器对话框。
			File fi = jf.getSelectedFile();//返回所选文件
			String f = fi.getAbsolutePath() + "\\" + pageTitle + ".xml";
			XMLWriter writer = new XMLWriter(new FileWriter(new File(f)), format);//写入xml文件
			// XMLWriter writer = new XMLWriter(new FileWriter(new
			// File("E:/page.xml")),format);

			writer.write(document);
			// System.out.println("成功");
			writer.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@SuppressWarnings("unchecked")//这个注解就很迷
	/**
	 * @describe 获取people与connection集
	 * @param xml格式的数据串
	 * @param p  people实例的引用
	 * @param c  connection实例的引用
	 * @return
	 */
	public static Map<String, Object> readPeopleXml(String xml, People p, Connection c){
		// System.out.println(xml);
		Map<String, Object> map = new HashMap<String, Object>();
		List<People> peoplelist = new ArrayList<People>();
		List<Connection> connectionlist = new ArrayList<Connection>();
		Document doc = null;
		// 下面的是通过解析xml字符串的
		try {
			doc = DocumentHelper.parseText(xml); // 将字符串转为XML
			Element rootElt = doc.getRootElement(); // 获取根节点
			// System.out.println("根节点：" + rootElt.getName()); // 拿到根节点的名称

			// 获取根节点下的子节点people
			Iterator itercon = rootElt.elementIterator("people");
			// ArrayList<String> strArray = new ArrayList<String> ();
			Field[] properties = p.getClass().getDeclaredFields();// 运用反射获得实例的属性
			// 实例的get方法
			Method getMethodPeople;
			// 实例的set方法
			Method setMethodPeople = null;
			while (itercon.hasNext()) {//遍历所有的people结点
				Element recordElecon = (Element) itercon.next();
				
				People pp = new People();
				People ss = pp.getClass().newInstance();
				pp = ss;

				p = (People) p.getClass().newInstance();//实例化？本身就是一个实例的引用，再实例化获取引用？
				for (int j = 0; j < properties.length; j++) {// 遍历所有孙子节点
					// 实例的set方法
					setMethodPeople = p.getClass().getMethod("set" + properties[j].getName().substring(0, 1).toUpperCase()
							+ properties[j].getName().substring(1), properties[j].getType());
					// properties[j].getType()为set方法入口参数的参数类型(Class类型)
					setMethodPeople.invoke(p, recordElecon.elementText(properties[j].getName()));// 将对应节点的值存入

				}

				// System.out.println(p);
				peoplelist.add(p);
			}
			// 获取根节点下的子节点connect
			Iterator iter = rootElt.elementIterator("connect");
			Field[] propertiesc = c.getClass().getDeclaredFields();// 获得实例的属性
			// 实例的get方法
			Method getMethodConnection = null;//没有用到
			// 实例的set方法
			Method setMethodConnection = null;
			while (iter.hasNext()) {
				Element recordEle = (Element) iter.next();
				// System.out.println(recordEle.getName());
				c = (Connection) c.getClass().newInstance();
				for (int j = 0; j < propertiesc.length; j++) {// 遍历所有孙子节点
					// 实例的set方法
					setMethodConnection = c.getClass().getMethod("set" + propertiesc[j].getName().substring(0, 1).toUpperCase()
							+ propertiesc[j].getName().substring(1), propertiesc[j].getType());
					// properties[j].getType()为set方法入口参数的参数类型(Class类型)
					setMethodConnection.invoke(c, recordEle.elementText(propertiesc[j].getName()));// 将对应节点的值存入

				}

				// System.out.println(c);
				connectionlist.add(c);

			}
			map.put("people", peoplelist);
			map.put("connection", connectionlist);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

}