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

$(document).ready(function(){

    $("#myinfodiv").hover(function(){

            $(this).css( {"width" : "21%", "left" : "82%"});

            $("#infotip").css( {"display" : "none"});
            $("#myinfo").css( {"display" : "block"});
            $("#logout").css( {"display" : "block"});
        },

        function()
        {
            $(this).css( {"width" : "3%", "left" : "97%"});
            $("#infotip").css( {"display" : "block"});
            $("#myinfo").css( {"display" : "none"});
            $("#logout").css( {"display" : "none"});
        }
    );

    drawArc();
});

var flag = true;
function control_switch()
{
    if (flag)
    {
        $("#newblogdiv").find("ul li:nth-child(1)").css({"display": "none"});

        setTimeout(function () {
            $("#newblogdiv").find("ul li:nth-child(2)").css({"display": "none"});
        }, 260);
        setTimeout(function(){
            $("#newblogdiv").find("ul li:nth-child(3)").css({"display": "none"});
        }, 520);

        flag = false;
    }
    else
    {
        $("#newblogdiv").find("ul li:nth-child(1)").css({"display": "block"});

        setTimeout(function () {
            $("#newblogdiv").find("ul li:nth-child(2)").css({"display": "block"});
        }, 260);
        setTimeout(function () {
            $("#newblogdiv").find("ul li:nth-child(3)").css({"display": "block"});
        }, 520);

        flag = true;
    }
}

function deletemyblog(articleId)
{
    var flag = confirm("确定删除该博客吗？");

    if (flag)
    {
        location.href = "${pageContext.request.contextPath}/deleteblog.action?articleId=" + articleId;
    }
}

function getsearch()
{
    var content = $(".searchtxt").val().replace(/(^\s*)|(\s*$)/g,"");

    if (content != "")
    {
        document.getElementById("myform").submit();
    }
}

function setTimeList()
{
    var date = new Date();
    var $timeList = $("ul[id = timelist] > span:first");
    var year = date.getFullYear();

    for (var  i = 0; i < 12; i++)
    {
        var $li = $("<li></li>");
        var $a = $("<a></a>");
        $a.attr("href", "${pageContext.request.contextPath}/searchbydate.action?datetxt=" + year + "-" + (i + 1));
        $a.attr("title", year + "年" + (i + 1) + "月");
        $a.html(year + "年" + (i + 1) + "月");
        $li.append($a);
        $li.insertAfter($timeList);
    }
}
