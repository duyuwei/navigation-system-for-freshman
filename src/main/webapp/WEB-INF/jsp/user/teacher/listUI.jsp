<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<title>教师用户管理</title>
<%@include file="/common/header.jsp"%>
<script type="text/javascript">
	function doDelete(id) {
		window.location.href = "${basePath}user/teacher_delete.action?teacher.id="
				+ id;
	}
	function doEdit(id) {
		window.location.href = "${basePath}user/teacher_editUI.action?teacher.id="
				+ id;
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
								<th>姓名</th>
								<th>用户名</th>
								<th>性别</th>
								<th>电话</th>
								<th>微信</th>
								<th>QQ</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<s:iterator value="teacherList">
								<tr>
									<td><s:property value="name" /></td>
									<td><s:property value="username" /></td>
									<td><s:property value="gender?'男':'女'" /></td>
									<td><s:property value="telephone" /></td>
									<td><s:property value="weChat" /></td>
									<td><s:property value="QQNumber" /></td>
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