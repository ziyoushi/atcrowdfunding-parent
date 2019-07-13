<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<!-- <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/font-awesome.min.css">
	<link rel="stylesheet" href="css/main.css">
	<link rel="stylesheet" href="css/doc.min.css"> -->
	<%@include file="/WEB-INF/views/common/common-css.jsp"%>
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	</style>
  </head>

<%pageContext.setAttribute("title", "用户维护"); %>
  <body>

    <%@include file="/WEB-INF/views/common/nav-bar.jsp"%>

    <div class="container-fluid">
      <div class="row">
        <%@include file="/WEB-INF/views/common/side-bar.jsp"%>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="${PATH}/main.html">首页</a></li>
				  <li><a href="${PATH}/admin/index.html">数据列表</a></li>
				  <li class="active">修改</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form role="form" action="${PATH}/admin/add" method="post">
				  <div class="form-group">
				  	
					<label for="exampleInputPassword1">登陆账号</label>
					<input type="text" class="form-control" name="loginacct" value="${TAdmin.loginacct}">
				  </div>
				  <div class="form-group">
					<label for="exampleInputPassword1">用户名称</label>
					<input type="text" class="form-control" name="username" value="${TAdmin.username}">
				  </div>
				  <div class="form-group">
					<label for="exampleInputEmail1">邮箱地址</label>
					<input type="email" class="form-control" name="email" value="${TAdmin.email}">
				  </div>
				  <button type="submit" class="btn btn-success"><i class="glyphicon glyphicon-edit"></i> 新增</button>
				  <button type="reset" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>
    
	
	<%@include file="/WEB-INF/views/common/common-js.jsp" %>
    
  </body>
</html>
    