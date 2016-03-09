//设置背景图片自适应浏览器窗口宽高
$(document).ready(function(){
    drawDot();
    $(".vertihr").css("height", $(document).height() - 460 + "px");
});

window.onscroll = function()
{
    window.onscroll = function()
    {
        //scrollTop指代内层元素超过外层元素的内容，即需要滚动拖动显示的那部分内容
        //页面具有 DTD，或者说指定了 DOCTYPE 时，使用 document.documentElement
        //页面不具有 DTD，或者说没有指定了 DOCTYPE，时，使用 document.body

        if ($(document).scrollTop() > 260)
        {
            $("#to_top").css({"position" : "fixed"});
            $("#to_top").css({"display" : "block"});
        }
        else
        {
            $("#to_top").css({"position": "absolute"});
            $("#to_top").css({"display" : "none"});
        }


        if ($(document).scrollTop() > 80)
        {
            $("#wrapper").css({"position" : "fixed"});
        }
        else
        {
            $("#wrapper").css({"position": "absolute"});
        }
    };

    $("#to_top").click(function()
    {
        document.documentElement.scrollTop = document.body.scrollTop = 0;
    });
};

function drawDot()
{
    var colorArray = ["#57baff", "#EFCA02", "#FFA42A", "#FFA6EF", "#A6FF46"];
    var canvas = $("canvas[id = colorfuldot]");

    if (canvas == null)
        return false;

    canvas.attr("width", "550px");
    canvas.attr("height", "345px");

    if (canvas == null)
        return false;
    var context = canvas.get(0).getContext("2d");

    for (var i = 0; i < 6; i++)
    {
        for (var j = 0; j < 10; j++)
        {
            context.beginPath();
            context.arc( 20 + j * 50, 20 + i * 50, 16, 0, Math.PI * 2, true);
            if (
                j == 1
                || (i == 2 && j < 8 && j >= 4)
                || (i == 2 && j >=0 && j <= 2)
                || (i >= 1 && i <= 4 && j == 5)
                || (i >= 2 && j == 7)
                || (i == 5 && j == 4)
                || ((i == 3 && j == 4) || (i == 4 && j == 3))
                || ((i == 3 && j == 8) || (i == 4 && j == 9))
            )
            {
                context.fillStyle = colorArray[0];
            }
            else
            {
                context.fillStyle = colorArray[parseInt(Math.random() * 4 + 1)];
            }
            context.fill();
        }
    }
}

function drawLine(length, maxpopularity, userId)
{
    $("#" + userId).css( {"width" : parseInt(length) / parseInt(maxpopularity) * 350 + "px", "height" : "14px"});
    $("#" + userId).css( {"background-color" : "#57baff", "border-radius" : "20px"});
}
