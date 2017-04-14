<%@ page language="java" import="java.util.*" import="java.text.*"
import="cap.bean.*" import="cap.dao.impl.*"
pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<%
	int userId = (Integer)request.getAttribute("userId");
User u = (User)request.getSession().getAttribute("user");
BlogInfo bi = (BlogInfo)request.getAttribute("blogInfo");
List<Category> cgList = (List<Category>)request.getAttribute("cgList");
List<Article> artList = (List<Article>)request.getAttribute("artList");
String blogName = (String)request.getAttribute("blogName");
String blogAnnoucement = (String)request.getAttribute("blogAnnoucement");
String author = (String)request.getAttribute("author");

int curPage = (Integer)request.getAttribute("curPage");
int totalPages = (Integer)request.getAttribute("totalPages");
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
            <li><a href="<%=basePath%>index.html">网站首页</a></li>
          </ul>
          
          <%
                    	if ((null != u) && (u.getIsApplied() == 1)) {
                    %>
          <ul class="nav navbar-nav">
            <li><a href="<%=basePath%>user?action=myblog&userId=<%=u.getId()%>">我的博客</a></li>
          </ul>
          
          <ul class="nav navbar-nav">
            <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">博客管理<b class="caret"></b></a>
                <ul class="dropdown-menu">
                    <li><a href="<%=basePath%>article?action=manage&userId=<%=u.getId()%>"><i class="glyphicon glyphicon-cog"></i> 博文管理</a></li>
                    <li class="divider"></li>
                    <li><a href="<%=basePath%>category?action=manage&userId=<%=u.getId()%>"><i class="glyphicon glyphicon-cog"></i> 分类管理</a></li>
                    <li class="divider"></li>
                    <li><a href="<%=basePath%>comment.html?action=manage&userId=<%=u.getId()%>"><i class="glyphicon glyphicon-cog"></i> 评论管理</a></li>
                </ul>
            </li>
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
                    <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">欢迎，<%=u.getUserName()%> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="<%=basePath%>user?action=profile&id=<%=u.getId()%>"><i class="glyphicon glyphicon-cog"></i> 编辑个人信息</a></li>
                            <%
                            	if (u.getIsApplied() == 1) {
                            %>
                            <li class="divider"></li>
                            <li><a href="<%=basePath%>user?action=bloginfo&userId=<%=u.getId()%>"><i class="glyphicon glyphicon-cog"></i> 编辑博客信息</a></li>
                            <%
                            	}
                            %>
                            <li class="divider"></li>
                            <li><a href="<%=basePath%>user?action=logout"><i class="glyphicon glyphicon-off
glyphicon "></i> 登出</a></li>
                        </ul>
                    </li>
                </ul>
          </div>
          <%
          	}
          %>
          
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container -->
    </nav>

    <div class="container">

      <div class="row">
        <div class="col-lg-8">
        
          <!-- blog entry -->
          <h1><a href="<%=basePath%>user?action=myblog&userId=<%=userId%>">
          <%
          	if (null != blogName) {
          %> 
          	<%=blogName%>
          <%
          	} else {
          %>
          	读取博客标题失败！
          <%
          	}
          %>
          </a></h1>
          <p class="lead">
           <%
           	if (null != bi) {
           %> 
          	<%=bi.getDescription()%>
          <%
          	} else {
          %>
          	读取博客副标题失败！
          <%
          	}
          %>
          </p><br>
         
          
          <%
                             	if ((null != artList) && (artList.size() > 0)) { 
                                                     	 	for (Article art : artList) {
                                                     	 		if (0 == art.getIsDelete()) {	//删除的文章就不显示了
                             %>
 		  <h3><a href="<%=basePath%>comment.html?action=post&artId=<%=art.getId()%>&userId=<%=userId%>"><%=art.getTitle() %></a></h3>
          <p>
          <i class="glyphicon glyphicon-user"></i> <a href="#"> <%=author %></a> 
		| <i class="glyphicon glyphicon-calendar"></i> <%=art.getPublishTime() %>
		| 阅读 <%=art.getCount() %> 次
 		  </p>
          <hr>
          <p><%=art.getSummary() %></p>
          <a class="btn btn-primary" href="<%=basePath%>comment.html?action=post&artId=<%=art.getId()%>&userId=<%=userId%>">Read More <span class="glyphicon glyphicon-chevron-right"></span></a>               
          <hr>
          
          <%		}	
             	}
          	 } else { %>
          <p>还没有写过文章哦，赶紧写吧~</p>
          <% } %>
          <!-- pager -->
          <ul class="pager">
          	<% if (curPage > 1) { %>
            <li class="previous"><a href="<%=basePath%>user?action=myblog&curPage=<%=(curPage-1)%>&userId=<%=userId%>">&larr; 上一页</a></li>
            <% } %>
            
            <% if (curPage < totalPages-1) { %>
            <li class="next"><a href="<%=basePath%>user?action=myblog&curPage=<%=(curPage+1)%>&userId=<%=userId%>">下一页  &rarr;</a></li>
            <% } %>
          </ul>

        </div>
        
        <div class="col-lg-4">                  
          <form action="servlet/GetSysCategoryServlet" method="GET">
          <div class="well">
            <h4> 文章分类</h4>
              <div class="row">
                <div class="col-lg-6">
                  <ul class="list-unstyled">
                  	<% if ((null != cgList) && (cgList.size() > 0)) {
                  	       for (Category cg : cgList) {
                  		       if (cg.getIsDelete() == 0) {
                  	%>	
                  	<li><a href="#"><%=cg.getCategoryName() %></a></li>
                  	<%         }
                  	       }
                  	   } else { %>
                  	<li>无分类</li>
                  	<% } %>
                  </ul>
                </div>
              </div>
          </div><!-- /well -->
          </form> 
          
          <div class="well">
            <h4>公告</h4>
            <p><%=bi.getAnnoucement() %></p>
          </div><!-- /well -->
        </div>
      </div>
    </div><!-- /.container -->
    
<jsp:include page="frame/Footer.jsp"></jsp:include>