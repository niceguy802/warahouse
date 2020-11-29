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
    	
    	//监听
    	$("#toolbar button").on("click",function(){
    		
    		//this 代表dom 对象
    		//$(this) 将dom对象变成jquery对象
    		
    		var $it = $(this);  //
    		var ope = $it.data("ope");
    		var rowValue = $table.bootstrapTable('getAllSelections');
    		var length = rowValue.length;
    		if(length==0){
    		    alert("至少选择一条记录");
    	        return;
    		}
    		
    		if(ope=="delete"){
    			var ids = [];
    			for(var i=0;i<length;i++){
    				ids.push(rowValue[i].id);
    			}
    			
    			//join("拼接符")
    			//var idParams = ids.join("&id=");
    			$.ajax({
    				type:"post",
    				url:"${pageContext.request.contextPath}/suppliers/delete",
    				data:"id="+ids.join("&id="),
    				success:function(data){//data:JsonModel
    					if(data.success){
    						//重新的刷新table
    						$table.bootstrapTable('refresh'); 
    					}else{
    						alert(data.msg);
    					}
    				}
    			})
    		}else{
    			//编辑
    			window.location.href="/WMS/suppliers/edit?id="+rowValue[0].id;
    		}
    	});
    	
    	$("#searchForm").on("submit",function(){
    		$table.bootstrapTable('refresh'); 
    		return false;
    	})
    	
        var queryURL = "${pageContext.request.contextPath}/suppliers/list"; 
     $table=$('#supplier_table').bootstrapTable({
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
            pageNumber:1,             //初始化加载第一页，默认第一页,并记录
            pageSize:3,               //每页显示的数量
            pageList: [3, 10, 20, 50, 100],       //设置每页显示的数量

            queryParams : function (params) {
            	//携带查询条件中的角色名
            	params.pageSize=params.limit;
            	delete params.limit;
            	var supplierName = $("#searchForm input[name='name']").val();
            	if(supplierName){
            		params.name=supplierName;
            	}
                return params;
            },
            columns: [
                {
                    checkbox: true
                },{
                    field: 'name',
                    title:'名字',
                    sortable: true
                },{
                    field: 'phone',
                    title:'电话',
                    sortable: true
                },{
                    field: 'address',
                    title:'地址',
                    sortable: true
                }
            ],
            onLoadSuccess: function () {
            },
            onLoadError: function () {
                alert("数据加载失败！");
            },
            responseHandler: function(res) {
            	//{“rows”:数据,”total”:总的记录数}
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
                                       厂商管理
            <small>在艺术与梦里，你应该放荡不羁的前行</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="/WMS/"><i class="fa fa-dashboard"></i>主页</a></li>
            <li><a href="JavaScript:history.go(-1)">返回上一页</a></li>
            <li class="active">厂商管理</li>
          </ol>
        </section>
 
        <section class="content">
          <div class="row">
                
            <form id="searchForm" action="" onsubmit="return false;">
              <div class="col-xs-2">
                <input type="text" name="name" class="form-control" placeholder="名字">
              </div>
              <div class="col-xs-2">
                 <button type="submit" class="btn bg-olive btn-flat">查询</button>
              </div>
            </form>
          </div>
          <div id="toolbar">
            <div id="toolbar">
              <a href="${pageContext.request.contextPath}/suppliers/add" type="button" class="btn bg-maroon btn-flat">添加</a>
              <button type="button" data-ope="delete" class="btn bg-olive btn-flat">删除</button>
              <button type="button" data-ope="edit" class="btn bg-orange btn-flat">编辑</button>
            </div>
           </div>
          <table id="supplier_table"></table>
        </section>
   
      </div>
       <!-- 底部 -->
       <jsp:include page="/WEB-INF/jsp/common/footer.jsp"/>
    
       <!-- 设置 -->
       <jsp:include page="/WEB-INF/jsp/common/setting.jsp"/>
    </div>
    
    
  </body>
</html>

