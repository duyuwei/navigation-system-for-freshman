<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%@include file="/common/mobileheader.jsp" %>
    <script type="text/javascript" src="../common/ajax.js"></script>

    <!--<script type="text/javascript">
    function disp_alert()
    {
    alert("我是一个消息框！")
    }
    </script>
    -->

    <script type="text/javascript">
        var xloc, yloc, locationName, stepNumber, TimeO;
        var isStart = 0;
        var isNavigation = false;

        function alert1() {

            ons.notification.alert({ message: '确定退出吗？' });

        };

        function confirm() {
            ons.notification.confirm({
                message: '是否开始下一次导航 ?',
                callback: function (idx) {
                    switch (idx) {
                        case 0:
                            if (stepNumber==1||stepNumber==2) {
                                stepNumber = 3;
                                //写入数据库
                                ajaxUtil.setstepNumber(stepNumber);
                            }
                            if (stepNumber==2||stepNumber==4) {
                                stepNumber = stepNumber + 1;
                                //写入数据库
                                ajaxUtil.setStep(stepNumber);
                            }
                            break;
                        case 1:
                            if (stepNumber == 1 || stepNumber == 2) {
                                stepNumber = 3;
                                //写入数据库
                                ajaxUtil.setStep(stepNumber);
                            }
                            if (stepNumber == 2 || stepNumber == 4) {
                                stepNumber = stepNumber + 1;
                                //写入数据库
                                ajaxUtil.setStep(stepNumber);
                            }
                            //得到终点坐标
							ajaxUtil.getLoc(stepNumber);
                            clearElements();
                            clearTimeout(TimeO);
                            isStart = 0;
                            geoLocation();
                            break;
                    }
                }
            });
        }

        //0未开始，1绿色通道，2交费处，3报到点，4宿舍，5报道导航完成
        function confirm_step0() {
            ons.notification.confirm({
                message: '请确定是否已经缴费 ?',
                callback: function (idx) {
                    switch (idx) {
                        case 0:
                            stepNumber = stepNumber + 3;
                            //写进数据库
                            ajaxUtil.setStep(stepNumber);
                            //获取到达报到点的坐标
                            ajaxUtil.getLoc(stepNumber);
                            //xloc = 4158.5057275359;
                            //yloc = -3151.8838173298;
                            init();
                            geoLocation(locationName);
                            break;
                        case 1:
                            confirm_step1();
                            break;
                    }
                }
            });
        }

        function confirm_step1() {
            ons.notification.confirm({
                message: '是否选择绿色通道 ?',
                callback: function (idx) {
                    switch (idx) {
                        case 0:
                            stepNumber = stepNumber + 2;
                            //写进数据库
                            ajaxUtil.setStep(stepNumber);
                            //获取到达报到点的坐标
                            //xloc = 4158.5057275359;
                            //yloc = -3151.8838173298;
                            ajaxUtil.getLoc(stepNumber);
                            init();
                            geoLocation(locationName);
                            break;
                        case 1:
                            stepNumber = stepNumber + 1;
                            //写进数据库
                            ajaxUtil.setStep(stepNumber);
                            //获取到达报到点的坐标
                            //xloc = 4158.5057275359;
                            //yloc = -3151.8838173298;
                            ajaxUtil.getLoc(stepNumber);
                            init();
                            geoLocation(locationName);
                            break;
                    }
                }
            });
        }

        $(function () {
            myNavigator.on('postpush', function (event) {
                //根据locationName，判断是否需要开始导航，进入特定的一些页面才进入导航
                if (isNavigation && locationName == "开始入学导航" && stepNumber == 0) {
                    confirm_step0();
                    alert("daishikaohangle");
                    return;
                }


                if (isNavigation) {
                    init();
                    geoLocation(locationName);
                }



            });

            myNavigator.on('postpop', function (event) {
                isStart = 0;
                isNavigation = false;

            });

            //TimeO = setTimeout(geoLocation(), 30000);
            //clearTimeout(TimeO);
        });

        function getReady(id) {


            locationName = $.trim(id.innerText);
            if (locationName=="开始入学导航") {
                //得到开始入学导航的导航步骤
            }
            //得到终点坐标
            //xloc=4158.5057275359;
            //yloc = -3151.8838173298;
            ajaxUtil.getLoc(stepNumber);
            isNavigation = true;

        }



        //var host = document.location.toString().match(/file:\/\//) ? "http://localhost:8090" : 'http://' + document.location.host;
        var host = "http://localhost:8090";
        var local, map, layer, vectorLayer, markerLayer, geolocate,
        drawPoint, select,marker,
        nodeArray = [], pathTime, i = 0, j = 0,
        style = {
            strokeColor: "#304DBE",
            strokeWidth: 3,
            pointerEvents: "visiblePainted",
            fill: false
        },
        styleGuidePoint = {
            pointRadius: 10,
            externalGraphic: "images/walk.png"
        },
        styleGuideLine = {
            strokeColor: "#25FF25",
            strokeWidth: 6,
            fill: false
        },
        url1 = host + "/iserver/services/map-changchun/rest/maps/长春市区图",
        url2 = host + "/iserver/services/transportationanalyst-sample/rest/networkanalyst/RoadNet@Changchun";
        //加载地图
        function init() {
            vectorLayer = new SuperMap.Layer.Vector("Vector Layer");

            drawPoint = new SuperMap.Control.DrawFeature(vectorLayer, SuperMap.Handler.Point);

            select = new SuperMap.Control.SelectFeature(vectorLayer, { onSelect: onFeatureSelect, onUnselect: onFeatureUnselect });

            drawPoint.events.on({ "featureadded": drawCompleted });
            map = new SuperMap.Map("map", {
                controls: [
                new SuperMap.Control.LayerSwitcher(),
                new SuperMap.Control.Zoom(),
                new SuperMap.Control.Navigation({
                    dragPanOptions: {
                        enableKinetic: true
                    }
                }),
                drawPoint,
                select], units: "m"
            });

            //添加geo定位控件
            //地理定位控件包装了w3c 的geolocation 接口，与map结合使用；在位置改变时可以响应事件。
            //通过 activate 和 deactivate 两个方法，实现动态的激活和注销。
            geolocate = new SuperMap.Control.Geolocate({
                bind: false,
                geolocationOptions: {
                    //指示浏览器获取高精度的位置，默认为false
                    enableHighAccuracy: false,
                    maximumAge: 0
                },
                eventListeners: {
                    //locationupdated 当浏览器返回新的位置时触发。
                    //locationfailed 当地理定位失败时触发。
                    //locationuncapable 当前浏览器不支持地理定位时触发。
                    "locationupdated": getGeolocationCompleted,
                    "locationfailed": getGeolocationFailed
                }
            });
            //激活控件
            map.addControl(geolocate);

            layer = new SuperMap.Layer.TiledDynamicRESTLayer("Changchun", url1, { transparent: true, cacheEnabled: true }, { maxResolution: "auto" });
            layer.events.on({ "layerInitialized": addLayer });
            markerLayer = new SuperMap.Layer.Markers("Markers");
        }

        function addLayer() {
            map.addLayers([layer, vectorLayer, markerLayer]);
            map.setCenter(new SuperMap.LonLat(4503.6240321526, -3861.911472192499), 1);
        }

        //响应选择站点按钮点击事件
        function selectPoints() {
            clearElements();
            drawPoint.activate();
        }

        //当添加要素时会触发此事件
        function drawCompleted(drawGeometryArgs) {
            var point = drawGeometryArgs.feature.geometry,
            size = new SuperMap.Size(44, 33),
            offset = new SuperMap.Pixel(-(size.w / 2), -size.h),
            icon = new SuperMap.Icon("../theme/images/marker.png", size, offset);
            markerLayer.addMarker(new SuperMap.Marker(new SuperMap.LonLat(point.x, point.y), icon));
            nodeArray.push(point);
        }

        //选中时显示路径指引信息
        function onFeatureSelect(feature) {
            if (feature.attributes.description) {
                popup = new SuperMap.Popup("chicken",
                feature.geometry.getBounds().getCenterLonLat(),
                new SuperMap.Size(200, 30),
                "<div style='font-size:.8em; opacity: 0.8'>" + feature.attributes.description + "</div>",
                null, false);
                feature.popup = popup;
                map.addPopup(popup);
            }
            if (feature.geometry.CLASS_NAME != "SuperMap.Geometry.Point") {
                feature.style = styleGuideLine;
                vectorLayer.redraw();
            }
        }

        //清除要素时调用此函数
        function onFeatureUnselect(feature) {
            map.removePopup(feature.popup);
            feature.popup.destroy();
            feature.popup = null;
            if (feature.geometry.CLASS_NAME != "SuperMap.Geometry.Point") {
                feature.style = style;
            }
            vectorLayer.redraw();

        }

        //响应提交按钮点击事件
        function findPath() {
            drawPoint.deactivate();
            var findPathService, parameter, analystParameter, resultSetting;
            resultSetting = new SuperMap.REST.TransportationAnalystResultSetting({
                returnEdgeFeatures: true,
                returnEdgeGeometry: true,
                returnEdgeIDs: true,
                returnNodeFeatures: true,
                returnNodeGeometry: true,
                returnNodeIDs: true,
                returnPathGuides: true,
                returnRoutes: true
            });
            analystParameter = new SuperMap.REST.TransportationAnalystParameter({
                resultSetting: resultSetting,
                weightFieldName: "length"
            });
            parameter = new SuperMap.REST.FindPathParameters({
                isAnalyzeById: false,
                nodes: nodeArray,
                hasLeastEdgeCount: false,
                parameter: analystParameter
            });
            if (nodeArray.length <= 1) {
                alert("站点数目有误");
            }
            findPathService = new SuperMap.REST.FindPathService(url2, {
                eventListeners: { "processCompleted": processCompleted }
            });
            findPathService.processAsync(parameter);
        }

        //服务端成功返回最佳路径分析结果时触发事件
        function processCompleted(findPathEventArgs) {
            var result = findPathEventArgs.result;
            allScheme(result);
        }
        function allScheme(result) {
            if (i < result.pathList.length) {
                addPath(result);
            } else {
                i = 0;
                addPathGuideItems(result);

            }
        }

        ////以动画效果显示分析结果
        function addPath(result) {
            if (j < result.pathList[i].route.components.length) {
                var pathFeature = new SuperMap.Feature.Vector();
                var points = [];
                for (var k = 0; k < 2; k++) {
                    if (result.pathList[i].route.components[j + k]) {
                        points.push(new SuperMap.Geometry.Point(result.pathList[i].route.components[j + k].x, result.pathList[i].route.components[j + k].y));
                    }
                }
                var curLine = new SuperMap.Geometry.LinearRing(points);
                pathFeature.geometry = curLine;
                pathFeature.style = style;
                vectorLayer.addFeatures(pathFeature);
                pathTime = setTimeout(function () { addPath(result); }, 0.001);
                j++;
            } else {
                clearTimeout(pathTime);
                j = 0;
                i++;
                allScheme(result);
            }
        }

        var sesul ;
        //线绘制完成后会绘制关于路径指引点的信息
        function addPathGuideItems(result) {
            resul = result;
            vectorLayer.removeAllFeatures();
            for (var k = 0; k < result.pathList.length; k++) {
                var pathGuideItems = result.pathList[i].pathGuideItems, len = pathGuideItems.length;
                for (var m = 0; m < len; m++) {
                    var guideFeature = new SuperMap.Feature.Vector();
                    guideFeature.geometry = pathGuideItems[m].geometry;
                    guideFeature.attributes = { description: pathGuideItems[m].description };
                    if (guideFeature.geometry.CLASS_NAME === "SuperMap.Geometry.Point") {
                        guideFeature.style = styleGuidePoint;
                    }
                    else {
                        guideFeature.style = style;
                    }
                    vectorLayer.addFeatures(guideFeature);
                }

                select.activate();

            }
        }
            //清楚要素
            function clearElements() {
                n = 0;
                i = 0;
                j = 0;
                nodeArray = [];
                select.deactivate();
                if (vectorLayer.selectedFeatures.length > 0) {
                    map.removePopup(vectorLayer.selectedFeatures[0].popup);
                }
                vectorLayer.removeAllFeatures();
                markerLayer.clearMarkers();
            }

            //function walking_route() {
            //    var pathGuideItems = resul.pathList[0].pathGuideItems;
            //    var path
            //    var steps = [];
            //    route_text = "";
            //    for (var v = 0; v < pathGuideItems.length; v++) {
            //        if (v % 2 == 0 && v != 0) {
            //            var instruction = pathGuideItems[v - 1].description + pathGuideItems[v].description;
            //            steps.push(instruction);
            //        }
            //    }
            //    for (var i = 0 ; i < steps.length; i++) {
            //        route_text += "<tr><td >" + i + "." + steps[i] + "</td></tr>";
            //    }
            //    route_text = "<table cellspacing=\"5 px\" >" + route_text + "</table>";
            //    document.getElementById("result").innerHTML = route_text;

            //}

            function geoLocation() {
                if (!geolocate.active) {
                    geolocate.activate();
                }
                geolocate.getCurrentLocation();
            }

            var j=0;
            //更新定位
            function getGeolocationCompleted(event) {
                var isDingWeiDian = false;
                if (isStart == 0) {
                    drawpoint(2599.3728359303, -3700.8742721205,"qidian.png",isDingWeiDian);
                    drawpoint(xloc, yloc,"zhongdian.png",isDingWeiDian);
                    isStart++;
                    findPath();
                    geolocate.deactivate();
                    TimeO = setTimeout("geoLocation()", 10000);
                    return;
                }
                if (isStart < 4) {
                    isStart++;
                    return;
                }
                var lonLat = new SuperMap.LonLat(event.point.x, event.point.y);
                //if (isDingWeiDian>4) {
                //    isDingWeiDian = true;
                //    alert("settimeout执行成功");
                //}
                //if (isStart == 4) {
                //    alert("第五次");

                //}
                //if (isStart == 5) {
                //    alert("第六次");
                //}
                //if (isStart == 6) {
                //    alert("第七次");
                //}
                //if (isStart == 7) {
                //    alert("第八次");
                //}
                //if (isStart == 8) {
                //    alert("第九次");
                //}
                //if (isStart == 9) {
                //    alert("第十次");
                //}
                //positionLayer.clearMarkers()
                //size = new SuperMap.Size(44, 33),
                //offset = new SuperMap.Pixel(-(size.w / 2), -size.h),
                //icon = new SuperMap.Icon("../theme/images/marker.png", size, offset);
                //positionLayer.addMarker(new SuperMap.Marker(lonLat, icon));
                //map.setCenter(lonLat);
                drawpoint(2607.8522400652, -3682.5745902937, "dingWeiDian.png",isDingWeiDian);

                event.point.x = 2607.8522400652;
                event.point.y = -3682.5745902937;
                var hint_Text = getHint_Text(event, j);
                $("#hint_p").text(hint_Text);

                //event.point.x = 2622.1165105855;
                //event.point.y = -3641.7791667841;
                //var hint_Text2 = getHint_Text(event, j);
                //event.point.x = 2629.9119339793;
                //event.point.y = -3642.5297396713;
                //var hint_Text3 = getHint_Text(event, j);
                //hint_Text = "您已到达终点";
                //stepNumber = 1;
                if (hint_Text=="您已到达终点") {
                    if (locationName == "开始入学导航" && stepNumber < 4) {
                        confirm();
                    }

                }
            }

            function getGeolocationFailed(event) {
                alert("您当前使用的浏览器不支持地图定位服务");
            }
            //计算两点间的距离
            function getDistance(a,b) {
                var z = (a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y);
                var dis = Math.sqrt(z);
                return dis;
            }

            // p点到(a,b)点两所在直线的垂点坐标
            function getFoot(a, b, p) {
                var fa = b.y - a.y;
                var fb = a.x - b.x;
                var fc = a.y * b.x - a.x * b.y;
                var foot = new SuperMap.Geometry.Point(0, 0);
                foot.x = 13;
                var jd = (fb * fb * p.x - fa * fb * p.y - fa * fc) / (fa * fa + fb * fb);
                foot.x = (fb * fb * p.x - fa * fb * p.y - fa * fc) / (fa * fa + fb * fb);
                foot.y = (fa * fa * p.y - fa * fb * p.x - fb * fc) / (fa * fa + fb * fb);
                return foot;
            }

            //判断p点是否在(a,b)两点所在直线上
            function dotIsOnLine(a,b,foot) {
                return Math.min(a.x, b.x) <= foot.x && foot.x <= Math.max(a.x, b.x) && Math.min(a.y, b.y) <= foot.y && foot.y <= Math.max(a.y, b.y);
            }

            function getHint_Text(event, k) {
                var pathGuideItems = resul.pathList[0].pathGuideItems;
                var hint_Text;
                for (var i = k; i < pathGuideItems.length; i++) {
                    if (pathGuideItems[i].geometry.CLASS_NAME == "SuperMap.Geometry.Point") {
                        var disQian = getDistance(event.point, pathGuideItems[i].geometry);
                        var disZhong = getDistance(event.point, pathGuideItems[i + 2].geometry);
                        //判断是否在当前线段内
                        //当前线段
                        var foot2 = getFoot(pathGuideItems[i].geometry, pathGuideItems[i + 2].geometry, event.point);
                        var dis2 = getDistance(event.point, foot2);
                        var dotIsOnLine2 = dotIsOnLine(pathGuideItems[i].geometry, pathGuideItems[i + 2].geometry, foot2);
                        //当下一条线段为最后一条线段不能计算
                        if (i < pathGuideItems.length - 3) {
                            var foot3 = getFoot(pathGuideItems[i + 2].geometry, pathGuideItems[i + 4].geometry, event.point);
                            var dis3 = getDistance(event.point, foot3);
                            var dotIsOnLine3 = dotIsOnLine(pathGuideItems[i + 2].geometry, pathGuideItems[i + 4].geometry, foot3);
                        }

                        //当前线段为最后一条线段
                        if (i == pathGuideItems.length - 3) {
                            //在当前线段内
                            if (dotIsOnLine2 == true) {
                                hint_Text = getText(i, dis2, disZhong, pathGuideItems);
                                j = i;
                                return hint_Text;
                            }

                            if (dotIsOnLine2 == false) {
                                var dismin_2 = Math.min(disQian, disZhong);
                                //在上一条线段内
                                if (dismin_2 == disQian) {
                                    i = i - 3;
                                    continue;
                                }
                                //走过了终点
                                if (dismin_2 == disZhong) {
                                    hint_Text = "您已走过了终点";
                                    j = i;
                                    return hint_Text;
                                }
                            }
                        }

                        //在当前线段内
                        if (dotIsOnLine2 == true && dotIsOnLine3 == false) {
                            hint_Text = getText(i, dis2, disZhong, pathGuideItems);
                            j = i;
                            return hint_Text;
                        }

                        //在下一条线段内
                        if (dotIsOnLine2 == false && dotIsOnLine3 == true) {
                            i = i + 1;
                            continue;
                        }



                        if (dotIsOnLine2 == true && dotIsOnLine3 == true) {
                            //在下一条线段内
                            if (dis2 > dis3) {
                                i = i + 1;
                                continue;
                            }
                            //在当前线段内
                            if (dis2 <= dis3) {
                                hint_Text = getText(i, dis2, disZhong, pathGuideItems);
                                j = i;
                                return hint_Text;
                            }
                        }

                        if (dotIsOnLine2 == false && dotIsOnLine3 == false) {
                            var disHou = getDistance(event.point, pathGuideItems[i + 4].geometry);
                            var dismin = Math.min(disQian, disZhong, disHou);
                            //在上一条线段内
                            if (dismin == disQian) {
                                if (i > 0) {
                                    i = i - 3;
                                    continue;
                                }
                                //当前线段为第一条线段
                                if (i = 0) {
                                    hint_Text = "您走错了方向";
                                    j = o;
                                    return hint_Text;
                                }
                            }
                            //在下一条线段内
                            if (dismin == disHou) {
                                i = i + 1;
                                continue;
                            }
                            //在当前线段内
                            if (dismin == disZhong) {
                                hint_Text = getText(i, dis2, disZhong, pathGuideItems);
                                j = i;
                                return hint_Text;
                            }
                        }



                    }

                }
            }

            //已判断为在当前线段内，分析得到提示
            function getText(i, dis2, disZhong, pathGuideItems) {
                var hint_Text;

                //在当前线段内，判断是否偏离路径
                if (dis2 > 40) {
                    hint_Text = "偏离路径";
                    return hint_Text;
                }

                //判断是否到达终点
                if (i == pathGuideItems.length - 3 && disZhong < 20) {
                    hint_Text = "您已到达终点";
                    return hint_Text;
                }

                //在当前线段内，返回hint_Text
                if (pathGuideItems[i + 1].length > 50) {

                    if (disZhong > 50) {
                        hint_Text = pathGuideItems[i + 1].description;
                        return hint_Text;
                    }
                    else {
                        hint_Text = "50米后路口" + pathGuideItems[i + 2].description;
                        return hint_Text;
                    }
                }
                else {
                    hint_Text = pathGuideItems[i + 1].description + pathGuideItems[i + 2].description;
                    return hint_Text;
                }

            }






            function drawpoint(x, y, tubiao,isDingWeiDian) {
                if (isDingWeiDian) {
                    markerLayer.removeMarker(marker);
                }
                var point = new SuperMap.Geometry.Point(x, y);
                var size = new SuperMap.Size(44, 44),
                offset = new SuperMap.Pixel(-(size.w / 2), -size.h),
                tubiaoPath="theme/images/"+tubiao;
                icon = new SuperMap.Icon(tubiaoPath, size, offset);

                marker = new SuperMap.Marker(new SuperMap.LonLat(x, y), icon);
                markerLayer.addMarker(marker);

                nodeArray.push(point);
            }

                //function drawElements() {
                //    drawpoint(2599.3728359303, -3700.8742721205);
                //    drawpoint(4158.5057275359, -3151.8838173298);

                //}

    </script>



