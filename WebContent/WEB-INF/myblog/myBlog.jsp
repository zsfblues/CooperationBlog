<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>${sessionScope.user} | 我的博客</title>

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/sign.png" />

    <link rel=stylesheet type=text/css href="${pageContext.request.contextPath}/css/indexcss/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buttons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myblog/myblog.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Font-Awesome/css/font-awesome.min.css">

    <script type=text/javascript src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/js.min.js"></script>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/tabs.js"></script>

    <script type=text/javascript>
        $(function(){$(".lavaLamp").lavaLamp({ fx: "backout", speed: 600 })});
    </script>

    <script type=text/javascript src="${pageContext.request.contextPath}/js/myblog/myblog.js"></script>
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

    <h3 style="text-align:left; text-indent:1cm;">&nbsp; <span class="username"><s:property value="#session.user"/>&nbsp;博客地带</span> </h3>

<div id="controldiv">
    <button title="点我" onClick="control_switch()" class="button button-primary button-box button-small">
        <i class="icon-plus"></i> </button>
</div>

<div id="newblogdiv">
    <ul>
        <li>
            <a href="${pageContext.request.contextPath}/edit.action" title="新博文" target="_blank"> <i class="icon-edit icon-2x"></i> 新博文</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/editinfo.action" title="编辑信息" target="_blank"> <i class="icon-pencil icon-2x"></i> 编辑信息</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/showmyfriend.action" title="关注的人" target="_blank"> <i class="icon-heart icon-2x"></i> 关注的人</a>
        </li>
    </ul>
</div>

<div id="content">

    <s:set scope="request" var="blogcounts" value="0"/>
    <s:iterator value="bloglist" var="objects" status="sta">

        <s:if test="#sta.isLast()">
            <s:set scope="request" var="blogcounts" value="#request.blogcount"/>
        </s:if>
            <div id="text">

                <s:iterator value="objects" var="object" status="st">

                    <s:if test="#st.isFirst()">
                        <s:set scope="request" var="typeflag" value="#object"/>
                    </s:if>

                    <s:elseif test="#st.index == 1">
                        <s:set scope="request" var="articleId" value="#object"/>
                    </s:elseif>

                    <%-- 显示标题 --%>
                    <s:elseif test="#st.index == 2">
                        <center>
                            <a class="title" target="_blank" href="${pageContext.request.contextPath}/findarticle.action?articleId=${articleId}"> <s:property value="#object"/></a>
                            <a onclick="deletemyblog('${articleId}')" style="font-size: 12px">删除</a>
                        </center>
                    </s:elseif>

                    <s:elseif test='#st.index == 3 && #request.typeflag == "L" '>
                        <p>
                            导语：${object}
                        </p>
                    </s:elseif>
                    
                    <s:elseif test='#st.index == 4 &&  #request.typeflag == "N" '>
                        <p>
                            <s:if test="#object.length() > 150">
                                ${object.substring(0, 150)}......
                            </s:if>
                            <s:else>
                                ${object}
                            </s:else>
                        </p>
                    </s:elseif>

                    <%-- 显示标签 --%>
                    <s:elseif test="#st.index == 5">
                        <p>
                            <a href="${pageContext.request.contextPath}/findarticle.action?articleId=${articleId}" target="_blank">阅读全文→</a>
                        </p>
                        <p>
                            <s:if test="#object.length() > 0">
                            <span style="margin-left: 1.5cm;"> <i class="icon-tag"></i><s:property value="#object"/></span>
                            </s:if>
                        </p>
                    </s:elseif>

                    <s:elseif test="#st.isLast()">
                        <center><span style="font-size:13px;">最后编辑于 <s:property value="#object.substring(0, #object.length() - 5)"/> by  <a style="color:#FF3F00;cursor: default"> ${sessionScope.user} </a></span></center>
                        <hr size=2 style="color:#00DFFF;border-style:dashed ;width:100%" />

                     </s:elseif>

                </s:iterator>
            </div>

        <s:if test="#sta.isLast()">
            <c:forEach varStatus="indexstatus" begin="${requestScope.startIndex}" end="${requestScope.totalpages}">

                <a href="${pageContext.request.contextPath}/myblog.action?startIndex=${requestScope.startIndex}&pageIndex=${indexstatus.index}" class="button button-primary button-square button-small">
                        ${indexstatus.index}
                </a>

            </c:forEach>
        </s:if>

    </s:iterator>

</div>

<div id="side_content">

    <div id="infosummarydiv">
        ${sessionScope.myemail}
        <br />
        <div> 博客数&nbsp;&nbsp;&nbsp;${blogcounts}</div>
        <div> 红人度&nbsp;&nbsp;&nbsp;<s:property value="popularity"/></div>
        <p></p>
    </div>

    <div id="classify_by_time">
      <p>&nbsp;  </p>

        <p>
            <form id="myform" action="${pageContext.request.contextPath}/search.action" method="post">
                <input type="text" name="searchtxt" class="searchtxt" placeholder="文章标题 作者查找"/>
                <img onclick="getsearch()" src="${pageContext.request.contextPath}/images/search.png" style="cursor:pointer"/>
            </form>
        </p>

        <ul id="timelist">
            <span style="font-size:16px"> 文章归档：</span>

            <script> setTimeList(); </script>
        </ul>
    </div>

    <div id="new_article">
        <ul>
            <li style="font-size:16px"> 最新博文：</li>

            <s:iterator value="bloglist" var="objects" status="sta">
                <s:iterator value="objects" var="object" status="st">

                    <s:if test="#st.index == 1">
                        <s:set scope="request" var="articleId" value="#object"/>
                    </s:if>

                    <s:elseif test="#st.index == 2">
                            <li> <a target="_blank" href="${pageContext.request.contextPath}/findarticle.action?articleId=${articleId}" title="<s:property value="#object"/>"><s:property value="#object"/> </a> </li>

                    </s:elseif>

                </s:iterator>
            </s:iterator>
        </ul>
    </div>

</div>

<div id="myinfodiv">
    <span id="infotip">我的信息</span>

        <span id="myinfo" style="display: none">
            欢迎您
            <br/>
            <a style="font-size: 14px" title="${sessionScope.myemail}" href="#"> ${sessionScope.user}
            </a>
        </span>
        <a href="${pageContext.request.contextPath}/logout.action" id="logout" style="display: none;color: white">注销</a>
</div>

<div id="to_top"> <img src="${pageContext.request.contextPath}/images/topback.gif"/> </div>
</body>
</html>
