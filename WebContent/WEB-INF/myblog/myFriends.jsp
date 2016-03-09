<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>

    <title>${sessionScope.user} | 关注好友</title>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/Font-Awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buttons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myblog/myFriends.css">

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/sign.png" />


    <script>
        function search()
        {
            var content = $("#searchtxt").val().replace(/(^\s*)|(\s*$)/g,"");

            if (content == "")
            {
                return false;
            }

            $.post("${pageContext.request.contextPath}/searchfriend.action",
                    {"condition" : content},

                    function(data)
                    {
                        $("#concern").attr("href", "${pageContext.request.contextPath}/concern.action?userId=" + data.userId + "&requestToken=" + "${sessionScope.requestToken}");
                        $("#friendinfo").css("display", "block");

                        $("#femail").html(data.email);
                        $("#fusername").html(data.username);
                        $("#fsignname").html(data.signname);
                    }
            );
        }
    </script>
</head>
<body>

<div id="friend">
    <div id="search">
        查找你感兴趣的人
        <br>
        <input placeholder="好友名或邮箱" type="text" id="searchtxt"/>
        <img onclick="return search()" src="${pageContext.request.contextPath}/images/search.png" style="cursor:pointer"/>
    </div>

    <div id="friendinfo">
        <table>
            <tr>
                <td>邮箱:</td>
                <td>
                    <span id="femail"></span>
                </td>
            </tr>
            <tr>
                <td>用户名:</td>
                <td>
                    <span id="fusername"></span>
                </td>
            </tr>
            <tr>
                <td>签名:</td>
                <td width="240px">
                    <span id="fsignname"></span>
                </td>
            </tr>
            <tr>
                <td>
                    <a id="concern" style="background-color: #94c6ff" class="button button-rounded button-tiny"><i class="icon-plus"></i>关注</a>
                </td>
            </tr>
        </table>
    </div>
</div>

<div id="messagediv">
    <p>&nbsp;</p>
    <span style="margin-left: 30px">用户名 <i class="icon-user"></i></span>
    <span style="margin-left: 245px">签名 <i class="icon-book"></i></span>
    <span style="margin-left: 280px">最新博客 <i class="icon-share"></i></span>
    <hr class="horhr"/>

    <table id="friendtable" cellpadding="0" cellspacing="10">
        <s:iterator value="friendlist" var="objects" status="sta">

            <tr>
                <s:iterator value="objects" var="object" status="st">
                    <s:if test="#st.isFirst()">
                        <s:set var="userId" value="#object"/>
                    </s:if>

                    <s:elseif test="#st.index == 1">
                        <td width="200px" height="40px">
                            <a style="cursor: default" title="<s:property value="#object"/>">
                                <img src="${pageContext.request.contextPath}/images/user.png"/>

                                <s:if test="#object.length() > 5">
                                    <s:property value="#object.substring(0, 5)"/>...
                                    <br/>
                                    <a style="font-size: 12px;color: black"
                                       href="${pageContext.request.contextPath}/cancelconcern.action?userId=${userId}">取消关注</a>
                                </s:if>
                                <s:else>
                                    <s:property value="#object"/>
                                    <br/>
                                    <a style="font-size: 12px;color: black"
                                       href="${pageContext.request.contextPath}/cancelconcern.action?userId=${userId}">(<i
                                            class="icon-plus"></i>取消关注)</a>
                                </s:else>
                            </a>
                        </td>
                    </s:elseif>

                    <%-- 显示所关注者的签名 --%>
                    <s:elseif test="#st.index == 2">
                        <td style="text-align: center" width="300px">
                            <s:if test="#object.length() > 15">
                                <span title="<s:property value="#object"/>">
                                    <s:property value="#object.substring(0, 20)"/>
                                </span>
                            </s:if>
                            <s:else>
                                <span title="<s:property value="#object"/>">
                                    <s:property value="#object"/>
                                <span>
                            </s:else>
                        </td>
                    </s:elseif>

                    <s:elseif test="#st.index == 3">
                        <s:set scope="request" var="articleId" value="#object"/>
                    </s:elseif>

                    <%-- 显示所关注者的最新博客 --%>
                    <s:elseif test="#st.isLast()">
                        <td style="text-align: right" width="240px">
                            <a title="<s:property value='#object'/>" href="${pageContext.request.contextPath}/viewblog.action?articleId=${articleId}" target="_blank">
                                <s:if test="#object.length() > 8">
                                    <s:property value="#object.substring(0, 8)"/>...
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

</body>
</html>
