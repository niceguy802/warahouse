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
        	$('#user-form').bootstrapValidator({
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
        	        loginName: {
        	          message: 'The username is not valid',
        	          validators: {
        	            notEmpty: {
        	              message: '账号不能为空'
        	            },
        	            remote: {
        	              url: '/WMS/users/validate/loginName',
        	              message: '账号已存在',
        	              //data: {"age":"110"}   添加额外的参数
        	            }
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
            主页
            <small>it all starts here</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="${pageContext.request.contextPath}/users/listUI"><i class="fa fa-circle-o"></i>用户管理</a></li>
        <li><a href="${pageContext.request.contextPath}/depts/listUI"><i class="fa fa-circle-o"></i>部门管理</a></li>
        <li><a href="${pageContext.request.contextPath}/roles/listUI"><i class="fa fa-circle-o"></i>角色管理</a></li>
          </ol>
        </section>
 
        <section class="content">
           <!-- 添加的表单 -->
           <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">添加用户</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form id="user-form" class="form-horizontal" action="${pageContext.request.contextPath}/users/add" method="post" enctype="multipart/form-data">
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
                  <label for="loginName" class="col-sm-2 control-label">账号</label>
                  <div class="col-sm-10">
                    <input type="text"  class="form-control" id="loginName" name="loginName" placeholder="账号">
                  </div>
                </div>
                </div>
                </div>
              
                <div class="row">
                  <div class="col-sm-6">
                    <div class="form-group">
                      <label for="header" class="col-sm-2 control-label">头像</label>
                      <div class="col-sm-10">
                        <input type="file" class="form-control" name="header" id="header"/>
                      </div>
                    </div>
                  </div>                
                <div class="col-sm-6">
                <div class="form-group">
                  <label for="deptId" class="col-sm-2 control-label">部门</label>

                  <div class="col-sm-10">
                    <select class="form-control" id="deptId" name="dept.id">
                       <option value="">请选择部门</option>
                       <c:forEach items="${depts}" var="dept">
                          <option value="${dept.id}">${dept.name}</option>
                       </c:forEach>
                    </select>
                  </div>
                </div>
                
                </div>
                </div>
                 
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <button type="button" class="btn btn-info" onclick="javascript:history.back(-1)">返回</button>
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

