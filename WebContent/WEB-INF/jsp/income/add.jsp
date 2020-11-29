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
  
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/dist/plugins/validate/css/bootstrapValidator.min.css">
	<script src="${pageContext.request.contextPath}/static/dist/plugins/validate/js/bootstrapValidator.min.js"></script>
	<script src="${pageContext.request.contextPath}/static/dist/plugins/validate/js/language/zh_CN.js"></script>
    
    <script type="text/javascript">
//     $(function(){
//     $('#form_income').bootstrapValidator({
//         message: 'This value is not valid',
//         feedbackIcons: {
//           valid: 'glyphicon glyphicon-ok',
//           invalid: 'glyphicon glyphicon-remove',
//           validating: 'glyphicon glyphicon-refresh'
//         },
//         fields: {
//         	storeId: {
//             message: '仓库不能为空！',
//             validators: {
//               notEmpty: {
//                 message: '仓库不能为空！'
//               }
//             }
//           }
//         }
//       })
      
//   });

    </script>
    
    <style type="text/css">
      #income_item_table_body .form-group{
        margin-right: 0px;
        margin-left: 0px;
        margin-bottom: 0px;
      }
    </style>
    
    <script type="text/javascript">
        var $bookItemTable = null;
        $(function(){
        	 
        	//监听点击名称input事件
        	$("#income_item_table_body > tr input[id='productName']").on("click",function(){
        		$('#modal_book').modal('show');
        	});
        	
        	//监听删除按钮的事件(删除所在行)
        	$("#delete_income_item").on("click",function(){
        		if($(this).closest("tbody").find("tr").length==1){
        			alert("最后一个不能删除");
        			return;
        		}
        		$(this).closest("tr").remove();
        	});
        	
        	//复制明细行
        	$("#add_income_item").on("click",function(){
        		var $newTr = $("#income_item_table_body tr:first").clone(true);
        		$newTr.appendTo($("#income_item_table_body"));
        		
        		$newTr.find("input[id='productName']").val("");
        		$newTr.find("input[id='id']").val("");
        		$newTr.find("input[id='bookItemId']").val("");
        		$newTr.find("input[name='productPrice']").val("");
        		$newTr.find("input[name='totalCount']").val("");
        		$newTr.find("input[name='productTotalPrice']").val("");
        	});
        	
        	//监听查询事件
        	$("#searchForm").on("submit",function(){
        		createBookItemTable();
        		$bookItemTable.bootstrapTable('refresh'); 
        		return false;
        	});
        	
        	//监听批量入库事件
        	$("#btn_batch_income").on("click",function(){
        		//订单(编号)
        		var bookId = $("#searchForm input[name='book_id']").val();
        		 
        		$("input[name='bookId']").val(bookId);
        		
        		//获取选中的
        		//添加
        		var bookItems = $bookItemTable.bootstrapTable('getAllSelections');
        		var bookItemSize = bookItems.length;
        		for(var i=0;i<bookItemSize;i++){
        			
        			
        			var $idInput = $("#income_item_table_body tr input[value='"+bookItems[i].productId+"']");
        			if($idInput.length==0){
        				
        				//还需要把bookItem的主键获取到并且提交到控制器中
        				
        				
        			    var $newTr = $("#income_item_table_body tr:first").clone(true);
            		    $newTr.appendTo($("#income_item_table_body"));
            		    
            		    $newTr.find("input[id='productName']").val(bookItems[i].productName);
            		    $newTr.find("input[id='id']").val(bookItems[i].productId);
            		    $newTr.find("input[id='bookItemId']").val(bookItems[i].id);
            		    $newTr.find("input[name='productPrice']").val(bookItems[i].costPrice);
            		    $newTr.find("input[name='totalCount']").val(1);
            		    $newTr.find("input[name='productTotalPrice']").val(bookItems[i].costPrice);
        			}else{
        				//合并
        				var $oldTr = $idInput.closest("tr");
        				$oldTr.find("input[name='totalCount']").val(parseInt($oldTr.find("input[name='totalCount']").val())+1);
            		       
        				var totalPrice =parseInt($oldTr.find("input[name='totalCount']").val())*parseInt($oldTr.find("input[name='productPrice']").val());
        				
        				$oldTr.find("input[name='productTotalPrice']").val(totalPrice);
        			}
        		}
        		$('#modal_book').modal('hide');
        		
        		//删除无用
        		var currentTrs = $("#income_item_table_body tr");
        		for(var i=0;i<currentTrs.length;i++){
        			var $tr = $(currentTrs[i]);
        			if(!$tr.find("input[id='id']").val()){
        				$tr.remove();
        			}
        		}
        		
        		
        		var $tre = $("#income_item_table_body > tr");
        		var totalA = 0;
        		var totalC = 0;
        		for(var i=0;i<$tre.length;i++){
        			var tempTotalPrice = parseInt($($tre[i]).find("input[name=productTotalPrice]").val());
        			totalA+=tempTotalPrice;
        			var temoTotalCount = parseInt($($tre[i]).find("input[name=totalCount]").val());
        			totalC+=temoTotalCount
        		}
        		$("#totalAmount").val(totalA);
        		$("#totalCount").val(totalC);
        		//关闭对话框
        		$("#modal_stock").modal("hide");
        	});
        	//监听数量变化事件
        	$("#income_item_table_body > tr:first input[id='number']").on("change",function(){
        		var $it = $(this);
        		var counts = parseInt($it.val());
        		if(!counts || counts<=0){ 
        			$it.val("1");   
        			counts=1;
        		}
        		var price = parseInt($it.closest("tr").find("input[name='productTotalPrice']").val());
        		if(price){
        		    $it.closest("tr").find("input[name='productTotalPrice']").val(counts*price);
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
        	$("#income_item_table_body > tr:first input[id='costPrice']").on("change",function(){
        		var $it = $(this);
        		var danjia = parseInt($it.val());
        		if(!danjia || danjia<=0){ 
        			$it.val("0");   
        			danjia=1;
        		}
        		var num = parseInt($it.closest("tr").find("input[id='number']").val());
        		if(num){
        		    $it.closest("tr").find("input[id='amount']").val(danjia*num);
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
        	
        	//监听表单提交事件
        	$("#form_income").on("submit",function(){
        		
        		//修改请求参数的名字
        		var $trs = $("#income_item_table_body tr");
        		for(var i=0;i<$trs.length;i++){
        			
        			var $tr = $($trs[i]);
        	 
        			$tr.find("input[name='id']").attr("name","incomeItems["+i+"].productId");
        			$tr.find("input[name='bookItemId']").attr("name","incomeItems["+i+"].bookItemId");
        			$tr.find("input[name='totalCount']").attr("name","incomeItems["+i+"].number");
        		}
        		return true;
        	});
        });
        
        
        function createBookItemTable(){
        	if($bookItemTable!=null){
        		return;
        	}
	        var queryURL = "${pageContext.request.contextPath}/bookItems/list"; 
		    $bookItemTable=$('#book_item_table').bootstrapTable({
		            url: queryURL,  //数据的接口地址,ajax请求[请求头:]
		            method: 'GET',
		            uniqueId: 'id', //绑定ID
		            
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
		            	
		            	var bookId = $("#searchForm input[name='book_id']").val();
		            	params.bookId=bookId;
		                return params;
		            },
		            
		            columns: [
		                {
		                    checkbox: true
		                },{
		                    field: 'costPrice',
		                    title:'成本价'
		                },{
		                    field: 'number',
		                    title:'数量'
		                },{
		                    field: 'amount',
		                    title:'总价'
		                },{
		                    field: 'productName',
		                    title:'商品名字'
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
         <section class="content-header">
          <h1>
                                         入库管理
            <small>在艺术与梦里，你应该放荡不羁德前行</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="/WMS/"><i class="fa fa-dashboard"></i>主页</a></li>
            <li><a href="JavaScript:history.go(-1)">返回上一页</a></li>
            <li class="active">添加入库</li>
          </ol>
        </section>
 
        <section class="content">
           <!-- 添加的表单 -->
           <div class="box box-info">
            <div class="box-header with-bincome">
              <h3 class="box-title">添加</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form id="form_income" class="form-horizontal" action="${pageContext.request.contextPath}/incomes/add" method="post">
              <input type="hidden" id="bookId" name="bookId">
              <div class="box-body">
        
                <div class="row">
                <div class="col-sm-6">
                <div class="form-group">
                  <label for="totalAmount" class="col-sm-2 control-label">总金额</label>
                  
                  <div class="col-sm-10">
                    <input  required="required"  type="text" class="form-control" readonly="readonly" id="totalAmount" placeholder="总金额">
                  </div>
                </div>
                </div>
                <div class="col-sm-6">
                <div class="form-group">
                  <label for="totalCount" class="col-sm-2 control-label">总数量</label>
                  <div class="col-sm-10">
                    <input   required="required" type="text" class="form-control" id="totalCount" readonly="readonly" placeholder="总数量">
                  </div>
                </div>   
                </div>
                </div>
                
                <div class="row">
                  <div class="col-sm-6">
                    <div class="form-group">
                      <label for="storeId" class="col-sm-2 control-label">仓库</label>
                      <div class="col-sm-10">
                         <select  required="required"  name="storeId" id="storeId" class="form-control">
                            <option value="">请选择仓库</option>
                            <c:forEach items="${stores}" var="store">
                               <option value="${store.id}">${store.name}</option>
                            </c:forEach>
                         </select>
                      </div>
                    </div>
                  </div>
                  
              <div class="col-sm-6">
                <div class="form-group">
                  <label for="sn" class="col-sm-2 control-label">送货单号</label>
                  <div class="col-sm-10">
                    <input  required="required"  type="text" class="form-control" name="sn" id="sn" placeholder="送货单号">
                  </div>
                </div>   
                </div>
                
                
                </div>
                
                    <!--添加订单明细-->
                    <div class="col-md-12">
                      <div class="col-md-6 ">
                        <div class="form-group">
                          <button type="button" id="add_income_item" class="btn btn-success btn-flat">添加入库明细</button>
                        </div>
                      </div>
                    </div>

                    <div class="col-md-12">
                      <table id="income_item_table" data-toggle="table">
                        <thead>
                          <tr>
                            <th>名称</th>
                            <th>单价</th>
                            <th>数量</th>
                            <th>总价</th>
                            <th>操 作 </th>
                          </tr>
                        </thead>
                        <tbody id="income_item_table_body">
                          <tr>
                            <td>
                              <div class="form-group">
                                <input  required="required"  type="text" id="productName"   class="form-control" placeholder="名称" data-bv-notempty="true"/>
                                <input type="hidden" id="id" name="id"/>
                                <input type="hidden" id="bookItemId" name="bookItemId"/>
                              </div>
                            </td>
                            <td>
                              <div class="form-group">
                                <input  required="required" type="text" name="productPrice"   class="form-control" placeholder="单价" data-bv-notempty="true"/>
                              </div>
                            </td>
                            <td>
                              <div class="form-group">
                                <input  required="required"  type="text" name="totalCount"  class="form-control" placeholder="数量" data-bv-notempty="true"/>
                              </div>
                            </td>
                            <td>
                              <div class="form-group">
                                <input  required="required"  type="text" name="productTotalPrice" readonly="readonly"   class="form-control" placeholder="总价" data-bv-notempty="true"/>
                              </div>
                            </td>
                            <td>
                            <button type="button" id="delete_income_item" class="btn btn-danger btn-flat">删除</button>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                
                 
              </div>   
              <!-- /.box-body -->
              <div class="box-footer" style="margin-top:10px;">
                <button type="reset" class="btn btn-default">重置</button>
                <button type="submit" class="btn btn-info">添加</button>
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
    <div id="modal_book" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myLargeModalLabel">入库操作</h4>
          </div>
          <div class="modal-body">
            <div class="row">
            <form id="searchForm" action="" onsubmit="return false;">
              <div class="col-xs-4">
                <input type="text" name="sn" class="form-control" placeholder="采购编号">
              </div>
              <div class="col-xs-2">
                 <button type="submit" class="btn bg-olive btn-flat">查询</button>
              </div>
            </form>
            </div>
            <div id="bookItemToolbar">
              <button id="btn_batch_income" type="button" class="btn bg-olive btn-flat" style="margin-top:10px;">批量入库</button>
            </div>
            <table id="book_item_table"></table>
          </div>
        </div>
      </div>
    </div>
    
  </body>
</html>

