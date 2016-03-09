<%@ page import="java.util.Calendar" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>协有不同</title>

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/sign.png" />

    <script type=text/javascript src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/js.min.js"></script>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/tabs.js"></script>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/searchPage/searchPage.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/Font-Awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/searchPage/searchPage.css">
    <link rel=stylesheet type=text/css href="${pageContext.request.contextPath}/css/indexcss/style.css">


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
        <li> <a href='${pageContext.request.contextPath}/recordmylife.action'> 捕捉生活</a> </li>
    </ul>
</div>

<div id="content">
    <div id="text_content">
        <h3 style="text-align:left; text-indent:1cm;">&nbsp; <span class="username">以下为&nbsp;&nbsp;<s:property value="condition"/>&nbsp;&nbsp;的查询结果</span> </h3>
    </div>

    <%-- 显示每篇文章的具体信息列表 --%>
    <s:iterator value="searchlist" var="objects" status="sta">
        <div id="text">

            <s:iterator value="objects" var="object" status="st">

                <s:if test="#st.isFirst()">
                    <s:set scope="request" var="typeflag" value="#object"/>
                </s:if>

                <s:elseif test="#st.index == 1">
                    <s:set scope="request" var="articleId" value="#object"/>
                </s:elseif>

                <s:elseif test="#st.index == 2">
                    <s:set scope="request" var="views" value="#object" />
                </s:elseif>

                <s:elseif test="#st.index == 3">
                    <center>
                        <s:if test="#session.user != null">
                            <a class="title" href="${pageContext.request.contextPath}/viewblog.action?articleId=${articleId}" target="_blank">  <%-- 注册后才跳到新页面,否则在当前页面跳转 --%>
                                <s:property value="#object"/>
                            </a>
                        </s:if>
                        <s:else>
                            <a class="title" href="${pageContext.request.contextPath}/viewblog.action?articleId=${articleId}">
                                <s:property value="#object"/>
                            </a>
                        </s:else>
                    </center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font style="font-size: 13px;color: #62c462">${requestScope.views}人阅读</font>
                </s:elseif>

                <s:elseif test='#st.index == 4 && #request.typeflag == "L" '>
                    <p>
                        导语：${object}
                    </p>
                </s:elseif>

                <s:elseif test='#st.index == 5 &&  #request.typeflag == "N" '>
                    <p>
                        <s:if test="#object.length() > 150">
                            ${object.substring(0, 150)}......
                        </s:if>
                        <s:else>
                            ${object}
                        </s:else>
                    </p>
                </s:elseif>

                <%-- 显示tag --%>
                <s:elseif test="#st.index == 6 ">
                    <p>
                        <s:if test="#session.user != null">
                            <a href="${pageContext.request.contextPath}/viewblog.action?articleId=${articleId}" target="_blank">阅读全文→</a>
                        </s:if>
                        <s:else>
                            <a href="${pageContext.request.contextPath}/viewblog.action?articleId=${articleId}" >阅读全文→</a>
                        </s:else>
                    </p>
                    <p>
                        <s:if test="#object.length() > 0">
                            <span style="margin-left: 1.5cm;"> <i class="icon-tag"></i><s:property value="#object"/></span>
                        </s:if>
                    </p>
                </s:elseif>

                <s:elseif test="#st.index == 7">
                    <s:set scope="request" var="mydate" value="#object" />
                </s:elseif>

                <s:elseif test="#st.isLast()">
                    <center>
                        <span style="font-size:13px;">最后编辑于 ${mydate.substring(0 ,mydate.length() - 5)} by  <a style="color:#FF3F00;cursor: default"> ${object} </a>
                        </span>
                    </center>
                    <hr size=2 style="color:#00DFFF;border-style:dashed ;width:100%" />
                </s:elseif>
            </s:iterator>
        </div>
    </s:iterator>

</div>

<div id="side_content">

    <div id="classify_by_time">
        <p>
            <s:if test="#session.user == null">
                <a href="${pageContext.request.contextPath}/registerAndLogin.jsp">登陆</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a href="${pageContext.request.contextPath}/registerAndLogin.jsp">注册</a>
            </s:if>
            <s:else>
                &nbsp;
            </s:else>
        </p>

        <p>
            <form id="myform" action="${pageContext.request.contextPath}/search.action" method="post">
                <input type="text" name="searchtxt" class="searchtxt" placeholder="文章标题 作者查找"/>
                <img onclick="getsearch()" src="${pageContext.request.contextPath}/images/search.png" style="cursor:pointer"/>
            </form>
        </p>

        <ul>
            <span style="font-size:16px"> 文章归档：</span>
            <%
                for (int i = 12; i > 0; i--)
                {
                    int year = Calendar.getInstance().get(Calendar.YEAR);
            %>
            <li><a href="${pageContext.request.contextPath}/searchbydate.action?datetxt=<%=year + "-" + i%>" title="<%=year %>年<%=i %>月"><%=year %>年<%=i %>月</a></li>
            <%
                }
            %>
        </ul>
    </div>
</div>

<div id="myinfodiv">
    <span id="infotip">我的信息</span>

    <s:if test="#session.user != null">
            <span id="myinfo" style="display: none">欢迎您
                <br/>
                <a style="font-size: 14px" title="${sessionScope.myemail}" href="#"> ${sessionScope.user} </a>
            </span>
        <a href="${pageContext.request.contextPath}/logout.action" id="logout" style="display: none;color: white">
            注销
        </a>
    </s:if>
    <s:else>
        <span id="myinfo" style="display: none">欢迎您 &nbsp;&nbsp;协同人 </span>
    </s:else>
</div>

<div id="to_top"> <img src="${pageContext.request.contextPath}/images/topback.gif"/> </div>
<div id="baseBackgroud"> </div>
</body>
</html>
