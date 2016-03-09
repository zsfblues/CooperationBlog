<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${sessionScope.user} | 协有不同</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buttons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/myblog/showBlogDetail.css">

    <script type=text/javascript src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/myblog/showBlogDetail.js"></script>

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/sign.png" />

</head>
<body>

<div id="all_content_div">
        <s:iterator value="myarticle" var="objects" status="sta">
            <s:iterator value="objects" var="object" status="st">

                <s:if test="#st.isFirst()">
                    <s:set var="articleId" value="#object" scope="request"/>
                </s:if>

                <s:elseif test="#st.index == 1">
                    <input type="text" id="blogtitle" name="blogtitle" readonly value="<s:property value="#object"/>" required/>
                    <p></p>
                </s:elseif>

                <s:elseif test="#st.index == 2">
                    <div id="blogtextarea">${object}</div>
                    <p></p>
                </s:elseif>

                <s:elseif test="#st.isLast()">
                    <input placeholder="标签 以空格分隔" type="text" id="tag" name="tag" value="<s:property value="#object"/>" readonly/>
                </s:elseif>

            </s:iterator>
        </s:iterator>
    <p>&nbsp;</p>
    <center>
        <button type="button" class="button button-raised button-primary button-pill" onclick="editarticle()">编辑</button>
        <button id="savebtn" disabled class="button button-raised button-primary button-pill" onclick="ajaxToSaveBlog('${requestScope.articleId}')">保存</button>
        <span id="tips"></span>
    </center>
</div>
<canvas id="mycanvas"> </canvas>

<div id="messagediv"> 恭喜! 保存成功</div>

</body>
</html>
