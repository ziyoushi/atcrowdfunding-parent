<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="keys" content="">
<meta name="author" content="">

<link rel="stylesheet"
	href="${PATH}/static/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${PATH}/static/css/font-awesome.min.css">
<link rel="stylesheet" href="${PATH}/static/css/login.css">
<style>
</style>
</head>
<body>
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<div>
					<a class="navbar-brand" href="${PATH}/main.html"
						style="font-size: 32px;">尚筹网-创意产品众筹平台</a>
				</div>
			</div>
		</div>
	</nav>

	<div class="container">
		

		<form class="form-signin" role="form" id="loginForm" method="post"
			action="${PATH}/login">
			
			<c:if test="${!empty param.msg }">
			<div class="alert alert-danger alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert">
					<span aria-hidden="true">&times;</span>
				</button>
				<strong>Warning!</strong> ${param.msg}
			</div>

			</c:if>
			
			<h2 class="form-signin-heading">
				<i class="glyphicon glyphicon-log-in"></i> 用户登录
			</h2>

			<div class="form-group has-success has-feedback">
				<input type="text" class="form-control" name="loginacct"
					placeholder="请输入登录账号" value="superadmin" autofocus> <span
					class="glyphicon glyphicon-user form-control-feedback"></span>
			</div>
			<div class="form-group has-success has-feedback">
				<input type="password" class="form-control" name="userpswd"
					placeholder="请输入登录密码" value="123456" style="margin-top: 10px;"> <span
					class="glyphicon glyphicon-lock form-control-feedback"></span>
			</div>
			<div class="form-group has-success has-feedback">
				<select class="form-control">
					<option value="member">会员</option>
					<option value="user">管理</option>
				</select>
			</div>
			<div class="checkbox">
				<label> <input type="checkbox" value="remember-me"
					name="remeber-me"> 记住我
				</label> <br> <label> 忘记密码 </label> <label style="float: right">
					<a href="${PATH}/reg.html">我要注册</a>
				</label>
			</div>
			<a class="btn btn-lg btn-success btn-block" onclick="dologin()">
				登录</a>
		</form>
	</div>
	<script src="${PATH}/static/jquery/jquery-2.1.1.min.js"></script>
	<script src="${PATH}/static/bootstrap/js/bootstrap.min.js"></script>
	<script>
		function dologin() {
			$("#loginForm").submit();
		}
	</script>
</body>
</html>