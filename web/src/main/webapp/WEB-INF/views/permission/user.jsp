<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<!-- <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/font-awesome.min.css">
	<link rel="stylesheet" href="css/main.css"> -->
<%@ include file="/WEB-INF/views/common/common-css.jsp"%>
<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}

table tbody tr:nth-child(odd) {
	background: #F4F4F4;
}

table tbody td:nth-child(even) {
	color: #C00;
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
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="glyphicon glyphicon-th"></i> 数据列表
						</h3>
					</div>
					<div class="panel-body">
						<form class="form-inline" role="form" style="float: left;" action="${PATH}/admin/index.html">
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input class="form-control has-success" type="text" name="condition"
										placeholder="请输入查询条件" value="${sessionScope.condition }">
								</div>
							</div>
							<button type="submit" class="btn btn-warning">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<button type="button" class="btn btn-danger" id="deleteAll"
							style="float: right; margin-left: 10px;">
							<i class=" glyphicon glyphicon-remove"></i> 删除
						</button>
						<button type="button" class="btn btn-primary"
							style="float: right;" onclick="window.location.href='${PATH}/admin/add.html'">
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="30">#</th>
										<th width="30"><input type="checkbox" id="allCheck" ></th>
										<th>账号</th>
										<th>名称</th>
										<th>邮箱地址</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>

								<c:forEach items="${pageInfo.list}" var="admin">
									<tr>
										<td>${admin.id }</td>
										<td><input type="checkbox" class="itemCheck"></td>
										<td>${admin.loginacct }</td>
										<td>${admin.username }</td>
										<td>${admin.email }</td>
										<td>
											<button type="button" class="btn btn-success btn-xs" onclick="location.href='${PATH}/admin/toAssign.html?adminId=${admin.id }'">
												<i class=" glyphicon glyphicon-check"></i>
											</button>
											<button type="button" class="btn btn-primary btn-xs" onclick="toUpdate(${admin.id})">
												<i class=" glyphicon glyphicon-pencil"></i>
											</button>
											<button type="button" class="btn btn-danger btn-xs" onclick="toDelete(${admin.id},${pageInfo.pageNum})">
												<i class=" glyphicon glyphicon-remove"></i>
											</button>
										</td>
									</tr>
								</c:forEach>

								</tbody>
								<tfoot>
									<tr>
										<td colspan="6" align="center">
											<ul class="pagination">
											<li ><a href="${PATH}/admin/index.html">首页</a></li>
											
												<c:if test="${pageInfo.hasPreviousPage }">
													<li ><a href="${PATH}/admin/index.html?pageNum=${pageInfo.prePage}&condition=${sessionScope.condition}">上一页</a></li>
												
												</c:if>
												
												<c:forEach items="${pageInfo.navigatepageNums}" var="num">
													<c:if test="${num == pageInfo.pageNum }">
													
														<li class="active"><a href="${PATH}/admin/index.html?pageNum=${num}&condition=${sessionScope.condition}">${num }</a></li>
													</c:if>
													<c:if test="${num != pageInfo.pageNum }">
														<li><a href="${PATH}/admin/index.html?pageNum=${num}&condition=${sessionScope.condition}">${num }</a></li>
													
													</c:if>
													
												</c:forEach>
												<c:if test="${pageInfo.hasNextPage}">
													<li><a href="${PATH}/admin/index.html?pageNum=${pageInfo.nextPage}&condition=${sessionScope.condition}">下一页</a></li>
												</c:if>
												<li><a href="${PATH}/admin/index.html?pageNum=${pageInfo.pages}&condition=${sessionScope.condition}">尾页</a></li>
											</ul>
										</td>
									</tr>

								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/common-js.jsp"%>
	<script type="text/javascript">
		
		//去edit页面
		function toUpdate(id){
			window.location.href="${PATH}/admin/toUpdate?id="+id;
		}
		
		function toDelete(id,pageNum){
			
			layer.confirm("确定要删除吗？",{btn:["确定","取消"],title:"删除提示框"}, function(cindex){
        		window.location.href='${PATH}/admin/delete.html?id='+id+'&pageNum='+pageNum;
			    layer.close(cindex);
			}, function(cindex){
			    layer.close(cindex);
			});
			
		}
		
		//全选
		$("#allCheck").click(function(){
			//获取全选的checked属性
			var allChecked = $(this).prop("checked");
			console.log('allChecked==='+allChecked);
			//给下面的每个check设值
			$(".itemCheck").prop("checked",allChecked);
			
		});
		
		//表单中的复选框 已经选中的数等于总数才会全选 否则不全选
		$(".itemCheck").click(function(){
			
			//获取总数
			var total = $(".itemCheck").length;
			
			//已经选中的数
			var checked = $(".itemCheck:checked").length;
			
			$("#allCheck").prop("checked",total==checked);
			
		});
		
		//批量删除
		$("#deleteAll").click(function(){
			
			var checked = $(".itemCheck:checked");
			
			if(checked.length ==0){
				layer.msg("至少选择一个",{icon:6,time:1000});
				return false;
			}
			
			var array = new Array();
			$.each(checked,function(){
				var id = $(this).parents("tr").find("td:eq(0)").text();
				array.push(id);
			});
			
			var ids = array.join(",");
			console.log('ids==='+ids);
			
			layer.confirm("确定要删除吗？",{btn:["确定","取消"],title:"删除提示框"}, function(cindex){
        		window.location.href='${PATH}/admin/batchDelete.html?ids='+ids;
			    layer.close(cindex);
			}, function(cindex){
			    layer.close(cindex);
			});
			
		});
		
		
		
		
	</script>
</body>
</html>
