<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@include file="/common/mobileheader.jsp" %>
<title>欢迎新生</title>
<style type="text/css">
ons-carousel-item {
  display: table;
  text-align: center;
}
.item-label {
  display: table-cell;
  vertical-align:top;
  width:100%;
  font-size:larger;
  text-align:left;
  color: white;
  line-height: 1;
  font-weight:bolder;
  top:10%;
}
.cover-label {
  text-align: center;
  position: absolute;
  left: 0px;
  width: 100%;
  bottom: 10px;
  color: blue;
}
.button--outline {
width:40%;
height:10%;
position:absolute;
top:80%;
left:30%;
color:#000000

}
.center{
line-height:50px;
}
</style>
<script type="text/javascript">
ons.bootstrap();
</script>
</head>

<body>
  <ons-page>
    <ons-toolbar>
      <div class="center"  style="background-color:#FFFFFF">报到流程</div>
    </ons-toolbar>
    <ons-carousel swipeable overscrollable auto-scroll auto-scroll-ratio=0.1 fullscreen var="carousel">
	      <ons-carousel-item style="background-color:#FFFFFF;">
		 <ons-list style="background-color:#FFFFFF;">
          <ons-list-header style="background-color:#FFFFFF;" >流程简介：</ons-list-header>
          <ons-list-item>一、预交学费</ons-list-item>
          <ons-list-item>二、寻找本学院接待点报到</ons-list-item>
          <ons-list-item>三、交资料，领亲卡，分宿舍</ons-list-item>
          <ons-list-item>四、领钥匙，放行李，见室友</ons-list-item>
          <ons-list-item>五、买东西，逛学校，找老乡</ons-list-item>
          <ons-list-item>六、导员点名，查看报到情况</ons-list-item>
        </ons-list>	
		<a href="${basePath}mobile/main/main4.html"><button class="button button--outline">跳过详细介绍</button></a>
      </ons-carousel-item>

      <ons-carousel-item style="background-color: #1DFE05;">
        <div class="item-label">
		<br>
		一、预交学费:<hr/>&nbsp&nbsp&nbsp&nbsp
		如未预交学费，需要先到行政楼交齐学费再报到。
		</div>
		<a href="${basePath}mobile/main/main4.html"><button class="button button--outline">跳过介绍</button></a>
      </ons-carousel-item>
      <ons-carousel-item style="background-color:#0AAC49;">
        <div class="item-label">
		<br>
		二、寻找本学院接待点报到:<hr/>&nbsp&nbsp&nbsp&nbsp	    在报道期间各学院将在学校主干道设立报到点，同学们可导航至所属学院报报到点报到。接待人员将对新生进行安排。（如需办理绿色通道，请到本学院办公楼办理）</div>
		<a href="${basePath}mobile/main/main4.html"><button class="button button--outline">跳过介绍</button></a>
      </ons-carousel-item>
      <ons-carousel-item style="background-color:#248750;">
        <div class="item-label">
		<br>三、交资料，领亲卡，分宿舍。<hr/>
		1）在本学院报到点请将录取通知书、学籍档案等资料（具体内容请询接待人员）交齐。<br/><br/>
		2）交齐资料将发放亲卡（即一卡通），本卡为食堂吃饭、超市购物、澡堂用水、图书馆门禁及借阅等通用。<br/><br/>
		3）接待人员将为您分配宿舍，并有分配单；手续完成，您可步行导航至宿舍楼。<br/><br/>
		</div>
		<a href="${basePath}mobile/main/main4.html"><button class="button button--outline">跳过介绍</button></a>
      </ons-carousel-item>
      <ons-carousel-item style="background-color: #12A7FE;">
        <div class="item-label"><br>四、领钥匙，放行李，见室友<hr/>
		1）	持票据可在宿舍楼管处领取宿舍钥匙，宿舍人员每人一把；<br/><br/>
		2）	自选床铺，安置行李；<br/><br/>
		3）	如果来的早可先行打扫宿舍卫生，等待即将一起生活四年的室友。<br/><br/>
		</div>
		<a href="${basePath}mobile/main/main4.html"><button class="button button--outline">跳过介绍</button></a>
      </ons-carousel-item>
	  <ons-carousel-item style="background-color: #4F69FE;">
        <div class="item-label"><br>五、买东西，逛学校，找老乡<hr/>
		1）	宿舍整理完毕，可在超市等处采购生活用品，以迎接新生活；<br/><br/>
		2）	自由时间可利用本系统‘校园观光’、‘学校周边’等功能熟悉环境；<br/><br/>
		3）	可利用本系统‘找老乡’功能联系老乡。<br/><br/>

		</div>
		<a href="${basePath}mobile/main/main4.html"><button class="button button--outline">跳过介绍</button></a>
      </ons-carousel-item>
	  <ons-carousel-item style="background-color: #369CFE;">
        <div class="item-label"><br>六、导员点名<hr/>&nbsp&nbsp&nbsp&nbsp
		报道完毕，导员将定下时间与同学们见面点名，查看报到情况，有什么问题可多与导员导师交流。<br/><br/>
		</div>
		<a href="${basePath}mobile/main/main4.html"><button class="button button--outline">进入导航</button></a>
      </ons-carousel-item>
	  <ons-carousel-cover><div class="cover-label">< < < 左滑以查看详细介绍 < < < </div></ons-carousel-cover>		
  </ons-page>
</body>
</html>
