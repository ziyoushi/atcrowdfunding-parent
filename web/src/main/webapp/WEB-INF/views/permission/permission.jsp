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
	<link rel="stylesheet" href="css/main.css">
	<link rel="stylesheet" href="css/doc.min.css">
	<link rel="stylesheet" href="ztree/zTreeStyle.css"> -->
	<%@ include file="/WEB-INF/views/common/common-css.jsp" %>
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	</style>
  </head>

<%pageContext.setAttribute("title","权限维护");%>
  <body>

    <%@ include file="/WEB-INF/views/common/nav-bar.jsp" %>

    <div class="container-fluid">
      <div class="row">
        
        <%@ include file="/WEB-INF/views/common/side-bar.jsp" %>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

			<div class="panel panel-default">
              <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 许可权限管理 <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
                  <ul id="treeDemo" class="ztree"></ul>
			  </div>
			</div>
        </div>
      </div>
    </div>
    
    <!-- 新增权限模态框 -->
	<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增权限</h4>
				</div>
				<div class="modal-body">

					<form id="addForm">
						<div class="form-group">
							<label for="exampleInputEmail1">标题</label> 
							<input type="text" class="form-control" name="title" placeholder="请输入标题">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">图标</label> 
							<input type="text" class="form-control" name="icon" placeholder="请输入图标">
						</div>
						<div class="form-group">
							<input type="hidden" name="pid" />
							<label for="exampleInputEmail1">name</label> 
							<input type="text" class="form-control" name="name" placeholder="请输入name">
						</div>
						
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" id="saveBtn" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
	</div>

