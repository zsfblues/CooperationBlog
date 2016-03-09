<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${sessionScope.user} | 协有不同</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buttons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homepage/viewBlog.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Font-Awesome/css/font-awesome.min.css">

    <script charset="utf-8" src="${pageContext.request.contextPath}/kindeditor/kindeditor.js"></script>
    <script charset="utf-8" src="${pageContext.request.contextPath}/kindeditor/lang/zh_CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script charset="utf-8" src="${pageContext.request.contextPath}/js/homepage/viewBlog.js"></script>

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/sign.png" />

</head>
<body>

<%-- 显示博客文章的id 标题 内容  --%>
<div id="blogtextarea">
<s:iterator value="article" var="objects" status="sta">
    <s:iterator value="objects" var="object" status="st">

        <s:if test="#st.isFirst()">
            <input type="hidden" value="<s:property value="#object"/>"/>
        </s:if>

        <s:elseif test="#st.index == 1">
            <div id="blogtitle" > <s:property value="#object"/> </div>
<p></p>
        </s:elseif>

        <s:elseif test="#st.index == 2">
            <div> ${object} </div>
            <p></p>
        </s:elseif>
    </s:iterator>
</s:iterator>
</div>

    <%-- 点赞按钮区域  --%>
    <div class="mybuttondiv">
        <button id="myadmire" onClick="ajaxToAdmire('<s:property value="articleId"/>', '${sessionScope.requestToken}')" class="button button-3d button-action button-circle button-jumbo">
            <i class="icon-thumbs-up"></i>
        </button>
        &nbsp;&nbsp;
        <span id="plusone" style="opacity:0;color:red;">+1</span>
        &nbsp;&nbsp;&nbsp;
        <span id="buttonfont">赞博主</span>
    </div>

<p>&nbsp;&nbsp;&nbsp;</p>
    <%--回复评论区域--%>

<form action="<s:url action="viewblog">
                <s:param name="articleId"><s:property value="articleId"/></s:param>
              </s:url>" method="post">

    <div id="parent_reply_div">
        <textarea name="reply_content" id="reply_content" style="width:500px;height:180px;margin-top: 5cm"></textarea>
        <input type="hidden" name="requestToken" value="${sessionScope.requestToken}"/>

        <div id="reply_table">
            <table>
                <tr >
                    <td width="83" height="107px">
                        <input type="submit" onClick="return submit_reply()" class="button button-glow button-border button-rounded button-primary" value="回复"/>
                    </td>

                    <td width="79" height="107px">
                        <button onClick="return clearContent()" class="button button-glow button-rounded button-caution">清空</button>
                    </td>

                    <td width="114" height="107px"> <span id="reply_tip"></span> </td>
                </tr>

            </table>
        </div>
    </div>
</form>

<%-- 加载回复 --%>
<div id="allreplydiv">

    <s:iterator value="replylist" var="objects" status="sta">

        <s:iterator value="objects" var="object" status="st">

            <s:if test="#st.isFirst()">
              <span>
                    ${object} &nbsp;&nbsp;发表于&nbsp;&nbsp;
              </span>
            </s:if>

            <s:elseif test="#st.index == 3">
                <s:set scope="request" var="myreceiver" value="#object"/>
            </s:elseif>

            <s:elseif test="#st.isLast()">

                <div id="replydiv">
                        ${object}
                </div>
                <br/>

                <div>
                    <a href="javascript:void(0)" onClick="show('light', ${requestScope.num}, '${myreceiver}')" class="button button-pill button-tiny">回复</a>
                </div>

                <%----------------------- 回复与子回复迭代华丽丽的分隔线(上边界) ----------------------%>

                <%-- 显示该条回复的子回复 --%>
                <s:iterator value="subreplylist" var="re_objects">
                    <s:iterator value="re_objects" var="re_object" status="rest">

                        <s:if test="#rest.index == 1">
                            <s:set scope="request" var="order" value="#re_object"/>
                        </s:if>

                        <%---显示子回复时间，发送者以及接收者的信息 --%>
                        <div style="margin-left: 100px">
                            <s:elseif test="#rest.index == 2 && #request.order == #request.num">
                                <s:set scope="request" var="myreceiver" value="#re_object"/>
                            </s:elseif>
                            <s:elseif test="#rest.index == 3 && #request.order == #request.num">
                                ${re_object}
                            </s:elseif>
                        </div>

                        <s:if test="#rest.isLast() && #request.order == #request.num">

                            <%--显示 子回复的div框及其显示内容 ---%>
                            <div id="subreplydiv">
                                <s:property value="re_object"/>
                            </div>
                            <br/>

                            <%---显示子回复按钮 --%>
                            <div style=" margin-left: 100px;">
                                <a href="javascript:void(0)" onClick="show('light', ${requestScope.order}, '${requestScope.myreceiver}')" class="button button-pill button-tiny">回复</a>
                            </div>

                        </s:if>

                    </s:iterator>
                </s:iterator>
                <br />

            </s:elseif>

            <%----------------------- 回复与子回复迭代华丽丽的分隔线(下边界) ----------------------%>

            <%-- 显示回复的发表时间 --%>
            <s:elseif test="#st.index == 1">
                <s:property value="#object.substring(0, #object.length() - 2)" />
            </s:elseif>

            <s:elseif test="#st.index == 2">
                <s:set scope="request" var="num" value="#object" />
            </s:elseif>

        </s:iterator>

        <s:if test="#sta.isLast()">
            <div style="margin-left: 35%; margin-right: 35%;">

                <s:if test="page_index + 0 > 1">
                <a href="<s:url action="viewblog">
                           <s:param name="articleId"><s:property value="articleId"/></s:param>
                           <s:param name="page_index"><s:property value="page_index - 1"/></s:param>
                         </s:url>" class="button button-primary button-rounded button-small">上一页</a>
                </s:if>

                <s:if test="page_index + 0 < pagecounts + 0">
                    <a href="<s:url action="viewblog">
                               <s:param name="articleId"><s:property value="articleId"/></s:param>
                               <s:param name="page_index"><s:property value="page_index + 1"/></s:param>
                             </s:url>" class="button button-primary button-rounded button-small">下一页</a>
                </s:if>
            </div>
        </s:if>

    </s:iterator>
</div>

<%-- 添加子回复 --%>
<form action="<s:url action="viewblog" >
                <s:param name="articleId"><s:property value="articleId"/></s:param>
              </s:url>" method="post">
    <div id="light" class="subreply_content">
        <a href="javascript:void(0)" onClick="hide('light')"> 关闭</a> <br />
        <textarea name="subreply_textarea" id="subreply_textarea" onKeyUp="return limitInput()"></textarea> <br/> <br/>
        <input type="hidden" id="reply_id" name="replyId"/>
        <input type="hidden" name="myreceiver" id="myreceiver"/>
        <input type="hidden" name="requestToken" value="${sessionScope.requestToken}"/>
        <button id="rebutton" onClick="return limitInput()" class="button button-primary button-pill button-small">评论</button>
        <span id="limitNum"> &lt;限定140个字符&gt; </span>
    </div>
</form>

<%-- 作为背景模糊层以便回复某条评论 --%>
<div id="fade" class="black_overlay"></div>

<div id="to_top"><img  src="${pageContext.request.contextPath}/images/topback.gif"/></div>
<canvas style="background:none" id="ramdoncanvas"> </canvas>

</body>
</html>
