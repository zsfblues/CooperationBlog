//设置背景图片自适应浏览器窗口宽高
$(document).ready(function(){
    $("#baseBackgroud").css( {"width" : $(document).width(), "height" : $(document).height()});

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

function getsearch()
{
    var content = $(".searchtxt").val().replace(/(^\s*)|(\s*$)/g,"");

    if (content != "")
    {
        document.getElementById("myform").submit();
    }
}
