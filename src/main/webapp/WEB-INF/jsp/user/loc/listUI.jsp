<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<title>地点管理</title>
<%@include file="/common/header.jsp"%>
<script type="text/javascript">
	function doDelete(id) {
		window.location.href = "${basePath}user/loc_delete.action?loc.id=" + id;
	}
	function doEdit(id) {
		window.location.href = "${basePath}user/loc_editUI.action?loc.id=" + id;
	}
</script>
</head>

<body>
	<%@include file="/common/nav.jsp"%>
	<div class="container-fluid">
		<div class="row">
			<%@include file="/common/left.jsp"%>
			<div class="col-sm-9  col-md-10  main" style="margin-top: 70px">
				<div class="table-responsive">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>名称</th>
								<th>类别</th>
								<th>位置X</th>
								<th>位置Y</th>
								<th>介绍</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<s:iterator value="locs">
								<tr>
									<td><s:property value="name" /></td>
									<td><s:property value="type" /></td>
									<td><s:property value="locX" /></td>
									<td><s:property value="locY" /></td>
									<td><s:property value="introduce" /></td>
									<td><a href="javascript:doEdit('<s:property value='id'/>')">编辑</a> <a href="javascript:doDelete('<s:property value='id'/>')">删除</a></td>
								</tr>
							</s:iterator>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

