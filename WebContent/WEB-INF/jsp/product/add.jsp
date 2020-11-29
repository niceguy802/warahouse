<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <jsp:include page="/WEB-INF/jsp/common/common.jsp"/>
  </head>

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/dist/plugins/validate/css/bootstrapValidator.min.css">
 
    <script src="${pageContext.request.contextPath}/static/dist/plugins/validate/js/bootstrapValidator.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/dist/plugins/validate/js/language/zh_CN.js"></script>
    
    <script type="text/javascript">
        $(function(){
        	$('#product-form').bootstrapValidator({
        	      message: 'This value is not valid',
        	      feedbackIcons: {
        	        valid: 'glyphicon glyphicon-ok',
        	        invalid: 'glyphicon glyphicon-remove',
        	        validating: 'glyphicon glyphicon-refresh'
        	      },
        	      fields: {
        	        name: {
        	          message: 'The username is not valid',
        	          validators: {
        	            notEmpty: {
        	              message: '名字不能为空'
        	            }
        	          }
        	        },       	      
        	        sn: {
          	          message: 'The username is not valid',
          	          validators: {
          	            notEmpty: {
          	              message: '编号不能为空'
          	            }
          	          }
          	        },       	
          	      costPrice: {
        	          message: 'The username is not valid',
        	          validators: {
        	            notEmpty: {
        	              message: '成本价不能为空'
        	            }
        	          }
        	        },       	
        	        salePrice: {
          	          message: 'The username is not valid',
          	          validators: {
          	            notEmpty: {
          	              message: '售价不能为空'
          	            }
          	          }
          	        },       	        	           
        	          } 
        	     })
        	});
    </script>

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
                                        商品管理
            <small>在艺术与梦里，你应该放荡不羁的前行</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="/WMS/"><i class="fa fa-dashboard"></i>主页</a></li>
            <li><a href="JavaScript:history.go(-1)">返回上一页</a></li>
            <li class="active">添加商品</li>
          </ol>
        </section>
 
        <section class="content">
           <!-- 添加的表单 -->
           <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">添加商品</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form  id="product-form" class="form-horizontal" action="${pageContext.request.contextPath}/products/add" method="post" enctype="multipart/form-data">
              <div class="box-body">
              
                <div class="row">
                  <div class="col-sm-6">
                    <div class="form-group">
                      <label for="name" class="col-sm-2 control-label">名字</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" name="name" id="name" placeholder="名字">
                      </div>
                    </div>
                  </div>
                  
                  <div class="col-sm-6">
                    <div class="form-group">
                      <label for="sn" class="col-sm-2 control-label">编号</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" name="sn" id="sn" placeholder="编号">
                      </div>
                    </div>
                  </div>
                </div>
              
                <div class="row">
                  <div class="col-sm-6">
                    <div class="form-group">
                      <label for="costPrice" class="col-sm-2 control-label">成本价</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" name="costPrice" id="costPrice" placeholder="成本价">
                      </div>
                    </div>
                  </div>
                  
                  <div class="col-sm-6">
                    <div class="form-group">
                      <label for="salePrice" class="col-sm-2 control-label">销售价</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" name="salePrice" id="salePrice" placeholder="销售价">
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-sm-6">
                    <div class="form-group">
                      <label for="productImg" class="col-sm-2 control-label">图片</label>
                      <div class="col-sm-10">
                        <input type="file" class="form-control" name="productImg" id="productImg"/>
                      </div>
                    </div>
                  </div>
                  
                  <div class="col-sm-6">
                    <div class="form-group">
                      <label for="brandId" class="col-sm-2 control-label">品牌</label>
                      <div class="col-sm-10">
                        <select class="form-control" id="brandId" name="brandId">
                           <option value="">请选择品牌</option>
                           <c:forEach items="${brands}" var="brand">
                              <option value="${brand.id}">${brand.name}</option>
                           </c:forEach>
                        </select>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col-sm-12">
                    <div class="form-group">
                      <label for="remark" class="col-sm-1 control-label">描述</label>
                      <div class="col-sm-11">
                        <textarea rows="4" cols="10"  class="form-control" id="remark" name="remark" ></textarea>
                      </div>
                    </div>
                  </div>
                </div>
                 
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
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
  </body>
</html>

