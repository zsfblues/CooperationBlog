<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${sessionScope.user} | 相册</title>

    <script type=text/javascript src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/js.min.js"></script>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/tabs.js"></script>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/photoWall/photoWall.js"></script>

    <link rel=stylesheet type=text/css href="${pageContext.request.contextPath}/css/indexcss/style.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buttons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Font-Awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/photoWall/photoWall.css">

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/sign.png" />


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
        <li> <a href='${pageContext.request.contextPath}/recordmylife.action'> 捕捉生活</a></li>
    </ul>
</div>

<div id="photodiv">
    <span id="typetips"></span>

    <div class="uploaddiv">

        <form action="${pageContext.request.contextPath}/uploadfiles.action" method="post" enctype="multipart/form-data">
            <input type="file" name="uploadimg" id="uploadimg" style="display:none">
            <input id="uploadurl" style="height: 30px" type="text" disabled>
            <input type="hidden" name="requestToken" value="${sessionScope.requestToken}">

            <a class="button button-primary button-rounded button-small" onclick="show()">
                <i class="icon-folder-open-alt icon-large"></i> 浏览
            </a>
            <button onclick="return checkUploadType()" style="height: 32px;font-size: 12px" class="button button-pill button-tiny">
                <i class="icon-upload-alt icon-large"></i> 上传图片
            </button>
        </form>
    </div>

    <div id="imagelistdiv">
        <table>
            <tr>
                <s:iterator value="imagelist" var="objects" status="sta">

                    <s:if test="#sta.index % 4 == 0 && #sta.index != 0">
                        <tr></tr>
                    </s:if>

                    <s:iterator value="objects" var="object" status="st">

                        <%--保存图片的上传用户--%>
                        <s:if test="#st.isFirst()">
                            <s:set scope="request" var="username" value="#object"/>
                        </s:if>

                        <%--保存图片的id--%>
                        <s:elseif test="#st.index == 1">
                            <s:set scope="request" var="imgId" value="#object"/>
                        </s:elseif>

                        <s:elseif test="#st.index == 2">
                            <s:set var="userId" value="#object"/>
                        </s:elseif>

                        <s:elseif test="#st.isLast()">
                            <td style="padding-left: 30px">
                                <s:if test="#sta.isLast() && #st.isLast() && uploadflag != null">

                                    <img alt="正在加载..." src="" id="lastimg"/>
                                    <script>showlastimg('<s:property value="#object"/>', '${username}')</script>

                                    <div id="menu" style="display: none">
                                        <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <a onclick="showPreview('<s:property value="#object"/>')">预览</a> &nbsp;&nbsp;&nbsp;&nbsp;
                                        <a href="${pageContext.request.contextPath}/download.action?imgname=<s:property value="#object"/>">下载</a> &nbsp;&nbsp;&nbsp;&nbsp;

                                        <a href="${pageContext.request.contextPath}/deleteimg.action?imgId=${imgId}&requestToken=${sessionScope.requestToken}">删除</a>

                                    </div>
                                </s:if>

                                <s:else>
                                    <img alt="过3秒刷新一下" title="上传者：${username}" width="200px" height="120px" src="${pageContext.request.contextPath}/uploadimg/<s:property value="#object"/>" />

                                    <div>
                                        <br/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <a onclick="showPreview('<s:property value="#object"/>')">预览</a> &nbsp;&nbsp;&nbsp;&nbsp;
                                        <a href="${pageContext.request.contextPath}/download.action?imgname=<s:property value="#object"/>">下载</a> &nbsp;&nbsp;&nbsp;&nbsp;

                                        <s:if test=' #userId == #session.userId '>
                                            <a href="${pageContext.request.contextPath}/deleteimg.action?imgId=${imgId}&requestToken=${sessionScope.requestToken}">删除</a>
                                        </s:if>
                                    </div>
                                </s:else>
                            </td>

                        </s:elseif>

                    </s:iterator>
                </s:iterator>
            </tr>
        </table>
    </div>
</div>

<div id="to_top"> <img src="${pageContext.request.contextPath}/images/topback.gif"/> </div>
<div id="previewdiv">
    <img id="preimg" src="" />
    <button class="button button-action button-circle" id="hidelink" onclick="hideimg()">
        <i class="icon-remove icon-large"></i>
    </button>
</div>
</body>
</html>
