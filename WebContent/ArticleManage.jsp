<%@ page language="java" import="java.util.*" import="cap.bean.*"
	import="cap.dao.impl.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
User u = (User)request.getSession().getAttribute("user");
List<Article> artList = (List<Article>)request.getAttribute("artList");
//添加下面两行代码用于分页显示
int curPage = (Integer)request.getAttribute("curPage");
int totalPages = (Integer)request.getAttribute("totalPages");

String succMsg = (String)request.getSession().getAttribute("succMsg");	//新建文章消息
String errorMsg = (String)request.getSession().getAttribute("errorMsg");

String deleSuccMsg = (String)request.getSession().getAttribute("deleSuccMsg");	//删除文章消息
String deleErrorMsg = (String)request.getSession().getAttribute("deleErrorMsg");
%>

<jsp:include page="frame/Header.jsp"></jsp:include>

<body>
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="index.html">JSP 博客</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse navbar-ex1-collapse">
				<ul class="nav navbar-nav">
					<li><a href="index.html">首页</a></li>
				</ul>

				<%
					if (null != u) {
				%>
				<ul class="nav navbar-nav">
					<li><a
						href="<%=basePath%>user?action=myblog&userId=<%=u.getId()%>">我的博客</a></li>
				</ul>

				<ul class="nav navbar-nav">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown">博客管理<b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a
								href="<%=basePath%>article?action=manage&userId=<%=u.getId()%>"><i
									class="glyphicon glyphicon-cog"></i> 博文管理</a></li>
							<li class="divider"></li>
							<li><a
								href="<%=basePath%>category?action=manage&userId=<%=u.getId()%>"><i
									class="glyphicon glyphicon-cog"></i> 分类管理</a></li>
							<li class="divider"></li>
							<li><a
								href="<%=basePath%>comment.html?action=manage&userId=<%=u.getId()%>"><i
									class="glyphicon glyphicon-cog"></i> 评论管理</a></li>
						</ul></li>
				</ul>
				<%
					}
				%>

				<%
					if (null == u) {
				%>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="Login.jsp" target="_blank">登录</a></li>
					<li><a href="Register.jsp" target="_blank">注册</a></li>
				</ul>
				<%
					} else {
				%>
				<div class="pull-right">
					<ul class="nav pull-right">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">欢迎，<%=u.getUserName()%> <b
								class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a
									href="<%=basePath%>user?action=profile&id=<%=u.getId()%>"><i
										class="glyphicon glyphicon-cog"></i> 编辑个人信息</a></li>
								<%
									if (u.getIsApplied() == 1) {
								%>
								<li class="divider"></li>
								<li><a
									href="<%=basePath%>user?action=bloginfo&userId=<%=u.getId()%>"><i
										class="glyphicon glyphicon-cog"></i> 编辑博客信息</a></li>
								<%
									}
								%>
								<li class="divider"></li>
								<li><a href="<%=basePath%>user?action=logout"><i
										class="glyphicon glyphicon-off"></i> 登出</a></li>
							</ul></li>
					</ul>
				</div>
				<%
					}
				%>

			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>

	<%
		if (null != succMsg) {
	%>
	<div class="container">
		<div class="alert alert-success"><%=succMsg%></div>
	</div>
	<%
		request.getSession().removeAttribute("succMsg");
	  	   }
	%>

	<%
		if (null != errorMsg) {
	%>
	<div class="container">
		<div class="alert alert-error"><%=errorMsg%></div>
	</div>
	<%
		request.getSession().removeAttribute("errorMsg"); 
	  	   }
	%>

	<%
		if (null != deleSuccMsg) {
	%>
	<div class="container">
		<div class="alert alert-success"><%=deleSuccMsg%></div>
	</div>
	<%
		request.getSession().removeAttribute("deleSuccMsg");
	  	   }
	%>

	<%
		if (null != deleErrorMsg) {
	%>
	<div class="container">
		<div class="alert alert-error"><%=deleErrorMsg%></div>
	</div>
	<%
		request.getSession().removeAttribute("deleErrorMsg"); 
	  	   }
	%>

	<%
		if (null != u) {
	%>
	<div class="container">
		<div class="btn-toolbar">
			<a class="btn btn-primary"
				href="<%=basePath%>article?action=add&userId=<%=u.getId()%>">新建文章</a>
		</div>
		<div class="well">
			<table class="table">
				<thead>
					<tr>
						<th>标题</th>
						<th>系统分类</th>
						<th>个人分类</th>
						<th>最近一次修改时间</th>
						<th style="width: 50px;">操作</th>
					</tr>
				</thead>
				<tbody>
				<%
					/*添加视图实现*/
							if (null != artList) { 
					      			for (Article art : artList) {
								if (0 == art.getIsDelete()) { //文章管理界面就不显示删除的文章了
							
									String deleUrl = basePath
											+ "article?action=delete&artId="
											+ art.getId() + "&userId=" + u.getId(); //删除链接
				%>
					<tr>
						<td><a
							href="<%=basePath %>article?action=update&artId=<%=art.getId() %>"><%=art.getTitle() %></a></td>
						<td><%=art.getScName()%></td>
						<td><%=art.getCategoryName() %></td>
						<td><%=art.getPublishTime() %></td>
						<td><a
							href="<%=basePath %>article?action=update&artId=<%=art.getId() %>"><i
								class="glyphicon glyphicon-pencil"></i></a> <a
							onClick="dele('<%=deleUrl %>')"><i
								class="glyphicon glyphicon-remove"></i></a></td>
					</tr>
					<%         }
		               }
		           } else { %>

					<% } %>
				</tbody>
			</table>
		</div>
		<div>
			<!-- pager -->
			<ul class="pager">
				<% if (curPage > 1) { %>
				<li class="previous"><a
					href="<%=basePath%>article?action=manage&userId=<%=u.getId()%>&curPage=<%=(curPage-1)%>">&larr;
						上一页</a></li>
				<% } %>

				<% if (curPage < totalPages) { %>
				<li class="next"><a
					href="<%=basePath%>article?action=manage&userId=<%=u.getId() %>&curPage=<%=(curPage+1)%>">下一页
						&rarr;</a></li>
				<% } %>
			</ul>
		</div>


	</div>
	<!-- /container -->
	<% }%>

	<jsp:include page="frame/Footer.jsp"></jsp:include>

	<script type="text/javascript">
function dele(deleUrl) {
	
	if (confirm("你确定要删除这篇文章吗？")) {
		location.href = deleUrl;
	}
}
</script>