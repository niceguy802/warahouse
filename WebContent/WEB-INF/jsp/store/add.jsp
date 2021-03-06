<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <jsp:include page="/WEB-INF/jsp/common/common.jsp"/>
    
    
    <!-- bootstrapvalidator步骤
            添加对应的资源
            编写校验规则
     -->
     
   <link rel="stylesheet" href="${pageContext.request.contextPath}/static/dist/plugins/validate/css/bootstrapValidator.min.css">
 
    <script src="${pageContext.request.contextPath}/static/dist/plugins/validate/js/bootstrapValidator.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/dist/plugins/validate/js/language/zh_CN.js"></script>
    
    <script type="text/javascript">
        $(function(){
        	$('#store-form').bootstrapValidator({
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
        	              message: '仓库名不能为空'
        	            },
        	            remote: {
          	              url: '/WMS/stores/validate/name',
          	              message: '仓库已存在',
          	              //data: {"age":"110"}   添加额外的参数
          	            },
        	          }
        	        },
        	        
        	        address: {
        	          message: 'The username is not valid',
        	          validators: {
        	            notEmpty: {
        	              message: '地址不能为空'
        	            },
        	           
        	          }
        	        }
        	      }
        	    })
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
                                         仓库管理
            <small>在艺术与梦里，你应该放荡不羁的前行</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="/WMS/"><i class="fa fa-dashboard"></i>主页</a></li>
            <li><a href="JavaScript:history.go(-1)">返回上一页</a></li>
            <li class="active">添加仓库</li>
          </ol>
        </section>
 
        <section class="content">
           <!-- 添加的表单 -->
           <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">添加仓库</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form id="store-form" class="form-horizontal" action="${pageContext.request.contextPath}/stores/add" method="post" enctype="multipart/form-data">
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
                  <label for="address" class="col-sm-2 control-label">地址</label>

                  <div class="col-sm-10">
                    <input type="text" class="form-control" name="address" id="地址" placeholder="地址">
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

