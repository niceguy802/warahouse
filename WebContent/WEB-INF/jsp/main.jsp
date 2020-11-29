<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <jsp:include page="/WEB-INF/jsp/common/common.jsp"/>
       <!-- 导入echarts.js -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/dist/plugins/echarts/echarts.js"></script>            
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/dist/plugins/jquery-3.3.1/jquery-3.3.1.min.js"></script>            
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/dist/plugins/jquery-3.3.1/jquery-3.3.1.js"></script>            
   
    <script type="text/javascript">
     $(function(){
            // 初始化echarts实例
            var myChart = echarts.init($("#stock")[0]);
            //空坐标轴
		    option=({
		      title: {
		          text: '库存信息'
		             },
		      color: ['#3398DB'],
		      tooltip: {},
		      grid: {
		          left: '3%',
		          right: '4%',
		          bottom: '3%',
		          containLabel: true
		      },
		      legend: {
		          data:['库存']
		              },
		      xAxis: {
		          data: [],
		         
		             },
		      yAxis: {},
		      series: [{
		          name: '库存',
		          type: 'bar',
		          barWidth: '50%',
		          data: []
		               }]
		      })
            //用ajax加载数据
            $.ajax({
            	type:"get",
            	url:"${pageContext.request.contextPath}/stocks/statis/product",
            	success : function(data){  //data 就是服务器响应来的数据
       			 //处理数据格式 
       			 var dataLength = data.data.length; 
       			 var xAxisData = [];
       			 var seriesData = [];
       			 for(var i=0;i<dataLength;i++){
       				 var stockRecord = data.data[i];
       				 xAxisData.push(stockRecord.productName);
       				 seriesData.push(stockRecord.number);
       			                              }       			        			  
       			  // 填入数据
       		     myChart.setOption({
       		          xAxis: {
       		              data: xAxisData       		              
       		                 },
       		          series: [{
       		              name: '库存',       		              
    		              data: seriesData          		                  		              
       		                   }],
       	              });             	 
            	 } 
           	});
            
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);   
          });
     /*
		    $(function(){
		        // 初始化echarts实例
		        var myChart = echarts.init($("#book")[0]);
		        //空坐标轴
			    option=({
			      title: {
			          text: '销量信息'
			             },
			      tooltip: {},
			      legend: {
			          data:['销量']
			              },
			      xAxis: {
			          data: []
			             },
			      yAxis: {},
			      series: [{
			    	  name: '销量',
				      type: 'pie',
				      radius:'55%',
			          data: []
			               }]
			      })
		         //用ajax加载数据
		         $.ajax({
		         	type:"get",
		         	url:"${pageContext.request.contextPath}/bookItems/statis/product",
		         	success : function(data){  //data 就是服务器响应来的数据
		    			 //处理数据格式 
		    			 var dataLength = data.data.length; 
		    			 var xAxisData = [];
		    			 var seriesData = [];
		    			 for(var i=0;i<dataLength;i++){
		    				 var stockRecord = data.data[i];
		    				 xAxisData.push(stockRecord.productName);
		    				 seriesData.push(stockRecord.num);
		    			                              }       			        			  
		    			  // 填入数据
		    		     myChart.setOption({
		    		          xAxis: {
		    		              data: xAxisData       		              
		    		                 },
		    		          series: [{
		    		              name: '销量',       		              
		 		              data: seriesData          		                  		              
		    		                   }],
		    	              });             	 
		         	 } 
		        	});
		         // 使用刚指定的配置项和数据显示图表。
		         myChart.setOption(option);   
		         });
		    */
		    $(function(){
		        // 初始化echarts实例
		        var myChart = echarts.init($("#out")[0]);
		        //空坐标轴
			    option=({
			      title: {
			          text: '出库信息'
			             },
			      tooltip: {
			    	 
			      },
			      legend: {
			          data:['出库']
			              },
			      xAxis: {
			          data: []
			             },
			      yAxis: {},
			      series: [{
			    	  name: '出库',
				      type: 'line',
				      radius:'55%',
			          data: []
			               }]
			      })
		         //用ajax加载数据
		         $.ajax({
		         	type:"get",
		         	url:"${pageContext.request.contextPath}/outcomeItems/statis/product",
		         	success : function(data){  //data 就是服务器响应来的数据
		    			 //处理数据格式 
		    			 var dataLength = data.data.length; 
		    			 var xAxisData = [];
		    			 var seriesData = [];
		    			 for(var i=0;i<dataLength;i++){
		    				 var stockRecord = data.data[i];
		    				 xAxisData.push(stockRecord.name);
		    				 seriesData.push(stockRecord.num);
		    			                              }       			        			  
		    			  // 填入数据
		    		     myChart.setOption({
		    		          xAxis: {
		    		              data: xAxisData       		              
		    		                 },
		    		          series: [{
		    		              name: '出库',       		              
		 		              data: seriesData          		                  		              
		    		                   }],
		    	              });             	 
		         	      } 
		        	});
		         // 使用刚指定的配置项和数据显示图表。
		         myChart.setOption(option);   
		     });

   </script>
   <script type="text/javascript">
   $(function(){
	   var myChart = echarts.init(document.getElementById('book'));
      // var myChart = echarts.init($("#book"));
		// 初始 option
		 option = ({
		    title : {
		        text: '订单信息',
		        x:'center'
		    },
		    tooltip: {
		        trigger: 'item',
		        formatter: "{a} <br/>{b}: {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        x: 'right',
		        data: []
		    },
		    series: [{
		        name: '销量',
		        type: 'pie',
		        data: [],
		        
		    }],
		    emphasis: {
                itemStyle: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
	    });
		// Ajax异步加载
		getChart();
		function getChart() {
		    var statisticsData = [];   //这是我自己建的空数组，为了把异步拿到的数据push进去
		    myChart.showLoading();  //加载数据前的loading动画
		    $.ajax({
		        url: "${pageContext.request.contextPath}/bookItems/statis/product",    //请求的接口名
		        type: 'get',
		        async: true,
		        success: function(data){
		            myChart.hideLoading();  //加载数据完成后的loading动画
		            var dataStage = data.data;   //这里是我们后台返的数据
		            for(var i in dataStage) {
		                var bookRecord = {name:'',value:''};   //ECharts里边需要的数据格式是这样的
		                bookRecord.name = dataStage[i].productName;
		                bookRecord.value = dataStage[i].num;
		                statisticsData.push(bookRecord);   //把拿到的异步数据push数组里
		            }
		            myChart.setOption({
		                legend: {
		                    orient: 'vertical',
		                    x: 'right',
		                    data: statisticsData.name   //这里是图表上的数据
		                },
		                series: [{
		                    name: '销量',
		                    type: 'pie',
		                    radius: ['40%', '55%'],
		                    data: statisticsData    //这里是异步加载系列列表
		                }]
		            })
		        },
		        error: function(){
		            console.log('失败')
		        }
		    })
		}
		
	myChart.setOption(option);
   })
   </script>
  </head>
  <body class="hold-transition skin-blue sidebar-mini">
   
    <div class="wrapper">
      <!-- 头部 -->
      <jsp:include page="/WEB-INF/jsp/common/top.jsp"/>
      
      <!-- 菜单 -->
      <jsp:include page="/WEB-INF/jsp/common/menu.jsp"/>
     
      <!-- 内容区域 -->
      <div class="content-wrapper">
        
        <section class="content-header">
          <h1>
                                        主页
            <small>在艺术与梦里，你应该放荡不羁德前行</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="/WMS/"><i class="fa fa-dashboard"></i>主页</a></li>
            <li><a href="JavaScript:history.go(-1)">返回上一页</a></li>
            <li class="active">主页</li>
          </ol>
        </section>
 
        <section class="content">
                      
             <div class="col-sm-6"> 
             <!-- 表格容器 -->
             <div id="stock" style="width: 500px;height:300px;"></div>
           </div>   
           
            <div class="row" >
            <div class="col-sm-6"> 
             <!-- 表格容器 -->
             <div id="book" style="width: 500px;height:300px;"></div>
            </div>
           </div>
           
           <div class="row" >
             <div class="col-sm-6"> 
             <!-- 表格容器 -->
             <div id="out" style="width: 500px;height:300px;"></div>
             </div>
           </div>
        </section>
   
      </div>
       <!-- 底部 -->
       <jsp:include page="/WEB-INF/jsp/common/footer.jsp"/>
    
       <!-- 设置 -->
       <jsp:include page="/WEB-INF/jsp/common/setting.jsp"/>
    </div>
  </body>
</html>

