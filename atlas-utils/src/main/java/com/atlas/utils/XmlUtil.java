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

import com.atlas.po.connection;
import com.atlas.po.people;
import com.atlas.po.connection;
import com.atlas.po.people;

/**
 * 
 * @author 高伟鹏 原作 李文渊学姐
 * @email gaoweipeng3@gmail.com
 * @version 创建时间：2018年5月14日 下午8:15:03
 * @describe 代码阅读与命名修改
 */
public class XmlUtil {
	public static String getBeanXml(Object object){  
	    String xml = null;  
	    try {  
	        JAXBContext context = JAXBContext.newInstance(object.getClass());  
	        Marshaller marshaller = context.createMarshaller();  
	        marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);  
	        marshaller.setProperty(Marshaller.JAXB_ENCODING, "UTF-8");  
	        StringWriter writer = new StringWriter();  
	        marshaller.marshal(object, writer);  
	        xml = writer.toString();  
	    } catch (Exception e) {  
	        e.printStackTrace();  
	    }  
	    //System.out.println(xml);  
	    return xml;               
	} 

	public static void strChangeXML(String str,String pagetitle) throws IOException {
	    SAXReader saxReader = new SAXReader();
	    Document document;
	    
	    try {
	     document = saxReader.read(new ByteArrayInputStream(str.getBytes("UTF-8")));
	     OutputFormat format = OutputFormat.createPrettyPrint();
	     /** 将document中的内容写入文件中 */
	     //自定义导出路径 统一在一个文件夹下 名字是page的title
         JFileChooser jf = new JFileChooser();
         jf.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);  
         jf.showDialog(null,null);  
         File fi = jf.getSelectedFile();  
         String f = fi.getAbsolutePath()+"\\"+ pagetitle +".xml";
         XMLWriter writer = new XMLWriter(new FileWriter(new File(f)), format);
	    // XMLWriter writer = new XMLWriter(new FileWriter(new File("E:/page.xml")),format);
	     
	     writer.write(document);
	     //System.out.println("成功"); 
	     writer.close();
	    } catch (DocumentException e) {
	     e.printStackTrace();
	    }
	}

  
	 
	
    public static  Map<String,Object> readpeopleXml(String xml,people p,connection c){
    	//System.out.println(xml);
	    Map<String,Object> map=new HashMap<String, Object>();
    	List<people> peoplelist = new ArrayList<people>();
    	List<connection>  connectionlist = new ArrayList<connection> ();
    	Document doc = null;
  	 // 下面的是通过解析xml字符串的
     try{
  	   doc = DocumentHelper.parseText(xml); // 将字符串转为XML  
  	 Element rootElt = doc.getRootElement(); // 获取根节点
  	// System.out.println("根节点：" + rootElt.getName()); // 拿到根节点的名称
  	 
     // 获取根节点下的子节点people
  	 Iterator itercon = rootElt.elementIterator("people");  
  	// ArrayList<String>  strArray = new ArrayList<String> ();
    Field[] properties = p.getClass().getDeclaredFields();//获得实例的属性   
    //实例的get方法   
    Method getmeth;   
    //实例的set方法   
    Method setmeth;  
  	 while (itercon.hasNext()) {
  		  Element recordElecon = (Element) itercon.next();
  		 
			p=(people)p.getClass().newInstance();
			for (int j = 0; j < properties.length; j++) {//遍历所有孙子节点   			  
                //实例的set方法   
                  setmeth = p.getClass().getMethod(   
                        "set"  
                                + properties[j].getName().substring(0, 1)   
                                      .toUpperCase()   
                                + properties[j].getName().substring(1),properties[j].getType());   
              //properties[j].getType()为set方法入口参数的参数类型(Class类型)   
                setmeth.invoke(p, recordElecon.elementText(properties[j].getName()));//将对应节点的值存入   
                
       
            }   
			
    	//System.out.println(p);  
         peoplelist.add(p);
         
		}
    // 获取根节点下的子节点connect
  	Iterator iter = rootElt.elementIterator("connect");  
    Field[] propertiesc = c.getClass().getDeclaredFields();//获得实例的属性   
    //实例的get方法   
    Method getmethc;   
    //实例的set方法   
    Method setmethc;  
  	 while (iter.hasNext()) {
  		    Element recordEle = (Element) iter.next();
  		    //System.out.println(recordEle.getName());
			c=(connection)c.getClass().newInstance();
			for (int j = 0; j < propertiesc.length; j++) {//遍历所有孙子节点   			  
                //实例的set方法   
                  setmethc = c.getClass().getMethod(   
                        "set"  
                                + propertiesc[j].getName().substring(0, 1)   
                                      .toUpperCase()   
                                + propertiesc[j].getName().substring(1),propertiesc[j].getType());   
              //properties[j].getType()为set方法入口参数的参数类型(Class类型)   
                setmethc.invoke(c, recordEle.elementText(propertiesc[j].getName()));//将对应节点的值存入   
                
       
            }   
			
    	    //System.out.println(c);  
			connectionlist.add(c);
         
		}
  	map.put("people",peoplelist);
  	map.put("connection",connectionlist);
	   } catch (Exception e) {   
           e.printStackTrace();   
       }   
	return map;
    }
	
	
}  