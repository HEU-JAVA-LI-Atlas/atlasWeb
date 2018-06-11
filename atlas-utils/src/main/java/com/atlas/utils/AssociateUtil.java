package com.atlas.utils;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.apache.commons.collections.Transformer;
import org.apache.commons.lang.StringUtils;

import com.atlas.po.connection;
import com.atlas.po.people;

public class AssociateUtil {
	
	
	//将sourceid targetid都改为身份证号
		public static List<connection> transformIdToIdCardNum(List<connection> connectList,List<people> peopleList){
			for(connection c:connectList){
				for(people p:peopleList){
					if(p.getId().equals(c.getSourceId())){
						c.setSourceId(p.getIdCardNum());
					}else if(p.getId().equals(c.getTargetId())){
						c.setTargetId(p.getIdCardNum());
					}
				}
			}
			return  connectList;
		}

		 //取出只有人员身份证信息的list	
		
		public static List<String> getPeopleIdCardNumCollect(List<people> peopleList){
		    @SuppressWarnings("unchecked")
			List<String> idCardNumList = (List<String>) CollectionUtils.collect(
		            peopleList, new Transformer() {
		                public Object transform(Object arg0) {
		                    people p = (people) arg0;
		                    return p.getIdCardNum();
		                }
		            });
		    //System.out.println(idCardNumList);
		    return idCardNumList;
		}
		 
		//给关系text编号
		public static void rankConnection(List<connection> connectList){
			  List<List<String>> connectFromToList=new ArrayList<List<String>>();
			    
			    for(connection c:connectList){
			    	List<String> sourceTargetIdList=new ArrayList<String>();
			    	sourceTargetIdList.add(c.getSourceId());
			    	sourceTargetIdList.add(c.getTargetId());
			    	connectFromToList.add(sourceTargetIdList);
			    }

			    for(int i = 0;i<connectFromToList.size()-1;i++){
			    	int num=1;
			    	boolean hasSame=false;
			    	for(int j=i+1;j<connectFromToList.size();j++){
			    		if(connectFromToList.get(i).containsAll(connectFromToList.get(j))){
			    			hasSame=true;
			    			num++;
			    			connectList.get(j).setText(num+connectList.get(j).getText());
			    			 
			    			connectFromToList.remove(j);
			    		}
			    	}
			    	if(hasSame){
			    		connectList.get(i).setText("1"+connectList.get(i).getText());
			    	}
			    }

		}
		
	    //用idCardNum来删选人员集合
		public static void useIdCardNumFilterPeopleList(List<people> peopleList,List<people> intersectionPeopleList,Collection<String> list){
			   CollectionUtils.filter(peopleList, new Predicate(){
				   public boolean evaluate(Object arg0) {
		                people p = (people)arg0;
		                for(String idCardNum:list){
		                	if(StringUtils.isNotBlank(p.getIdCardNum()) && p.getIdCardNum().equals(idCardNum)){
		                		intersectionPeopleList.add(p);
		                	}               	
		                }
		                return true;
		            }
			   });
		}

		
	    //用idCardNum来删选连线集合
		public static void useIdCardNumFilterConnectionList(List<connection> connectList,List<connection> intersectionConnectList,Collection<String> list){
			   CollectionUtils.filter(connectList, new Predicate(){
		            public boolean evaluate(Object arg0) {
		            	connection c = (connection)arg0;
		            	//当sourceId和targetId都在交集里时保留连线
		            	if(list.contains(c.getSourceId())&&list.contains(c.getTargetId()))
		            	{
		            		intersectionConnectList.add(c);
		                }
		                return true;
		            }
		        });
		}
		
		
		
		//获取两个图谱的交集

		public static Map<String,Object> getIntersection(List<people> firstPeopleList,List<connection> firstConnectList,
			List<people> secondPeopleList,List<connection> secondConnectList,List<String> pList_1,List<String> pList_2){
			Map<String,Object> interMap=new HashMap<String, Object>();
		    Collection<String> intersectionList = CollectionUtils.intersection(pList_1, pList_2);
			//System.out.println(intersectionList); 

		    //从第一个图谱里通过身份证号得到对应人员的list放入interMap
		    List<people> intersectionPeopleList=new ArrayList<people>();
		    useIdCardNumFilterPeopleList(firstPeopleList,intersectionPeopleList,intersectionList);
		   
		    if(intersectionPeopleList!=null){
		    	interMap.put("people", intersectionPeopleList);
		    }	    
		    
		    List<connection> intersectionConnectList=new ArrayList<connection>();
		    
		    useIdCardNumFilterConnectionList(firstConnectList,intersectionConnectList,intersectionList);
		    useIdCardNumFilterConnectionList(secondConnectList,intersectionConnectList,intersectionList);

		    if(intersectionConnectList!=null){
		    	interMap.put("connection", intersectionConnectList);
		    }
		    //获取连线集合之后查重  只要sourceid和targetid都一样就要修改text
		    rankConnection(intersectionConnectList);
			return interMap;
		}
		
		
		//获取两个图谱的差集

