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
	<%@ include file="/WEB-INF/views/common/common-css.jsp" %>
	
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
  </head>
<%pageContext.setAttribute("title","广告审核");%>
  <body>

    <%@ include file="/WEB-INF/views/common/nav-bar.jsp" %>

    <div class="container-fluid">
      <div class="row">
        
        <%@ include file="/WEB-INF/views/common/side-bar.jsp" %>
        
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
                  <th>广告描述</th>
                  <th>时间</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>1</td>
                  <td>XXXXXXXXXXXX商品广告</td>
                  <td>2017-06-01</td>
                  <td>
                      <button type="button" class="btn btn-success btn-xs"><i class="glyphicon glyphicon-eye-open"></i></button>
				  </td>
                </tr>
                <tr>
                  <td>2</td>
                  <td>XXXXXXXXXXXX商品广告</td>
                  <td>2017-06-01</td>
                  <td>
                      <button type="button" class="btn btn-success btn-xs"><i class="glyphicon glyphicon-eye-open"></i></button>
				  </td>
                </tr>
                <tr>
                  <td>3</td>
                  <td>XXXXXXXXXXXX商品广告</td>
                  <td>2017-06-01</td>
                  <td>
                      <button type="button" class="btn btn-success btn-xs"><i class="glyphicon glyphicon-eye-open"></i></button>
				  </td>
                </tr>
              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="4" align="center">
						<ul class="pagination">
								<li class="disabled"><a href="#">上一页</a></li>
								<li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
								<li><a href="#">2</a></li>
								<li><a href="#">3</a></li>
								<li><a href="#">4</a></li>
								<li><a href="#">5</a></li>
								<li><a href="#">下一页</a></li>
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

	<%@include file="/WEB-INF/views/common/common-js.jsp" %>
        <script type="text/javascript">
            $(function () {
			    
            });
        </script>
  </body>
</html>
    