<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<title>新增地点</title>
<%@include file="/common/header.jsp"%>
<style type="text/css">
body {
	padding-top: 40px;
	padding-bottom: 40px;
	background-color: #eee;
}

.form-signin {
	max-width: 330px;
	padding: 15px;
	margin: 0 auto;
}

.form-signin .form-signin-heading,.form-signin .checkbox {
	margin-bottom: 10px;
}

.form-signin .checkbox {
	font-weight: normal;
}

.form-signin .form-control {
	position: relative;
	height: auto;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	padding: 10px;
	font-size: 16px;
}

.form-signin .form-control:focus {
	z-index: 2;
}

.form-signin input[type="email"] {
	margin-bottom: -1px;
	border-bottom-right-radius: 0;
	border-bottom-left-radius: 0;
}

.form-signin input[type="password"] {
	margin-bottom: 10px;
	border-top-left-radius: 0;
	border-top-right-radius: 0;
}
</style>
</head>
<body>

	<div class="container">

		<form class="form-signin" action="/nsff/student/student_listUI.action">
			<h2 class="form-signin-heading">新生导航系统</h2>
			<label for="inputUsername" class="sr-only">用户名</label> <input type="text" id="inputUsername" class="form-control" placeholder="请输入用户名" required autofocus> <label for="inputPassword"
				class="sr-only">密码</label> <input type="password" id="inputPassword" class="form-control" placeholder="请输入密码" required>
			<div class="checkbox">
				<label> <input type="checkbox" value="remember-me"> 保持登陆
				</label>
			</div>
			<button class="btn btn-lg btn-primary btn-block" type="submit">登陆</button>
		</form>

	</div>

</body>
</html>