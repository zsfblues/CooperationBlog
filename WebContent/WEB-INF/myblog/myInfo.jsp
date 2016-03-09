<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title> ${sessionScope.user} | 协有不同</title>

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/sign.png" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buttons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myblog/myInfo.css">

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/myblog/myInfo.js"></script>

</head>
<body>

<div id="editdiv">
    <s:iterator value="infolist" var="objects" status="sta">
        <table style="line-height: 70px">
            <s:iterator value="objects" var="object" status="st">

                <s:if test="#st.isFirst()">
                    <tr>
                        <td>
                            用户名：
                        </td>
                        <td>
                            <input type="text" name="username" id="username" required
                                   value="<s:property value="#object"/>"/>
                        </td>
                        <td></td>
                    </tr>
                </s:if>

                <s:elseif test="#st.index == 1">
                    <tr>
                        <td>
                            签&nbsp;&nbsp;名&nbsp;：
                        </td>
                        <td>
                            <input type="text" name="signname" id="signname" value="<s:property value="#object"/>"/>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>
                            原密码：
                        </td>
                        <td>
                            <input type="password" name="mypassword" id="mypassword" onblur="checkPassword()"/>
                        </td>
                        <td width="100px" id="passwordtxt"></td>
                    </tr>

                    <tr>
                        <td>
                            新密码：
                        </td>
                        <td>
                            <input type="password" name="newpassword" id="newpassword" disabled required/>
                        </td>
                        <td></td>
                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            <button onclick="return submitmyinfo()"
                                    class="button button-glow button-rounded button-raised button-primary">提交
                            </button>
                        </td>
                        <td style="line-height: 13px" width="100px" id="tips"></td>
                    </tr>
                </s:elseif>

            </s:iterator>
        </table>

    </s:iterator>
</div>

<div id="hidediv">
    <span id="changetip">修改成功, 5秒后自动跳转</span> &nbsp;<a href="${pageContext.request.contextPath}/myblog.action">直接进入</a>
</div>

<canvas id="graph"></canvas>
<canvas id="gratext"></canvas>
</body>
</html>
