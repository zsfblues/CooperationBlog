<%@ page import="java.util.Random" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>欢迎使用协同博客</title>

    <link rel="shortcut icon" href="images/sign.png" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buttons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/registerAndLogincss/registerAndLogin.css">

    <script src="js/jquery.min.js" type="text/javascript"></script>
    <script src="laydate/laydate.js"></script>

    <script type="text/javascript">

        $(document).ready(function(){

            $("#register").click(function (){

                $("#register").css({"color" : "black", "opacity" : 1});
                $("#register").hover(function(){
                    $(this).css('color','red');
                },
                        function () {
                            $(this).css('color','black');
                        }
                );
                $("#login").css({"color" : "#ffc015", "opacity" : 0.5});
                $("#login").hover(function(){
                            $(this).css('color','red');
                        },
                        function () {
                            $(this).css('color','#ffc015');
                        }
                );
                $("#mylogindiv").css( {"display" : "none"});
                $("#findpassworddiv").css( {"display" : "none"});
                $("#myregisterdiv").css( {"display" : "block"});

            });

            $("#login").click(function() {

                $("#register").css({"color" : "#ffc015", "opacity" : 0.5});
                $("#register").hover(function(){
                            $(this).css('color','red');
                        },
                        function () {
                            $(this).css('color','#ffc015');
                        }
                );
                $("#login").css({"color" : "black", "opacity" : 1});
                $("#login").hover(function(){
                            $(this).css('color','red');
                        },
                        function () {
                            $(this).css('color','black');
                        }
                );

                $("#mylogindiv").css( {"display" : "block"});
                $("#myregisterdiv").css( {"display" : "none"});
                $("#findpassworddiv").css( {"display" : "none"});
            });

            //初始化日期控件
            laydate(
                    {
                        elem: '#datepicker',
                        isclear: false,
                        format: 'YYYY-MM-DD',
                        event: 'focus'
                    });
            laydate.skin('danlan');
        });

        function isValidEmailAddress()
        {
            var myemailtxt = $(".email").val().replace(/(^\s*)|(\s*$)/g,"");

            if (myemailtxt.length == 0)
            {
                $("#emailtxt").html("请输入邮箱");
                return false;
            }
            else
            {
                $("#emailtxt").html("");
            }

            var index = myemailtxt.lastIndexOf(".");
            var index1 = myemailtxt.lastIndexOf("@");

            if (index > 0 && index1 > 0)
            {
                if (myemailtxt.substring(index + 1, myemailtxt.length) == "com"
                        && myemailtxt.charAt(index - 1) != '@')
                {

                    //采用同步方式获取数据(默认异步，这会导致 function数据未返回时就执行后面方法)
                    $.ajax({
                            url: "${pageContext.request.contextPath}/emailvalidation.action",
                            data: "emailtxt="+ myemailtxt ,
                            async : false,
                            type : "post",
                            success : function(data){

                                if (data.isExist)
                                {
                                    $("#emailtxt").html("");
                                    $("#emailtxt").html("<font style='font-size: 15px; color: red'>该邮箱已注册!</font>");
                                }
                                else
                                {
                                    $("#emailtxt").html("");
                                    $("#emailtxt").html("<font style='font-size: 15px; color: limegreen'>该邮箱可使用!</font>");
                                }
                            }
                });

                    if ($("#emailtxt").html().indexOf("邮箱已注册") >= 0)
                    {
                        return false;
                    }
                    return true;
                }
                else
                {
                    $("#emailtxt").html("");
                    $("#emailtxt").html("邮箱格式有误");
                    return false;
                }
            }

            else
            {
                $("#emailtxt").html("");
                $("#emailtxt").html("邮箱格式有误");
                return false;
            }
        }

        function isSamePassword()
        {
            var password = $(".mypassword").val().replace(/(^\s*)|(\s*$)/g,"");
            var repassword = $(".repassword").val().replace(/(^\s*)|(\s*$)/g,"");

            if (password.length == 0 || repassword.length == 0)
            {
                $("#passwordtxt").html("");
                $("#passwordtxt").html("密码为空");
                return false;
            }

            if (password.length < 3)
            {
                $("#passwordtxt").html("");
                $("#passwordtxt").html("密码小于3位");
                return false;
            }

            if (password != repassword)
            {
                $("#passwordtxt").html("");
                $("#passwordtxt").html("密码须一致");
                return false;
            }
            else
            {
                $("#passwordtxt").html("");
                return true;
            }
        }

        function getCheckCode()
        {
            $(".checkcode").removeAttr("disabled");
            $.post("${pageContext.request.contextPath}/checkcode.action",

                    function(data)
                    {
                        $("#check").html(data);
                    }
            );
        }

        function checkInfoFormat()
        {
            var checkcode = $(".checkcode").val().replace(/(^\s*)|(\s*$)/g,"");
            var mycheckcode =  $("#check").html().replace(/(^\s*)|(\s*$)/g,"");
            var myusername = $(".myusername").val().replace(/(^\s*)|(\s*$)/g,"");

            if (checkcode.length == 0 || myusername.length == 0 || checkcode != mycheckcode)
            {
                $("#formattxt").html("<font style='color: red; font-size: 13px'>请填写正确信息</font>");
                return false;
            }

            if (!isSamePassword() || !isValidEmailAddress())
            {
                $("#formattxt").html("<font style='color: red; font-size: 13px'>信息格式错误</font>");
                return false;
            }
            else
            {
                $("#formattxt").html("");
            }            
        }

        function checkLoginInfo()
        {
            var username = $(".username").val().replace(/(^\s*)|(\s*$)/g,"");
            var password = $(".password").val().replace(/(^\s*)|(\s*$)/g,"");

            if (username.length == 0)
            {
                $("#user").html("邮箱为空");
                return false;
            }
            else
            {
                $("#user").html("");
            }

            if (password.length == 0)
            {
                $("#pass").html("密码为空");
                return false;
            }
            else
            {
                $("#pass").html("");
            }

            return true;
        }

        function fade(opacity)
        {
            $(".loginerrordiv").css({"opacity" : opacity});
            opacity = (opacity*10 - 0.1*10)/10;

            var t = setTimeout(function(){fade(opacity)}, 200);

            if (opacity < 0)
            {
                clearTimeout(t);
            }
        }

        function showfindpassword()
        {
            $("#mylogindiv").css( {"display" : "none"});
            $("#myregisterdiv").css( {"display" : "none"});

            $("#findpassworddiv").css("display", "block");
        }

        function checkregistdate()
        {
            var content = $("#findemail").val().replace(/(^\s*)|(\s*$)/g,"");

            if (content != "")
            {
                $("#emailtips").html("");
                $.post(
                        "${pageContext.request.contextPath}/checkregistdate.action",

                        {
                            "email" : content,
                            "registDate" : $("#datepicker").val()
                        },

                        function (data) {

                            //表单提交属性设为disabled后值无法传递
                            if (data.isCorrect)
                            {
                                $("#newpassword").attr("disabled", false);
                                $("#findemail").attr("readonly", true);
                                $("#datepicker").attr("disabled", true);
                                $("#datetips").html("<span style='color: lawngreen;font-weight: bold'>请重置密码 <span>");
                            }
                            else
                            {
                                $("#datetips").html("<span style='color: red'>注册时间错误 <span>");
                            }
                        }
                );
            }
            else
            {
                $("#emailtips").html("<span style='color: red'>请填写邮箱<span>");
            }
        }

        function updatepassword()
        {
            var content = $("#findemail").val().replace(/(^\s*)|(\s*$)/g,"");
            var newpassword = $("#newpassword").val().replace(/(^\s*)|(\s*$)/g,"");

            return !(content == null || content == "" || newpassword == "" || newpassword == null);

        }

    </script>
    
