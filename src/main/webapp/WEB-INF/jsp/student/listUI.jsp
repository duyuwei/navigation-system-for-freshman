<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<title>学生报到情况查看</title>
<%@include file="/common/header.jsp"%>
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
								<th>班级</th>
								<th>学院</th>
								<th>电话</th>
								<th>位置X</th>
								<th>位置Y</th>
								<th>步骤</th>
								<th>宿舍</th>
							</tr>
						</thead>
						<tbody>
							<s:iterator value="students">
								<tr>
									<td><s:property value="name" /></td>
									<td><s:property value="grade.name" /></td>
									<td><s:property value="grade.college.name" /></td>
									<td><s:property value="telephone" /></td>
									<td><s:property value="LocX" /></td>
									<td><s:property value="LocY" /></td>
									<td><s:property value="step" /></td>
									<td><s:property value="dormID" /></td>
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
