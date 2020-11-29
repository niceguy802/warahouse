<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="main-sidebar">
  <section class="sidebar">
    <div class="user-panel">
      <div class="pull-left image">
        <img src="${pageContext.request.contextPath}/static/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
      </div>
      <div class="pull-left info">
        <p>${sessionScope.user.name}</p>
        <a href="#"><i class="fa fa-circle text-success"></i>在线</a>
      </div>
    </div>
    <!-- search form -->
    <form action="#" method="get" class="sidebar-form">
      <div class="input-group">
        <input type="text" name="q" class="form-control" placeholder="Search...">
        <span class="input-group-btn">
        <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
        </button>
        </span>
      </div>
    </form>
    <ul class="sidebar-menu" data-widget="tree">
      <li class="header">导航</li>
      <li class="treeview">
        <a href="#">
        <i class="fa fa-dashboard"></i> <span>系统管理</span>
        <span class="pull-right-container">
          <i class="fa fa-angle-left pull-right"></i>
        </span>
        </a>
        <ul class="treeview-menu">
        <li><a href="${pageContext.request.contextPath}/users/listUI"><i class="fa fa-circle-o"></i>用户管理</a></li>
        <li><a href="${pageContext.request.contextPath}/depts/listUI"><i class="fa fa-circle-o"></i>部门管理</a></li>
        <li><a href="${pageContext.request.contextPath}/roles/listUI"><i class="fa fa-circle-o"></i>角色管理</a></li>
        </ul>
      </li>
    </ul>
    
    <ul class="sidebar-menu" data-widget="tree">
      <li class="treeview">
        <a href="#">
        <i class="fa fa-dashboard"></i> <span>商品中心</span>
        <span class="pull-right-container">
          <i class="fa fa-angle-left pull-right"></i>
        </span>
        </a>
        <ul class="treeview-menu">
        <li><a href="${pageContext.request.contextPath}/brands/listUI"><i class="fa fa-circle-o"></i>品牌管理</a></li>
        <li><a href="${pageContext.request.contextPath}/products/listUI"><i class="fa fa-circle-o"></i>商品管理</a></li>
        </ul>
      </li>
    </ul>
    
    <ul class="sidebar-menu" data-widget="tree">
      <li class="treeview">
        <a href="#">
        <i class="fa fa-dashboard"></i> <span>基础数据</span>
        <span class="pull-right-container">
          <i class="fa fa-angle-left pull-right"></i>
        </span>
        </a>
        <ul class="treeview-menu">
        <li><a href="${pageContext.request.contextPath}/suppliers/listUI"><i class="fa fa-circle-o"></i>厂商管理</a></li>
        <li><a href="${pageContext.request.contextPath}/clients/listUI"><i class="fa fa-circle-o"></i>客户管理</a></li>
        </ul>
      </li>
    </ul>
    
    <ul class="sidebar-menu" data-widget="tree">
      <li class="treeview">
        <a href="#">
        <i class="fa fa-dashboard"></i> <span>订单中心</span>
        <span class="pull-right-container">
          <i class="fa fa-angle-left pull-right"></i>
        </span>
        </a>
        <ul class="treeview-menu">
        <li><a href="${pageContext.request.contextPath}/books/listUI"><i class="fa fa-circle-o"></i>订单管理</a></li>
        <li><a href="${pageContext.request.contextPath}/bookItems/listUI"><i class="fa fa-circle-o"></i>明细管理</a></li>
        </ul>
      </li>
    </ul>
    
    <ul class="sidebar-menu" data-widget="tree">
      <li class="treeview">
        <a href="#">
        <i class="fa fa-dashboard"></i> <span>仓库中心</span>
        <span class="pull-right-container">
          <i class="fa fa-angle-left pull-right"></i>
        </span>
        </a>
        <ul class="treeview-menu">
        <li><a href="${pageContext.request.contextPath}/incomes/listUI"><i class="fa fa-circle-o"></i>入库管理</a></li>
        <li><a href="${pageContext.request.contextPath}/incomeItems/listUI"><i class="fa fa-circle-o"></i>明细管理</a></li>
        <li><a href="${pageContext.request.contextPath}/stores/listUI"><i class="fa fa-circle-o"></i>仓库管理</a></li>
        <li><a href="${pageContext.request.contextPath}/stocks/listUI"><i class="fa fa-circle-o"></i>库存信息</a></li>		
        </ul>
      </li>
    </ul>
    
     <ul class="sidebar-menu" data-widget="tree">
      <li class="treeview">
        <a href="#">
        <i class="fa fa-dashboard"></i> <span>销售中心</span>
        <span class="pull-right-container">
          <i class="fa fa-angle-left pull-right"></i>
        </span>
        </a>
        <ul class="treeview-menu">
        <li><a href="${pageContext.request.contextPath}/outcomes/listUI"><i class="fa fa-circle-o"></i>出库管理</a></li>
        <li><a href="${pageContext.request.contextPath}/outcomeItems/listUI"><i class="fa fa-circle-o"></i>出库明细</a></li>	
        </ul>
      </li>
    </ul>
  </section>
</aside>
