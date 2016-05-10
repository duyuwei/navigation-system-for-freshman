<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<title>新增教师管理员</title>
<%@include file="/common/header.jsp"%>
</head>

<body>
	<%@include file="/common/nav.jsp"%>
	<div class="container-fluid">
		<div class="row">
			<%@include file="/common/left.jsp"%>
			<div class="col-sm-9  col-md-10  main" style="margin-top: 70px">
				<form action="${basePath}user/teacher_add.action" method="post" class="form-horizontal">
					<div class="form-group">
						<label for="inputName" class="col-sm-2 control-label">姓名</label>
						<div class="col-sm-10">
							<s:textfield type="text" id="inputName" cssClass="form-control" name="teacher.name" />
						</div>
					</div>
					<div class="form-group">
						<label for="inputUsername" class="col-sm-2 control-label">用户名</label>
						<div class="col-sm-10">
							<s:textfield type="text" id="inputUsername" cssClass="form-control" name="teacher.username" />
						</div>
					</div>
					<div class="form-group">
						<label for="inputPassword" class="col-sm-2 control-label">密码</label>
						<div class="col-sm-10">
							<s:textfield type="password" id="inputUsername" cssClass="form-control" name="teacher.password" />
						</div>
					</div>
					<div class="form-group">
						<label for="inputGender" class="col-sm-2 control-label">性别</label>
						<div class="col-sm-10">
							<s:radio list="#{'true':'男','false':'女'}" id="inputGender" cssClass="radio-inline" name="teacher.gender" />
						</div>
					</div>
					<div class="form-group">
						<label for="inputtelephone" class="col-sm-2 control-label">电话</label>
						<div class="col-sm-10">
							<s:textfield type="text" id="inputtelephone" cssClass="form-control" name="teacher.telephone" />
						</div>
					</div>
					<div class="form-group">
						<label for="inputweChat" class="col-sm-2 control-label">微信</label>
						<div class="col-sm-10">
							<s:textfield type="text" id="inputweChat" cssClass="form-control" name="teacher.weChat" />
						</div>
					</div>
					<div class="form-group">
						<label for="inputQQNumber" class="col-sm-2 control-label">QQ</label>
						<div class="col-sm-10">
							<s:textfield type="text" id="inputQQNumber" cssClass="form-control" name="teacher.QQNumber" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-default">保存</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>