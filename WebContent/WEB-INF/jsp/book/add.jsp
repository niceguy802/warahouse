<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <jsp:include page="/WEB-INF/jsp/common/common.jsp"/>
    
    <!-- 引入bootstral-table插件的资源 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bower_components/table/bootstrap-table.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/bower_components/table/bootstrap-table.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/bower_components/table/bootstrap-table-zh-CN.js"></script>
  	<!-- 引入bootstral-validate的资源 -->
  	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/dist/plugins/validate/css/bootstrapValidator.min.css">
	<script src="${pageContext.request.contextPath}/static/dist/plugins/validate/js/bootstrapValidator.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/dist/plugins/validate/js/language/zh_CN.js"></script>
    
     <style type="text/css">
      #order_item_table_body .form-group{
        margin-right: 0px;
        margin-left: 0px;
        margin-bottom: 0px;
      }
    </style>
    
    <script type="text/javascript">
    
    $(function(){
    	//校验
        $('#form_order').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
              valid: 'glyphicon glyphicon-ok',
              invalid: 'glyphicon glyphicon-remove',
              validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
            	supplierId: {
                message: '供应商不能为空',
                validators: {
                  notEmpty: {
                    message: '供应商不能为空'
                  }
                }
              }
            }
          })
      });
        $(function(){
        	
        	//监听表单提交事件
        	$("#form_order").on("submit",function(){
        		
        		//处理参数名字
        		var $trs = $("#order_item_table_body > tr");
        		var trSize = $trs.length;
        		for(var i=0;i<trSize;i++){
        			var $tr = $($trs[i]);
        			$tr.find("input[name='id']").attr("name","bookItems["+i+"].productId");
        			$tr.find("input[name='totalCount']").attr("name","bookItems["+i+"].number");
        		}
        		return true;
        	});
        	
        	var $productTable=null;
        	
        	//监听批量下单点击事件
            $("#btn_batch_order").on("click",function(){
            	
           	//获取选中的商品
           	//添加table中
       		var rowValue = $productTable.bootstrapTable('getAllSelections');
       		var length = rowValue.length;
       		if(length!=0){
        		    //添加table中
       		    for(var i=0;i<length;i++){
       		    	var product = rowValue[i];
       		    	//先判断有没有,如果有的话修改数量,没有的话添加新的
       		    	
       		    	var $tempIdInput = $("#order_item_table_body > tr input[value='"+product.id+"']");
       		    	
       		    	if($tempIdInput.length==1){
       		    		//存在了
       		    		var $totalCountInput = $tempIdInput.closest("tr").find("input[name=totalCount]")
       		    		$totalCountInput.val(parseInt($totalCountInput.val())+1);
       		    		
       		    	}else{
        		    	//遍历一次--->创建TR
                		var $newTr = $("#order_item_table_body > tr:first").clone(true);
                		$newTr.appendTo($("#order_item_table_body"));
                		$newTr.find("input[name='productName']").val(product.name);
                		$newTr.find("input[name='id']").val(product.id);
                		$newTr.find("input[name='num']").val(product.sn);
                		$newTr.find("input[name='productPrice']").val(product.costPrice);
                		$newTr.find("input[name='totalCount']").val(1);
                		$newTr.find("input[name='productTotalPrice']").val(product.costPrice);
       		    	}     		    	
       		    }
        		    
        			//删除无用的TR
        			var $currentTr = $("#order_item_table_body > tr");
        			var currentLength = $currentTr.length;
        			for(var i=0;i<currentLength;i++){
        				var $tempTr = $($currentTr[i]);
        				
        				if(!$tempTr.find("input[name='id']").val()){
        					$tempTr.remove();
        				}
        			}
        		}
        		
        		//选中物品后修改总数量和总金额
        		var $trs=$("#order_item_table_body").find("tr");
        		var totalPrice=0;
        		for(var i=0;i<$trs.length;i++){
        			var $tr = $($trs[i]);
        			var tempTotalPrice = parseInt($tr.find("input[name='productPrice']").val())*parseInt($tr.find("input[name='totalCount']").val());
        			totalPrice+=tempTotalPrice;    
        		}
        		$("#totalAmount").val(totalPrice);
        		
        		var totalCount=0;
        		for(var i=0;i<$trs.length;i++){
        			var $tr = $($trs[i]);
        			var tempTotalCount = parseInt($tr.find("input[name='totalCount']").val());
        			totalCount+=tempTotalCount;    
        		}
        		$("#totalCount").val(totalCount);
        		
        		$('#modal_product').modal('hide');
            });
        	
        	$("#searchForm").on("submit",function(){
        		$productTable.bootstrapTable('refresh'); 
        		return false;
        	});
        	
        	//监听数量变化事件
        	$("#order_item_table_body > tr:first input[name='totalCount']").on("change",function(){
        		
        		var $it = $(this);
        		var count = parseInt($it.val());
        		if(!count || count<=0){  
        			$it.val("1");   
        			count=1;
        		}
        		var price = parseInt($it.closest("tr").find("input[name='productPrice']").val());
        		
        		if(price){
        		    $it.closest("tr").find("input[name='productTotalPrice']").val(count*price);
        		}else{
        			$it.val("");   
        		}
        		
        		var $trs=$(this).closest("tbody").find("tr");
        		
        		//总金额
        		var totalPrice=0;
        		for(var i=0;i<$trs.length;i++){
        			var $tr = $($trs[i]);
        			var tempTotalPrice = parseInt($tr.find("input[name='productTotalPrice']").val());
        			totalPrice+=tempTotalPrice;    
        		}
        		$("#totalAmount").val(totalPrice);
        		
        		//总数量
        		var totalCount=0;
        		for(var i=0;i<$trs.length;i++){
        			var $tr = $($trs[i]);
        			var tempTotalCount = parseInt($tr.find("input[name='totalCount']").val());
        			totalCount+=tempTotalCount;    
        		}
        		$("#totalCount").val(totalCount);
        	});
        	
        	$("#order_item_table_body > tr:first input[name='productName']").on("click",function(){
       		$('#modal_product').modal('show');
       		
       		if($productTable==null){
       	        var queryURL = "${pageContext.request.contextPath}/products/list"; 
       		     $productTable=$('#product_table').bootstrapTable({
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
       		                },{
       		                    field: 'name',
       		                    title:'名字'
       		                },{
       		                    field: 'sn',
       		                    title:'编号'
       		                },{
       		                    field: 'costPrice',
       		                    title:'成本价'
       		                },{
       		                    field: 'salePrice',
       		                    title:'销售价'
       		                },{
       		                    field: 'img',
       		                    title:'图片',
       		                    formatter:imgFormatter
       		                }
       		            ],
       		            responseHandler: function(res) {
       		            	return {
       		            		"rows":res.data,
       		            		"total":res.count
       		            	}
       		            }
       		        });
       		   }
       	});
        	
        	$("#order_item_table_body > tr:first button[id='delete_order_item']").on("click",function(){
        		var $it = $(this);  //事件源
        		//如果是最后一个tr不应该删除
        		var trCount = $("#order_item_table_body > tr").length;
        		if(trCount==1){
        			alert("这是最后一个不能再删除");
        		}else{
        		    var $tr = $it.closest("tr");  //一直往上找,直到找到为止
        		    $tr.remove();//自我删除
        		}
        		
        		//选中物品后修改总数量和总金额
        		var $trs=$("#order_item_table_body").find("tr");
        		var totalPrice=0;
        		for(var i=0;i<$trs.length;i++){
        			var $tr = $($trs[i]);
        			var tempTotalPrice = parseInt($tr.find("input[name='productPrice']").val())*parseInt($tr.find("input[name='totalCount']").val());
        			totalPrice+=tempTotalPrice;    
        		}
        		$("#totalAmount").val(totalPrice);
        		
        		var totalCount=0;
        		for(var i=0;i<$trs.length;i++){
        			var $tr = $($trs[i]);
        			var tempTotalCount = parseInt($tr.find("input[name='totalCount']").val());
        			totalCount+=tempTotalCount;    
        		}
        		$("#totalCount").val(totalCount);
        	});
        	
        	//添加明细
        	$("#add_order_item").on("click",function(){
        		var $newTr = $("#order_item_table_body > tr:first").clone(true);
        		//将原来的数据清除掉
                $newTr.find("input[name='productName']").val("");
                $newTr.find("input[name='id']").val("");
                $newTr.find("input[name='num']").val("");
                $newTr.find("input[name='productPrice']").val("");
                $newTr.find("input[name='totalCount']").val("");
                $newTr.find("input[name='productTotalPrice']").val("");
        		$newTr.appendTo($("#order_item_table_body"));
        	});
        });
        function imgFormatter(value,row,index){
        	return '<img height="40px" src="/WMS/static/'+value+'">';     
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
                                         订单管理
            <small>在艺术与梦里，你应该放荡不羁的前行</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="/WMS/"><i class="fa fa-dashboard"></i>主页</a></li>
            <li><a href="JavaScript:history.go(-1)">返回上一页</a></li>
            <li class="active">添加订单</li>
          </ol>
        </section>
 
        <section class="content">
           <!-- 添加的表单 -->
           <div class="box box-info">
            <div class="box-header with-border">
             <h3 class="box-title">添加订单</h3>
           </div>
             
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form id="form_order" class="form-horizontal" action="${pageContext.request.contextPath}/books/add" method="post">
              <div class="box-body">
        
                <div class="row">
                <div class="col-sm-6">
                <div class="form-group">
                  <label for="totalAmount" class="col-sm-2 control-label">总金额</label>
                  
                  <div class="col-sm-10">
                    <input type="text" class="form-control" readonly="readonly" id="totalAmount" placeholder="总金额">
                  </div>
                </div>
                </div>
                <div class="col-sm-6">
                <div class="form-group">
                  <label for="totalCount" class="col-sm-2 control-label">总数量</label>
                  <div class="col-sm-10">
                    <input type="text" class="form-control" id="totalCount" readonly="readonly" placeholder="总数量">
                  </div>
                </div>   
                </div>
                </div>
                
                <div class="row">
                <div class="col-sm-6">
                <div class="form-group">
                  <label for="supplierId" class="col-sm-2 control-label">供应商</label>
                  <div class="col-sm-10">
                     <select name="supplierId" id="supplierId" class="form-control">
                        <option value="">请选择供应商</option>
                        <c:forEach items="${suppliers}" var="supplier">
                           <option value="${supplier.id}">${supplier.name}</option>
                        </c:forEach>
                     </select>
                  </div>
                </div>
                </div>
                </div>
                
                  <!--添加订单明细-->
                  <div class="col-md-12">
                    <div class="col-md-6 ">
                      <div class="form-group">
                        <button type="button" id="add_order_item" class="btn btn-success btn-flat">添加明细</button>
                      </div>
                    </div>
                  </div>

                  <div class="col-md-12">
                    <table id="order_item_table" data-toggle="table">
                      <thead>
                        <tr>
                          <th>名称</th>
                          <th>编号</th>
                          <th>单价</th>
                          <th>数量</th>
                          <th>总价</th>
                          <th>操 作 </th>
                        </tr>
                      </thead>
                      <tbody id="order_item_table_body">
                        <tr>
                          <td>
                            <div class="form-group">
                              <input type="text" name="productName" readonly="readonly" class="form-control" placeholder="名称" data-bv-notempty="true"/>
                              <input type="hidden" name="id"/>
                            </div>
                          </td>
                          <td>
                            <div class="form-group">
                              <input type="text" name="num" readonly="readonly" class="form-control" placeholder="编号" data-bv-notempty="true"/>
                            </div>
                          </td>
                          <td>
                            <div class="form-group">
                              <input type="text" name="productPrice" readonly="readonly"  class="form-control" placeholder="单价" data-bv-notempty="true"/>
                            </div>
                          </td>
                          <td>
                            <div class="form-group">
                              <input type="text" name="totalCount"  class="form-control" placeholder="数量" data-bv-notempty="true"/>
                            </div>
                          </td>
                          <td>
                            <div class="form-group">
                              <input type="text" name="productTotalPrice" readonly="readonly"   class="form-control" placeholder="总价" data-bv-notempty="true"/>
                            </div>
                          </td>
                          <td>
                          <button type="button" id="delete_order_item" class="btn btn-danger btn-flat">删除</button>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                   </div>   
              <!-- /.box-body -->
              <div class="box-footer" style="margin-top:10px;">
                <button type="reset" class="btn btn-default" style="margin-top:15px">重置</button>
                <button type="submit" class="btn btn-info" style="margin-top:15px">添加</button>
              </div>
              <!-- /.box-footer -->
            </form>
          </div>
        </section>
      </div>
       <!-- 底部 -->
       <jsp:include page="/WEB-INF/jsp/common/footer.jsp"/>
    
       <!-- 设置 -->
       <jsp:include page="/WEB-INF/jsp/common/setting.jsp"/>
    </div>
    
    <!-- 选择名称对话框 -->
    <div id="modal_product" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myLargeModalLabel">请选择名称</h4>
          </div>
          <div class="modal-body">
            <div class="row ">
            <form id="searchForm" action="" onsubmit="return false;">
              <div class="col-xs-2">
                <select id="option_select"  class="form-control">
                   <option value="">请选择查询条件</option>
                   <option value="name">名字</option>
                   <option value="sn">编号</option>
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
            <div id="productToolbar">
              <button id="btn_batch_order" type="button" class="btn bg-olive btn-flat" style="margin-top:15px">批量下单</button>
            </div>
            <table id="product_table"></table>
          </div>
        </div>
      </div>
    </div>
    
  </body>
</html>

