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
	pageContext.setAttribute("title", "项目分类");
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
						<form class="form-inline" role="form" style="float: left;"
							id="searchForm">
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input class="form-control has-success" type="text"
										name="condition" placeholder="请输入查询条件">
								</div>
							</div>
							<button type="button" id="searchBtn" class="btn btn-warning">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<button type="button" class="btn btn-danger" id="batchDeleteBtn"
							style="float: right; margin-left: 10px;">
							<i class=" glyphicon glyphicon-remove"></i> 删除
						</button>
						<button type="button" id="addBtn" class="btn btn-primary"
							style="float: right;">
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="30">#</th>
										<th width="30"><input type="checkbox" id="checkedAll"></th>
										<th width="300">分类名称</th>
										<th>简介</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>

								</tbody>
								<tfoot>
									<tr>
										<td colspan="6" align="center">
											<ul class="pagination">

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

	<!-- 新增模态框 -->
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增项目分类</h4>
				</div>
				<div class="modal-body">

					<form id="addForm">
						<div class="form-group">
							<label for="exampleInputEmail1">分类名称</label> <input type="email"
								class="form-control" name="name" placeholder="请输入分类名称">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">简介</label> <input type="email"
								class="form-control" name="remark" placeholder="请输入简介">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="saveBtn" type="button" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
	</div>


	<!-- 修改模态框 -->
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改项目分类</h4>
				</div>
				<div class="modal-body">

					<form id="updateForm">
						<div class="form-group">
						<input type="hidden" name="id" />
							<label for="exampleInputEmail1">分类名称</label> 
							<input type="text" class="form-control" name="name" placeholder="请输入分类名称">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">简介</label> 
							<input type="text" class="form-control" name="remark" placeholder="请输入简介">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="updateBtn" type="button" class="btn btn-primary">修改</button>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/views/common/common-js.jsp"%>
	<script type="text/javascript">
		var globalPageNum = 1;
		var globalPageSize = 3;
		var globalCondition = '';
		$(function() {
			loadProjectTypes();
		});

		function loadProjectTypes() {
			$.get("${PATH}/project/loadProjectTypes", {
				pageNum : globalPageNum,
				pageSize : globalPageSize,
				condition : globalCondition
			}, function(pageInfo) {

				buildTableContent(pageInfo.list);

				buildPageContent(pageInfo);
			});
		}

		function buildTableContent(list) {
			$("tbody").empty();
			//遍历list
			$.each(list,function(i, e) {
				var tr = $('<tr></tr>');
				var td1 = $('<td>' + e.id + '</td>');
				var td2 = $('<td><input type="checkbox" class="checkItem"></td>');
				var td3 = $('<td>' + e.name + '</td>');
				var td4 = $('<td>' + e.remark + '</td>');
				var btnGroup = $('<td></td>');
				var updateBtn = $('<button tid='+e.id+' type="button" class="btn btn-primary btn-xs updateItem"><i class=" glyphicon glyphicon-pencil"></i></button>');
				var deleteBtn = $('<button tid='+e.id+' type="button" class="btn btn-danger btn-xs deleteItem"><i class=" glyphicon glyphicon-remove"></i></button>');
				btnGroup.append(updateBtn).append(" ");
				btnGroup.append(deleteBtn);
				tr.append(td1);
				tr.append(td2);
				tr.append(td3);
				tr.append(td4);
				tr.append(btnGroup);
				$("tbody").append(tr);
			});
		}

		function buildPageContent(pageInfo) {
			$("ul.pagination").empty();
			//首页 
			var firstPage = '<li pn='+1+'><a href="#">首页</a></li>';
			$("ul.pagination").append(firstPage);

			if (pageInfo.hasPreviousPage) {
				//上一页 pageInfo.prePage
				var prePage = '<li pn='+pageInfo.prePage+'><a href="#">上一页</a></li>';
				$("ul.pagination").append(prePage);
			}

			//遍历导航栏 追加到ul里 pagination
			$.each(pageInfo.navigatepageNums, function() {
				//this表示当前
				var li = '';
				//如果是当前页 则高亮
				if (pageInfo.pageNum == this) {
					li = '<li pn='+this+' class="active"><a href="#">' + this
							+ '</a></li>';
				} else if (pageInfo.pageNum != this) {
					li = '<li pn='+this+'><a href="#">' + this + '</a></li>';
				}

				$("ul.pagination").append(li);
			});

			if (pageInfo.hasNextPage) {
				//下一页pageInfo.hasNextPage
				var nextPage = '<li pn='+pageInfo.nextPage+'><a href="#">下一页</a></li>';
				$("ul.pagination").append(nextPage);
			}

			//尾页 pages
			var lastPage = '<li pn='+pageInfo.pages+'><a href="#">尾页</a></li>';
			$("ul.pagination").append(lastPage);
		}

		//为分页导航栏添加点击事件
		$("ul.pagination").on("click", "li", function() {
			var pageNum = $(this).attr("pn");
			globalPageNum = pageNum;
			//alert($(this).attr("pn"))
			loadProjectTypes();
		});

		//给查询添加点击事件
		$("#searchBtn").click(function() {

			var condition = $("#searchForm input[name='condition']").val();
			globalCondition = condition;
			loadProjectTypes();
		});

		//为新增添加模态框
		$("#addBtn").click(function() {
			$("#addForm input[name='name']").val('');
			$("#addForm input[name='remark']").val('');
			$("#addModal").modal({
				show : true,
				backdrop : 'static'
			});
		});

		$("#saveBtn").click(function() {
			$.post("${PATH}/project/add", $("#addForm").serialize(),function(result) {
				if (result == "ok") {
					layer.msg("新增成功");
					$("#addModal").modal('hide');
					globalPageNum = 1000;
					loadProjectTypes();
				} else {
					layer.msg("新增失败");
					$("#addModal").modal('hide');
				}
			});
		});

		//为修改添加点击事件
		$("tbody").on("click", ".updateItem", function() {
			var tid = $(this).attr("tid");
			//根据tid查询项目分类
			$.get("${PATH}/project/get", {tid : tid}, function(data) {
				//给页面设值 回显 
				$("#updateModal input[name='id']").val(data.id);
				$("#updateModal input[name='name']").val(data.name);
				$("#updateModal input[name='remark']").val(data.remark);
			});
			
			//弹出修改模态框
			$("#updateModal").modal({show:true,backdrop:'static'});
		});
		
		//修改
		$("#updateBtn").click(function(){
			$.post("${PATH}/project/update",$("#updateForm").serialize(),function(result){
				if(result=="ok"){
					layer.msg("修改成功");
					$("#updateModal").modal("hide");
					loadProjectTypes();
				}else{
					layer.msg("修改失败");
					$("#updateModal").modal("hide");
					loadProjectTypes();
				}
			});
		});
		
		//为单个删除添加点击事件
		$("tbody").on("click",".deleteItem",function(){
			
			var tid = $(this).attr("tid");
			layer.confirm("确定删除吗",  {btn:["确定","取消"], title:'删除分类'}, function(cindex){
				$.get("${PATH}/project/delete",{tids:tid},function(result){
					if(result=="ok"){
						layer.msg("删除成功");
						loadProjectTypes();
					}else{
						layer.msg("删除失败");
						loadProjectTypes();
					}
				});
			    layer.close(cindex);
			}, function(cindex){
			    layer.close(cindex);
			});
			
		});
		
		//全选 全不选
		$("#checkedAll").click(function(){
			var checkedAll = $(this).prop("checked");
			//console.log(checkedAll);
			//设置单个复选框的选中状态
			$(".checkItem").prop("checked",checkedAll);
		});
		
		//根据单个复选控制 全选 全不选
		$("tbody").on("click",".checkItem",function(){
			
			//总的复选框数			
			var total =  $(".checkItem").length;
			//console.log('总数'+total);
			//已经选中的复选框数
			var checkedTotal = $(".checkItem:checked").length;
			//console.log('已选中的数'+checkedTotal);
			$("#checkedAll").prop("checked",total==checkedTotal);
			
		});
		
		//批量删除
		$("#batchDeleteBtn").click(function(){
			
			//获取已经选中的对象
			var checked = $(".checkItem:checked");
			
			if(checked.length==0){
				layer.msg("请至少选择一个!");
				return false;
			}
			
			var array = new Array();
			//遍历 获取id
			$.each(checked,function(){
				var tid = $(this).parents("tr").find("td:eq(0)").text();
				array.push(tid);
			});
			var tids = array.join(",");
			
			layer.confirm("确认删除吗？",  {btn:["确定","取消"], title:'删除分类'}, function(cindex){
				
				$.get("${PATH}/project/delete",{tids:tids},function(result){
					if(result=="ok"){
						layer.msg("删除成功");
						loadProjectTypes();
					}else{
						layer.msg("删除失败");
						loadProjectTypes();
					}
				});
				
			    layer.close(cindex);
			}, function(cindex){
			    layer.close(cindex);
			});
			
		});
		
	</script>
</body>
</html>