		public static Map<String,Object> getSubtract(List<people> firstPeopleList,List<connection> firstConnectList,
				List<people> secondPeopleList,List<connection> secondConnectList,List<String> pList_1,List<String> pList_2){
			Map<String,Object> subtractMap=new HashMap<String, Object>();
		    Collection<String> subtractList = CollectionUtils.subtract(pList_1, pList_2);
		    //System.out.println(subtractList);
		    //得到人员差集
		    List<people>  subtractPeopleList=new ArrayList<people>();
		    useIdCardNumFilterPeopleList(firstPeopleList,subtractPeopleList,subtractList);

		    if(subtractPeopleList!=null){
		    	subtractMap.put("people", subtractPeopleList);
		    }
		    List<String> subtractPeopleIdList=new ArrayList<String>();
		    for(people p:subtractPeopleList){
		    	subtractPeopleIdList.add(p.getId());
		    }
		    //得到关系差集
		    List<connection> subtractConnectList=new ArrayList<connection>();
		    useIdCardNumFilterConnectionList(firstConnectList,subtractConnectList,subtractPeopleIdList);
		    if(subtractConnectList!=null){
		    	subtractMap.put("connection", subtractConnectList);
		    }
			return subtractMap;
		}
		
	    
		//获取两个图谱的并集

		public static Map<String,Object> getUnion(List<people> firstPeopleList,List<connection> firstConnectList,
				List<people> secondPeopleList,List<connection> secondConnectList,List<String> pList_1,List<String> pList_2){
			Map<String,Object> unionMap=new HashMap<String, Object>();
			List<people> unionPeopleList=new ArrayList<people>();
			unionPeopleList=firstPeopleList;
		    

		    Collection<String> subtractList = CollectionUtils.subtract(pList_2, pList_1);

		    useIdCardNumFilterPeopleList(secondPeopleList,unionPeopleList,subtractList);
		    
		    Collection<connection> unionConnectionList = CollectionUtils.union(firstConnectList, secondConnectList);

		    if(unionPeopleList!=null){
		    	unionMap.put("people", unionPeopleList);
		    }	  
		    List<connection> p=new ArrayList(unionConnectionList);
		    rankConnection(p);
		    if(unionConnectionList!=null){
		    	unionMap.put("connection", p);
		    }	   
		    //System.out.println(unionList);
	        //要把id都重新排一下
		   
			return unionMap;
		}
		
		//获取两个图谱的相对补集 
		public static Map<String,Object> getDisjunction(List<people> firstPeopleList,List<connection> firstConnectList,
				List<people> secondPeopleList,List<connection> secondConnectList,List<String> pList_1,List<String> pList_2){
			Map<String,Object> disjunctionMap=new HashMap<String, Object>();
		    Collection<String> subtractList = CollectionUtils.subtract(pList_2, pList_1);
		    //System.out.println(subtractList);
		    //得到人员差集
		    List<people>  disjunctionPeopleList=new ArrayList<people>();
		    useIdCardNumFilterPeopleList(secondPeopleList,disjunctionPeopleList,subtractList);

		    if(disjunctionPeopleList!=null){
		    	disjunctionMap.put("people", disjunctionPeopleList);
		    }
		    List<String> subtractPeopleIdList=new ArrayList<String>();
		    for(people p:disjunctionPeopleList){
		    	subtractPeopleIdList.add(p.getId());
		    }
		    List<connection> disjunctionConnectList=new ArrayList<connection>();
		    useIdCardNumFilterConnectionList(secondConnectList,disjunctionConnectList,subtractPeopleIdList);

		    if(disjunctionConnectList!=null){
		    	disjunctionMap.put("connection", disjunctionConnectList);
		    }
			return disjunctionMap;
		}
	}
