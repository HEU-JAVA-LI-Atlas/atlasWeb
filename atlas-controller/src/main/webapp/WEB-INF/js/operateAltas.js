/**
 * 
 */

           //保存图谱
			function savePageAsXML(){
				var selectedTab = $('#t_map').tabs('getSelected');
				var selectedTabTitle = selectedTab.panel('options').title;
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
				
			      	var method=$('a[group="g2"].l-btn-selected').attr("name");
					var selectedFile = document.getElementById('openFile').files[0];
		            var name = selectedFile.name;//读取选中文件的文件名
		            //console.log("文件名:"+name);
		            var index1=name.lastIndexOf(".");		           
		            var filename=name.substring(0,index1);
		           // console.log("文件名:"+suffix)
		           
		            var reader = new FileReader();//这是核心,读取操作就是由它完成.
		            reader.readAsText(selectedFile);//读取文件的内容,也可以读取文件的URL
		            reader.onload = function () {
		                //判断是否要做关联运算
		                 if(method!=null){
		                	 //console.log("111")
		                	 $.post("lwy/xmlCalculate.do", {data:this.result,fileName:filename,associateMethod:method} , function(data) {
			                	 console.log(data)
	                             //新增图谱页
			                	 if(data==null){
			                		 $('#newpage').dialog("open");
			                	 }else{
			                		 $('a[group="g2"].l-btn-selected').removeClass("l-btn-selected");
			                	 }
			                	 
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
			                		  img.style.width='30px';
			                	      img.style.height='45px';
			                		  //console.log(img)
			                		  img.onload=function(){
			                			  
			                			  createGroup(parseInt(x), parseInt(y), parseInt(w), parseInt(h), t, n , img);
			                		  }})(i);
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
		                		  img.style.width='30px';
		                	      img.style.height='45px';
		                		  //console.log(img)
		                		  img.onload=function(){
		                			  
		                			  createGroup(parseInt(x), parseInt(y), parseInt(w), parseInt(h), t, n , img);
		                		  }})(i);
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
    				                		if(data.people[j].id==sid){
    		    		                		  sx=data.people[j].x;
    		    		                		  sy=data.people[j].y;
    		    		                		  w=data.people[j].width;
    		    		                		  h=data.people[j].height;
    				                		}else if(data.people[j].id==tid){
    				                			  tx=data.people[j].x;
    		    		                		  ty=data.people[j].y;
    				                		}
    				                	}
                                      
    				                  
    		                		  drawShortestLine(lineStyle,parseInt(lineWidth),lineColor,parseInt(sx),parseInt(sy),parseInt(tx),parseInt(ty),parseInt(w),parseInt(h),text);
    		                		

    		                	 }
                             }
		                	 
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
            		console.log("111")
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
				console.log(text)
				var t = new fabric.Text(text, {
					left: (x1+x2)/2,
					top: (y1+y2)/2,
					fontSize: fontsize,
					fontColor: fontcolor
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
          