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
    	
    	//监听table中的name列的点击事件(事件的传递)
    	$("#dept_table").on("click","a",function(){
    		//DOM对象-->  ${dom对象}  -->Jquery对象
    		                        //很多方法
    		                            //data("dept");  //获取的是元素  data-dept="具体指"
    		
    		var deptId = $(this).data("dept");
    		//刷新table的数据
    		$table.bootstrapTable('refresh',{query:{"parentId":deptId}});
    	});
    	
    	 
    	$("#dept_table").on("click","button",function(){
    		var $it = $(this);
    		//data-id="'+value+'" data-parent="'+row.parentId+'"
    		var deptId = $it.data("id");
    		var parentId = $it.data("parent");
    		//删除
    		$.ajax({
    			type:"post",
    			url:"/WMS/depts/delete",
    			data:"id="+deptId,
    			success:function(respData){
    				if(respData.success){
    					$table.bootstrapTable('refresh',{query:{"parentId":parentId}});
    				}else{
    					alert(respData.msg);
    				}
    			}
    		})
    		 
    	});
    	
    	
    	
    	$("#searchForm").on("submit",function(){
    		$table.bootstrapTable('refresh'); 
    		return false;
    	})
    	
        var queryURL = "${pageContext.request.contextPath}/depts/list"; 
        $table=$('#dept_table').bootstrapTable({
            url: queryURL, 
            method: 'GET',
            uniqueId: 'id',
            
            striped: true,   
            cache: false,                           
            
            sortable: false,
            sortOrder: "asc",                       
            
            sidePagination: "server", 
            undefinedText: '--',
            pagination: true, 
            pageNumber:1, 
            pageSize:5, 
            pageList: [5, 10, 20, 50, 100], 
            
            //boostrap-table每次加载数据都会触发该方法,在这里添加上查询条件
            queryParams : function (params) {
            	params.pageSize=params.limit;
            	
            	var deptName = $("#searchForm input[name='name']").val();
            	if(deptName){
               	    params.name=deptName;
            	}
                return params;
            },
            columns: [
                {
                    checkbox: true
                },{
                    field: 'name',
                    title:'名字',
                    sortable: true,
                    formatter:nameFormatter
                },{
                	width:'200px',
                    field: 'id',  
                    title:'操作',
                    formatter:opeFormatter
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
    
    function nameFormatter(value,row,index){
    	return "<a href='javascript:;' data-dept='"+row.id+"'>"+value+"</a>";
    }
    
    function opeFormatter(value,row,index){
    	return '<div class="btn-group">'+
        '<a href="/WMS/depts/add?parentId='+value+'" type="button" class="btn btn-flat btn-xs bg-maroon">添加</a>'+  
        '<button type="button" data-id="'+value+'" data-parent="'+row.parentId+'" class="btn btn-flat btn-xs bg-olive" style="margin-left:5px;margin-right:5px;">删除</button>'+
        '<a href="/WMS/depts/edit?id='+value+'" type="button" class="btn btn-flat btn-xs  bg-orange">编辑</a>'+
      '</div>';     
    }
    
    function myFunction(){
    	
    	return window.location.href="/WMS";
    	
    }
    
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
            <button class="btn bg-maroon btn-flat" onclick="myFunction()">返回主页</button>
            <small>it all starts here</small>
           
          </h1>
          <ol class="breadcrumb">
            <li><a href="${pageContext.request.contextPath}/users/listUI"><i class="fa fa-circle-o"></i>用户管理</a></li>
        <li><a href="${pageContext.request.contextPath}/depts/listUI"><i class="fa fa-circle-o"></i>部门管理</a></li>
        <li><a href="${pageContext.request.contextPath}/roles/listUI"><i class="fa fa-circle-o"></i>角色管理</a></li>
          </ol>
        </section>
 
        <section class="content">
          <div class="row" style="margin-bottom: 10px;">
                
            <form id="searchForm" action="" onsubmit="return false;">
              <div class="col-xs-2">
                <input type="text" name="name" class="form-control" placeholder="部门">
              </div>
              <div class="col-xs-2">
                 <button type="submit" class="btn bg-olive btn-flat">查询</button>
              </div>   
            </form>
          </div>
    <!--       <a href="/WMS/depts/add?parentId='+value+'" type="button"  class="btn bg-maroon btn-flat">添加</a> -->
          
          <div id="toolbar">
            <div id="toolbar">
              
            
              <!-- data-xx="yy" -->
              
              
            </div>
           </div>
          
          <table id="dept_table"></table>
        </section>
   
      </div>
       <!-- 底部 -->
       <jsp:include page="/WEB-INF/jsp/common/footer.jsp"/>
    
       <!-- 设置 -->
       <jsp:include page="/WEB-INF/jsp/common/setting.jsp"/>
    </div>
    
  </body>
</html>

