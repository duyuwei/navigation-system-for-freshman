<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>test page</title>
	<%@include file="/common/mobileheader.jsp" %>
    <script type="text/javascript" src="../common/ajax.js"></script>
    <script type="text/javascript">
  		//0未开始，1绿色通道，2交费处，3报到点，4宿舍，5报道导航完成
    	var xloc, yloc;
  		var stepNumber=0;
    </script>
  </head>
  
  <body>
  	<h2>一下是异步测试（测试前请登陆）</h2>
	<input type="button" onclick="ajaxUtil.setStep(100)" value="测试设置步骤"> 
	<br/>
	<input type="button" onclick="ajaxUtil.getStep()" value="测试获取步骤"> 
	<br/>
	<input type="button" onclick="ajaxUtil.getLoc(2)" value="测试获取坐标（缴费处）"> 
	<br/>
	<input type="button" onclick="ajaxUtil.getLoc(3)" value="测试获取坐标（接待处/报到点）"> 
	<br/>
	<input type="button" onclick="ajaxUtil.getLoc(4)" value="测试获取坐标（宿舍）"> 
	<br/>
	<h6>显示获取的坐标</h6>
	<input type="button" onclick="alert(xloc);alert(yloc)" value="测试获取坐标（显示坐标）"> 
	<h6>显示步骤（step）</h6>
	<input type="button" onclick="alert(stepNumber)" value="显示步骤（step）">

  </body>
</html>
