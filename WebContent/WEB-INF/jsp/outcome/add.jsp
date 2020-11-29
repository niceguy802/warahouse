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
  
    
    <style type="text/css">
      #outcome_item_table_body .form-group{
        margin-right: 0px;
        margin-left: 0px;
        margin-bottom: 0px;
      }
    </style>
    <script type="text/javascript">

   
        var $stockTable=null;
        $(function(){
        	
        	//监听仓库选择事件
        	$("#form_outcome #storeId").on("change",function(){
        		$("#outcome_item_table_body > tr:gt(0)").remove(); //非第一个
        		cleanTr($("#outcome_item_table_body > tr:first"));
        	}); 
        	
        	//监听打开对话框
        	$("#outcome_item_table_body input[id='productName']").on("click",function(){
        		openSelectStock();
        	});
        	//监听删除(删除所在行)
        	$("#outcome_item_table_body #delete_outcome_item").on("click",function(){
        		
        		//判断是否最后一个
        		if($("#outcome_item_table_body tr").length==1){
        			alert("不能删除最后一个");
        			return;
        		}
        		$(this).closest("tr").remove();
        	});
        	
        	//添加一行
        	$("#add_outcome_item").on("click",function(){
        		var $newTr = $("#outcome_item_table_body tr:first").clone(true);
        		cleanTr($newTr);
        		
        		$newTr.appendTo($("#outcome_item_table_body"));
        	});
        	
        	//监听批量出库事件
        	$("#btn_batch_outcome").on("click",function(){

        		//获取选中的
        		//添加
        		var selectedProducts = $stockTable.bootstrapTable('getAllSelections');
        		var length = selectedProducts.length;
        		if(length>0){
	        		for(var i=0;i<length;i++){
                        var product =selectedProducts[i];
                        var $tempIdInput = $("#outcome_item_table_body > tr input[value='"+product.productId+"']");
                        if($tempIdInput.length==1){
        		    		//有了只需要改变数量和金额
        		    		var $oldTr = $tempIdInput.closest("tr");
        		    		var $numberInput = $oldTr.find("input[id=number]")
        		    		$numberInput.val(parseInt($numberInput.val())+1);
        		    		var amountInput = parseInt($oldTr.find("input[id='number']").val())*parseInt($oldTr.find("input[id='salePrice']").val());
        		    		$oldTr.find("input[id='amount']").val(amountInput);
        		    	}
                          else{
                        	//创建一个tr
        		            var $newTr = $("#outcome_item_table_body tr:first").clone(true);
        	        	    $newTr.find("input[id='productName']").val(product.productName);
        	        	    $newTr.find("input[id='productId']").val(product.productId);
        	        	    $newTr.find("input[id='salePrice']").val("");
        	        	    $newTr.find("input[id='number']").val("1");
        	        	    $newTr.find("input[id='amount']").val("");
        	        	    $newTr.appendTo($("#outcome_item_table_body"));
                        }
	        		}
        		}
	            //删除无用的
	            var $allTr = $("#outcome_item_table_body tr");
	            for(var i=0;i<$allTr.length;i++){
	            	if(!($($allTr[i]).find("input[id='productId']").val())){
	            		$allTr[i].remove();
	            	}
	            }  
	            var $tre = $("#outcome_item_table_body > tr");
        		var totalA = 0;
        		var totalC = 0;
        		for(var i=0;i<$tre.length;i++){
        			var tempTotalPrice = parseInt($($tre[i]).find("input[id=amount]").val());
        			totalA+=tempTotalPrice;
        			var temoTotalCount = parseInt($($tre[i]).find("input[id=number]").val());
        			totalC+=temoTotalCount
        		}
        		$("#totalAmount").val(totalA);
        		$("#totalCount").val(totalC);
        		//关闭对话框
        	
        		$("#modal_stock").modal("hide");
        		
        		
        		
        		
        	});
        	
        	//监听数量变化事件
        	$("#outcome_item_table_body > tr:first input[id='number']").on("change",function(){
        	
        		var $it = $(this);
        		var counts = parseInt($it.val());
        		if(!counts || counts<=0){ 
        			$it.val("1");   
        			counts=1;
        		}
        		var price = parseInt($it.closest("tr").find("input[id='salePrice']").val());
        		if(price){
        		    $it.closest("tr").find("input[id='amount']").val(counts*price);
        		}else{
        			$it.val("");   
        		}
        		//当数量改变时，总金额和总数量的改变
        		var $tre = $(this).closest("tbody").find("tr");
        		var totalA = 0;
        		var totalC = 0;
        		for(var i=0;i<$tre.length;i++){
        			var tempTotalPrice = parseInt($($tre[i]).find("input[id=amount]").val());
        			totalA+=tempTotalPrice;
        			var temoTotalCount = parseInt($($tre[i]).find("input[id=number]").val());
        			totalC+=temoTotalCount
        		}
        		$("#totalAmount").val(totalA);
        		$("#totalCount").val(totalC);
        	});
        	
        	//监听单价变化事件
        	$("#outcome_item_table_body > tr:first input[id='salePrice']").on("change",function(){
        		var $it = $(this);
        		var danjia = parseInt($it.val());
        		if(!danjia || danjia<=0){ 
        			$it.val("0");   
        			danjia=1;
        		}
//         		var price = parseInt($it.closest("tr").find("input[id='salePrice']").val());
				var counts =parseInt($it.closest("tr").find("input[id='number']").val());
        		if(counts){
        		    $it.closest("tr").find("input[id='amount']").val(danjia*counts);
        		}else{
        			$it.val("");   
        		}
        		//当数量改变时，总金额和总数量的改变
        		var $tre = $(this).closest("tbody").find("tr");
        		var totalA = 0;
        		var totalC = 0;
        		for(var i=0;i<$tre.length;i++){
        			var tempTotalPrice = parseInt($($tre[i]).find("input[id=amount]").val());
        			totalA+=tempTotalPrice;
        			var temoTotalCount = parseInt($($tre[i]).find("input[id=number]").val());
        			totalC+=temoTotalCount
        		}
        		$("#totalAmount").val(totalA);
        		$("#totalCount").val(totalC);
        	});
        	
        	//监听添加事件
        	$("#form_outcome").on("submit",function(){
        		
        		//修改请求参数
        		var $trs = $("#outcome_item_table_body > tr");
        		var trSize = $trs.length;
        		for(var i=0;i<trSize;i++){
        			var $tr = $($trs[i]);
        			$tr.find("input[id='productId']").attr("name","outcomeItems["+i+"].productId");
        			$tr.find("input[id='number']").attr("name","outcomeItems["+i+"].number");
        			$tr.find("input[id='salePrice']").attr("name","outcomeItems["+i+"].salePrice");
        		}
        		return true;
        	});
        });
        function openSelectStock(){
        	//获取仓库的信息
        	var storeId = $("#form_outcome #storeId").val();
        	console.log(storeId)
        		//弹出选择指定仓库下的库存信息
        		$("#modal_stock").modal("show");
        		
        		if($stockTable==null){
        			//创建stockeTable
        	        var queryURL = "${pageContext.request.contextPath}/stocks/list"; 
        	        $stockTable=$('#stock_table').bootstrapTable({
        	            url: queryURL,  //数据的接口地址,ajax请求[请求头:]
        	            method: 'GET',
        	            uniqueId: 'id', //绑定ID，不显示
        	            
        	            striped: true,  //是否显示行间隔色             
        	            cache: false,   //是否使用缓存，默认为true                             
        	            
        	            sortable: false,//是否启用排序
        	            sortOrder: "asc",//排序方式                                
        	            
        	            sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）      
        	            undefinedText: '--',
        	    
        	            toolbar: '#outcomeItemToolbar',      // 工具条         
        	            pagination: true,         //是否显示分页  false:不分页数据格式又不一要
        	            pageNumber:1,             //初始化加载第一页，默认第一页,并记录
        	            pageSize:5,               //每页显示的数量
        	            pageList: [5, 10, 20, 50, 100],       //设置每页显示的数量

        	            queryParams : function (params) {
        	            	params.pageSize=params.limit;
        	            	delete params.limit;
        	            	 
        	            	//添加仓库条件  
        	            	var productId = $("#searchForm input[name='productId']").val();
    		            	params.productId=productId; 
        	            	params.storeId=$("#form_outcome #storeId").val();
        	                return params;
        	            },
        	            columns: [
        	                {
        	                    checkbox: true
        	                },{
        	                    field: 'storeCount',
        	                    title:'库存数量'
        	                },{
        	                    field: 'productName',
        	                    title:'商品名字'
        	                },{
        	                    field: 'productId',
        	                    title:'商品Id'
        	                },{
        	                    field: 'storeId',
        	                    title:'仓库Id'
        	                }
        	            ],
        	            responseHandler: function(res) {
        	            	return {
        	            		"rows":res.data,
        	            		"total":res.count
        	            	}
        	            }
        	        });
        		}else{
        			//执行刷新table操作
        			$stockTable.bootstrapTable('refresh'); 
        		}
        	
        }    
        
        
        //清空tr下的input值
        function cleanTr(tr){
        	tr.find("input[id='productName']").val("");
        	tr.find("input[id='productId']").val("");
        	tr.find("input[id='salePrice']").val("");
        	tr.find("input[id='number']").val("");
        	tr.find("input[id='amount']").val("");
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
                        添加销售出库单
            <small>在艺术与梦里，你应该放荡不羁的前行</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 主页</a></li>
            <li><a href="#">返回上一页</a></li>
            <li class="active">销售出库单</li>
          </ol>
        </section>
 
        <section class="content">
           <!-- 添加的表单 -->
           <div class="box box-info">
            <div class="box-header with-boutcome">
              <h3 class="box-title">销售出库单</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form id="form_outcome" class="form-horizontal" action="${pageContext.request.contextPath}/outcomes/add" method="post">
              <input type="hidden" id="bookId" name="bookId">
              <div class="box-body">
        
                <div class="row">
                <div class="col-sm-6">
                <div class="form-group">
                  <label for="totalAmount" class="col-sm-2 control-label">总金额</label>
                  
                  <div class="col-sm-10">
                    <input required="required" type="text" class="form-control" readonly="readonly" id="totalAmount" name="totalAmount" placeholder="总金额">
                  </div>
                </div>
                </div>
                <div class="col-sm-6">
                <div class="form-group">
                  <label for="totalCount" class="col-sm-2 control-label">总数量</label>
                  <div class="col-sm-10">
                    <input  required="required" type="text" class="form-control" id="totalCount" name="totalCount" readonly="readonly" placeholder="总数量">
                  </div>
                </div>   
                </div>
                </div>
                
                <div class="row">
                
                
                  <div class="col-sm-6">
                    <div class="form-group">
                      <label for="clientId" class="col-sm-2 control-label">客户</label>
                      <div class="col-sm-10">
                         <select name="clientId" id="clientId" class="form-control"  required="required">
                            <option value="">请选择客户</option>
                            <c:forEach items="${clients}" var="client">
                               <option value="${client.id}">${client.name}</option>
                            </c:forEach>
                         </select>
                      </div>
                    </div>
                  </div>
                 <div class="col-sm-6">
                    <div class="form-group">
                      <label for="outcomeSN" class="col-sm-2 control-label">出货单号</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" name="outcomeSN" id="outcomeSN" placeholder="出货单号"  required="required">
                      </div>
                    </div>   
                 </div>
                </div>
                
                <div class="row">
                
                
                  <div class="col-sm-6">
                    <div class="form-group">
                      <label for="storeId" class="col-sm-2 control-label">仓库</label>
                      <div class="col-sm-10">
                         <select name="storeId" id="storeId" class="form-control"  data-bv-notempty="true"  required="required">
                            <option value="">请选择仓库</option>
                            <c:forEach items="${stores}" var="store">
                               <option value="${store.id}">${store.name}</option>
                            </c:forEach>
                         </select>
                      </div>
                    </div>
                  </div>
                </div>
                </div>
                
                    <!--添加订单明细-->
                    <div class="col-md-12">
                      <div class="col-md-6 ">
                        <div class="form-group">
                          <button type="button" id="add_outcome_item" class="btn btn-success btn-flat">添加销售明细</button>
                        </div>
                      </div>
                    </div>

                    <div class="col-md-12">
                      <table id="outcome_item_table" data-toggle="table">
                        <thead>
                          <tr>
                            <th>名称</th>
                            <th>单价</th>
                            <th>数量</th>
                            <th>总价</th>
                            <th>操 作 </th>
                          </tr>
                        </thead>
                        <tbody id="outcome_item_table_body">
                          <tr>
                            <td>
                              <div class="form-group">
                                <input required="required" type="text" id="productName" name="productName"   class="form-control" placeholder="名称" data-bv-notempty="true"/>
                                <input type="hidden" id="productId" name="productId"/>
                              </div>
                            </td>
                            <td>
                              <div class="form-group">
                                <input  required="required" type="text" id="salePrice"  name="salePrice" class="form-control" placeholder="销售单价" data-bv-notempty="true"/>
                              </div>   
                            </td>
                            <td>
                              <div class="form-group">
                                <input   required="required" type="text" id="number" name="number"  class="form-control" placeholder="数量" data-bv-notempty="true"/>
                              </div>
                            </td>
                            <td>
                              <div class="form-group">
                                <input  required="required" type="text" id="amount" name="amount" readonly="readonly"   class="form-control" placeholder="总价" data-bv-notempty="true"/>
                              </div>
                            </td>
                            <td>
                            <button type="button" id="delete_outcome_item" class="btn btn-danger btn-flat">删除</button>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                
                 
              </div>   
              <!-- /.box-body -->
              <div class="box-footer" style="margin-top:155px;">
                <button type="reset" class="btn btn-default">重置</button>
                <button type="submit" class="btn btn-info"  id="add_btn">添加</button>
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
    <script src="${pageContext.request.contextPath}/static/dist/plugins/validate/js/bootstrapValidator.min.js"></script>
   
    
    <!-- 选择名称对话框 -->
    <div id="modal_stock" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myLargeModalLabel">销售出库操作</h4>
          </div>
          <div class="modal-body">
            <div class="row">
            <form id="searchForm" action="" onsubmit="return false;">
              <div class="col-xs-4">
                <input type="text" name="productId" class="form-control" placeholder="商品名字">
              </div>
              <div class="col-xs-2">
                 <button type="submit" class="btn bg-olive btn-flat">查询</button>
              </div>
            </form>
            </div>
            <div id="outcomeItemToolbar" style="margin-top:10px;">
              <button id="btn_batch_outcome" type="button" class="btn bg-olive btn-flat">批量销售出库</button>
            </div>
            <table id="stock_table"></table>
          </div>
        </div>
      </div>
    </div>
    
  </body>
</html>

