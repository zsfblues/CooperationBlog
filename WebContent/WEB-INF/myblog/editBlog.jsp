<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${sessionScope.user} | 协有不同</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buttons.css">
    <script type=text/javascript src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Font-Awesome/css/font-awesome.min.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/buttons.js"></script>

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/sign.png" />
</head>

<style>
    body
    {
        background: url("${pageContext.request.contextPath}/images/newblog.jpg");
    }

    #blogtitle, #tag
    {
        font-family: "Microsoft YaHei", Tahoma, Verdana, SimSun, monospace;
        font-style: normal;
        font-variant: normal;
        font-size-adjust: none;
        font-stretch: normal;
        font-weight:normal;
        padding: 4px;
        font-size: 17px;
        outline: invert none medium;
        border-radius: 3px;
        margin-right: 8px;
        border: 1px solid #ccc;
        width: 55%;
        line-height: 26px;
        margin-left: 20%;
    }

    #blogtextarea
    {
        font-family: "Microsoft YaHei", Tahoma, Verdana, SimSun, monospace;
        min-height: 550px;
        max-height: 550px;
        min-width: 55%;
        max-width: 55%;
        border-radius: 6px;
        border: 1px solid #ccc;
        outline: invert none medium;
        overflow-x: hidden;
        margin-left: 20%;
    }

    #blogtextarea:focus, #blogtitle:focus, #tag:focus
    {
        border: 1px solid #fafafa;
        box-shadow: 0px 0px 5px #007eff;
    }

</style>

<script>
    function submitblog(privilegeflag)
    {
        if (!checkInfoFormat(privilegeflag))
        {
            return false;
        }
        else
        {
            $("#myform").submit();
        }
    }

    function checkInfoFormat(privilegeflag)
    {
        var title = $("#blogtitle").val().replace(/(^\s*)|(\s*$)/g,"");
        var content = $("#blogtextarea").val().replace(/(^\s*)|(\s*$)/g,"");

        if (title == "" || content == "")
        {
            $("#tips").html("<font style='color: red'>请将信息填写完整</font>");
            return false
        }
        if (title.length > 45)
        {
            $("#tips").html("<font style='color: red'>标题过长</font>");
            return false;
        }

        $("#privilegeflag").val(privilegeflag);

        return true;
    }

</script>
<body>

<form id="myform" action="${pageContext.request.contextPath}/submitblog.action" method="post">
    <input type="text" id="blogtitle" name="blogtitle" placeholder="标题必填" required/>
    <p></p>
    <textarea placeholder="写点什么..." id="blogtextarea" name="blogtextarea" required></textarea>
    <p></p>
    <input type="text" name="tag" id="tag" placeholder="标签 以空格分隔"/>
    <input type="hidden" name="userId" id="userId" value="${sessionScope.userId}">
    <input type="hidden" name="privilegeflag" id="privilegeflag"/>
    <input type="hidden" name="requestToken" value="${sessionScope.requestToken}"/>
    <p></p>

    <span style="margin-left: 40%" class="button-dropdown button-dropdown-plain" data-buttons="dropdown">
        <button style="width: 140px;background-color: #00BFFF" class="button button-caution button-pill" onclick="return false">
            发表 <i class="icon-caret-down"></i>
        </button>

        <ul class="button-dropdown-list">
            <li><a href="javascript:void(0)" onclick="return submitblog(0)">仅自己可见</a></li>
            <li class="button-dropdown-divider">
                <a href="javascript:void(0)" onclick="return submitblog(1)">他人可见</a>
            </li>
        </ul>
    </span>
    <span id="tips"></span>
    <p>&nbsp;</p>

</form>

</body>
</html>
