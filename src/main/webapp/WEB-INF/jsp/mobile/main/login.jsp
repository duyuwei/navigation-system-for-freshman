<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/common/mobileheader.jsp" %>
<style type="text/css">
.login-form {
	text-align: center;
	width: 80%;
	margin: 60px auto 0;
}

input[type=text] {
	display: block;
	width: 100%;
	margin: 0 auto;
	outline: none;
	padding-top: 24px;
	padding-bottom: 24px;
}

.login-button {
	width: 100%;
	margin: 0 auto;
}

.radio-button {
	width: 100%
}
</style>

<script>
	ons.bootstrap();
	//var global_path = 'http://123.57.251.92:8080/nsff/';
	var global_path = "/nsff/";
	
	function login() {
		var queryString = $('#loginFrom').serialize();
		$.ajax({
			url : global_path + 'student/student_login.action',
			cache : false,
			async : true,
			type : "post",
			dataType : 'json',
			data : queryString,
			success : function(data) {
				if(data.result == 'success'){
					window.location.href=global_path + 'mobile/mobile_guide.action';
				}
				else{
					alert(data.msg);
				}
			},
			error : function(result) {
			}
		});
	}
</script>

<title>welcome</title>
</head>
<body>
	<ons-page>
	<h3 style="color:#0066FF" align="center">welcome</h3>
	<form id="loginFrom" class="login-form">
		<input type="text" name="student.id" class="text-input--underbar"
			placeholder="学号（位于通知上）" value=""> <input type="text"
			name="student.name" class="text-input--underbar" placeholder="姓名"
			value=""> <br>
		<ons-list-item> <span style="color: #666">是否预交学费</span>
		<ons-switch  modifier="list-item" checked></ons-switch>
		</ons-list-item>
		<br />

		<ons-button onclick="login()" modifier="large" class="login-button">进入</ons-button>
		<br>
		<br>
	</form>
	</ons-page>
</body>
</html>
