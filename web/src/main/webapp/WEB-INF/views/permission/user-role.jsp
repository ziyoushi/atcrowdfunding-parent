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

	<link rel="stylesheet" href="${PATH}/static/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${PATH}/static/css/font-awesome.min.css">
	<link rel="stylesheet" href="${PATH}/static/css/main.css">
	<link rel="stylesheet" href="${PATH}/static/css/doc.min.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	</style>
  </head>

<%
	pageContext.setAttribute("title", "用户维护");
%>
  <body>

    <%@ include file="/WEB-INF/views/common/nav-bar.jsp"%>

    <div class="container-fluid">
      <div class="row">
        
        <%@ include file="/WEB-INF/views/common/side-bar.jsp"%>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="#">首页</a></li>
				  <li><a href="#">数据列表</a></li>
				  <li class="active">分配角色</li>
				</ol>
			<div class="panel panel-default">
			  <div class="panel-body">
				<form role="form" class="form-inline">
				  <div class="form-group">
					<label for="exampleInputPassword1">未分配角色列表</label><br>
					<select id="unassignSelect" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
                        <c:forEach items="${unassigns}" var="role">
	                        <option value="${role.id}">${role.name}</option>
                        </c:forEach>
                        
                    </select>
				  </div>
				  <div class="form-group">
                        <ul>
                            <li id="toRightBtn" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                            <br>
                            <li id="toLeftBtn" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                        </ul>
				  </div>
				  <div class="form-group" style="margin-left:40px;">
					<label for="exampleInputPassword1">已分配角色列表</label><br>
					<select id="assignSelect" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
                        <c:forEach items="${assigns}" var="role">
	                        <option value="${role.id}">${role.name}</option>
                        </c:forEach>
                    </select>
				  </div>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>
    
    <%@ include file="/WEB-INF/views/common/common-js.jsp"%>
	<script type="text/javascript">
		//点击去分配
		$("#toRightBtn").click(function(){
			
			var array = new Array();
			//获取到已经选择的select
			var leftSelected = $("#unassignSelect option:selected");
			$.each(leftSelected,function(){
				//console.log('获取到的value===='+this.value);
				var id = this.value;
				array.push(id);
			});
			var roleIds = array.join(",");
			//console.log(leftSelected);
			console.log('拼接后的roleids===='+roleIds);
			
			//获取adminId
			var adminId = ${param.adminId};
			console.log('获取到的adminId===='+adminId);
			
			//使用同步的方式进行请求
			
			location.href="${PATH}/admin/assignRole?adminId="+adminId+"&roleIds="+roleIds;
			/* $.post("${PATH}/admin/assignRole",{adminId:adminId,roleIds:roleids},function(){
				
			}); */
			
		});
		
		//点击取消分配
		$("#toLeftBtn").click(function(){
			
			var array = new Array();
			//获取右侧已选中的select
			var rightSelected = $("#assignSelect option:selected");
			$.each(rightSelected,function(){
				var id = this.value;
				array.push(id);
			});
			
			var roleIds = array.join(",");
			var adminId = ${param.adminId};
			
			location.href="${PATH}/admin/unAssignRole?adminId="+adminId+"&roleIds="+roleIds;
			
		});
		
	
	</script>
    
  </body>
</html>
    