</head>

<body>

    <ons-tabbar>
        <ons-tab page="zhuye" label="我的主页" icon="ion-home" active="true"></ons-tab>
        <ons-tab page="help" label="求助学长" icon="ion-chatbox-working"></ons-tab>
        <ons-tab page="flow" label="报到流程" icon="ion-ios-pricetag"></ons-tab>
        <ons-tab page="myme" label="我的信息" icon="ion-ios-cog"></ons-tab>
    </ons-tabbar>

    <!------------------------------------我的主页----------------------------------------->
    <ons-template id="zhuye">
        <ons-navigator title="Navigator" var="myNavigator" ons-postpush="true" postpush="alert('postpush')" postpop="alert('postpop')" >
            <ons-page>
                <ons-toolbar>
                    <div class="center">我的主页</div>
                </ons-toolbar>

                <ons-list>
                    <ons-list-item modifier="chevron" onclick="getReady(this);myNavigator.pushPage('daohang', { animation: 'slide' }); ">
                        开始入学导航
                    </ons-list-item>
                    <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('mainPlace', { animation : 'slide' } )">
                        导航至学校主要地点
                    </ons-list-item>
                    <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('mySchool', { animation : 'slide' } )">
                        我的学校
                    </ons-list-item>
                    <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('laoxiang', { animation : 'slide' } )">
                        老乡会
                    </ons-list-item>
                    <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('sLife', { animation : 'slide' } )">
                        校园生活
                    </ons-list-item>
                </ons-list>
            </ons-page>
        </ons-navigator>
    </ons-template>

    <!------------------------------------我的主页----------------------------------------->
    <!----------------------地图导航界面导航---------------------------->

    <ons-template id="daohang">
        <ons-page>
            <ons-toolbar>
                <div class="left"><ons-back-button>Back</ons-back-button></div>
                <div class="center">实时导航</div>
                <!--<div class="right"><input type="button" value="开始导航" onclick="geoLocation();" /></div>-->
            </ons-toolbar>
            <div id="hint">
                <div id="hint_img_div"><img id="hint_img" src="../images/hint/walk.png" /></div>
                <div id="hint_p_div"><p id="hint_p">从此处开始出发</p></div>
            </div>
			<div id="map" >
            </div>

        </ons-page>

    </ons-template>
    <!----------------------地图导航界面导航---------------------------->

    <ons-template id="mainPlace">
        <ons-page>
            <ons-toolbar>
                <div class="left"><ons-back-button>Back</ons-back-button></div>
                <div class="center">请选择地点分类</div>
            </ons-toolbar>
            <ons-list>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('jiaoxuelou', { animation : 'slide' } )">
                    教学楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('shitang', { animation : 'slide' } )">
                    食堂
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('sushe', { animation : 'slide' } )">
                    宿舍
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('tiyu', { animation : 'slide' } )">
                    体育运动
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    图书馆
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('computer', { animation : 'slide' } )">
                    计算机中心
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    校医院
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    学术交流中心（嘉园）
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('chaoshi', { animation : 'slide' } )">
                    校园超市
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('xiyu', { animation : 'slide' } )">
                    洗浴中心
                </ons-list-item>
            </ons-list>
        </ons-page>
    </ons-template>

    <!-----------------------------------------教学楼------------------------------------------------------------>
    <ons-template id="jiaoxuelou">
        <ons-page>
            <ons-toolbar>
                <div class="left"><ons-back-button>Back</ons-back-button></div>
                <div class="center">教学楼</div>
            </ons-toolbar>

            <ons-list>
                <ons-list-header style="background-color:#33FFFF">主校区</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    主教
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    行政楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    电阶教室
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    第二教学楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    第三教学楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    第四教学楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    第五教学楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    第六教学楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    第七教学楼
                </ons-list-item>
                <ons-list-header style="background-color:#33FFFF">西校区</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    第八教学楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    第九教学楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    第十教学楼
                </ons-list-item>
                <ons-list-header style="background-color:#33FFFF">东校区（科信）</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    第十一教学楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    第十二教学楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    第十三教学楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    第十四教学楼
                </ons-list-item>
            </ons-list>
        </ons-page>
    </ons-template>
    <!-----------------------------------------教学楼------------------------------------------------------------>
    <!------------------------------------------食堂-------------------------------------------------------------->
    <ons-template id="shitang">
        <ons-page>
            <ons-toolbar>
                <div class="left"><ons-back-button>Back</ons-back-button></div>
                <div class="center">食堂</div>
            </ons-toolbar>
            <ons-list>
                <ons-list-header style="background-color:#33FFFF">主校食堂</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    第一餐厅
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    第二餐厅
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    好味道（德顺斋）
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    好时尚
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    红泥餐厅（米兰）
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    湖南风味餐厅
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    中和饮食广场
                </ons-list-item>
                <ons-list-header style="background-color:#33FFFF">东校区（科信）食堂</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    东苑饮食广场
                </ons-list-item>
                <ons-list-header style="background-color:#33FFFF">西校区食堂</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    公诚饮食广场
                </ons-list-item>
            </ons-list>
        </ons-page>
    </ons-template>
    <!------------------------------------------食堂-------------------------------------------------------------->
    <!--------------------------------------------宿舍------------------------------------------------------------>
    <ons-template id="sushe">
        <ons-page>
            <ons-toolbar>
                <div class="left"><ons-back-button>Back</ons-back-button></div>
                <div class="center">宿舍</div>
            </ons-toolbar>
            <ons-list>
                <ons-list-header style="background-color:#33FFFF">主校区宿舍</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    思静斋
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    思敏斋
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    思信斋
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    思齐斋
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    思远斋
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    临雅轩
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    临风轩
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    听湖轩
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    观湖轩
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    鉴湖轩
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    宏民苑
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    宏善苑
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    宏德苑
                </ons-list-item>
                <ons-list-header style="background-color:#33FFFF">东校区（科信）宿舍</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    致远楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    明志楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    成学楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    广才楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    养德楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    崇礼楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    修身楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    明德楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    知行楼
                </ons-list-item>
                <ons-list-header style="background-color:#33FFFF">西校区宿舍</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    朝曦楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    朝晖楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    朝华楼
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    朝阳楼
                </ons-list-item>
            </ons-list>
        </ons-page>
    </ons-template>

    <!--------------------------------------------宿舍------------------------------------------------------------>
    <!------------------------------------------体育运动------------------------------------------------------------->
    <ons-template id="tiyu">
        <ons-page>
            <ons-toolbar>
                <div class="left"><ons-back-button>Back</ons-back-button></div>
                <div class="center">体育运动</div>
            </ons-toolbar>

            <ons-list>
                <ons-list-header style="background-color:#33FFFF">主校区</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    主校塑胶篮球场
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    主校网球场
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    主校操场
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    主校乒乓球场
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    主校体育馆
                </ons-list-item>
                <ons-list-header style="background-color:#33FFFF">东校区（科信）</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    篮球场
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    东校区操场（体育场）
                </ons-list-item>
                <ons-list-header style="background-color:#33FFFF">西校区</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    篮球场（乒乓球场）
                </ons-list-item>
            </ons-list>
        </ons-page>
    </ons-template>

    <!------------------------------------------体育运动------------------------------------------------------------->
    <!-------------------------------------------计算机中心---------------------------------------------------------->
    <ons-template id="computer">
        <ons-page>
            <ons-toolbar>
                <div class="left"><ons-back-button>Back</ons-back-button></div>
                <div class="center">计算机中心</div>
            </ons-toolbar>
            <ons-list>
                <ons-list-header style="background-color:#33FFFF">主校区</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    主校区计算机中心
                </ons-list-item>
                <ons-list-header style="background-color:#33FFFF">东校区（科信）</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    东校区校区计算机中心
                </ons-list-item>
            </ons-list>
        </ons-page>
    </ons-template>
    <!-------------------------------------------计算机中心---------------------------------------------------------->
    <!----------------------------------------------超市------------------------------------------------------------>
    <ons-template id="chaoshi">
        <ons-page>
            <ons-toolbar>
                <div class="left"><ons-back-button>Back</ons-back-button></div>
                <div class="center">校园超市</div>
            </ons-toolbar>
            <ons-list>
                <ons-list-header style="background-color:#33FFFF">主校区</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    鉴园超市
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    塑胶篮球场小超市
                </ons-list-item>
                <ons-list-header style="background-color:#33FFFF">东校区（科信）</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    小超市
                </ons-list-item>
            </ons-list>
        </ons-page>
    </ons-template>
    <!----------------------------------------------超市------------------------------------------------------------>
    <!---------------------------------------------洗浴中心------------------------------------------------------->
    <ons-template id="xiyu">
        <ons-page>
            <ons-toolbar>
                <div class="left"><ons-back-button>Back</ons-back-button></div>
                <div class="center">洗浴中心</div>
            </ons-toolbar>
            <ons-list>
                <ons-list-header style="background-color:#33FFFF">主校区</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    学生洗浴中心（理发）
                </ons-list-item>
                <ons-list-header style="background-color:#33FFFF">东校区（科信）</ons-list-header>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                    学生洗浴中心
                </ons-list-item>
            </ons-list>
        </ons-page>
    </ons-template>
    <!---------------------------------------------洗浴中心------------------------------------------------------->
    <!-----------------------------------------------校园生活---------------------------------------------------->
    <ons-template id="sLife">
        <ons-page>
            <ons-toolbar>
                <div class="left"><ons-back-button>Back</ons-back-button></div>
                <div class="center">校园生活</div>
            </ons-toolbar>
            <ons-list>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('common', { animation : 'slide' } )">
                    学生会
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('common', { animation : 'slide' } )">
                    社团组织介绍
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('common', { animation : 'slide' } )">
                    校园一卡通
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('common', { animation : 'slide' } )">
                    图书馆
                </ons-list-item>
            </ons-list>
        </ons-page>
    </ons-template>
    <!-----------------------------------------------校园生活---------------------------------------------------->
    <!------------------------------------------------老乡会------------------------------------------------------>
    <ons-template id="laoxiang">
        <ons-page>
            <ons-toolbar>
                <div class="left"><ons-back-button>Back</ons-back-button></div>
                <div class="center">老乡会信息</div>
            </ons-toolbar>
            <ons-list>
                <ons-list-header style="background-color:#33FFFF">乡长信息</ons-list-header>
                <ons-list-item>
                    姓名：****
                </ons-list-item>
                <ons-list-item>
                    手机号：12312423523
                </ons-list-item>
                <ons-list-item>
                    微信：
                </ons-list-item>
                <ons-list-item>
                    QQ：
                </ons-list-item>
                <ons-list-item>
                    学院专业：
                </ons-list-item>
                <ons-list-item>
                    年级：
                </ons-list-item>
                <ons-list-item>
                    老乡会QQ群：
                </ons-list-item>
            </ons-list>
        </ons-page>
    </ons-template>
    <!------------------------------------------------老乡会------------------------------------------------------>
    <!--------------------------------------------------我的学校------------------------------------------------>
    <ons-template id="mySchool">
        <ons-page>
            <ons-toolbar>
                <div class="left"><ons-back-button>Back</ons-back-button></div>
                <div class="center">我的学校</div>
            </ons-toolbar>
            <ons-list style=" padding-top:10px;">
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('common', { animation : 'slide' } )">
                    学校简介
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('common', { animation : 'slide' } )">
                    学校领导班子
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('common', { animation : 'slide' } )">
                    荣誉校友
                </ons-list-item>
                <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('common', { animation : 'slide' } )">
                    校园风光
                </ons-list-item>
            </ons-list>
        </ons-page>
    </ons-template>
    <!--------------------------------------------------我的学校------------------------------------------------>
    <!--------------------------------------------------common content----------------------------------------->
    <ons-template id="common">
        <ons-page>
            <ons-toolbar>
                <div class="left"><ons-back-button>Back</ons-back-button></div>
            </ons-toolbar>
            <p>信息正在完善中...</p>

        </ons-page>
    </ons-template>

    <!--------------------------------------------------common content----------------------------------------->
    <!------------------------------------------------help---------------------------------------------------------->
    <ons-template id="help">
        <ons-page>
            <ons-toolbar>
                <div class="center">求助学长</div>
            </ons-toolbar>

            <ons-list>
                <ons-list-header style="background-color:#33FFFF">联系方式</ons-list-header>

                <ons-list-item>QQ：1234355667</ons-list-item>
                <ons-list-item>微信：12234354364</ons-list-item>
                <ons-list-item>手机号：183****4204</ons-list-item>

                <ons-list-header style="background-color:#33FFFF">在线提问</ons-list-header>

                <section style="padding:8px">
                    <textarea class="textarea" ng-model="text2" placeholder="描述你的问题并留下你的联系方式" style="width: 100%; height:150px;"></textarea>
                </section>

                <form action="http://w3school.com.cn/example/html/form_action.asp" method="get">
                    <input type="submit" value="Submit" id="sub" style="margin-top:5px;width:200px;height:40px;line-height:35px;border:none;background-color:#33CCFF;margin-left:80px;" />
                </form>
                </ons-list-item>
            </ons-list>
        </ons-page>
    </ons-template>

    <!------------------------------------------------help---------------------------------------------------------->
    <!-------------------------------------------------tags-------------------------------------------------------->
    <ons-template id="flow">
        <ons-page>
            <ons-toolbar>
                <div class="left"><ons-back-button>Back</ons-back-button></div>
                <div class="center">报到流程</div>
            </ons-toolbar>
            <p>导入张恒首页的流程图</p>
        </ons-page>

    </ons-template>
    <!-------------------------------------------------tags-------------------------------------------------------->
    <!-------------------------------------------------me-------------------------------------------------------->

    <ons-template id="myme">
        <ons-navigator title="Navigator" var="myNavigator">
            <ons-page>
                <ons-toolbar>
                    <div class="left"><ons-back-button>Back</ons-back-button></div>
                    <div class="center">我的信息</div>
                </ons-toolbar>

                <ons-list>
                    <ons-list-header style="background-color:#33FFFF">基本信息</ons-list-header>
                    <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('common', { animation : 'slide' } )">
                        我的报到步骤
                    </ons-list-item>
                    <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('medaoyuan', { animation : 'slide' } )">
                        我的导员
                    </ons-list-item>
                    <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('common', { animation : 'slide' } )">
                        我的学院介绍
                    </ons-list-item>
                    <ons-list-header style="background-color:#33FFFF">我的常用导航</ons-list-header>
                    <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                        到我的宿舍
                    </ons-list-item>
                    <ons-list-item modifier="chevron" onclick="myNavigator.pushPage('daohang', { animation : 'slide' } )">
                        到我的学院
                    </ons-list-item>
                    <ons-list-header style="background-color:#33FFFF">账号管理</ons-list-header>
                    <ons-list-item modifier="chevron" onclick="alert1()">
                        <!--<input type="button" onclick="alert('确定退出吗？')" value="显示消息框" />-->
                        退出
                    </ons-list-item>
                </ons-list>

                <div style="margin:10px 0 0 10px;"></div>


            </ons-page>

        </ons-navigator>
    </ons-template>
    <!-------------------------------------------------me-------------------------------------------------------->
    <!----------------------------------------------我的导员----------------------------------------------------->
    <ons-template id="medaoyuan">
        <ons-page>
            <ons-toolbar>
                <div class="left"><ons-back-button>Back</ons-back-button></div>
                <div class="center">我的导员</div>
            </ons-toolbar>
            <ons-list>
                <ons-list-header style="background-color:#33FFFF">基本信息</ons-list-header>
                <ons-list-item>
                    姓名：****
                </ons-list-item>
                <ons-list-item>
                    性别：
                </ons-list-item>
                <ons-list-item>
                    手机号：12312423523
                </ons-list-item>
                <ons-list-item>
                    微信：
                </ons-list-item>
                <ons-list-item>
                    QQ：
                </ons-list-item>
                <ons-list-item>
                    教龄：
                </ons-list-item>
                <ons-list-item>
                    职称：
                </ons-list-item>
            </ons-list>
        </ons-page>
    </ons-template>
    <!----------------------------------------------我的导员----------------------------------------------------->


</body>
</html>