<!-- 修改权限模态框 -->
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改权限</h4>
				</div>
				<div class="modal-body">

					<form id="updateForm">
						
						<div class="form-group">
							<input type="hidden" name="id">
							<input type="hidden" name="pid" />
							<label for="exampleInputEmail1">权限标题</label> 
							<input type="text" class="form-control" name="title" placeholder="请输入标题">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">图标</label> 
							<input type="text" class="form-control" name="icon" placeholder="请输入图标">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">name</label> 
							<input type="text" class="form-control" name="name" placeholder="请输入name">
						</div>
						
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" id="updateBtn" class="btn btn-primary">修改</button>
				</div>
			</div>
		</div>
	</div>
    
    <!-- 给权限分配菜单模态框 -->
	<div class="modal fade" id="assignPermissionMenuModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">系统菜单</h4>
				</div>
				<div class="modal-body">
					<ul id="menuTreeDemo" class="ztree"></ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="assignPermissionMenuBtn" type="button" class="btn btn-primary">修改</button>
				</div>
			</div>
		</div>
	</div>
    
    
	<%@ include file="/WEB-INF/views/common/common-js.jsp" %>
        <script type="text/javascript">
        	var globalPermissionId = '';
            $(function () {
            	loadPermissionTree();
            });
            
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
        					addDiyDom : showMyIcon,//自定义图片,
        					addHoverDom : showBtnGroup,
        					removeHoverDom : removeBtnGroup
        				}
        			};
        			var zNodes = null;

        			$.get("${PATH}/permission/getAllPermissions", function(data) {
        				zNodes = data;
        				//添加数据
        				 zNodes.push({
        					id : 0,
        					title : "系统权限菜单",
        					icon : "glyphicon glyphicon-th"
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

    		function showBtnGroup(treeId, treeNode) {
    			var addBtn = $("<button permissionId='"+treeNode.id+"' title='添加' class='btn btn-success btn-xs glyphicon glyphicon-plus'></button> ");
    			var deleteBtn = $("<button permissionId='"+treeNode.id+"' title='删除' class='btn btn-danger btn-xs glyphicon glyphicon-minus'></button> ");
    			var updateBtn = $("<button permissionId='"+treeNode.id+"' title='修改' class='btn btn-primary btn-xs glyphicon glyphicon-pencil'></button> ");
    			var assignPermissionBtn = $("<button permissionId='"+treeNode.id+"' title='分配菜单' class='btn btn-info btn-xs glyphicon glyphicon-cog'></button> ");
    			var tid = treeNode.tId;
    			var btnGroup = $("<span id='"+tid+"_btngroup' class='curdBtnGroup'></span>");

    			var length = 0;
    			try {
    				length = treeNode.children.length;
    			} catch (e) {
    				length = 0;
    			}

    			if (treeNode.pid == 0 && length > 0) {
    				//当前元素是父菜单 并且有子元素 显示 + * 添加 修改
    				btnGroup.append(addBtn).append(" ").append(updateBtn).append(" ").append(assignPermissionBtn);
    			} else if (treeNode.pid == 0 && length == 0) {
    				//当前元素是父菜单  没有子元素 显示 添加 删除 修改
    				btnGroup.append(addBtn).append(" ").append(deleteBtn).append(" ").append(updateBtn);
    			} else if (treeNode.pid > 0) {
    				//当前元素是子菜单 显示 删除 修改
    				btnGroup.append(deleteBtn).append(" ").append(updateBtn).append(" ").append(assignPermissionBtn);
    			} else if (treeNode.id == 0) {
    				//说明是系统权限菜单 根
    				btnGroup.append(addBtn);
    			}

    			if ($("#" + tid + "_a").nextAll("#" + tid + "_btngroup").length == 0) {
    				$("#" + tid + "_a").after(btnGroup);
    			}
    			
    		}

    		function removeBtnGroup(treeId, treeNode) {
    			//鼠标从当前元素身上移出去了。
    			var tid = treeNode.tId;
    			$("#" + tid + "_a").nextAll("#" + tid + "_btngroup").remove();
    		}

    		//给crud添加事件
    		$("#treeDemo").on("click", ".curdBtnGroup", function(e) {

    			var target = e.target;//传入的是当前被点击的元素
    			if ($(target).hasClass("btn-success")) {
    				addPermission($(target).attr("permissionId"));
    			}
    			if ($(target).hasClass("btn-primary")) {
    				updatePermission($(target).attr("permissionId"));
    			}
    			if ($(target).hasClass("btn-danger")) {
    				detelePermission($(target).attr("permissionId"));
    			}
    			if ($(target).hasClass("btn-info")) {
    				assignPermission($(target).attr("permissionId"));
    			}

    		});

    		function addPermission(permissionId) {
    			$("#addForm input[name='pid']").val(permissionId);
    			//新增模态框
    			$("#addModal").modal({show:true,backdrop:'static'});
    		}
    		
    		$("#saveBtn").click(function(){
    			
    			$.post("${PATH}/permission/add",$("#addForm").serialize(),function(result){
    				
    				if(result == "ok"){
    					layer.msg("新增成功",{icon:6,time:1000});
    					//关闭模态框
    					$("#addModal").modal("hide");
    					//重新加载树
    					loadPermissionTree();
    				}
    				
    			});
    		});

    		function updatePermission(permissionId) {
    			console.log('修改打印的permissionId'+permissionId);
    			//根据menuId查找出菜单 回显
    			$.get("${PATH}/permission/get",{permissionId:permissionId},function(result){
    				//查询后回显
    				$("#updateForm input[name='id']").val(result.id);
    				$("#updateForm input[name='pid']").val(result.pid);
    				$("#updateForm input[name='name']").val(result.name);
    				$("#updateForm input[name='icon']").val(result.icon);
    				$("#updateForm input[name='title']").val(result.title);
    			});
    			
    			$("#updateModal").modal({show:true,backdrop:"static"});
    			
    		}
    		
    		$("#updateBtn").click(function(){
    			
    			$.post("${PATH}/permission/update",$("#updateForm").serialize(),function(result){
    				if(result == "ok"){
    					//修改成功
    					layer.msg("修改成功",{icon:6,time:1000});
    					//关闭模态框
    					$("#updateModal").modal("hide");
    					loadPermissionTree();
    				}
    			});
    			
    		});

    		function detelePermission(permissionId) {

    			layer.confirm("确认删除吗",  {icon: 3, title:'提示'}, function(cindex){
    				
    				$.get("${PATH}/permission/delete",{permissionId:permissionId},function(result){
    					if(result=="ok"){
    						layer.msg("删除成功",{icon:6,time:1000});
    						loadPermissionTree();
    					}else {
    						layer.msg("删除失败",{icon:6,time:1000});
    						loadPermissionTree();
    					}
    				});
    				
    			    layer.close(cindex);
    			}, function(cindex){
    			    layer.close(cindex);
    			});
    		}
    		
    		function assignPermission(permissionId){
    			globalPermissionId = permissionId;
    			
    			//根据权限id查询出其对应的菜单 用于回显
    			$.get("${PATH}/permission/getMenusById",{permissionId:permissionId},function(data){
    				//获取节点之前先进行清空
    				menuTreeObj.checkAllNodes(false);
    				$.each(data,function(){
    					console.log('获取到permissionId===='+this.id);
    					var treeNode = menuTreeObj.getNodeByParam("id", this.id, null);
    					menuTreeObj.checkNode(treeNode, true, false);
    				});
    				
    			});
    			//弹出模态框
    			$("#assignPermissionMenuModal").modal({show:true,backdrop:'static'});
    			
    		}
    		
    		$("#assignPermissionMenuBtn").click(function(){
    			
    			//获取已经选中的复选框
    			var array = new Array();
    			var menuNodes = menuTreeObj.getCheckedNodes(true);
    			//console.log('选中的nodes=='+menuNodes);
    			$.each(menuNodes,function(){
    				var menuId = this.id
    				//console.log('------'+menuId);
    				array.push(menuId);
    			});
    			var menuIds = array.join(",");
    			
    			$.post("${PATH}/permission/assignPermissionMenu",{permissionId:globalPermissionId,menuIds:menuIds},function(result){
    				if(result=="ok"){
    					layer.msg("分配菜单成功");
    					$("#assignPermissionMenuModal").modal("hide");
    					loadPermissionTree();
    				}else{
    					layer.msg("分配菜单失败");
    					$("#assignPermissionMenuModal").modal("hide");
    					loadPermissionTree();
    				}
    				
    				
    			});
    			
    		});
            
    		
            
            
        </script>
        
        <!-- 加载菜单树 -->
        <script type="text/javascript">
        var menuTreeObj = null;
	        $(function() {
				loadMenuTree();
			});
	        
	        function loadMenuTree() {

				var setting = {
					data : {
						simpleData : {
							enable : true,
							pIdKey : "pid"
						},
						key : {
							url : "xxx"
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

				$.get("${PATH}/menu/getAllMenus", function(data) {
					zNodes = data;
					//添加数据
					zNodes.push({
						id : 0,
						name : "系统菜单",
						icon : "glyphicon glyphicon-calendar"
					});
					//
					menuTreeObj = $.fn.zTree.init($("#menuTreeDemo"), setting, zNodes);

					//打开树
					menuTreeObj.expandAll(true);

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
    