</head>
<body>

<div id="logo">协&nbsp;&nbsp;&nbsp;同</div>  <span class="annotation">协有不同</span>
<span id="subtext">博客</span>
<div class="motto">醇美的乌托邦一隅</div>

<div id="border">

	<div class="title">
        <div id="register"> 注册 </div>
        <div id="login">  登陆  </div>
    </div>

    <div class="reflectsign">爱生活&nbsp;&nbsp;&nbsp;爱分享</div>

    <div id="mylogindiv">
        <div id="login_form">
            <form action="${pageContext.request.contextPath}/login.action" method="post">
                <table style="line-height: 1cm;margin-top: -10px">
                    <tr>
                        <td width="75px"></td>

                        <s:if test="#request.loginerror != null">
                            <td class="loginerrordiv" style="font-size: 13px;color: red"><s:property value="#request.loginerror"/></td>
                            <script>
                                fade(1);
                            </script>
                        </s:if>
                        <s:else>
                            <td style="opacity: 0">错误信息占位符</td>
                        </s:else>

                        <td></td>
                    </tr>
                    <tr>
                        <td> 用户名：</td>
                        <td><input type="text" onblur="return checkLoginInfo()" name="username" class="username" placeholder="您的邮箱"/></td>
                        <td id="user"></td>
                    </tr>
                    <tr>
                        <td>密&nbsp;&nbsp;&nbsp;码：</td>
                        <td><input type="password" onblur="return checkLoginInfo()" name="password" class="password" placeholder="密码"/></td>
                        <td id="pass"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><button onclick="return checkLoginInfo()" class="button button-raised button-caution">登陆</button></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td><a onclick="showfindpassword()" style="text-decoration: none;color: #007eff;cursor: pointer">忘记密码</a></td>
                    </tr>
                </table>
            </form>
      </div>
  </div>

    <div id="myregisterdiv">
        <div id="register_form">

            <form action="${pageContext.request.contextPath}/register.action" method="post">
                <table style="line-height: 1cm;margin-top: -32px">
                    <tr>
                        <td width="85px">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：</td>
                        <td><input type="text" name="email" class="email" onblur="return isValidEmailAddress()" placeholder="正确的邮箱"/></td>
                        <td width="auto" id="emailtxt"></td>
                    </tr>
                    <tr>
                        <td> 用&nbsp;户&nbsp;名&nbsp;：</td>
                        <td><input type="text" name="myusername" class="myusername" placeholder="昵称"/></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td> 密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
                        <td><input type="password" name="mypassword" class="mypassword" placeholder="密码" onblur="return isSamePassword()" /> </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td> 确认密码：</td>
                        <td><input type="password" name="repassword" class="repassword" placeholder="确认密码" onblur="return isSamePassword()" /> </td>
                        <td id="passwordtxt"></td>
                    </tr>
                    <tr>
                        <td> 验&nbsp;证&nbsp;码&nbsp;：</td>
                        <td><input type="text" disabled="disabled" name="checkcode" class="checkcode" placeholder="输入验证码"/></td>
                        <td style="cursor: pointer" id="check" onclick="getCheckCode()">点击获取</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><button onclick="return checkInfoFormat()" class="button button-raised button-caution">注册</button></td>
                        <td id="formattxt"></td>
                    </tr>
                </table>
            </form>

        </div>
    </div>

    <div id="findpassworddiv">
        <form action="${pageContext.request.contextPath}/updatepassword.action" method="post">
            <table>
                <tr>
                    <td>
                        您的邮箱：
                    </td>
                    <td>
                        <input type="text" name="findemail" id="findemail" onblur="checkregistdate()" />
                    </td>
                    <td id="emailtips"></td>
                </tr>
                <tr>
                    <td>
                        注册日期：
                    </td>
                    <td>
                        <input id="datepicker" name="datepicker" value="2015-11-7" readonly onblur="checkregistdate()">
                    </td>
                    <td id="datetips"></td>
                </tr>

                <tr>
                    <td>
                        新密码：
                    </td>
                    <td>
                        <input id="newpassword" name="newpassword" disabled>
                    </td>
                </tr>

                <tr>
                    <td></td>
                    <td>
                        <button onclick="return updatepassword()"  class="button button-raised button-caution">修改密码 </button>
                    </td>
                </tr>
            </table>
        </form>

    </div>

</div>

<div id="background"> <img src="images/registerjpg/<%=new Random().nextInt(15) + 1%>.jpg" alt="图片无法显示"/></div>

</body>
</html>