<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>

	<head>
		
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
		<title>人员关系图谱建模</title>
		<link rel="stylesheet" href="css/style.min.css"></link>
		<link href="css/easyui.css" rel="stylesheet" type="text/css" />
		<link href="css/icon.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery.contextMenu.css" rel="stylesheet" type="text/css" />
		<link href="css/handsontable.full.css" rel="stylesheet" type="text/css" />

		 <style type="text/css">
        .container {
				border: 1px solid #E0E0E0;
				position: absolute;
				left: 250px;
				top: 58px;
				width:1260px
			}
        .btn{
            background:#E0E0E0;
        }
        .fileinput-button {
            position: relative;
            display: inline-block;
            overflow: hidden;
        }

        .fileinput-button input{
            position: absolute;
            left: 0px;
            top: 0px;
            opacity: 0;
            -ms-filter: 'alpha(opacity=0)';
        }
    </style>
	</head>

	<body>    
	    <!-- 工具栏 -->
	    <div id="toolBar" style="background:#E0E0E0;border:1px solid #E0E0E0;width:100%; height:50px">
	       <span class="fileinput-button">
            <span style="color:#005CBF">打开</span>
            <input id="openFile"  runat="server"  onchange="javascript:openPageAsXml(this);" type="file">
           </span>
           <span class="create fileinput-button">
               <span style="color:#005CBF">新建</span>           
           </span>
           <span  class="save fileinput-button">
                  <span style="color:#005CBF">保存</span>
           </span>
           <span class="fileinput-button">
            <span style="color:#005CBF">编辑</span>
           </span>
            <span class="fileinput-button">
            <span style="color:#005CBF">删除</span>
           </span >
            <span class="fileinput-button">
            <span style="color:#005CBF">更新</span>
           </span >
           <span class="fileinput-button">
            <span style="color:#005CBF">自定义模式</span>
           </span >
           <input id="customMode" class="easyui-combobox" 
                     data-options="
                     valueField:'label',
                     textField:'value'"
                     />
           <span class="line fileinput-button">
            <span style="color:#005CBF">线条样式</span>
           </span >
            <input id="lineStyle" class="easyui-combobox" 
                     data-options="
                     valueField:'label',
                     textField:'value',
                     data:[
                     {label:'line',value:'line'},
                     {label:'polyline',value:'polyline'}
                     ]"/>
            <span class="line fileinput-button">
            <span style="color:#005CBF">线条粗细</span>
           </span >
            <input id="lineWidth" class="easyui-combobox" 
                     data-options="
                     valueField:'label',
                     textField:'value',
                     data:[
                     {label:'1',value:'5px'},
                     {label:'2',value:'10px'}
                     ]"/>
             <span class="line fileinput-button">
            <span style="color:#005CBF">线条颜色</span>
           </span >
           <input id="lineColor" type="color" />
		</div>
		 <!-- 图谱以及信息表  -->
		<div class="container">
		    <div id="mapTab" class="easyui-tabs" ></div>
			<canvas id="canvas"  width="1300px" height="500px"></canvas> 
			<div id="contextMenuOutPut"></div>
			<div>
			  
			  <div id="peopleTab"  class="easyui-tabs" style="height:30px"></div>
				<div id="peopleHot"></div>
				<button onclick="javascript:savePeopleInfo()">保存修改</button>
			</div>
			

		</div>
           <!-- 图元和图谱目录 -->
	    <div id="treeTab" class="easyui-tabs" style="width:240px">
	         <div title="图元" data-options="selected:true" >
	          <div id="jst" style="background:#E0E0E0;border:1px solid #E0E0E0;width:240px; height:800px;"></div>
            </div>
            <div title="图谱"  style="display:none;">        
	          <div id="jstMap" style="background:#E0E0E0;border:1px solid #E0E0E0;width:240px; height:800px"></div>
           </div>
   
	    </div>
		<div id="newPage" class="easyui-dialog" title="新增图谱" style="width: 300px;height: 200px;padding: 10px 20px" closed="true" buttons="#createPageButton">
			<table cellspacing="8px">
				<tr>
					<td>图谱名称：</td>
					<td>
						<input type="text" id="pageTitle" class="easyui-validatebox" required="true" />
					</td>
				</tr>

			</table>
		</div>
		<div id="createPageButton">
			<a href="javascript:createBlankPage()" class="easyui-linkbutton">创建</a>
		</div>	
		
		<div id="editTable" class="easyui-dialog" title="编辑表格" style="width:500px; height:400px;" closed="true" toolbar="#nodeTabToolBar">
			<div id="nodeTab" class="easyui-tabs"></div>
			 <div id="nodeHot"></div>
		</div>
		<!--创建Toolbar-->
		<div id="nodeTabToolBar">
			<table cellpadding="0" cellspacing="0" style="width: 100%">
				<tr>
					<td>
						<a href="javascript:openCreateTable()" class="easyui-linkbutton">新建表格</a>
						<a id="saveTableAttr" href="javascript:saveTableAttr()" class="easyui-linkbutton">保存</a>
					</td>
				</tr>
			</table>
		</div>

		<div id="createTable" class="easyui-dialog" title="新增表格" style="width: 300px;height: 200px;padding: 10px 20px" closed="true" buttons="#createTableButton">
			<table cellspacing="8px">
				<tr>
					<td>表名：</td>
					<td>
						<input type="text" id="tableTitle"  class="easyui-validatebox" required="true" />
					</td>
				</tr>

			</table>
		</div>
		<div id="createTableButton">
			<a href="javascript:createBlankTable()" class="easyui-linkbutton">创建</a>
		</div>	
		<!--要修改编辑姓名和上传照片的表格-->
		<div id="peopleDialog" closed="true" class="easyui-dialog" style="width:500px; height:300px;;padding: 10px 20px" title="人员照片" buttons="#peopleDialogButton">

			<table cellspacing="8px" align="center">
				<tr>
					<td>人员姓名:</td>
					<td>
						<input type="text" id="name" name="pname" class="easyui-validatebox" required="true" />
					</td>
				</tr>
				<tr>
					<td>人员照片:</td>
					<td>
						<input id="idFile" style="width:224px" runat="server" name="pic" onchange="javascript:setImagePreview(this,localImag,preview);" type="file" />
					</td>
				</tr>
				<tr>
					<td>预　　览:</td>
					<td>
						<div id="localImag">
							<img id="preview" alt="预览图片" onclick="over(preview,divImage,imgbig);" src="img/people.png" style="width: 100px; height: 100px;" />
						</div>
					</td>
				</tr>
			</table>

			<div id="peopleDialogButton">
				<a href="javascript:saveUser()" class="easyui-linkbutton">确定</a>
			</div>
		</div>
		
		  
		        
		<script src="js/jquery-1.11.3.min.js"></script>
		<script src="js/jstree.min.js"></script>
		<script src="js/jquery.easyui.min.js"></script>
		<script src="js/fabric.js"></script>
		<script src="js/jquery.contextMenu.js"></script>
		<script src="js/jquery.ui.position.js"></script>
		<script src="js/handsontable.full.js"></script>
		<script type="text/javascript">
			var canvas = new fabric.Canvas('canvas');
			var nodeHot;
			var nodeNum =-1;
			var nodeTitle;
			var contextMenuItems;
			var currentNodeId;
			 
			//自定义模式的下拉框
		    /* $('#linestyle').combox({
		    	 
		     });*/
		     //node handsontable setting
			var nodeHot = Handsontable(document.getElementById("nodeHot"), {
				colHeaders: [
								'Attr',
								'value',
								'Remarks'
							],
				height: 300,
				colWidths: 150,
				maxCols:3,
				minRows: 10,
				contextMenu: false,
				rowHeaders: true,
				
				manualColumnResize: true,
			});
		     //people handsontable setting
			var peopleHot = Handsontable(document.getElementById("peopleHot"), {
				colHeaders: [
								'Attr',
								'value',
								'Remarks'
							],
				colWidths: 220,
				maxCols:6,
				minRows:10,
				contextMenu: false,
				rowHeaders: true,				
				manualColumnResize: true,
			});
			window.onload = function() {
				//在canvas上层对象上添加右键事件监听
				$(".upper-canvas").contextmenu(onContextmenu);

				//初始化右键菜单
				$.contextMenu({
					selector: '#contextMenuOutPut',
					trigger: 'none',
					build: function($trigger, e) {
						//构建菜单项build方法在每次右键点击会执行
						return {
							callback: contextMenuClick,
							items: contextMenuItems
						};
					},
				});
			}
             
			//右键点击事件响应
			function onContextmenu(event) {
				var pointer = canvas.getPointer(event.originalEvent);
				var objects = canvas.getObjects();
				for(var i = objects.length - 1; i >= 0; i--) {
					var object = objects[i];
					//判断该对象是否在鼠标点击处
					if(canvas.containsPoint(event, object)) {
						//选中该对象
						canvas.setActiveObject(object);
						//显示菜单
						showContextMenu(event, object);
						continue;
					}
				}

				//阻止系统右键菜单
				event.preventDefault();
				return false;
			}
             
			//右键菜单项点击
			function showContextMenu(event, object) {
				//定义右键菜单项
				contextMenuItems = {
					"delete": {
						name: "删除",
						//icon: "delete",
						data: object
					},
					"info": {
						name: "编辑信息",
						data: object
					},

				};
				//右键菜单显示位置
				var position = {
					x: event.clientX,
					y: event.clientY
				}
				$('#contextMenuOutPut').contextMenu(position);
			}

			//右键菜单项点击
			function contextMenuClick(key, options) {
				if(key == "delete") {
					//得到对应的object并删除
					var object = contextMenuItems[key].data;
					canvas.remove(object);
				} else if(key == "info") {
					//关闭上一个节点的tabs
					
					var tabs = $("#peopleTab").tabs("tabs");
                    var length = tabs.length;
                     for(var i = 0; i < length; i++) {
                              var onetab = tabs[0];
                              var title = onetab.panel('options').tab.text();
                              $("#peopleTab").tabs("close", title);
                      }
                     //清空表格
                     peopleHot.loadData(null);
					var obj = canvas.getActiveObject();
					var pid=obj.id+1;
					console.log(pid)
					//alert(obj.id);
					//查看人员信息
					//加载人员信息表通过people的id加载tab   
	                 $.post("lwy/loadInfoTab.do", {pid:pid} , function(data) {
	                	 
						  //循环增加tab
						  //console.log(data)
						  for(var i=0;i<data.length;i++){
							  $('#peopleTab').tabs('add', {
									title: data[i],
									closable:true
								});
							  
						  }
		              });
				}

			}
            //随机生成位置
			function randomFromTo(from, to) {
				return Math.floor(Math.random() * (to - from + 1) + from);
			}
			var w = 100;
			var h = 70;
            //生成节点
			function createGroup(posX, posY, width,height,newTitle, newName, pimg) {
				
				var rect = new fabric.Rect({
					left: posX,
					top: posY,
					stroke: 'black',
					strokeWidth: 3,
					fill: 'white',
					width: width,
					height: height
				});
				var pName = new fabric.Text(newName, {
					left: posX + 60,
					top: posY + 40,
					fontSize: 10,
				});
				var title = new fabric.Text(newTitle, {
					left: posX + 50,
					top: posY + 20,
					fontSize: 10
				});
				var img = new fabric.Image(pimg, {
					left: posX + 10,
					top: posY + 10,
				});
				var group = new fabric.Group([rect, pName, title, img], {
					left: posX,
					top: posY,
					id: nodeNum
				});
				canvas.add(group);
			
			}
            //连线算法 主要有带箭头的线直线虚线折线和有text的线
             function drawLine(lineStyle, lineWidth, lineColor,x1,y1,x2,y2){	
				switch (lineStyle)
            	{
				//直线
            	case 0:
            		
            		drawStraightLine(x1, y1, x2, y2, lineWidth, lineColor) ;
            		
            	  break;
            	//折线
            	case 1:
            		drawPolyLine(x1, y1, x2, y2, lineWidth, lineColor);
            	  break;           
            	//虚线
            	case 2:
            		drawDashedLine(x1, y1, x2, y2, lineWidth, lineColor);
            	  break;
                //带箭头的线
            	case 3:
            		drawArrowLine();
            	  break;
            	//带文字的线
            	case 4:
            		drawTextLine();
            	  break;
            	}
				
			}
           //画直线
 			function drawStraightLine(x1, y1, x2, y2, lineWidth, lineColor) {
        	    console.log("drawStraight")
 				var line = new fabric.Line([x1, y1, x2, y2], {
 					stroke:lineColor,
					strokeWidth: lineWidth,
 				});
 				canvas.add(line);
 			}
            //画虚线算法
            function drawDashedLine(x1, y1, x2, y2, lineWidth, lineColor){
            	var dashedline=new fabric.Line([x1, y1, x2, y2], {
            		stroke: lineColor,
					strokeWidth: lineWidth,
					strokeDashArray: [10, 5] 	
				});
				canvas.add(dashedline);
            }
			//画折线算法		
			function drawPolyLine(x1, y1, x2, y2, lineWidth, lineColor) {

				var poly = new fabric.Polyline([{
						x: x1,
						y: y1
					},
					{
						x: x1,
						y: y2
					},
					/*{
						x: 60,
						y: 50
					},*/
					{
						x: x2,
						y: y2
					}
				], {
					stroke: lineColor,
					strokeWidth: lineWidth,
					fill: 'white',
				});
				canvas.add(poly);
			}
			
			//画带箭头的连线算法
			function drawArrowLine() {
				
			}
			
			//画带text的连线算法
			function drawTextLine(){
				
			}
			
			//直线最短路径算法
			function drawShortestLine(lineStyle, lineWidth, lineColor,x1, y1, x2, y2, w, h) {
				
				if(y2 < y1 - 3 * h / 4) {
					if(x2 > x1 + 3 * w / 4) drawLine(lineStyle, lineWidth, lineColor,x1 + w, y1, x2, y2 + h);
					else if(x2 < x1 - 3 * w/ 4) drawLine(lineStyle, lineWidth, lineColor,x1, y1, x2 + w, y2 + h);
					else drawLine(lineStyle, lineWidth, lineColor,x1 + w / 2, y1, x2 + w / 2, y2 + h);
				} else if(y2 > y1 + 3 * h / 4) {
					if(x2 > x1 + 3 * w/ 4) drawLine(lineStyle, lineWidth, lineColor,x1 + w, y1 + h, x2, y2);
					else if(x2 < x1 - 3 * w / 4) drawLine(lineStyle, lineWidth, lineColor,x1, y1 + h, x2 + w, y2);
					else drawLine(lineStyle, lineWidth, lineColor,x1 + w / 2, y1 + h, x2 + w / 2, y2);
				} else {
					if(x2 < x1 - w) drawLine(lineStyle, lineWidth, lineColor,x1, y1 + h / 2, x2 + w, y2 + h / 2);
					else if(x2 > x1 + w) drawLine(lineStyle, lineWidth, lineColor,x1 + w, y1 + h / 2, x2, y2 + h / 2);
				}
			}
			
			//生成人员节点
			function saveUser() {
				
				var pName = $('#name').val();
				if(!pName) {
					alert("姓名不能为空！");
					return;
				}
				var randomX = randomFromTo(0, 1300);
				var randomY = randomFromTo(0, 450);
				//显示人员照片
				var pImg = document.getElementById("preview");
			
				//console.log(pImg)
				//var url = $('#preview').attr("src");
				
				var selectedFile = document.getElementById('idFile').files[0];
	            var name = selectedFile.name;
	
	            var src="photo/"+name;
	            //pImg.src=src;
	            //console.log(pImg)
				//生成人员节点
				createGroup(randomX, randomY,w,h, nodeTitle, pName, pImg);
				nodeNum = nodeNum + 1;
				//传人员节点的数据
				var data={
						"id":nodeNum,
				        "title":nodeTitle,
				        "name":pName,
				        "photo":src,
				        //"photo":url,
				        "x":randomX,
				        "y":randomY,
				        "width":w,
				        "height":h,
				        "infoTableList":null
				};
				$.post("lwy/peoplePost.do", {data:JSON.stringify(data),nodeId:currentNodeId} , function(data) {
					  //alert(data);
					 
	              });           
                
				$('#peopleDialog').dialog("close");
				$('#peopleDialog').form("clear");
				
				
			}
			
			//添加标签页以及空表
			//在后台增加一个空表
			function createBlankTable() {
				$('#createTable').dialog("close");
				var t = $('#tableTitle').val();
				
                var data=null;
				//var content = '<div id="nodeHot"></div>';
				$('#nodeTab').tabs('add', {
					title: t,
					//content: content,
					closable:true
				});
				//创建一张空表
				/*$.post("lwy/tablePost.do", {nodeid:currentNodeId,tableid:t,tabletitle:t,changetabledata:data} , function(data) {
				  //alert(data);
                });
			    //nodeHot.clear();*/
				$('#createTable').form("clear");
			}


			//保存选中的未填写属性值的属性表格
			function saveTableAttr() {				
				//获取handsontable的数据
				var data = nodeHot.getData();
				//console.log(data);
				
				var selectedTab = $('#nodeTab').tabs('getSelected');
				var selectedTabTitle = selectedTab.panel('options').title;
				
				//数据传到后台
				/*$.post("lwy/tablePost.do", {nodeid:currentNodeId,tableid:selectedTabTitle,tabletitle:selectedTabTitle,changetabledata:data} , function(data) {
							  //alert(data);
			});*/
				 $.ajax({
				        url:"lwy/tablePost.do",
				        type:"post",
				        dataType:"text",
				        
				        data:{nodeId:currentNodeId,tableId:selectedTabTitle,tableTitle:selectedTabTitle,changeTableData:JSON.stringify(data)} ,
				        success:function(data){
				           // alert("测试进入success方法");
				        }
				    });
			}
             //打开新增表格的命名对话框
			function openCreateTable() {

				$('#createTable').dialog("open");

			}
             
             //新增
			$('.create').click(function() {
					$('#newPage').dialog("open");

		    });
             //保存
		    $('.save').click(function() {
			  savePageAsXml();
	        });
             
             
             
            //新建图谱    
           function createBlankPage(){
        	   var title=$('#pageTitle').val();
        	   //添加图谱tab
        	   
        	   $('#mapTab').tabs('add', {
					title: title,
					closable:true
				});
        	    //保存当前tab的画布
        	    
        	    //清空画布canvas
        	    canvas.clear();
        	    //清空dialog
        	    $('#newPage').dialog("close");
        	    $('#newPage').form("clear");
        	 }
            
            
            
            //保存填写完的人员信息表
            function savePeopleInfo(){
            	var obj = canvas.getActiveObject();
				var pId=obj.id+1;
				var data = peopleHot.getData();
				console.log(data);
            	var selectedTab = $('#peopleTab').tabs('getSelected');
				var selectedTabTitle = selectedTab.panel('options').title;
            	//传递人员的id
            	//把tablelist保存到人员信息中
            	$.post("lwy/infoTablePost.do", {pId:pId,tableTitle:selectedTabTitle,changeTableData:JSON.stringify(data)} , function(data) {
					  //alert(data);
	           });
            }
            	
            
			//保存图谱
			function savePageAsXml(){
				var selectedTab = $('#mapTab').tabs('getSelected');
				var selectedTabTitle = selectedTab.panel('options').title;
				//alert(currentNodeId);
				//数据传到后台				
				$.post("lwy/pagePost.do", {pageId:selectedTabTitle,pageTitle:selectedTabTitle} , function(data) {
							  //alert(data);
			});
			}
			
			//加载本地xml文件得到路径
			function openPageAsXml(obj){
				
				    
					var selectedFile = document.getElementById('openFile').files[0];
		            var name = selectedFile.name;//读取选中文件的文件名
		            //console.log("文件名:"+name);
		            var index=name.lastIndexOf(".");		           
		            var fileName=name.substring(0,index);//后缀名
		           // console.log("文件名:"+suffix)
		           //增加tab
		            $('#mapTab').tabs('add', {
					title:fileName,
					closable:true
				   });
		            var reader = new FileReader();//这是核心,读取操作就是由它完成.
		            reader.readAsText(selectedFile);//读取文件的内容,也可以读取文件的URL
		            reader.onload = function () {
		                //当读取完成后回调这个函数,然后此时文件的内容存储到了result中,直接操作即可
		   
		                //文件内容为this.result
		                 $.post("lwy/xmlPost.do", {data:this.result} , function(data) {
		                	 console.log(data)
                            
		                	 //先画节点
		                	 for(var i = 0;i<data.people.length;i++){
		                		 (function(i){
		                	
		                		  var x=data.people[i].x;
		                		  var y=data.people[i].y;
		                		  var w=data.people[i].width;
		                		  var h=data.people[i].height;
		                		  var t=data.people[i].title;
		                		  var n=data.people[i].name;
		                		  var s=data.people[i].photo;
		                		  //加载照片用相对路径		                				                		  
		                		  var img=new Image();
		                		  img.src=s;
		                		  //console.log(img)
		                		  img.onload=function(){
		                			  createGroup(parseInt(x), parseInt(y), parseInt(w), parseInt(h), t, n , img);
		                		  }})(i);
		                	 }
		                	 for(var i=0;i<data.connection.length;i++){
		                		 
		                		  var sId=data.connection[i].sourceId;
		                		  var tId=data.connection[i].targetId;
		                		  var sX=data.people[sId].x;
		                		  var sY=data.people[sId].y;
		                		  var tX=data.people[tId].x;
		                		  var tY=data.people[tId].y;
		                		  var w=data.people[sId].width;
		                		  var h=data.people[sId].height;
		                		  var lineStyle=data.connection[i].lineStyle;
		                		  var lineWidth=data.connection[i].lineWidth;
		                		  var lineColor=data.connection[i].lineColor;
		                		  drawShortestLine(parseInt(lineStyle),parseInt(lineWidth),lineColor,parseInt(sX),parseInt(sY),parseInt(tX),parseInt(tY),parseInt(w),parseInt(h));
		                		

		                	 }
		                	 
						});	
		            
		                
		            }	
			}
			
          
			function setImagePreview(obj, localImagId, imgObjPreview) {
				var array = new Array('gif', 'jpeg', 'png', 'jpg', 'bmp'); //可以上传的文件类型
				if(obj.value == '') {
					$.messager.alert("让选择要上传的图片!");
					return false;
				} else {
					var fileContentType = obj.value.match(/^(.*)(\.)(.{1,8})$/)[3]; //这个文件类型正则很有用 
					////布尔型变量
					var isExists = false;
					//循环判断图片的格式是否正确
					for(var i in array) {
						if(fileContentType.toLowerCase() == array[i].toLowerCase()) {
							//图片格式正确之后，根据浏览器的不同设置图片的大小
							if(obj.files && obj.files[0]) {
								//火狐下，直接设img属性 
								imgObjPreview.style.display = 'block';
								imgObjPreview.style.width = '30px';
								imgObjPreview.style.height = '45px';
								//火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式 
								imgObjPreview.src = window.URL.createObjectURL(obj.files[0]);
							} else {
								//IE下，使用滤镜 
								obj.select();
								var imgSrc = document.selection.createRange().text;
								//必须设置初始大小 
								localImagId.style.width = "30px";
								localImagId.style.height = "45px";
								//图片异常的捕捉，防止用户修改后缀来伪造图片 
								try {
									localImagId.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
									localImagId.filters.item("DXImageTransform.Microsoft.AlphaImageLoader=").src = imgSrc;
								} catch(e) {
									$.messager.alert("您上传的图片格式不正确，请重新选择!");
									return false;
								}
								imgObjPreview.style.display = 'none';
								document.selection.empty();
							}
							isExists = true;
							return true;
						}
					}
					if(isExists == false) {
						$.messager.alert("上传图片类型不正确!");
						return false;
					}
					return false;
				}
			}
			$('#jst').jstree({
				"core": {
					"themes": {
						"stripes": true
					},
					"check_callback": true, // enable all modifications
					"data": [

						{
							"id": "people",
							"text": "人员",
							"state": { //默认状态展开  
								"opened": true
							},
							"type": "people",

							"children": [{
									"text": "学生",
									"type": "people",
								},
								{
									"text": "教师",
									"type": "people",
								}
							]
						},
						{
							"id": "relate",
							"text": "关系",
							"state": { //默认状态展开  
								"opened": true
							},
							"type": "relate",
							"children": [{
								"text": "师生",
								"type": "relate",
							}]
						}
					],

				},
				"types": {
					"default": {

					},
					"people": {
						"icon": "img/people.png",
					},
					"relate": {
						"icon": "img/draw_line.png",
					},
				},
				"plugins": ["dnd", "contextmenu", "types"],
				"contextmenu": {

					"items": {
						"create": {
							"label": "新增",
							"action": function(obj) {

								var inst = jQuery.jstree.reference(obj.reference);
								var clickedNode = inst.get_node(obj.reference);
								
							   
								var newNode = inst.create_node(obj.reference, clickedNode.val);
								var parentType = inst.get_type(obj.reference);
								inst.set_type(newNode, parentType);
								inst.edit(newNode);
					         	var nodeObj=inst.get_json(newNode);
					         	var str={"id":nodeObj.id,"text":nodeObj.text,"icon":nodeObj.icon,"parentId":clickedNode.id,"tableList":null};
					             //得到新增节点的id
								$.post("lwy/nodePost.do", {changeData:JSON.stringify(str)} , function(data) {
										 //alert(data);
									});
									
								inst.open_node(obj.reference);
								
							},
						},
						"rename": {
							"label": "重命名",
							"action": function(obj) {
								var inst = jQuery.jstree.reference(obj.reference);
								var clickedNode = inst.get_node(obj.reference);
								inst.edit(obj.reference, clickedNode.val);
								
							}
						},
						"delete": {
							"label": "删除",
							"action": function(obj) {
								var inst = jQuery.jstree.reference(obj.reference);
								var clickedNode = inst.get_node(obj.reference);
								inst.delete_node(obj.reference);
								
							}

						},
						"editTable": {
							"label": "管理信息表",
							"action": function(obj) {
								$('#editTable').dialog("open");
								//关闭上一个节点的tabs
								var tabs = $("#nodeTab").tabs("tabs");
                                var length = tabs.length;
                                 for(var i = 0; i < length; i++) {
                                          var oneTab = tabs[0];
                                          var title = oneTab.panel('options').tab.text();
                                          $("#nodeTab").tabs("close", title);
                                  }
                                 //清空表格
                                 nodeHot.loadData(null);
								 //加载节点的信息表
								 //用currentnodeid加载人员信息表格
								 $.post("lwy/loadPeopleTab.do", {nodeId:currentNodeId} , function(data) {
										   
									 for(var i=0;i<data.length;i++){
										  $('#nodeTab').tabs('add', {
												title: data[i],
												closable:true
											});
										  
									  }
							     });	
								 
								 
								 
								// var inst = jQuery.jstree.reference(obj.reference);
								// var clickedNode = inst.get_node(obj.reference);
								
							}

						}

					}
				}
			});
			
			//增加标签（包括目录和人员节点的信息标签）选中事件
			$('#nodeTab').tabs({
                onSelect: function(title,index){           
                 
	              //加载表格数据
	              $.post("lwy/loadTableData.do", {tabTitle:title,nodeId:currentNodeId} , function(data) {
	            	       
	            	          // console.log(data);
	            	           if(data){
	            	        	//将string数据转化为数组 				            	
				            	var arr=new Array();
				            	arr=eval(data);	            	      
	            	        	//console.log(arr);			            					            		
								    nodeHot.loadData(arr);								 	            	
					           }	
	            	           else{
	            	        	   //加载空表表格
	            	        	   nodeHot.loadData(null);
	            	           }
				   });
                },
                //标签没被选中时自动保存
			onUnselect: function(title,index){
	                              
              }
	           
            });
			
			$('#peopleTab').tabs({
                onSelect: function(title,index){           
                	var obj = canvas.getActiveObject();
					var pId=obj.id+1;
	              //加载表格数据
	              $.post("lwy/loadInfoTable.do", {tabTitle:title,pId:pId} , function(data) {
	            	           
	            	            //console.log(data);
	            	        	//将string数据转化为数组 				            	
				            	var arr=new Array();
				            	arr=eval(data);	            	      
	            	        	//console.log(arr);			            					            		
								 peopleHot.loadData(arr);								 	            	
					           	            	          
	            	         //在photo中插入一列
	 						  //phot.alter('insert_col',1);
				   });
                },
                //标签没被选中时自动保存
			onUnselect: function(title,index){
	                              
              }
	           
            });
		
			$('#jst').on('activate_node.jstree', function(e, data) {
				//判断是否为叶子节点
                 currentNodeId=data.node.id;
				var isLeaf = data.instance.is_leaf(data.node);
				if(isLeaf) 
				{
					if(data.node.type== "people") {
						var nTitle = data.node.text;
						nodeTitle = nTitle;

						//弹出人员信息对话框
						//$('#createTable').dialog("open");
						$('#peopleDialog').dialog("open");
					}
					else if(data.node.type=="relate"){
							var i = 0;
							var sourceId,sourceX,sourceY;
							var targetId,targetX,targetY;
							canvas.on('object:selected', function() {

								var obj = canvas.getActiveObject();
								var x = obj.getLeft();
								var y = obj.getTop();
								//获取id
								//alert(obj.id);
								if(i==0){
									sourceId=obj.id+1;
									sourceX = x;
									sourceY = y;
									i=1;
									//console.log("source:"+sourceId)
									
								}
								else if(i==1){
									targetId=obj.id+1;
									//console.log("source:"+targetId)
									
									targetX = x;
									targetY = y;								 
									i=2;
									//从工具栏中的线条样式中获得下面的参数
									var lineStyle=0;
									var lineColor='black';
									var lineWidth=2;
									
									drawShortestLine(lineStyle,lineWidth,lineColor,sourceX,sourceY,targetX,targetY,w,h);
									//传递数据到后台
										var connectdata={
											"sourceId":sourceId,
											"targetId":targetId,
											"text":data.node.text,
											"lineStyle":0,
											"lineColor":'black',
											"lineWidth":2
									};
									$.post("lwy/connectPost.do", {data:JSON.stringify(connectdata)} , function(data) {
										  //alert(data);
									});																			
								}
								
							});
						
						
						
					}

				}

			});
			
			
			$('#jstMap').jstree({
				"core": {
					"themes": {
						"stripes": true
					},
					"check_callback": true, // enable all modifications
					"data": [

						{

							"id": "map",
							"text": "图谱",
							"state": { //默认状态展开  
								"opened": true
							},
							"type":"mapclass",
							

						},
						
					],

				},
				"types": {
					"default": {

					},
					"mapclass": {
						"icon": "img/people.png",
					},
					"mapfile": {
						"icon": "img/draw_line.png",
					},
				},
				"plugins": ["dnd", "contextmenu", "types"],
				"contextmenu": {
					"items": {
						"createclass": {
							"label": "新增分类",
							"action": function(obj) {

								var inst = jQuery.jstree.reference(obj.reference);
								var clickedNode = inst.get_node(obj.reference);
								var newNode = inst.create_node(obj.reference, clickedNode.val);
								inst.set_type(newNode, "mapclass");
								inst.edit(newNode);
								inst.open_node(obj.reference);

							},

						},
						"rename": {
							"label": "重命名",
							"action": function(obj) {
								var inst = jQuery.jstree.reference(obj.reference);
								var clickedNode = inst.get_node(obj.reference);
								inst.edit(obj.reference, clickedNode.val)
							}
						},
						"delete": {
							"label": "删除",
							"action": function(obj) {
								var inst = jQuery.jstree.reference(obj.reference);
								var clickedNode = inst.get_node(obj.reference);
								inst.delete_node(obj.reference);
							}

						},
					}
				}
			});
			
			
			$('#jstMap').on('activate_node.jstree', function(e, data) {


				
					if(data.node.type== "mapfile") {
						var t = data.node.text;
						$('#mapTab').tabs('add', {
							title: t,
							//content: content,
						});	
						//加载数据                       
					}							
			});
			$('#mapTab').tabs({
                onSelect: function(title,index){           
                	//选择时清空画布
                	var canvas = $('#canvas');  //选择要擦除的canvas元素
                    var context = canvas.get(0).getContext('2d');  //获取canvas上下文           
                    context.clearRect(0, 0, canvas.width(), canvas.height());
                	//回传page的名字加载相应的xml
                	
                },
               
			onUnselect: function(title,index){
	                              
              }
	           
            });
		</script>
	</body>

</html>

