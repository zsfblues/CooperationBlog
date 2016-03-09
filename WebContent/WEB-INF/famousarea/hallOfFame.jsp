<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>红人馆</title>

    <link rel=stylesheet type=text/css href="${pageContext.request.contextPath}/css/indexcss/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buttons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Font-Awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/famousarea/hallOfFame.css">

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/sign.png" />

    <script type=text/javascript src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/js.min.js"></script>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/tabs.js"></script>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/famousearea/hallOfFame.js"></script>

    <script type=text/javascript>
        $(function(){$(".lavaLamp").lavaLamp({ fx: "backout", speed: 600 })});
    </script>

</head>

<body>

<div id="wrapper">
    <ul class=lavaLamp>
        <li id="homepage"> <a href='${pageContext.request.contextPath}/showlastblog.action'> 首页</a></li>
        <li id="fame"> <a href='${pageContext.request.contextPath}/showfame.action'> 红人馆</a></li>
        <li id="it_news"> <a href='${pageContext.request.contextPath}/myitnews.action'> 科技新闻</a></li>
        <li id="dynamic_message"> <a href='${pageContext.request.contextPath}/Myindex.jsp?idname=dynamic_message'> 最新动态</a></li>
        <li id="myblog"> <a href="${pageContext.request.contextPath}/myblog.action"> 我的博客 </a></li>
        <li id="photots"> <a href="${pageContext.request.contextPath}/uploadfiles.action"> 相册 </a></li>
        <li> <a href='${pageContext.request.contextPath}/recordmylife.action'> 捕捉生活</a></li>
    </ul>
</div>

<div id="logo">
    <br />
    <canvas id="colorfuldot"></canvas>
    <span id="fameimg"> <img src="${pageContext.request.contextPath}/images/famelogo.jpg"/></span>
    <span id="red">红</span>
    <span id="person">人</span>
    <span id="hall">馆</span>
</div>

<div id="messagediv">

    <div id="briefdiv">
        <h3>简介</h3>
        <p>
            美：静物是凝固的美，动景是流动的美；直线是流畅的美，曲线是婉转的美；喧闹的城市是繁华的美，宁静的村庄是淡雅的美。生活中处处都有美，只要你有一双发现美的眼睛，有一颗感悟美的心灵。崇尚分享，热爱生活，在此纷繁复杂的社会中追寻宁静的一隅，踏着生活的脚印，用静谧的目光探嗅这美的气息...然后，微醺中看见一束光。没错，就是"打榜"。做生活的导演，你就是明星!
        </p>
    </div>

    <p></p>
    <hr class="horhr"/>
    <span style="margin-left: 80px">用户名 <i class="icon-user"></i></span>
    <span style="margin-left: 245px">红人度 <i class="icon-align-left"></i></span>
    <span style="margin-left: 310px">最新博客 <i class="icon-share"></i></span>
    <hr class="horhr"/>
    <hr class="vertihr"/>

    <table id="infotable" width="100%" cellpadding="0" cellspacing="0">
        <s:iterator value="popularitylist" var="objects" status="sta">

            <tr>
                <s:iterator value="objects" var="object" status="st">
                    <s:if test="#st.isFirst()"> <%-- 暂存用户id --%>
                        <s:set scope="request" var="userId" value="#object"/>
                    </s:if>

                    <s:elseif test="#st.index == 1">
                        <td style="padding-left: 80px" width="150px" height="40px">
                            <a style="cursor: default" title="<s:property value="#object"/>">
                                <img src="${pageContext.request.contextPath}/images/user.png"/>
                                <s:if test="#object.length() > 5">
                                    <s:property value="#object.substring(0, 5)"/>...
                                </s:if>
                                <s:else>
                                    <s:property value="#object"/>
                                </s:else>
                            </a>
                        </td>
                    </s:elseif>

                    <s:elseif test="#sta.isFirst() && #st.index == 2">
                        <td width="400px">
                            <s:set scope="request" var="maxpopularity" value="#object"/>
                            <div id="${userId}" title="红人度：<s:property value="#object"/>"></div>
                            <script> drawLine('<s:property value="#object"/>', '${maxpopularity}', '${userId}')  </script>
                        </td>
                    </s:elseif>

                    <s:elseif test="#st.index == 2">
                        <td width="400px">
                            <div id="${userId}" title="红人度：<s:property value="#object"/>"></div>
                            <script> drawLine('<s:property value="#object"/>', '${maxpopularity}', '${userId}')  </script>
                        </td>
                    </s:elseif>

                    <s:elseif test="#st.index == 3">
                        <s:set scope="request" var="articleId" value="#object"/>
                    </s:elseif>

                    <s:elseif test="#st.isLast()">
                        <td width="200px">
                            <a title="<s:property value='#object'/>" href="${pageContext.request.contextPath}/viewblog.action?articleId=${articleId}" target="_blank">
                                <s:if test="#object.length() > 12">
                                    <s:property value="#object.substring(0, 12)"/>...
                                </s:if>
                                <s:else>
                                    <s:property value="#object"/>
                                </s:else>
                            </a>
                        </td>
                    </s:elseif>
                </s:iterator>
            </tr>
        </s:iterator>
    </table>
</div>

<div id="to_top"> <img src="${pageContext.request.contextPath}/images/topback.gif"/> </div>
</body>
</html>
