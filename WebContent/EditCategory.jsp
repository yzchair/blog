<%@ page language="java" import="java.util.*" import="cap.bean.*"
	import="cap.dao.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
User u = (User)request.getSession().getAttribute("user");
String errorUpdateMsg = (String)request.getSession().getAttribute("errorUpdateMsg");
Category cg = (Category)request.getAttribute("cg");
 %>

<jsp:include page="frame/Header.jsp"></jsp:include>

<body>
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-ex1-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.html">JSP 博客</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse navbar-ex1-collapse">
				<ul class="nav navbar-nav">
					<li><a href="index.html">首页</a></li>
				</ul>

				<% if (null != u) { %>
				<ul class="nav navbar-nav">
					<li><a
						href="<%=basePath %>user?action=myblog&userId=<%=u.getId() %>">我的博客</a></li>
				</ul>

				<ul class="nav navbar-nav">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown">博客管理<b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a
								href="<%=basePath %>article?action=manage&userId=<%=u.getId() %>"><i
									class="icon-cog"></i> 博文管理</a></li>
							<li class="divider"></li>
							<li><a
								href="<%=basePath %>category?action=manage&userId=<%=u.getId() %>"><i
									class="icon-cog"></i> 分类管理</a></li>
							<li class="divider"></li>
							<li><a
								href="<%=basePath %>comment.html?action=manage&userId=<%=u.getId()%>"><i
									class="icon-cog"></i> 评论管理</a></li>
						</ul></li>
				</ul>
				<% } %>

				<% if (null == u) { %>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="Login.jsp" target="_blank">登录</a></li>
					<li><a href="Register.jsp" target="_blank">注册</a></li>
				</ul>
				<% } else { %>
				<div class="pull-right">
					<ul class="nav pull-right">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">欢迎，<%=u.getUserName() %> <b
								class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a
									href="<%=basePath %>user?action=profile&id=<%=u.getId() %>"><i
										class="icon-cog"></i> 编辑个人信息</a></li>
								<% if (u.getIsApplied() == 1) { %>
								<li class="divider"></li>
								<li><a
									href="<%=basePath %>user?action=bloginfo&userId=<%=u.getId() %>"><i
										class="icon-cog"></i> 编辑博客信息</a></li>
								<% } %>
								<li class="divider"></li>
								<li><a href="<%=basePath %>user?action=logout"><i
										class="icon-off"></i> 登出</a></li>
							</ul></li>
					</ul>
				</div>
				<% } %>

			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>

	<% if (null != cg) { %>
	<div class="container">
		<% if (null != errorUpdateMsg) { %>
		<%-- 提示更新分类失败 --%>
		<div class="container">
			<div class="alert alert-error"><%=errorUpdateMsg %></div>
		</div>
		<%     
	  	       request.getSession().removeAttribute("errorUpdateMsg"); 
	  	   } 
	  	%>
		<div class="row col-md-6">
			<div class="col-md-12">
				<ol class="breadcrumb">
					<li><a
						href="<%=basePath%>category?action=manage&userId=<%=u.getId() %>">分类管理</a></li>
					<li class="active">编辑分类</li>
				</ol>
			</div>
			<div class="col-md-12">
			<form class="form-horizontal" name="save_edit_category_form"
				action="<%=basePath %>category?action=save&userId=<%=u.getId() %>&cgId=<%=cg.getId() %>"
				method="post" onsubmit="return isValidate(save_edit_category_form)">
				<div class="form-group">
					<label for="category_name">分类名：</label> 
					<input class="form-control" id="category_name" name="category_name" value="<%=cg.getCategoryName() %>" type="text">
				</div>
				

				<div class="form-group">
					<button id="add_category_submit" type="submit" class="btn btn-primary">更新</button>
				</div>
			</form>
			</div>
		</div>
		</div>
		<% } %>
		<jsp:include page="frame/Footer.jsp"></jsp:include>

		<script type="text/javascript">
function isValidate(form) {
	var category_name = form.category_name.value;
	
	if (category_name == "") {
		alert("请填写分类名！");	
		
		return false;
	}
	return true;
}
</script>