<%@ page language="java" import="java.util.*" import="cap.bean.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
User u = (User)request.getSession().getAttribute("user");
BlogInfo bi = (BlogInfo)request.getAttribute("bi");

String succUpdateMsg = (String)request.getSession().getAttribute("succUpdateMsg");
String errorUpdateMsg = (String)request.getSession().getAttribute("errorUpdateMsg");
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
            <li><a href="<%=basePath %>index.html">首页</a></li>
          </ul>
          
          <% if ((null != u) && (u.getIsApplied() == 1)) { %>
          <ul class="nav navbar-nav">
            <li><a href="<%=basePath %>user?action=myblog&userId=<%=u.getId() %>">我的博客</a></li>
          </ul>
          
          <ul class="nav navbar-nav">
            <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">博客管理<b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="<%=basePath %>article?action=manage&userId=<%=u.getId() %>"><i class="glyphicon glyphicon-cog"></i> 博文管理</a></li>
                    <li class="divider"></li>
                    <li><a href="<%=basePath %>category?action=manage&userId=<%=u.getId() %>"><i class="glyphicon glyphicon-cog"></i> 分类管理</a></li>
                    <li class="divider"></li>
                    <li><a href="<%=basePath %>comment.html?action=manage&userId=<%=u.getId()%>"><i class="glyphicon glyphicon-cog"></i> 评论管理</a></li>
                </ul>
            </li>
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
                    <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">欢迎，<%=u.getUserName() %> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="<%=basePath %>user?action=profile&id=<%=u.getId()%>"><i class="glyphicon glyphicon-cog"></i> 编辑个人信息</a></li>
                            <% if (u.getIsApplied() == 1) { %>
                            <li class="divider"></li>
                            <li><a href="<%=basePath %>user?action=bloginfo&userId=<%=u.getId() %>"><i class="glyphicon glyphicon-cog"></i> 编辑博客信息</a></li>
                            <% } %>
                            <li class="divider"></li>
                            <li><a href="<%=basePath %>user?action=logout"><i class="glyphicon glyphicon-off"></i> 登出</a></li>
                        </ul>
                    </li>
                </ul>
          </div>
          <% } %>
          
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container -->
    </nav>

	<% if (null != succUpdateMsg) { %>
	<div class="container">
   	<div class="alert alert-success">
   	<%=succUpdateMsg %>
   	</div></div>
   	<%     request.getSession().removeAttribute("succUpdateMsg");
   	   } %>
   
   	<% if (null != errorUpdateMsg) { %>
   	<div class="container">
   	<div class="alert alert-error">
   	<%=errorUpdateMsg %>
   	</div></div>
   	<%    request.getSession().removeAttribute("errorUpdateMsg");
   	   } %>
   	   
	<% if (null != bi) { %>
	<div class="container">
		<div class="row col-md-6">	       
	    		<form class="form-horizontal" action="<%=basePath %>user?action=updatebloginfo&userId=<%=u.getId() %>" method="post" class="form-horizontal" 
	    		name="blog_info_form" id="blog_info_form" onsubmit="return isValidate(blog_info_form)">
	    			
	    			<div class="form-group">
	    				<label for="email">博客名称</label>	    				
    					<input class="form-control" name="blog_name" type="text" value="<%=bi.getBlogName() %>" id="blog_name">
	    			</div>
	     
	    			<div class="form-group">
	    				<label for="address">博客描述</label>	    				
	    				<input class="form-control" name="description" type="text" value="<%=bi.getDescription() %>" id="blog_des">	    				
	    			</div>
	     
	    			<div class="form-group">
	    				<label for="zip">博客公告</label>	    					    				
                   		 <textarea class="form-control" id="annoucement" name="annoucement"  rows="5"><%=bi.getAnnoucement() %></textarea>                		
	    			</div>   		
	     
	    			<div class="form-group">
	    				<button type="submit" class="btn btn-primary">保存</button>
	    			</div>
	    		</form>
	    	</div>
		</div>
	
	<% } else { %>
	<%="读取博客信息出错！" %>
	<% } %>
<jsp:include page="frame/Footer.jsp"></jsp:include>

<script type="text/javascript">
function isValidate(blog_info_form) {
	var blog_name = blog_info_form.blog_name.value;
	var description = blog_info_form.description.value;
	var annoucement = blog_info_form.annoucement.value;
	
	if (blog_name == "" || description == "" || annoucement == "") {
		alert("博客名称，博客描述，博客公告为必填项");	
		
		return false;
	}
	
	return true;
}
</script>