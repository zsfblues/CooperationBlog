window.onscroll = function()
{
    window.onscroll = function()
    {
        //scrollTopָ���ڲ�Ԫ�س������Ԫ�ص����ݣ�����Ҫ�����϶���ʾ���ǲ�������
        //ҳ����� DTD������˵ָ���� DOCTYPE ʱ��ʹ�� document.documentElement
        //ҳ�治���� DTD������˵û��ָ���� DOCTYPE��ʱ��ʹ�� document.body

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
});

function highlight(idname)
{
    $("#" + idname).children('a').css( {"font-weight" : "bolder", "color" : "#2b9fff", "background" : "white"});
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
