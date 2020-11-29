<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <!-- 这是JSP的语法,包含其他资源 -->
    <jsp:include page="/WEB-INF/jsp/common/common.jsp"/>    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/dist/plugins/validate/css/bootstrapValidator.min.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/dist/plugins/validate/js/bootstrapValidator.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/dist/plugins/validate/js/language/zh_CN.js"></script>
  
</head>
<body class="hold-transition login-page"> 
<div class="login-box">
  <div class="login-logo">
    <a href="../../index2.html"><b>仓库管理</b>系统</a>
  </div>
  
  <div class="login-box-body">
    <p class="login-box-msg">请输入账号密码</p>


    <form action="" method="post" id="login-form">
      <div class="form-group has-feedback">
        <input type="text" id="loginName" name="loginName" class="form-control" placeholder="账号">
        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" id="password" name="password" class="form-control" placeholder="密码">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="row">
        <div class="col-xs-12">
          <button type="submit" class="btn btn-primary btn-block btn-flat">登录</button>
        </div>
      </div>
    </form>
  </div>
</div>

<script type="text/javascript">
      $(function(){
    	  //校验
    	  $('#login-form').bootstrapValidator({
    	      message: 'This value is not valid',
    	      feedbackIcons: {
    	        valid: 'glyphicon glyphicon-ok',
    	        invalid: 'glyphicon glyphicon-remove',
    	        validating: 'glyphicon glyphicon-refresh'
    	      },
    	      fields: {
    	    	  loginName: {
    	            message: '登录名不能为空',
    	            validators: {
    	              notEmpty: {
    	                message: '登录名不能为空'
    	              },
    	            }
    	          },
    	          password: {
    	            validators: {
    	              notEmpty: {
    	                message: '密码不能为空'
    	              }
    	            }
    	          }
    	        }
    	      })
    	      .on('success.form.bv', function(e) {//校验通过执行
    	        // Prevent form submission
    	        e.preventDefault();
    	        // Get the form instance
    	        var $form = $(e.target);

    	        // Get the BootstrapValidator instance
    	        var bv = $form.data('bootstrapValidator');
    	        // TODO
    	        // Use Ajax to submit form data
    	        
	            //JSON对象    	    	
	    		var loginName = $("#loginName").val();
	    		var password = $("#password").val();
	    		
	    		var param = "loginName="+loginName+"&password="+password;
	    		$.ajax({
	    			type:"post",
	    			url:"/WMS/login",
	    			data:param,
	    			success:function(responseData){  //JSON对象
	    				//服务器响应回来的数据
	    				if(responseData.success){
	    					//去到主界面
	    					window.location.href="/WMS";
	    				}else{
	    					alert(responseData.msg);
	    				}
	    			}
	    		});
    	    });
    	 });
</script>

</body>
</html>
