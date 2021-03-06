<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <jsp:include page="/WEB-INF/jsp/common/common.jsp"/>
    
    <!-- 引入bootstral-table插件的资源 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bower_components/table/bootstrap-table.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/bower_components/table/bootstrap-table.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/bower_components/table/bootstrap-table-zh-CN.js"></script>
  
    <script type="text/javascript">
    $(function(){
    	
    	var $table=null;
    	$("#searchForm").on("submit",function(){
    		$table.bootstrapTable('refresh'); 
    		return false;
    	})
    	
        var queryURL = "${pageContext.request.contextPath}/bookItems/list"; 
	     $table=$('#bookItem_table').bootstrapTable({
	            url: queryURL,  //数据的接口地址,ajax请求[请求头:]
	            method: 'GET',
	            uniqueId: 'id', //绑定ID，不显示
	            
	            striped: true,  //是否显示行间隔色             
	            cache: false,   //是否使用缓存，默认为true                             
	            
	            sortable: false,//是否启用排序
	            sortOrder: "asc",//排序方式                                
	            
	            sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）      
	            undefinedText: '--',
	    
	            toolbar: '#toolbar',      // 工具条         
	            pagination: true,         //是否显示分页  false:不分页数据格式又不一要
	            pageNumber:2,             //初始化加载第一页，默认第一页,并记录
	            pageSize:5,               //每页显示的数量
	            pageList: [5, 10, 20, 50, 100],       //设置每页显示的数量
	
	            queryParams : function (params) {
	            	params.pageSize=params.limit;
	            	delete params.limit;
	            	var bookSn = $("#searchForm input[name='bookSn']").val();
	            	if(bookSn){
	            		params.bookSn=bookSn;
	            	}
	                return params;
	            },
	         
	            columns: [
	                {
	                    checkbox: true
	                },{
	                    field: 'bookSn',
	                    title:'订单编号'
	                },{
	                    field: 'costPrice',
	                    title:'价格'
	                },{
	                    field: 'number',
	                    title:'数量'
	                },{
	                    field: 'input',
	                    title:'入库数量'
	                },{
	                    field: 'amount',
	                    title:'总价'
	                },{
	                    field: 'productName',
	                    title:'商品'
	                }
	            ],
            responseHandler: function(res) {
            	return {
            		"rows":res.data,
            		"total":res.count
            	}
            }
        });
    });
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
                                   订单明细
            <small>在艺术与梦里，你应该放荡不羁的前行</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="/WMS/"><i class="fa fa-dashboard"></i>主页</a></li>
            <li><a href="JavaScript:history.go(-1)">返回上一页</a></li>
            <li class="active">明细管理</li>
          </ol>
        </section>
 
        <section class="content">
          <div class="row">
                
            <form id="searchForm" action="" onsubmit="return false;">
              <div class="col-xs-2">
                <input type="text" name="bookSn" class="form-control" placeholder="订单编号">
              </div>
              <div class="col-xs-2">
                 <button type="submit" class="btn bg-olive btn-flat">查询</button>
              </div>
            </form>
          </div>
          <table id="bookItem_table"></table>
        </section>
   
      </div>
       <!-- 底部 -->
       <jsp:include page="/WEB-INF/jsp/common/footer.jsp"/>
    
       <!-- 设置 -->
       <jsp:include page="/WEB-INF/jsp/common/setting.jsp"/>
    </div>
  </body>
</html>

