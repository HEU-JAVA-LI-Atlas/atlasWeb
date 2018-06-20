<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>

<head>

<meta name="viewport"
	content="initial-scale=1.0, user-scalable=no, width=device-width">
<title>人员关系图谱建模</title>
<link rel="stylesheet" href="css/style.min.css"></link>
<link href="css/easyui.css" rel="stylesheet" type="text/css" />
<link href="css/icon.css" rel="stylesheet" type="text/css" />
<link href="css/jquery.contextMenu.css" rel="stylesheet" type="text/css" />
<link href="css/handsontable.full.css" rel="stylesheet" type="text/css" />

<style type="text/css">
.container {
	
	position: absolute;
	left: 250px;
	top: 58px;
	width: 1200px
}

.btn {
	background: #E0E0E0;
}

.fileinput-button {
	position: relative;
	overflow: hidden;
}

.fileinput-button input {
	position: absolute;
	left: 0px;
	top: 0px;
	opacity: 0;
	-ms-filter: 'alpha(opacity=0)';
}
.lineConf{
height:30px;
width:30px
}
</style>
</head>

<body>

	<!-- 工具栏 -->
	<div id="toolbar" style="font-size: 12px; background: #E0E0E0; border: 1px solid #E0E0E0; width: 100%; height: 50px">
		<a  id="file" class="easyui-menubutton" data-options="menu:'#m1',iconCls:'icon-edit'">文件</a>
		<div id="m1" style="width: 150px;">
			<div class="fileinput-button"
				data-options="iconCls:'icon-large-smartart'">
				<span>打开</span> <input id="openFile" runat="server" onchange="javascript:openPageAsXml(this);" type="file">
			</div>
			<div class="save " data-options="iconCls:'icon-save'">保存</div>
			<div class="create" data-options="iconCls:'icon-add'">新建</div>
		</div>
		<a href="javascript:void(0)" id="mode" class="easyui-menubutton" data-options="menu:'#m2',iconCls:'icon-large-clipart'">自定义模式</a>
		<div id="m2" style="width: 150px;">
			<div>朋友模式</div>
			<div>家庭模式</div>
			<div>同学模式</div>
		</div>
		<span>线条样式</span> 
		<a class="easyui-linkbutton" name="0" data-options="toggle:true,group:'g3'"><img src="img/line.png" class="lineConf"/></a>
		<a class="easyui-linkbutton" name="1" data-options="toggle:true,group:'g3'"><img src="img/p_line.png" class="lineConf"/></a> 
		<a class="easyui-linkbutton" name="2" data-options="toggle:true,group:'g3'"><img src="img/d_line.png" class="lineConf"/></a> 
		<a class="easyui-linkbutton" name="3" data-options="toggle:true,group:'g3'"><img src="img/a_line.png" class="lineConf"/></a> 
		<a class="easyui-linkbutton" name="4" data-options="toggle:true,group:'g3'"><img src="img/t_line.png" class="lineConf"/></a> 
		
		<span>线条粗细</span> <input id="lineWidth"
			style="width: 60px" class="easyui-combobox"
			data-options="
                     valueField:'label',
                     textField:'value',
                     data:[
                     {label:'1',value:'1'},
                     {label:'2',value:'2'},
                     {label:'3',value:'3'},
                     {label:'4',value:'4'},
                     {label:'5',value:'5'},
                     {label:'6',value:'6'},
                     {label:'7',value:'7'},
                     {label:'8',value:'8'}
                     ]" />
		<span>线条颜色</span> <input id="lineColor" type="color" /> 
		<span>字体大小</span>
		<input id="fontSize" style="width: 60px" class="easyui-combobox"
			data-options="
                     valueField:'label',
                     textField:'value',
                     data:[
                     {label:'1',value:'2'},
                     {label:'2',value:'4'},
                     {label:'3',value:'6'},
                     {label:'4',value:'8'},
                     {label:'5',value:'10'},
                     {label:'6',value:'12'},
                     {label:'7',value:'14'},
                     {label:'8',value:'16'}
                     ]" />
		<span>字体颜色</span> 
		<input id="fontColor" type="color" /> 
		<span>对齐方式</span>
		<a href="#" class="easyui-linkbutton"
			data-options="toggle:true,group:'g1'">左对齐</a> <a href="#"
			class="easyui-linkbutton" data-options="toggle:true,group:'g1'">右对齐</a>
		<a href="#" class="easyui-linkbutton"
			data-options="toggle:true,group:'g1'">上对齐</a> <a href="#"
			class="easyui-linkbutton" data-options="toggle:true,group:'g1'">下对齐</a>

		<span>关联运算</span> <a  name="intersection" class="easyui-linkbutton"
			data-options="toggle:true,group:'g2'">交运算</a> <a  name="subtract"
			class="easyui-linkbutton" data-options="toggle:true,group:'g2'">差运算</a>
		<a  name="union" class="easyui-linkbutton"
			data-options="toggle:true,group:'g2'">并运算</a> <a  name="disjunction"
			class="easyui-linkbutton" data-options="toggle:true,group:'g2'">补运算</a>
	</div>
	<!-- 图谱以及信息表  -->
	
	<div class="container">
		<div class="easyui-tabs" id="t_map"></div>
		
		<div id="Div" style="background:url(img/canvas_bg.jpg)">
		<canvas id="c" 
			width="1200px" height="700px"   ></canvas>
		</div>
		<div id="contextmenu-output"></div>
		<div id="infoTable" class="easyui-dialog" title="人员信息栏" closed="true" style="width:1200px;height:250px;padding:10px; top:650px; left:250px;">
			<div class="easyui-tabs" id="ptab" style="height: 30px;width:100%"></div>
			<div id="phot"></div>
			<button onclick="javascript:savePeopleInfo()">保存修改</button>
		</div>


	</div>
	
	<!-- 图元和图谱目录 -->
	<div id="treetab" class="easyui-tabs" style=" width: 240px">
		<div title="图元管理目录" data-options="selected:true">
			<div id="jst"
				style="background: #E0E0E0; border: 1px solid #E0E0E0; width: 240px; height: 800px;"></div>
		</div>
		<div title="图谱管理目录" style="display: none;">
			<div id="jst_map"
				style="background: #E0E0E0; border: 1px solid #E0E0E0; width: 240px; height: 800px"></div>
		</div>

	
	</div>
	<div id="newpage" class="easyui-dialog" title="新增图谱"
		style="width: 400px; height: 200px; padding: 10px 20px" closed="true"
		buttons="#createpagebuttons">
		<table cellspacing="8px">
			<tr>
				<td>图谱名称：</td>
				<td><input type="text" id="pagetitle" name="pagetitle"
					class="easyui-validatebox" required="true" /></td>
			</tr>

		</table>
	</div>
	<div id="createpagebuttons">
		<a href="javascript:createblankpage()" class="easyui-linkbutton">创建</a>
	</div>

	<div id="editTable" class="easyui-dialog" title="编辑表格"
		style="width: 500px; height: 400px;" closed="true"
		toolbar="#dlg-toolbar">
		<div id="tt" class="easyui-tabs"></div>
		<div id="hot"></div>
	</div>
	<!--创建Toolbar-->
	<div id="dlg-toolbar">
		<table cellpadding="0" cellspacing="0" style="width: 100%">
			<tr>
				<td><a href="javascript:openCreateTable()"
					class="easyui-linkbutton">新建表格</a> <a id="saveTableAttr"
					href="javascript:saveTableAttr()" class="easyui-linkbutton">保存</a>
				</td>
			</tr>
		</table>
	</div>

	<div id="createtreeNode" class="easyui-dialog" title="新增分类"
		style="width: 400px; height: 200px; padding: 10px 20px" closed="true">
		<table cellspacing="8px">
			<tr>
				<td>text：</td>
				<td><input type="text" id="nodeName" class="easyui-validatebox"
					required="true" /></td>
			</tr>

		</table>
		<button id="createNode">确认</button>
	</div>

	<div id="renametreeNode" class="easyui-dialog" title="重命名"
		style="width: 400px; height: 200px; padding: 10px 20px" closed="true">
		<table cellspacing="8px">
			<tr>
				<td>new text：</td>
				<td><input type="text" id="newnodeName"
					class="easyui-validatebox" required="true" /></td>
			</tr>

		</table>
		<button id="renameNode">确认</button>
	</div>

	<div id="createTable" class="easyui-dialog" title="新增表格"
		style="width: 300px; height: 200px; padding: 10px 20px" closed="true"
		buttons="#createTablebuttons">
		<table cellspacing="8px">
			<tr>
				<td>表名：</td>
				<td><input type="text" id="Ttitle" name="Ttitle"
					class="easyui-validatebox" required="true" /></td>
			</tr>

		</table>
	</div>
	<div id="createTablebuttons">
		<a href="javascript:createblankTable()" class="easyui-linkbutton">创建</a>
	</div>
	<!--要修改编辑姓名和上传照片的表格-->
	<div id="dlg_1" closed="true" class="easyui-dialog"
		style="width: 380px; height: 300px;; padding: 10px 20px" title="人员信息"
		buttons="#dlg-buttons">

		<table cellspacing="8px" align="center">
			<tr>
				<td>姓名:</td>
				<td><input type="text" id="name" name="pname"
					class="easyui-validatebox" required="true" /></td>
			</tr>
			<tr>
				<td>身份证号:</td>
				<td><input type="text" id="IDCardNum"
					class="easyui-validatebox" required="true" /></td>
			</tr>
			<tr>
				<td>照片:</td>
				<td><input id="idFile" style="width: 224px" runat="server"
					name="pic"
					onchange="javascript:setImagePreview(this,localImag,preview);"
					type="file" /></td>
			</tr>
			<tr>
				<td>预览:</td>
				<td>
					<div id="localImag">
						<img id="preview" alt="预览图片"
							onclick="over(preview,divImage,imgbig);" src="img/people.png"
							style="width: 100px; height: 100px;" />
					</div>
				</td>
			</tr>
		</table>

		<div id="dlg-buttons" style="text-align: center">
			<a href="javascript:saveUser()" class="easyui-linkbutton">确定</a>
		</div>
	</div>

