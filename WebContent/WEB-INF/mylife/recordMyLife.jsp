<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${sessionScope.user} | 捕捉生活</title>

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/sign.png" />

    <script type=text/javascript src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/js.min.js"></script>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/tabs.js"></script>
    <script type=text/javascript
            src="${pageContext.request.contextPath}/js/recordMyLife/recordMyLife.js"></script>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/webuploaderjs/webuploader.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/buttons.js"></script>

    <link rel=stylesheet type=text/css href="${pageContext.request.contextPath}/css/indexcss/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buttons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/recordMyLife/recordMyLife.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Font-Awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/webuploader/webuploader.css">


    <script type=text/javascript>
        $(function(){$(".lavaLamp").lavaLamp({ fx: "backout", speed: 600 })});
    </script>

</head>
<body>

<div id="wrapper">
    <ul class=lavaLamp>
        <li id="homepage"> <a href='${pageContext.request.contextPath}/Myindex.jsp'> 首页</a></li>
        <li> <a href='${pageContext.request.contextPath}/showfame.action'> 红人馆 </a></li>
        <li id="it_news"> <a href='${pageContext.request.contextPath}/myitnews.action'> 科技新闻</a></li>
        <li id="dynamic_message"> <a href='${pageContext.request.contextPath}/Myindex.jsp?idname=dynamic_message'> 最新动态</a></li>
        <li id="myblog"> <a href="${pageContext.request.contextPath}/myblog.action"> 我的博客 </a></li>
        <li id="photots"> <a href="${pageContext.request.contextPath}/uploadfiles.action"> 相册 </a></li>
        <li id="mylife"> <a href='${pageContext.request.contextPath}/recordmylife.action'> 捕捉生活</a></li>
    </ul>
</div>

<div id="to_top"> <img src="${pageContext.request.contextPath}/images/topback.gif"/> </div>

<div class="contentdiv">
    <div id="header">
        <div id="headerword">这里的时光静悄悄</div>
    </div>

    <p>&nbsp;</p>
    <div id="newlifeword">
        <center>
            <button class="button button-glow button-rounded button-highlight" onClick="mytoggle()">分享生活</button>
        </center>
        <p>&nbsp;</p>

        <div id="sign">留下你的生活印记</div>

        <div id="editdiv" style="display: none">
            <form id="myform" action="${pageContext.request.contextPath}/submitlifeblog.action" method="post">
                <input placeholder="标题(必填)" name="title" id="title" type="text" required/>
                <input type="hidden" name="privilegeflag" id="privilegeflag"/>
                <input type="hidden" name="requestToken" value="${sessionScope.requestToken}"/>

                <%-- 将分享 div的内容装载后发送到后台  --%>
                <textarea id="mysharecontent" name="mysharecontent" style="display: none"></textarea>

                <textarea placeholder="介绍一下你的内容..." id="lead" name="lead" required></textarea>
                <p></p>
                <div id="sharecontent" contenteditable="true"></div>
                <div id="uploader">
                    <table width="500px">
                        <tr>
                            <td width="100px">
                                <span id="filePicker">上传图片</span>
                                <input type="file" id="lifeimg" name="lifeimg" style="display: none;">
                            </td>
                            <td>
                                <span class="button-dropdown" data-buttons="dropdown">
                                        <button style="width: 100px;background-color: #00b7ee;color: white" class="button button-rounded" onclick="return false">
                                            发表 <i class="icon-caret-down"></i>
                                        </button>

                                        <ul class="button-dropdown-list">
                                            <li><a href="javascript:void(0)" onclick="return submitlifeblog(0)">仅自己可见</a></li>
                                            <li class="button-dropdown-divider">
                                                <a href="javascript:void(0)" onclick="return submitlifeblog(1)">他人可见</a>
                                            </li>
                                        </ul>
                                   </span>
                            </td>
                            <td width="300px" id="info"></td>
                        </tr>
                    </table>
                </div>
            </form>

        </div>
    </div>
</div>

<div id="previewdiv">
    <img id="preimg" src="" />
    <button class="button button-action button-circle" id="hidebtn" onclick="hideimg()">
        <i class="icon-remove icon-large"></i>
    </button>
</div>
</body>
</html>
