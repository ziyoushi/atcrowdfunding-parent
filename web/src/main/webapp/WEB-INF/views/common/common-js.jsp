<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="${PATH}/static/jquery/jquery-2.1.1.min.js"></script>
<script src="${PATH}/static/bootstrap/js/bootstrap.min.js"></script>
<script src="${PATH}/static/script/docs.min.js"></script>
<script src="${PATH}/static/script/back-to-top.js"></script>
<script src="${PATH}/static/ztree/jquery.ztree.all-3.5.min.js"></script>
<script src="${PATH}/static/layer/layer.js"></script>
<script type="text/javascript">
	//高亮
	$("div.tree a:contains('${title}')").css("color","red");
	$("div.tree a:contains('${title}')").parents("ul").show();

	$(function() {
		$(".list-group-item").click(function() {
			if ($(this).find("ul")) {
				$(this).toggleClass("tree-closed");
				if ($(this).hasClass("tree-closed")) {
					$("ul", this).hide("fast");
				} else {
					$("ul", this).show("fast");
				}
			}
		});
	});
</script>