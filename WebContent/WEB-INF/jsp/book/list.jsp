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
       	$('#book_table').on("click","button",function(){
       		var bookId = $(this).data("id");
       		$.ajax({
       			type:"get",
       			url:"/WMS/books/"+bookId+"/status/pass",
       			success:function(data){
       				if(data.success){
       					//刷新table
       					$table.bootstrapTable('refresh'); 
       				}else{
       					alert(data.msg);
       				}
       			}
       			
       		})
       	});
    	$("#toolbar button").on("click",function(){
    		var $it = $(this);  
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
    			$.ajax({
    				type:"post",
    				url:"${pageContext.request.contextPath}/books/delete",
    				data:"id="+ids.join("&id="),
    				success:function(data){
    					if(data.success){
    						//重新的刷新table
    						$table.bootstrapTable('refresh'); 
    						alert("删除成功！");
    					}else{
    						alert(data.msg);
    					}
    				}
    			})
    		}
    	});
    	
    	$("#searchForm").on("submit",function(){
    		$table.bootstrapTable('refresh'); 
    		return false;
    	})
    	
        var queryURL = "${pageContext.request.contextPath}/books/list"; 
     $table=$('#book_table').bootstrapTable({
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
            pageSize:5,               //每页显示的数量
            pageList: [5, 10, 20, 50, 100],       //设置每页显示的数量

            queryParams : function (params) {
            	params.pageSize=params.limit;
            	delete params.limit;
            	var bookSn = $("#searchForm input[name='sn']").val();
            	if(bookSn){
            		params.sn=bookSn;
            	}
                return params;
            },
	            columns: [
	                {
	                    checkbox: true
	                },{
	                    field: 'sn',
	                    title:'编号'
	                },{
	                    field: 'totalAmount',
	                    title:'总金额'
	                },{
	                    field: 'totalCount',
	                    title:'总数量'
	                },{
	                    field: 'createDate',
	                    title:'创建时间'
	                },{
	                    field: 'makeUserId',
	                    title:'下单人'
	                },{
	                    field: 'supplierId',
	                    title:'供应商'
	                },{
	                    field: 'status',
	                    title:'状态',
	                    formatter:statusFormatter
	                },{
	                	width:'200px',
	                    field: 'xxx',  
	                    title:'操作',
	                    formatter:opeFormatter
	                }
	            ],
            responseHandler: function(res) {
            	//{“rows”:数据,”total”:总的记录数}
            	return {
            		"rows":res.data,
            		"total":res.count
            	}
            }
        });
    });
    
    function statusFormatter(value,row,index){
    	if(value==0){
    		return "未审核";
    	}else if(value==1){
    		return "已审核";
    	}else{
    		return "已完成";
    	}
    }
    
    function opeFormatter(value,row,index){
    	if(row.status==0){
    	    return '<button type="button" data-id="'+row.id+'" class="btn btn-flat btn-xs bg-olive">审核</button>';
    	}else{
    		return "--";
    	}
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
                                        订单中心
            <small>在艺术与梦里，你应该放荡不羁德前行</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="/WMS/"><i class="fa fa-dashboard"></i>主页</a></li>
            <li><a href="JavaScript:history.go(-1)">返回上一页</a></li>
            <li class="active">订单管理</li>
          </ol>
        </section>
 
        <section class="content">
          <div class="row">
                
            <form id="searchForm" action="" onsubmit="return false;">
              <div class="col-xs-2">
                <input type="text" name="sn" class="form-control" placeholder="订单编号">
              </div>
              <div class="col-xs-2">
                 <button type="submit" class="btn bg-olive btn-flat">查询</button>
              </div>
            </form>
          </div>
          <div id="toolbar">
            <div id="toolbar">
              <a href="${pageContext.request.contextPath}/books/add" type="button" class="btn bg-maroon btn-flat">添加</a>
              <button type="button" data-ope="delete" class="btn bg-olive btn-flat">删除</button>
            </div>
           </div>
          <table id="book_table"></table>
        </section>
   
      </div>
       <!-- 底部 -->
       <jsp:include page="/WEB-INF/jsp/common/footer.jsp"/>
    
       <!-- 设置 -->
       <jsp:include page="/WEB-INF/jsp/common/setting.jsp"/>
    </div>
  </body>
</html>