<script src="js/operateAltas.js"></script>

	<script src="js/jquery-1.11.3.min.js"></script>
	<script src="js/jstree.min.js"></script>
	<script src="js/jquery.easyui.min.js"></script>
	<script src="js/fabric.js"></script>
	<script src="js/jquery.contextMenu.js"></script>
	<script src="js/jquery.ui.position.js"></script>
	<script src="js/handsontable.full.js"></script>
	
	  
	<script type="text/javascript">
		var canvas = new fabric.Canvas('c');

		var hot;
		var nodeNum = -1;
		var Title;
		var contextMenuItems;
		var currentNodeid;
        //默认节点边框大小
		var w=100;
        var h=70;

        
        //人员分类属性表初始化
		var hot = Handsontable(document.getElementById("hot"), {
			colHeaders : [ '属性', '属性值', '备注' ],
			height : 300,
			colWidths : 150,
			maxCols : 3,
			minRows : 10,
			contextMenu : false,
			rowHeaders : true,

			manualColumnResize : true,
		});
		//人员属性表初始化
		var phot = Handsontable(document.getElementById("phot"), {
			colHeaders : [ '属性', '属性值', '备注' ],
			colWidths : 378,
			maxCols : 3,
			minRows : 10,
			contextMenu : false,
			rowHeaders : true,
			manualColumnResize : true,
		});
		//在canvas上层对象上添加右键事件监听
		window.onload = function() {	
			$(".upper-canvas").contextmenu(onContextmenu);

			//初始化右键菜单
			$.contextMenu({
				selector : '#contextmenu-output',
				trigger : 'none',
				build : function($trigger, e) {
					//构建菜单项build方法在每次右键点击会执行
					return {
						callback : contextMenuClick,
						items : contextMenuItems
					};
				},
			});
		}

		//右键点击事件响应
		function onContextmenu(event) {
			var pointer = canvas.getPointer(event.originalEvent);
			var objects = canvas.getObjects();
			for (var i = objects.length - 1; i >= 0; i--) {
				var object = objects[i];
				//判断该对象是否在鼠标点击处
				if (canvas.containsPoint(event, object)) {
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
				"delete" : {
					name : "删除",
					//icon: "delete",
					data : object
				},
				"info" : {
					name : "编辑信息",
					data : object
				},

			};
			//右键菜单显示位置
			var position = {
				x : event.clientX,
				y : event.clientY
			}
			$('#contextmenu-output').contextMenu(position);
		}

		//右键菜单项点击
		function contextMenuClick(key, options) {
			if (key == "delete") {
				//得到对应的object并删除
				var object = contextMenuItems[key].data;
				canvas.remove(object);
			} else if (key == "info") {
				
                $('#infoTable').dialog('open');
				var tabs = $("#ptab").tabs("tabs");
				var length = tabs.length;
				for (var i = 0; i < length; i++) {
					var onetab = tabs[0];
					var title = onetab.panel('options').tab.text();
					$("#ptab").tabs("close", title);
				}
				//清空表格
				phot.loadData(null);
				var obj = canvas.getActiveObject();
				var pid = obj.id + 1;
				console.log(pid)
				//alert(obj.id);
				//查看人员信息
				//加载人员信息表通过people的id加载tab   
				$.post("lwy/loadinfotab.do", {
					pid : pid
				}, function(data) {

					//循环增加tab
					//console.log(data)
					for (var i = 0; i < data.length; i++) {
						$('#ptab').tabs('add', {
							title : data[i],
							closable : true
						});

					}
				});
			}

		}
		function randomFromTo(from, to) {
			return Math.floor(Math.random() * (to - from + 1) + from);
		}
		//生成人员节点
		function saveUser() {

			var Nname = $('#name').val();
			var idCardNum=$('#IDCardNum').val();
			if (!Nname) {
				alert("姓名不能为空！");
				return;
			}
			var n_x = randomFromTo(0, 1100);
			var n_y = randomFromTo(0, 450);
			//显示人员照片
			var pimg = document.getElementById("preview");

			//console.log(pimg)
			//var url = $('#preview').attr("src");

			var selectedFile = document.getElementById('idFile').files[0];
			var name = selectedFile.name;

			var src = "photo/" + name;
			//pimg.src=src;
			//console.log(pimg)
			//生成人员节点
			
			createGroup(n_x, n_y, w, h, Title, Nname, pimg);
			nodeNum = nodeNum + 1;
			var selectedTab = $('#t_map').tabs('getSelected');
			var selectedTabTitle = selectedTab.panel('options').title;
			//传人员节点的数据
			var data = {
				"id" : nodeNum,
				"title" : Title,
				"name" : Nname,
				"idCardNum":idCardNum,
				"photo" : src,
				//"photo":url,
				"x" : n_x,
				"y" : n_y,
				"width" : w,
				"height" : h,
				"infoTableList" : null
			};
			$.post("lwy/peoplePost.do", {
				data : JSON.stringify(data),
				nodeid : currentNodeid,
				pageTitle:selectedTabTitle
			}, function(data) {
				//alert(data);

			});

			$('#dlg_1').dialog("close");
			$('#dlg_1').form("clear");

		}

		//添加标签页以及空表
		//在后台增加一个空表
		function createblankTable() {
			$('#createTable').dialog("close");
			var t = $('#Ttitle').val();

			var data = null;
			//var content = '<div id="hot"></div>';
			$('#tt').tabs('add', {
				title : t,
				//content: content,
				closable : true
			});
			//创建一张空表
			/*$.post("lwy/tablePost.do", {nodeid:currentNodeid,tableid:t,tabletitle:t,changetabledata:data} , function(data) {
			  //alert(data);
			});
			//hot.clear();*/
			$('#createTable').form("clear");
		}

		//保存选中的未填写属性值的属性表格
		function saveTableAttr() {
			//获取handsontable的数据
			var data = hot.getData();
			//console.log(data);

			var selectedTab = $('#tt').tabs('getSelected');
			var selectedTabTitle = selectedTab.panel('options').title;

			//数据传到后台
			/*$.post("lwy/tablePost.do", {nodeid:currentNodeid,tableid:selectedTabTitle,tabletitle:selectedTabTitle,changetabledata:data} , function(data) {
						  //alert(data);
			});*/
			var selectedTab = $('#t_map').tabs('getSelected');
			var pageTitle = selectedTab.panel('options').title;
			
			$.ajax({
				url : "lwy/tablePost.do",
				type : "post",
				dataType : "text",

				data : {
					nodeid : currentNodeid,
					tableid : selectedTabTitle,
					tabletitle : selectedTabTitle,
					changetabledata : JSON.stringify(data),
					pageTitle:pageTitle
				},
				success : function(data) {
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
			//drawTextLine(100, 100, 300, 300, 2, "black","111");
			$('#newpage').dialog("open");

		});
		//保存
		$('.save').click(function() {
			savePageAsXML();
		});

		
		//保存填写完的人员信息表
		function savePeopleInfo() {
			var obj = canvas.getActiveObject();
			var pid = obj.id + 1;
			var data = phot.getData();
			console.log(data);
			var selectedTab = $('#ptab').tabs('getSelected');
			var selectedTabTitle = selectedTab.panel('options').title;
			var selectedTab1 = $('#t_map').tabs('getSelected');
			var pageTitle = selectedTab.panel('options').title;
			//传递人员的id
			//把tablelist保存到人员信息中
			$.post("lwy/infotablePost.do", {
				pid : pid,
				tabletitle : selectedTabTitle,
				changetabledata : JSON.stringify(data),
				pageTitle:pageTitle
			}, function(data) {
				//alert(data);
			});
		}

		function setImagePreview(obj, localImagId, imgObjPreview) {
			var array = new Array('gif', 'jpeg', 'png', 'jpg', 'bmp'); //可以上传的文件类型
			if (obj.value == '') {
				$.messager.alert("让选择要上传的图片!");
				return false;
			} else {
				var fileContentType = obj.value.match(/^(.*)(\.)(.{1,8})$/)[3]; //这个文件类型正则很有用 
				////布尔型变量
				var isExists = false;
				//循环判断图片的格式是否正确
				for ( var i in array) {
					if (fileContentType.toLowerCase() == array[i].toLowerCase()) {
						//图片格式正确之后，根据浏览器的不同设置图片的大小
						if (obj.files && obj.files[0]) {
							//火狐下，直接设img属性 
							imgObjPreview.style.display = 'block';
							imgObjPreview.style.width = '30px';
							imgObjPreview.style.height = '45px';
							//火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式 
							imgObjPreview.src = window.URL
									.createObjectURL(obj.files[0]);
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
								localImagId.filters
										.item("DXImageTransform.Microsoft.AlphaImageLoader=").src = imgSrc;
							} catch (e) {
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
				if (isExists == false) {
					$.messager.alert("上传图片类型不正确!");
					return false;
				}
				return false;
			}
		}
		function drawPage(data){
			
    		 //先画节点
    		 if(data.people!=null){
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
        		  img.style.width='30px';
        	      img.style.height='45px';
        		  img.onload=function(){
        			  
        			  createGroup(parseInt(x), parseInt(y), parseInt(w), parseInt(h), t, n , img);
        		  }})(i);
        	 }
    		 }
        	 if(data.connection!=null){
            	 for(var i=0;i<data.connection.length;i++){
            		 
            		  var sid=data.connection[i].sourceId;
            		  var tid=data.connection[i].targetId;
                      var text=data.connection[i].text;
                      var lineStyle=data.connection[i].lineStyle;
                      var lineColor=data.connection[i].lineColor;
                      var lineWidth=data.connection[i].lineWidth;
            		  var sx;
            		  var sy;
            		  var tx;
            		  var ty;
            		  var w;
            		  var h;
            		  
	                  for(var j=0;j<data.people.length;j++){
	                		if(data.people[j].idCardNum==sid){
		                		  sx=data.people[j].x;
		                		  sy=data.people[j].y;
		                		  w=data.people[j].width;
		                		  h=data.people[j].height;
	                		}else if(data.people[j].idCardNum==tid){
	                			  tx=data.people[j].x;
		                		  ty=data.people[j].y;
	                		}
	                	}
                       //当关联运算时data.people[j].idCardNum==sid  用idCardNum判断
	                  
            		  drawShortestLine(lineStyle,parseInt(lineWidth),lineColor,parseInt(sx),parseInt(sy),parseInt(tx),parseInt(ty),parseInt(w),parseInt(h),text);
            		

            	 }
             }
		}

		           //保存图谱
					function savePageAsXML(){
						var selectedTab = $('#t_map').tabs('getSelected');
						var selectedTabTitle = selectedTab.panel('options').title;
						//console.log(nodeTreeData);
						//alert(currentNodeid);
						//数据传到后台				
						$.post("lwy/pagePost.do", {pageid:selectedTabTitle,pagetitle:selectedTabTitle} , function(data) {
									  //alert(data);
					});
					}
					
					//加载本地xml文件得到路径
					function openPageAsXml(obj){
						      //得到工具栏中选择的关联方法
					         // var method="union";
						    //jstreeOnload();
					      	var method=$('a[group="g2"].l-btn-selected').attr("name");
							var selectedFile = document.getElementById('openFile').files[0];
				            var fileName = selectedFile.name;//读取选中文件的文件名
				            //console.log("文件名:"+name);
				            
				            var index1=fileName.lastIndexOf(".");		           
				            var filename=fileName.substring(0,index1);
				           // console.log("文件名:"+suffix)
				           
				            var reader = new FileReader();//这是核心,读取操作就是由它完成.
				            reader.readAsText(selectedFile);//读取文件的内容,也可以读取文件的URL
				            reader.onload = function () {
				                //判断是否要做关联运算
				                 if(method!=null){
				                	 var selectedTab = $('#t_map').tabs('getSelected');
				                	 var pageTitle;
				                	 if(selectedTab!=null){
				                		 pageTitle = selectedTab.panel('options').title;
				                	 }						 
				                	 $.post("lwy/xmlCalculate.do", {data:this.result,fileName:filename,associateMethod:method,pageTitle:pageTitle} , function(data) {
					                	// console.log(data)
			                             //新增图谱页
					                	 if(data.people==null){
					                		 //console.log("111111")
					                		 $('#newpage').dialog("open");
					                		 
					                	 }else{
					                		 $('a[group="g2"].l-btn-selected').removeClass("l-btn-selected");
					                		
					                		 drawPage(data);
					                		 
					                	 }
					                	 
					                	
					                	 
									});	
				                 }
				                 else{
				                //文件内容为this.result
				                 $.post("lwy/xmlPost.do", {data:this.result,fileName:filename} , function(data) {
				                	 console.log(data)
		                            //增加tab
				            $('#t_map').tabs('add', {
							title:filename,
							closable:true
						   });
				                	//在图谱管理目录中新增一个子节点
				            $('#jst_map').jstree('create_node', $('#map'), { "text":filename, "id":filename }, "last", false, false);
				                	// drawPage(data);
				                	
				                	 
								});	
				                 }
				                
				            }	
					}
					//新建图谱    
					function createblankpage() {
						var title = $('#pagetitle').val();
						//添加图谱tab

						$('#t_map').tabs('add', {
							title : title,
							closable : true
						});
						//保存当前tab的画布
                        jstreeOnload();
						//清空画布canvas
						canvas.clear();
						//清空dialog
						$('#newpage').dialog("close");
						$('#newpage').form("clear");
					}

					var w = 100;
					var h = 70;
		            //生成节点
					function createGroup(posX, posY, width,height,newTitle, newName, pimg) {
						
						var Rect = new fabric.Rect({
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
						var group = new fabric.Group([Rect, pName, title, img], {
							left: posX,
							top: posY,
							id: nodeNum
						});
						canvas.add(group);
					
					}
		            //连线算法 主要有带箭头的线直线虚线折线和有text的线
		             function drawLine(style, linewidth, linecolor,x1,y1,x2,y2,text,fontsize,fontcolor){	
						switch (style)
		            	{
						//直线
		            	case "0":
		            		drawStraightLine(x1, y1, x2, y2, linewidth, linecolor) ;
		            	  break;
		            	//折线
		            	case "1":
		            		drawPolyLine(x1, y1, x2, y2, linewidth, linecolor);
		            	  break;           
		            	//虚线
		            	case "2":
		            		drawDashedLine(x1, y1, x2, y2, linewidth, linecolor);
		            	  break;
		                //带箭头的线
		            	case "3":
		            		drawArrowLine(x1, y1, x2, y2, linewidth, linecolor);
		            	  break;
		            	//带文字的线
		            	case "4":
		            		drawTextLine(x1, y1, x2, y2, linewidth, linecolor,text,fontsize,fontcolor);
		            	  break;
		            	}
						
					}
		           //画直线
		 			function drawStraightLine(x1, y1, x2, y2, linewidth, linecolor) {
		        	    
		 				var line = new fabric.Line([x1, y1, x2, y2], {
		 					stroke:linecolor,
							strokeWidth: linewidth,
		 				});
		 				canvas.add(line);
		 			}
		            //画虚线算法
		            function drawDashedLine(x1, y1, x2, y2, linewidth, linecolor){
		            	var dashedline=new fabric.Line([x1, y1, x2, y2], {
		            		stroke: linecolor,
							strokeWidth: linewidth,
							strokeDashArray: [10, 5] 	
						});
						canvas.add(dashedline);
		            }
					//画折线算法		
					function drawPolyLine(x1, y1, x2, y2, linewidth, linecolor) {

						var poly = new fabric.Polyline([{
								x: x1,
								y: y1
							},
							{//计算一个转折还是两个转折
								x: x1,
								y: y2
							},
							{
								x: x2,
								y: y2
							}
						], {
							stroke: linecolor,
							strokeWidth: linewidth,
							fill: 'white',
						});
						canvas.add(poly);
					}
					
					//画带箭头的连线算法
					function drawArrowLine(x1, y1, x2, y2, linewidth, linecolor) {
						
						 canvasObject = new fabric.Path(drawArrow(x1, y1, x2, y2, 30, 30), {
					          stroke: linecolor,
					          fill: "rgba(255,255,255,0)",
					          strokeWidth: linewidth
					        });
		 				canvas.add(canvasObject);
					}
					//画箭头
					function drawArrow(fromX, fromY, toX, toY, theta, headlen) {
					    theta = typeof theta != "undefined" ? theta : 30;
					    headlen = typeof theta != "undefined" ? headlen : 10;
					    // 计算各角度和对应的P2,P3坐标
					    var angle = Math.atan2(fromY - toY, fromX - toX) * 180 / Math.PI,
					      angle1 = (angle + theta) * Math.PI / 180,
					      angle2 = (angle - theta) * Math.PI / 180,
					      topX = headlen * Math.cos(angle1),
					      topY = headlen * Math.sin(angle1),
					      botX = headlen * Math.cos(angle2),
					      botY = headlen * Math.sin(angle2);
					    var arrowX = fromX - topX,
					      arrowY = fromY - topY;
					    var path = " M " + fromX + " " + fromY;
					    path += " L " + toX + " " + toY;
					    arrowX = toX + topX;
					    arrowY = toY + topY;
					    path += " M " + arrowX + " " + arrowY;
					    path += " L " + toX + " " + toY;
					    arrowX = toX + botX;
					    arrowY = toY + botY;
					    path += " L " + arrowX + " " + arrowY;
					    return path;
					  }
					//画带text的连线算法
					function drawTextLine(x1, y1, x2, y2, linewidth, linecolor,text,fontsize,fontcolor){
						//console.log(fontsize)
						//console.log(text)
						var t = new fabric.Text(text, {
							left: (x1+x2)/2,
							top: (y1+y2)/2,
							fontSize: 10
							//fontSize: fontsize,
							//fontColor: fontcolor
						});
						var line = new fabric.Line([x1, y1, x2, y2], {
		 					stroke:linecolor,
							strokeWidth: linewidth,
		 				});
						var group = new fabric.Group([t,line], {
						
						});
						canvas.add(group);
					}
					
					//直线最短路径算法
					function drawShortestLine(style, linewidth, linecolor,x1, y1, x2, y2, w, h,text,fontsize,fontcolor) {
						if(y2 < y1 - 3 * h / 4) {
							if(x2 > x1 + 3 * w / 4) drawLine(style, linewidth, linecolor,x1 + w, y1, x2, y2 + h,text,fontsize,fontcolor);
							else if(x2 < x1 - 3 * w/ 4) drawLine(style, linewidth, linecolor,x1, y1, x2 + w, y2 + h,text,fontsize,fontcolor);
							else drawLine(style, linewidth, linecolor,x1 + w / 2, y1, x2 + w / 2, y2 + h,text,fontsize,fontcolor);
						} else if(y2 > y1 + 3 * h / 4) {
							if(x2 > x1 + 3 * w/ 4) drawLine(style, linewidth, linecolor,x1 + w, y1 + h, x2, y2,text,fontsize,fontcolor);
							else if(x2 < x1 - 3 * w / 4) drawLine(style, linewidth, linecolor,x1, y1 + h, x2 + w, y2,text,fontsize,fontcolor);
							else drawLine(style, linewidth, linecolor,x1 + w / 2, y1 + h, x2 + w / 2, y2,text,fontsize,fontcolor);
						} else {
							if(x2 < x1 - w) drawLine(style, linewidth, linecolor,x1, y1 + h / 2, x2 + w, y2 + h / 2,text,fontsize,fontcolor);
							else if(x2 > x1 + w) drawLine(style, linewidth, linecolor,x1 + w, y1 + h / 2, x2, y2 + h / 2,text,fontsize,fontcolor);
						}
					}
		
		var nodeTreeData=[{"id" : "people","text" : "人员","state" : { "opened" : true},"type" : "people",},
		                   {"id" : "relate","text" : "关系","state" : { "opened" : true},"type" : "relate",} ];
		
		   
		$('#jst')
				.jstree(
						{
							"core" : {
								"themes" : {
									"stripes" : true
								},
								"check_callback" : true, // enable all modifications
								"data" : nodeTreeData,
								

							},
							"types" : {
								"default" : {

								},
								"people" : {
									"icon" : "img/people.png",
								},
								"relate" : {
									"icon" : "img/draw_line.png",
								},
							},
							"plugins" : [ "dnd", "contextmenu", "types" ],
							"contextmenu" : {

								"items" : {
									"create" : {
										"label" : "新增分类",
										"action" : function(obj) {
											$('#dlg_1').dialog("close");
											var inst = jQuery.jstree.reference(obj.reference);
											var clickedNode = inst.get_node(obj.reference);
											var newNode = inst.create_node(obj.reference,clickedNode.val);
											var ty = inst.get_type(obj.reference);
											inst.set_type(newNode, ty);
											var Nodeobj = inst.get_json(newNode);
											var str = {
												"id" : Nodeobj.id,
												"text" : Nodeobj.text,
												"icon" : Nodeobj.icon,
												"type" : Nodeobj.type,
												"parentid" : clickedNode.id,
												"tablelist" : null
											};
											var selectedTab = $('#t_map').tabs('getSelected');
											var pageTitle = selectedTab.panel('options').title;
											$.post("lwy/createNode.do", {changedata : JSON.stringify(str),pageTitle:pageTitle}, 
													function(data) {});
											inst.edit(newNode);
											inst.open_node(obj.reference);
										},
									},
									"editTable" : {
										"label" : "管理信息表",
										"action" : function(obj) {
											$('#dlg_1').dialog("close");
											$('#editTable').dialog("open");
											var tabs = $("#tt").tabs("tabs");
											var length = tabs.length;
											for (var i = 0; i < length; i++) {
												var onetab = tabs[0];
												var title = onetab.panel('options').tab.text();
												$("#tt").tabs("close", title);
											}
											//清空表格
											hot.loadData(null);
											//加载节点的信息表
											//用currentnodeid加载人员信息表格
											$.post("lwy/loadpeopletab.do",{nodeid : currentNodeid},
															function(data) {
																for (var i = 0; i < data.length; i++) {
																	$('#tt').tabs('add',{
																		title : data[i],
																		closable : true
																    });
																}
															});
										}

									},
									"rename" : {
										"label" : "重命名",
										"action" : function(obj) {
											$('#dlg_1').dialog("close");
											var inst = jQuery.jstree.reference(obj.reference);
											var clickedNode = inst.get_node(obj.reference);
											inst.edit(obj.reference,clickedNode.val);
										}
									},
									"delete" : {
										"label" : "删除分类",
										"action" : function(obj) {
											$('#dlg_1').dialog("close");
											var inst = jQuery.jstree.reference(obj.reference);
											var clickedNode = inst.get_node(obj.reference);
											inst.delete_node(obj.reference);
									},
									
									

								}
							}
						}
						});
		
		//增加标签（包括目录和人员节点的信息标签）选中事件
		$('#tt').tabs({
			onSelect : function(title, index) {
				var selectedTab = $('#t_map').tabs('getSelected');
				var pageTitle = selectedTab.panel('options').title;
				//加载表格数据
				$.post("lwy/loadtabledata.do", {
					tabtitle : title,
					nodeid : currentNodeid,
					pageTitle:pageTitle
				}, function(data) {

					// console.log(data);
					if (data) {
						//将string数据转化为数组 				            	
						var arr = new Array();
						arr = eval(data);
						//console.log(arr);			            					            		
						hot.loadData(arr);
					} else {
						//加载空表表格
						hot.loadData(null);
					}
				});
			},
			//标签没被选中时自动保存
			onUnselect : function(title, index) {

			}

		});

		$('#ptab').tabs({
			onSelect : function(title, index) {
				var obj = canvas.getActiveObject();
				var pid = obj.id + 1;
				//加载表格数据
				$.post("lwy/loadinfotable.do", {
					tabtitle : title,
					pid : pid
				}, function(data) {

					//console.log(data);
					//将string数据转化为数组 				            	
					var arr = new Array();
					arr = eval(data);
					//console.log(arr);			            					            		
					phot.loadData(arr);

					//在photo中插入一列
					//phot.alter('insert_col',1);
				});
			},
			//标签没被选中时自动保存
			onUnselect : function(title, index) {

			}

		});

		$('#jst').on(
				'activate_node.jstree',
				function(e, data) {
					//判断是否为叶子节点
					currentNodeid = data.node.id;
					var text = data.node.text;
					//默认线条和字体样式
					 var lineStyle=0;
					$('#lineWidth').combobox('select','2');
			        $('#fontSize').combobox('select','10');
					//console.log(text)
					var isLeaf = data.instance.is_leaf(data.node);
					if (isLeaf) {
						//从工具栏中的线条样式中获得线条和字体参数
						
						if (data.node.type == "people") {
							var Ntitle = data.node.text;
							Title = Ntitle;

							//弹出人员信息对话框
							//$('#createTable').dialog("open");
							$('#dlg_1').dialog("open");
						} 
						else if (data.node.type == "relate" && data.node.text!="关系") {
							var i = 0;
							var sourceID, sourcex, sourcey;
							var targetID, targetx, targety;
							if($('a[group="g3"].l-btn-selected').attr("name")!=null){
								lineStyle=$('a[group="g3"].l-btn-selected').attr("name");
							}
							
						    //console.log($('a[group="g3"].l-btn-selected').attr("name"))
							
							
							if($('#lineWidth').combobox('getValue')!=null){
								lineWidth=$('#lineWidth').combobox('getValue');
							}
							
							
							lineColor=$('#lineColor').val();
							    //console.log(lineColor)
							if($('#fontSize').combobox('getValue')!=null){
								fontSize=$('#fontSize').combobox('getValue');
							}
	
							fontColor=$('#fontColor').val();
							
							canvas.on('object:selected', function() {

								var obj = canvas.getActiveObject();
								var x = obj.getLeft();
								var y = obj.getTop();
								//获取id
								//alert(obj.id);
								if (i == 0) {
									sourceID = obj.id + 1;
									sourcex = x;
									sourcey = y;
									i = 1;
									//console.log("source:"+sourceID)

								} else if (i == 1) {
									targetID = obj.id + 1;
									targetx = x;
									targety = y;
									i = 2;
									
									//连线
									
									drawShortestLine(lineStyle, parseInt(lineWidth),
											lineColor, sourcex, sourcey,
											targetx, targety, w, h, text,parseInt(fontSize)*2,fontColor);
									//传递数据到后台
									var connectdata = {
										"sourceId" : sourceID,
										"targetId" : targetID,
										"text" : data.node.text,
										"lineStyle" : lineStyle,
										"lineColor" : lineColor,
										"lineWidth" : lineWidth,
									};
									var selectedTab = $('#t_map').tabs('getSelected');
									var pageTitle = selectedTab.panel('options').title;
									$.post("lwy/connectPost.do", {
										data : JSON.stringify(connectdata),
										pageTitle:pageTitle
									}, function(data) {
										//alert(data);
									});
								}
							});
						}
					}
				});

		$('#jst_map').jstree(
				{
					"core" : {
						"themes" : {
							"stripes" : true
						},
						"check_callback" : true, // enable all modifications
						"data" : [

						{

							"id" : "map",
							"text" : "图谱",
							"state" : { //默认状态展开  
								"opened" : true
							},
							"type" : "mapclass",

						},

						],

					},
					"types" : {
						"default" : {

						},
						"mapclass" : {
							"icon" : "img/people.png",
						},
						"mapfile" : {
							"icon" : "img/draw_line.png",
						},
					},
					"plugins" : [ "dnd", "contextmenu", "types" ],
					"contextmenu" : {
						"items" : {
							"createclass" : {
								"label" : "新增分类",
								"action" : function(obj) {

									var inst = jQuery.jstree
											.reference(obj.reference);
									var clickedNode = inst
											.get_node(obj.reference);
									var newNode = inst.create_node(
											obj.reference, clickedNode.val);
									inst.set_type(newNode, "mapclass");
									inst.edit(newNode);
									inst.open_node(obj.reference);

								},

							},
							"rename" : {
								"label" : "重命名",
								"action" : function(obj) {
									var inst = jQuery.jstree
											.reference(obj.reference);
									var clickedNode = inst
											.get_node(obj.reference);
									inst.edit(obj.reference, clickedNode.val)
								}
							},
							"delete" : {
								"label" : "删除",
								"action" : function(obj) {
									var inst = jQuery.jstree
											.reference(obj.reference);
									var clickedNode = inst
											.get_node(obj.reference);
									inst.delete_node(obj.reference);
								}

							},
						}
					}
				});

		$('#jst_map').on('activate_node.jstree', function(e, data) {

			if (data.node.type == "mapfile") {
				var t = data.node.text;
				$('#t_map').tabs('add', {
					title : t,
				//content: content,
				});
				//加载数据                       
			}
		});
		$('#t_map').tabs({
			onSelect : function(title, index) {
				//选择时清空画布
				canvas.clear();
				
				//传图谱名称加载后台图谱数据
				$.post("lwy/pageLoad.do", {
					pageTitle:title
				}, function(data) {
					
					drawPage(data);
				});	
			

			},

			onUnselect : function(title, index) {
			}
		});   
	</script>
</body>

</html>

