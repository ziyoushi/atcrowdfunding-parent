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
	pageContext.setAttribute("title", "角色维护");
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
									<input class="form-control has-success" name="condition"
										type="text" placeholder="请输入查询条件">
								</div>
							</div>
							<button type="button" id="searchBtn" class="btn btn-warning">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<button type="button" class="btn btn-danger" id="batchDelete"
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
					<h4 class="modal-title" id="myModalLabel">添加角色</h4>
				</div>
				<div class="modal-body">
					<form id="addRoleForm">
						<div class="form-group">
							<label for="">角色名称</label> 
							<input type="text" class="form-control" name="name" placeholder="角色名称">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="saveRoleBtn" type="button" class="btn btn-primary">保存</button>
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
					<h4 class="modal-title" id="myModalLabel">修改角色</h4>
				</div>
				<div class="modal-body">
					<form id="updateRoleForm">
						<div class="form-group">
						<input type="hidden" name="id" />
							<label for="">角色名称</label> 
							<input type="text" class="form-control" name="name" placeholder="角色名称">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="updateRoleBtn" type="button" class="btn btn-primary">修改</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 给角色分配权限模态框 -->
	<div class="modal fade" id="assignRolePermissionModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">系统权限菜单</h4>
				</div>
				<div class="modal-body">
					<ul id="treeDemo" class="ztree"></ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="assignRolePermissionRoleBtn" type="button" class="btn btn-primary">修改</button>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/views/common/common-js.jsp"%>

	<script type="text/javascript">
        //全局常量
        	var globalPageNum = 1;
        	var globalPageSize = 3;
        	var globalCondition = '';
        
        	$(function(){
        		
        		loadRoles();
        		
        	});
        	
        	//异步调用查询
        	function loadRoles(){
        		
        		$.get("${PATH}/role/getAllRoles",{pageNum:globalPageNum,pageSize:globalPageSize,condition:globalCondition},function(pageInfo){
       				//将数据展示到tbody 中
       				buildTableContent(pageInfo.list);
       				
       				//将数据展示到分页导航栏
       				buildPageContent(pageInfo);	
        			
        		});
        		
        	}
        	
        	function buildTableContent(list){
        		//清空表单数据
        		$("tbody").empty();
        		
        		//遍历数据
        		$.each(list,function(i,e){
        			
	        		//创建tr
	        		var tr = $('<tr></tr>');
	        		var td1 = $('<td>'+(e.id)+'</td>')
	        		var td2 = $('<td><input type="checkbox" class="checkItem"></td>');
	        		var td3 = $('<td>'+e.name+'</td>');
	        		tr.append(td1);
	        		tr.append(td2);
	        		tr.append(td3);
	        		var btnGroup = $('<td></td>');
	        		btnGroup.append('<button roleId='+e.id+' type="button" class="btn btn-success btn-xs assignRolePermission"><i class=" glyphicon glyphicon-check"></i></button> ');
        			btnGroup.append('<button roleId='+e.id+' type="button" class="btn btn-primary btn-xs updateItem"><i class=" glyphicon glyphicon-pencil"></i></button> ');
        			btnGroup.append('<button roleId='+e.id+' type="button" class="btn btn-danger btn-xs deleteItem"><i class=" glyphicon glyphicon-remove"></i></button> ');
	        		tr.append(btnGroup);
	        		
        			$("tbody").append(tr);
        			
        		});
        		
        	}
        	
        	function buildPageContent(pageInfo){
        		$("ul.pagination").empty();
        		//首页 
        		var firstPage = '<li pn='+1+'><a href="#">首页</a></li>';
        		$("ul.pagination").append(firstPage);
        		
        		if(pageInfo.hasPreviousPage){
        			//上一页 pageInfo.prePage
            		var prePage = '<li pn='+pageInfo.prePage+'><a href="#">上一页</a></li>';
            		$("ul.pagination").append(prePage);
        		}
        		
        		//遍历导航栏 追加到ul里 pagination
        		$.each(pageInfo.navigatepageNums,function(){
        			//this表示当前
        			var li = '';
        			//如果是当前页 则高亮
        			if(pageInfo.pageNum == this){
        				 li = '<li pn='+this+' class="active"><a href="#">'+this+'</a></li>';
        			}else if(pageInfo.pageNum != this){
        				 li = '<li pn='+this+'><a href="#">'+this+'</a></li>';
        			}
        			
        			$("ul.pagination").append(li);
        		});
        		
        		if(pageInfo.hasNextPage){
        			//下一页pageInfo.hasNextPage
            		var nextPage = '<li pn='+pageInfo.nextPage+'><a href="#">下一页</a></li>';
            		$("ul.pagination").append(nextPage);
        		}
        		
        		//尾页 pages
        		var lastPage = '<li pn='+pageInfo.pages+'><a href="#">尾页</a></li>';
        		$("ul.pagination").append(lastPage);
        		
        	}
        	
        	//为分页导航栏添加点击事件
        	$("ul.pagination").on("click","li",function(){
        		var pageNum = $(this).attr("pn");
        		globalPageNum = pageNum;
        		//alert($(this).attr("pn"))
        		loadRoles();
        	});
        	
        	//为模糊查询添加点击事件
        	$("#searchBtn").click(function(){
        		
        		//获取condition的值 并且赋值给全局变量
        		var condition = $("#searchForm input[name='condition']").val();
        		//console.log('获取到的condition的值'+condition);
        		globalCondition = condition;
        		loadRoles();
        		
        	});
        	
        	//为新增按钮增加点击事件
        	$("#addBtn").click(function(){
        		console.log(1);
        		//点击后 弹出模态框
        		$("#addModal").modal({show:true,backdrop:'static'});
        		
        	});
        	
        	//点击保存按钮 添加角色
        	$("#saveRoleBtn").click(function(){
        		
        		var name = $("#addRoleForm input[name='name']").val();
        		
        		$.post("${PATH}/role/add",{name:name},function(result){
        			
        			if(result == "ok"){
        				layer.msg("添加成功",{time:1000, icon:5});
        				//说明新增成功
        				globalPageNum = 1000;
        				//关闭模态框
        				$("#addModal").modal('hide');
        				//添加成功后 跳转到最后页
        				loadRoles();
        				
        			}else {
        				//添加失败 还在该页面 待写
        				
        			}
        			
        		});
        		
        	});
        	
        	//点击单个删除
        	$("tbody").on("click",".deleteItem",function(){
        		
        		var roleId = $(this).attr("roleId");
        		
        		layer.confirm("确定要删除吗？",{btn:["确定","取消"],title:"删除提示框"}, function(cindex){
            		$.get("${PATH}/role/delete",{ids:roleId},function(result){
            			if(result=="ok"){
            				//删除成功
            				layer.msg("删除成功",{icon:6,time:1000});
            				loadRoles();
            			}
            		});
    			    layer.close(cindex);
    			}, function(cindex){
    			    layer.close(cindex);
    			});
        		
        	});
        	
        	//全选全不选
        	$("#checkAll").click(function(){
        		
        		var allChecked = $(this).prop("checked");
        		console.log(allChecked);
        		
        		//获取全选的checked属性
    			var allChecked = $(this).prop("checked");
    			console.log('allChecked==='+allChecked);
    			//给下面的每个check设值
    			$(".checkItem").prop("checked",allChecked);
        		
        	});
        	
        	//$(".checkItem").click();
        	$("tbody").on("click",".checkItem",function(){
        		
        		//总数
        		var total = $(".checkItem").length;
        		//console.log(total);
        		//已经选中的数量
        		var checked= $(".checkItem:checked").length;
        		
        		$("#checkAll").prop("checked",total==checked);
        		
        	});
        	
        	
        	//批量删除
        	$("#batchDelete").click(function(){
        		
        		var checked = $(".checkItem:checked");
    			
    			if(checked.length ==0){
    				layer.msg("至少选择一个",{icon:6,time:1000});
    				return false;
    			}
    			
    			var array = new Array();
    			$.each(checked,function(){
    				//var id = e.id;
    				//console.log('每个id='+id);
    				var id = $(this).parents("tr").find("td:eq(0)").text();
    				array.push(id);
    			});
    			
    			var ids = array.join(",");
    			console.log('ids==='+ids);
    			 layer.confirm("确定要删除吗？",{btn:["确定","取消"],title:"删除提示框"}, function(cindex){
            		$.get("${PATH}/role/delete",{ids:ids},function(result){
            			if(result=="ok"){
            				//删除成功
            				layer.msg("删除成功",{icon:6,time:1000});
            				loadRoles();
            			}
            		});
    			    layer.close(cindex);
    			}, function(cindex){
    			    layer.close(cindex);
    			}); 
        		
        	});
        	
        	//修改
        	$("tbody").on("click",".updateItem",function(){
        		
        		var roleId = $(this).attr("roleId");
        		console.log(roleId);
        		
        		//根据id查询角色 做回显
        		$.get("${PATH}/role/get",{id:roleId},function(result){
        			//给修改模态框赋值
        			$("#updateModal input[name='name']").val(result.name);
        			$("#updateModal input[name='id']").val(result.id);
        		});
        		
        		//弹出修改模态框
        		$("#updateModal").modal({show:true,backdrop:'static'});
        		
        	});
        	
        	//修改
        	$("#updateRoleBtn").click(function(){
        		
        		$.post("${PATH}/role/update",$("#updateRoleForm").serialize(),function(result){
        			
        			if(result == "ok"){
        				layer.msg("修改成功",{icon:6,time:1000});
        				$("#updateModal").modal("hide");
        				
        				loadRoles();
        			}else{
        				layer.msg("修改失败",{icon:6,time:1000});
        				$("#updateModal").modal("hide");
        			}
        			
        		});
        		
        	});
           
        </script>
        
        <!-- 给角色分配权限功能 -->
        <script type="text/javascript">
        var globalRoleId = '';
        var treeObj = null;
        	$(function(){
        		loadPermissionTree();
        	});
        	
        	//为授权按钮绑定点击事件
        	$("tbody").on("click",".assignRolePermission",function(){
        		
        		globalRoleId = $(this).attr("roleId");
        		//layer.msg($(this).attr("roleId"));
        		
        		//根据roleId查询权限树中是否有选中想 todo
        		$.post("${PATH}/role/getPermssiionByRoleId",{roleId:globalRoleId},function(data){
        			console.log(globalRoleId+'根据roleId查询出来的data===='+data);
        			//遍历之前先清空 复选框 重要
        			treeObj.checkAllNodes(false);
        			//遍历data
        			$.each(data,function(){
        				//根据指定元素 获取treeNode
        				var treeNode = treeObj.getNodeByParam("id", this.id, null);
        				//勾选需要回显的数据
        				treeObj.checkNode(treeNode, true, false);
        				
        			});
        		});
        		
        		//弹出模态框
        		$("#assignRolePermissionModal").modal({show:true,backdrop:'static'});        		
        	});
        	
        	//点击修改按钮 来修改角色对应的权限
        	$("#assignRolePermissionRoleBtn").click(function(){
        		
        		//获取已经选中的权限id 
        		//console.log(treeObj.getCheckedNodes(true));
        		var array = new Array();
        		//遍历 获取对应的id
        		$.each(treeObj.getCheckedNodes(true),function(){
        			console.log('获取到已经选中的id===='+this.id);
        			array.push(this.id);
        		});
        		var permissionIds = array.join(",");
        		
        		//修改权限
        		$.post("${PATH}/role/assignRolePermission",{roleId:globalRoleId,permissionIds:permissionIds},function(result){
        			if(result=="ok"){
        				layer.msg("分配权限成功");
        				//关闭模态框
        				$("#assignRolePermissionModal").modal("hide");
        			}else{
        				layer.msg("分配失败");
        			}
        		});
        		
        	});
        	
        	//展示权限树
        	function loadPermissionTree(){
            	var setting = {
        				data : {
        					simpleData : {
        						enable : true,
        						pIdKey : "pid"
        					},
        					key : {
        						url : "xxx",
        						name: "title"
        					}
        				},
        				view : {
        					addDiyDom : showMyIcon//自定义图片,
        					
        				},
        				check: {
        					enable: true
        				}
        			};
        			var zNodes = null;

        			$.get("${PATH}/permission/getAllPermissions", function(data) {
        				zNodes = data;
        				//添加数据
        				 zNodes.push({
        					id : 0,
        					title : "系统权限菜单",
        					icon : "glyphicon glyphicon-calendar"
        				}); 
        				//
        				treeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);

        				//打开树
        				treeObj.expandAll(true);

        			});
            	
            }
        	
        	function showMyIcon(treeId, treeNode) {
    			console.log(treeNode);
    			var tId = treeNode.tId;
    			var iconSpan = $("<span class='"+treeNode.icon+"'></span>")
    			$("#" + tId + "_ico").removeClass();//清除默认样式
    			$("#" + tId + "_ico").after(iconSpan);//使用自己的图标span;
    		}
        	
        	
        
        </script>
        
        
</body>
</html>
