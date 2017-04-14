<%@ page language="java" import="java.util.*" 
import="cap.bean.*" import="cap.dao.impl.*"
pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
User u = (User)request.getSession().getAttribute("user");
List<SysCategory> scList = (List<SysCategory>)request.getAttribute("scList");
List<User> uList = (List<User>)request.getAttribute("uList");
List<Article> artList = (List<Article>)request.getAttribute("artList");
List<Article> tenList=(List<Article>)request.getAttribute("tenList");
int curPage = (Integer)request.getAttribute("curPage");
int totalPages = (Integer)request.getAttribute("totalPages");
%>

<jsp:include page="frame/Header.jsp"></jsp:include>

  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
        <a class="navbar-brand" href="index.html">J2EE 博客</a>
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
                            <li><a href="user?action=logout"><i class="glyphicon glyphicon-off"></i> 登出</a></li>
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
        <div id="blog" class="col-lg-8" >
          <h1><a href="user?action=index">轻博客——<small>基于JSP, Servlet技术构建</small></a></h1>
          <br>
          
          <%
                    	if ((null != artList) && (artList.size() > 0)) { 
                                                  	 	for (Article art : artList) {	//已经过滤删除的文章
                                               				//UserDaoImpl uDao = new UserDaoImpl();
                                               				//User user = uDao.getUserById(art.getUserId());
                                               			
                                               				//ArticleCounter artCnt = artCntDao.getCounter(art.getId());
                                               				
                                               				if (art != null) {
                    %>
 		  <h3><a href="<%=basePath%>comment.html?action=post&artId=<%=art.getId()%>&userId=<%=art.getUserId()%>" target="_blank"><%=art.getTitle()%></a></h3>
          <p>
          <i class="glyphicon glyphicon-user"></i> 
          <a href="<%=basePath%>user?action=myblog&userId=<%=art.getUserId()%>" target="_blank"><%=art.getUsername()%></a> 
          		 <%
           		 	}
           		 %>
          		 
		| <i class="glyphicon glyphicon-calendar"></i> <%=art.getPublishTime()%>
		| 阅读 <%=art.getCount()%> 次
 		  </p>
          
          <p><%=art.getSummary()%></p><br>
          <a class="btn btn-primary" href="<%=basePath%>comment.html?action=post&artId=<%=art.getId()%>&userId=<%=art.getUserId()%>">Read More <span class="glyphicon glyphicon-chevron-right"></span></a>               
          <hr>
          
          <%
                    	}
                              	 } else {
                    %>
          <p>还没有写过文章哦，赶紧写吧~</p>
          <%
          	}
          %>
          
          <!-- pager -->
          <ul class="pager">
          	<%
          		if (curPage > 1) {
          	%>
            <li class="previous"><a href="<%=basePath%>user?action=index&curPage=<%=(curPage-1)%>">&larr; 上一页</a></li>
            <%
            	}
            %>
            
            <%
                        	if (curPage < totalPages) {
                        %>
            <li class="next"><a href="<%=basePath%>user?action=index&curPage=<%=(curPage+1)%>">下一页  &rarr;</a></li>
            <%
            	}
            %>
          </ul>

        </div>
        
        <div class="col-lg-4">
        <%
        	if ((u != null) && (u.getIsApplied() == 0)) {
        %>
          <div class="well" align="center">
          	<a class="btn btn-primary" href="<%=basePath%>ApplyBlog1.jsp" target="_blank">申请个人博客</a>
          </div>
        <%
        	}
        %>
        
        <%
                	if ((u != null) && (u.getIsApplied() == 1)) {
                %>
          <div class="well" align="center">
          	<a class="btn btn-primary" href="<%=basePath%>user?action=myblog&userId=<%=u.getId()%>">进入我的博客</a>
          </div>
        <%
        	}
        %>
        
          <div class="well">
            <h4>搜索站内文章</h4>
            <form name="search_form" action="<%=basePath%>user?action=search" method="post">
            <div class="input-group">
              <input type="text" class="form-control" name="q">
              <span class="input-group-btn">
                <button class="btn btn-default" type="submit"><span class="glyphicon glyphicon-search"></span></button>
              </span>
            </div><!-- /input-group -->
            </form>
          </div><!-- /well -->
          
          <form action="servlet/GetSysCategoryServlet" method="GET">
          <div class="well">
            <h4>网站分类</h4>
              <div class="row">
                <div class="col-lg-6">
                  <ul class="list-unstyled">
                    <%
                    	if ((null != scList) && (scList.size() > 0)) { 
                                        	for (SysCategory sc : scList) { 
                                        		if (sc.getIsDelete() == 0) {
                    %>
                    <li>
                    <a href="#"><%=sc.getCategoryName()%></a>                  
                    </li>
                    <%
                    	}
                                        	} 
                                        } else {
                    %>
                    <li>无分类</li>
                    <%
                    	}
                    %>
                  </ul>
                </div>
              </div>
          </div><!-- /well -->
          </form> 
          
          <div class="well">
            <h4>本周活跃博主</h4>
            <div class="row">
                <div class="">
                  <ul class="list-unstyled">
                    <%
                    	if ((null != uList) && (uList.size() > 0)) { 
                                        	int i = 1;
                                        	for (User user : uList) {
                    %>
                    <li><a href="<%=basePath%>user?action=myblog&userId=<%=user.getId()%>" target="_blank"><%=i%>. <%=user.getUserName()%></a></li>
                    <%
                    	i++;
                                        	} 
                                        } else {
                    %>
                    <li>暂无排名，sorry......
                    </li>
                    <%
                    	}
                    %>
                  </ul>
                </div>
              </div>
          </div><!-- /well -->
          
          <div class="well">
            <h4>博文TOP10</h4>
            <div class="row">
                <div class="">
                  <ul class="list-unstyled">
                    <%
                    if(tenList!=null){
                    	int i=1;
                    	for(Article art:tenList){
                    %>
                    <li><a href="<%=basePath %>comment.html?action=post&artId=<%=art.getId() %>&userId=<%=art.getUserId() %>" target="_blank"><%=i %>. <%=art.getTitle() %></a></li>
                    <% 		i++;
                    	} 
                    } else { %>
                    <li>暂无排名，sorry......
                    </li>
                    <% } %>
                  </ul>
                </div>
              </div>
          </div><!-- /well -->
        </div>
      </div>
    </div><!-- /.container -->
    
<jsp:include page="frame/Footer.jsp"></jsp:include>
