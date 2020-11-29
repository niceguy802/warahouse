<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <jsp:include page="/WEB-INF/jsp/common/common.jsp"/>
    <!-- 引入bootstral-table插件的资源 -->
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bower_components/table/bootstrap-table.css">
    <!-- table插件的资源 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/bower_components/table/bootstrap-table.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/bower_components/table/bootstrap-table-zh-CN.js"></script>
  
    <script type="text/javascript">
    $(function(){
    	var $table=null;
    	 
    	$("#user_table").on("click","button",function(){
    		var $it = $(this);
    		$('#modal-role').data("user_id",$it.data("id"));
    		$('#modal-role').modal('show');
    	});
    	
    	$('#modal-role button[id=btn_select_all]').on("click",function(){
    		//appendTo:追加到的意思
    		$("#ul_all_role > li").appendTo($("#ul_current_role"));
    	});
    	
    	$('#modal-role button[id=btn_unselect_all]').on("click",function(){
    		$("#ul_current_role > li").appendTo($("#ul_all_role"));
    	});
    	$('#modal-role button[id=bind]').on("click",function(){
    		var $roleLi = $("#ul_current_role > li");
    		
    		var length = $roleLi.length;
    		
    		var roleId = []; 
    		for(var i=0;i<length;i++){
    			//console.log($roleLi[i]);
    			//$roleLi[i]//li
    			roleId.push($($roleLi[i]).data("role"));
    		}
    		
    		
    		//发送ajax绑定
    		
    		var userId = $('#modal-role').data("user_id");
    		$.ajax({
    			type:"post",
    			url:"/WMS/users/"+userId+"/roles",
    			data:"role="+roleId.join("&role="),
    			success:function(responseData){  //JsonModel
    				if(responseData.success){
    					//成功了
    					$('#modal-role').modal('hide');
    					
    				}else{
    					alert(responseData.msg);
    					
    				}
    			}
    		});
    		 
    	});
    	
    	//当对话框显示的时候触发该方法,在这里加载所有的角色信息
    	$('#modal-role').on('show.bs.modal', function (e) {
    		var userId = $(this).data("user_id");
    		
    		$.ajax({
    			type:"get",
    			url:"/WMS/roles/list",
    			success:function(responseData){//JsonModel
    				var $ul_all_role = $("#ul_all_role");
    				$ul_all_role.empty();
    			
    				var roles = responseData.data;
    			    var size = roles.length;
    			    for(var i=0;i<size;i++){
    			    	var $li = $('<li data-role='+roles[i].id+'><a href="#">'+roles[i].name+'</a></li>');
    			    	$ul_all_role.append($li);
    			    }
    			    
    			    //立即加载右边的数据
    			    var url = "/WMS/users/"+userId+"/roles";
    	    		$.ajax({
    	    			type:"get",
    	    			url:url,
    	    			success:function(responseData){
    	    				var $ul_current_role = $("#ul_current_role");
    	    				$ul_current_role.empty();
    	    			
    	    				var roles = responseData.data;
    	    			    var size = roles.length;
    	    			    for(var i=0;i<size;i++){
    	    			    	
    	    			    	//将左边的删除掉
    	    			    	$ul_all_role.find("li[data-role='"+roles[i].id+"']").remove();
    	    			    	
    	    			    	var $li = $('<li data-role='+roles[i].id+'><a href="#">'+roles[i].name+'</a></li>');
    	    			    	$ul_current_role.append($li);
    	    			    }
    	    			}
    	    		});
    			}
    		});
        });
    	
    	
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
    				url:"${pageContext.request.contextPath}/users/delete",
    				data:"id="+ids.join("&id="),
    				success:function(data){//data:JsonModel
    					if(data.success){
    						//重新的刷新table
    						$table.bootstrapTable('refresh'); 
    						alert('删除成功');
    					}else{
    						alert(data.msg);
    						alert('删除失败');
    					}
    				}
    			})
    		}else{
    			//编辑
    			window.location.href="/WMS/users/edit?id="+rowValue[0].id;
    			
    		}
    	});
    	
    	$("#searchForm").on("submit",function(){
    		$table.bootstrapTable('refresh'); 
    		return false;
    	})
    	
        var queryURL = "${pageContext.request.contextPath}/users/list"; 
     $table=$('#user_table').bootstrapTable({
            url: queryURL,  //数据的接口地址,ajax请求[请求头:]
            method: 'GET',
            uniqueId: 'id', //绑定ID，不显示
            
            striped: true,  //是否显示行间隔色             
            cache: false,   //是否使用缓存，默认为true                             
            
            sortable: false,//是否启用排序
            sortOrder: "asc",//排序方式                                
            
            sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）      
            undefinedText: '--',
            
            //singleSelect: true,     // 单选checkbox，默认为复选
            //showRefresh   : true,   // 显示刷新按钮
            //showColumns   : true,   // 选择显示的列
    
            toolbar: '#toolbar',      // 工具条         
            pagination: true,         //是否显示分页  false:不分页数据格式又不一要
            pageNumber:1,             //初始化加载第一页，默认第一页,并记录
            pageSize:5,               //每页显示的数量
            pageList: [5, 10, 20, 50, 100],       //设置每页显示的数量

            
            queryParams : function (params) {
            	params.pageSize=params.limit;
            	delete params.limit;
            	var selectType = $("#searchForm select[id='option_select']").val();;
            	if(selectType){
            	    var keyWords = $("#searchForm input[name='keyWords']").val();
            		if(keyWords){
            			params[selectType]=keyWords;
            		}
            	}
                return params;
            },
            columns: [
                {
                    checkbox: true
                },
                {
                    field: 'header',
                    title:'头像',
                    formatter:headerFormatter
                    
                },{
                    field: 'name',
                    title:'用户名',
                    sortable: true
                },{
                    field: 'loginName',
                    title:'账号'
                },{
                    field: 'dept.name',
                    title:'部门'
                },{
                    field: 'status',
                    title:'状态',  
                    formatter:statusFormatter    //进行格式化
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
    
    //参数一:当前这里的值
    //参数二:当前这行的值
    //参数三:第几行
    function statusFormatter(value,row,index){
    	//console.log(value);
    	//console.log(row);
    	//console.log(index);
    	return value==1?"激活":"禁用";
    }
    
    function opeFormatter(value,row,index){
    	return '<div class="btn-group">'+
        '<button type="button" data-id="'+value+'" class="btn btn-flat btn-xs bg-olive" style="margin-left:5px;margin-right:5px;">绑定</button>'+
      '</div>';     
    }
    
    function headerFormatter(value,row,index){
    	
    	return '<img height="40px" src="/WMS/static/'+value+'">';
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
          <div class="row">
                
            <form id="searchForm" action="" onsubmit="return false;">
              <div class="col-xs-2">
                <select id="option_select"  class="form-control">
                   <option value="">请选择查询条件</option>
                   <option value="name">名字</option>
                   <option value="loginName">账号</option>
                </select>
              </div>
              <div class="col-xs-2">
                <input type="text" name="keyWords" class="form-control" placeholder="关键字">
              </div>
              <div class="col-xs-2">
                 <button type="submit" class="btn bg-olive btn-flat">查询</button>
              </div>              
   </form>
            
   
            
          </div>
          <div id="toolbar">
            <div id="toolbar">
              <a href="${pageContext.request.contextPath}/users/add" type="button" class="btn bg-maroon btn-flat">添加</a>
              <!-- data-xx="yy" -->
              <button type="button" data-ope="delete" class="btn bg-olive btn-flat">删除</button>
              <button type="button" data-ope="edit" class="btn bg-orange btn-flat">编辑</button>
            </div>
           </div>
          <table id="user_table"></table>
        </section>
   
      </div>
       <!-- 底部 -->
       <jsp:include page="/WEB-INF/jsp/common/footer.jsp"/>
    
       <!-- 设置 -->
       <jsp:include page="/WEB-INF/jsp/common/setting.jsp"/>
    </div>
    
        
    <div id="modal-role" class="modal fade" tabindex="-1" role="dialog" >
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="gridSystemModalLabel">绑定角色</h4>
          </div>
          <div class="modal-body">
            <div class="row">
              <div class="col-md-5">
              
              <ul id="ul_all_role" class="nav nav-pills nav-stacked">
              </ul>
              
              </div>
              <div class="col-md-2">
                <button type="button" id="btn_select_all" class="btn btn-block btn-success btn-sm">&gt;&gt;</button><br/>
                <button type="button"  id="btn_unselect_all" class="btn btn-block btn-success btn-sm">&lt;&lt;</button>
              </div>
              <div class="col-md-5">
                <ul id="ul_current_role" class="nav nav-pills nav-stacked"></ul>
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="button" id="bind" class="btn btn-primary">绑定</button>
          </div>
        </div>
      </div>
    </div>
    
  </body>
</html>

