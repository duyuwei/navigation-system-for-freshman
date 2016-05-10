<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<html>
<head>
<title>地点编辑</title>
<%@include file="/common/header.jsp"%>
</head>

<body>
	<%@include file="/common/nav.jsp"%>
	<div class="container-fluid">
		<div class="row">
			<%@include file="/common/left.jsp"%>
			<div class="col-sm-9  col-md-10  main" style="margin-top: 70px">
				<form action="${basePath}user/loc_edit.action" method="post" class="form-horizontal">
					<s:hidden name="loc.id"></s:hidden>
					<div class="form-group">
						<label for="inputType" class="col-sm-2 control-label">类型</label>
						<div class="col-sm-10">
							<s:select name="loc.type" cssClass="form-control" list="#{'教学楼':'教学楼','宿舍':'宿舍','食堂':'食堂','洗浴中心':'洗浴中心'}" />
						</div>
					</div>
					<div class="form-group">
						<label for="inputName" class="col-sm-2 control-label">名称</label>
						<div class="col-sm-10">
							<s:textfield type="text" id="inputName" cssClass="form-control" name="loc.name" />
						</div>
					</div>
					<div class="form-group">
						<label for="inputLocX" class="col-sm-2 control-label">位置X</label>
						<div class="col-sm-10">
							<s:textfield type="text" id="inputLocX" cssClass="form-control" name="loc.locX" />
						</div>
					</div>
					<div class="form-group">
						<label for="inputLocY" class="col-sm-2 control-label">位置Y</label>
						<div class="col-sm-10">
							<s:textfield type="text" id="inputLocY" cssClass="form-control" name="loc.locY" />
						</div>
					</div>

					<div class="form-group">
						<label for="inputintroduce" class="col-sm-2 control-label">介绍</label>
						<div class="col-sm-10">
							<s:textarea type="text" id="inputintroduce" cssClass="form-control" name="loc.introduce" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-default">保存保存</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>

