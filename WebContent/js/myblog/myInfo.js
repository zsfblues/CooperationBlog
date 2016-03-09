function checkPassword()
{
    if ($("#mypassword").val().replace(/(^\s*)|(\s*$)/g,"") != "")
    {
        $.ajax({
            url : "${pageContext.request.contextPath}/ajaxcheckpasswod.action",
            data : {"password" : $("#mypassword").val()},
            type : "post",
            success : function(data){

                if ( !data.isCorrectPassword)
                {
                    $("#passwordtxt").html("<font color='red'>密码错误</font>");
                }
                else
                {
                    $("#passwordtxt").html("<font color='#7cfc00'>请输入新密码</font>");
                    $("#mypassword").attr("disabled", true);
                    $("#newpassword").attr("disabled", false);
                }
            }
        });
    }
}

function submitmyinfo()
{
    if ( $("#username").val().replace(/(^\s*)|(\s*$)/g,"") == "")
    {
        $("#tips").html("<span style='color: red;font-size: 13px'>请将信息填写完整</span>");
        return false;
    }
    if ($("#passwordtxt").html().indexOf("密码错误") >= 0)
    {
        return false;
    }
    else
    {
        $.post("${pageContext.request.contextPath}/submitmyinfo.action",
            {
                "username" : $("#username").val(),
                "password" : $("#newpassword").val().replace(/(^\s*)|(\s*$)/g,""),
                "signname" : $("#signname").val()
            },

            function (data)
            {
                if (data.changeFlag)
                {
                    $("#editdiv").css("display", "none");
                    $("#hidediv").css("display", "block");
                    go();
                }
            }
        );
    }
}

var time = 5;
function go()
{
    if (time == 0)
    {
        location.href = "${pageContext.request.contextPath}/myblog.action";
    }

    document.getElementById("changetip").innerHTML = "修改成功, <span style='color: red;font-size: 25px'>" + time + "</span>秒后自动跳转";
    time--;
    setTimeout("go()", 1000);
}

function drawGradientText()
{
    var canvas = $("canvas[id = gratext]");
    var context = canvas.get(0).getContext("2d");

    if (canvas == null)
        return false;

    canvas.attr("width", 500);
    canvas.attr("height", 100);

    //设置填充文本的字体样式
    context.font = "50px Verdana";

    // 创建渐变
    var gradient = context.createLinearGradient(0, 0, 200, 0); //渐变开始和结束的坐标
    gradient.addColorStop(0, "#CFC");   //规定渐变对象中的颜色和停止位置，前一个参数表示
                                        //介于 0.0 与 1.0 之间的值，表示渐变颜色在渐变中所占比例

    gradient.addColorStop(0.5, "#00BFFF");
    gradient.addColorStop(1, "red");

    context.fillStyle = gradient;
    context.fillText("修改信息", 10, 50);  //绘制文本，并指定在相对于画布的坐标
}

function drawGraph()
{
    var canvas = $("canvas[id = graph]");
    var context = canvas.get(0).getContext("2d");

    if (canvas == null)
        return false;

    canvas.attr("width", $(document).width());
    canvas.attr("height", $(document).height());

    for (var i = 15; i > 0; i--)
    {
        context.beginPath();                                                  //起始一条路径，或重置当前路径
        context.strokeStyle = "rgba(0, 191, 255, 0.4)";                       //填充线条颜色
        context.lineWidth = 0.3 * Math.pow(8 - i, 2);                         //设置线条的粗细
        context.moveTo( 320 - Math.pow(8 - i, 2), 15 + (15 - i) * 24);        //线条的开始位置坐标(x, y)
        context.lineTo( 100 - Math.pow(8 - i, 2), 15 + (15 - i) * 24);        //线条结束位置坐标(x, y)
        context.lineCap = 'round';
        context.stroke();
    }

    for (var j = 15; j > 0; j--)
    {
        context.beginPath();
        context.strokeStyle = "rgba(0, 191, 255, 0.4)";
        context.lineWidth = 0.3 * Math.pow(8 - j, 2);
        context.moveTo($(document).width() - 350 + Math.pow(8 - j, 2), 15 + (15 - j) * 24);
        context.lineTo($(document).width() - 130 + Math.pow(8 - j, 2),  15 + (15 - j) * 24);
        context.lineCap = 'round';
        context.stroke();
    }

    for (var k = 0; k < 50; k++)
    {
        context.rotate(Math.PI / 4);
        context.strokeStyle = "rgba(24, 24, 24, 0.2)";
        context.strokeRect(Math.random() * ($(document).width() - 200) + 100, Math.random() * 100 + 200, 8, 8);
    }
}

$(function(){

    drawGradientText();
    drawGraph();

});
