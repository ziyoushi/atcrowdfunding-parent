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
	pageContext.setAttribute("title", "资质维护");
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
							<button id="searchBtn" type="button" class="btn btn-warning">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<button type="button" class="btn btn-danger batchDeleteBtn"
							style="float: right; margin-left: 10px;">
							<i class=" glyphicon glyphicon-remove"></i> 删除
						</button>
						<button type="button" class="btn btn-primary addBtn"
							style="float: right;" >
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="30">#</th>
										<th width="30"><input type="checkbox" id="checkAll"></th>
										<th>名称</th>
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
					<h4 class="modal-title" id="myModalLabel">新增资质</h4>
				</div>
				<div class="modal-body">

					<form id="addForm">
						<div class="form-group">
							<label for="exampleInputEmail1">名称</label> 
							<input type="text" class="form-control" name="name" placeholder="请输入名称">
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
					<h4 class="modal-title" id="myModalLabel">修改资质</h4>
				</div>
				<div class="modal-body">

					<form id="updateForm">
						<div class="form-group">
						<input type="hidden" name="id" />
							<label for="exampleInputEmail1">名称</label> 
							<input type="text" class="form-control" name="name" placeholder="请输入名称">
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
			loadCertData();
		});

		function loadCertData() {

			$.get("${PATH}/cert/loadCertData", {
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

			$.each(list,function(i, e) {
				//拼接tr
				var tr = $('<tr></tr>');
				var td1 = $('<td>' + e.id + '</td>');
				var td2 = $('<td><input type="checkbox" class="checkItem"></td>');
				var td3 = $('<td>' + e.name + '</td>');
				var btnGroup = $('<td></td');
				var updateBtn = $('<button certId='+e.id+' type="button" class="btn btn-primary btn-xs updateItem"><i class=" glyphicon glyphicon-pencil"></i></button>');
				var deleteBtn = $('<button certId='+e.id+' type="button" class="btn btn-danger btn-xs deleteItem"><i class=" glyphicon glyphicon-remove"></i></button>');
				btnGroup.append(updateBtn).append(" ");
				btnGroup.append(deleteBtn);
				tr.append(td1);
				tr.append(td2);
				tr.append(td3);
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
			loadCertData();
		});

		//为查询按钮添加点击事件
		$("#searchBtn").click(function() {

			var condition = $("#searchForm input[name='condition']").val();
			globalCondition = condition;

			loadCertData();

		});

		//为修改 删除 添加点击事件
		$("tbody").on("click", ".updateItem", function() {

			var certId = $(this).attr("certId");
			//根据certId查询出资质 做回显
			$.get("${PATH}/cert/get",{certId:certId},function(data){
				//给页面赋值 回显
				$("#updateModal input[name=id]").val(data.id);
				$("#updateModal input[name=name]").val(data.name);
			});

			$("#updateModal").modal({show:true,backdrop:'static'});
		});
		
		//点击修改按钮进行修改
		$("#updateBtn").click(function(){
			$.post("${PATH}/cert/update",$("#updateForm").serialize(),function(result){
				if(result=="ok"){
					layer.msg("修改成功");
					//关闭模态框
					$("#updateModal").modal('hide');
					loadCertData();
				}else{
					layer.msg("修改失败");
					$("#updateModal").modal('hide');
					
				}
			}); 
		});
		
		//新增
		$(".addBtn").click(function(){
			$("#addModal input[name='name']").val('');
			//弹出模态框
			$("#addModal").modal({show:true,backdrop:'static'});
		});
		
		$("#saveBtn").click(function(){
			$.post("${PATH}/cert/add",$("#addForm").serialize(),function(result){
				if(result=="ok"){
					layer.msg("新增成功");
					$("#addModal").modal("hide");
					globalPageNum = 1000;
					loadCertData();
				}else{
					layer.msg("新增失败");
					$("#addModal").modal('hide');
				}
			});
		});

		//删除
		$("tbody").on("click", ".deleteItem", function() {

			var certId = $(this).attr("certId");
			
			layer.confirm("确认删除吗",  {btn:["确定","取消"], title:'删除资质'}, function(cindex){
				$.post("${PATH}/cert/delete",{certIds:certId},function(result){
					if(result="ok"){
						layer.msg("删除成功");
						loadCertData();
					}else{
						layer.msg("删除失败");
						loadCertData();
					}
				});
			    layer.close(cindex);
			}, function(cindex){
			    layer.close(cindex);
			});
			
		});
		
		//全选 全不选
		$("#checkAll").click(function(){
			
			var checkedAll = $(this).prop("checked");
			//console.log(checkedAll);
			//为子复选框设置 
			$(".checkItem").prop("checked",checkedAll);
		});
		
		//为单个的复选框添加事件
		$("tbody").on("click",".checkItem",function(){
			
			var checkedTotal =  $(".checkItem:checked").length;
			var total = $(".checkItem").length;
			$("#checkAll").prop("checked",total==checkedTotal);
			
		});
		
		//为批量删除按钮添加事件
		$(".batchDeleteBtn").click(function(){
			
			var checked = $(".checkItem:checked");
			if(checked.length==0){
				layer.msg("请至少选择一个!");
				return false;
			}
			var array = new Array();
			//遍历已经选中的 获取id
			$.each(checked,function(){
				var certId = $(this).parents("tr").find("td:eq(0)").text();
				array.push(certId);
			})
			var certIds = array.join(",");
			//console.log(certIds);
			
			layer.confirm("确认删除吗",  {btn:["确定","取消"], title:'删除资质'}, function(cindex){
				$.post("${PATH}/cert/delete",{certIds:certIds},function(result){
					if(result="ok"){
						layer.msg("删除成功");
						loadCertData();
					}else{
						layer.msg("删除失败");
						loadCertData();
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