$(function(){

    $(".mybuttondiv").hover(
        function(){
            $(".mybuttondiv").css( {"left" : "10px", "background-color" : "#D6E9F1"});
            $("span[id = buttonfont]").fadeIn(2500);
        },
        function()
        {
            $(".mybuttondiv").css( {"left" : "0", "background" : "none"});
            $("span[id = buttonfont]").css( "display" , "none");
        }
    );
    drawArc();
});
KindEditor.ready(function(K)
{
    window.editor = K.create('#reply_content', {

        items: ['undo', 'redo', '|', 'title', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'textcolor', 'bgcolor', 'bold',
            'italic', 'underline', 'strikethrough', 'removeformat', '|',
            'advtable', 'link', 'emoticons', 'source', '|', 'about'],

        minWidth : '500px',
        resizeType : 0,
        filterMode : true
    });
});

function drawArc()
{
    var canvas = $("canvas[id = ramdoncanvas]");

    if (canvas == null)
        return false;

    canvas.attr("width", $(document).width());
    canvas.attr("height", $(document).height());

    if (canvas == null)
        return false;
    var context = canvas.get(0).getContext("2d");

    for (var i = 0; i < $(document).height() * 0.03; i++)
    {
        context.beginPath();
        context.arc( Math.random() * ($(document).width()+10) + 1, Math.random() * $(document).height() + 1, 35, 0, Math.PI * 2, true);
        context.fillStyle = 'rgba(170, 170, 170, 0.3)';
        context.fill();
    }
}

function submit_reply()
{
    editor.sync();
    var reply_content = $("#reply_content").val();

    if(reply_content.length == 0)
    {
        $("#reply_tip").html("<h5 style='color: red'>回复不能为空!</h5>");
        return false;
    }
    else
    {
        $("#reply_tip").html("");
    }
}
function clearContent()
{
    editor.html(null);
    $("#reply_tip").html("");
    return false;
}

function show(tag, num, receiver)
{
    var light=document.getElementById(tag);
    var fade=document.getElementById('fade');

    $(".subreply_content").css( {"top" : parseInt(document.body.scrollTop) + 165 + "px"});
    $(".black_overlay").css( {"height": $(document.body).height() + 200 + "px", "margin-top" : -$(document.body).height() + "px", "left" : "0"});
    $("body").css("overflow", "hidden");
    $("#reply_id").val(num);
    $('input[id = myreceiver]').val(receiver);

    light.style.display='block';
    fade.style.display='block';
}

function hide(tag)
{
    var light = document.getElementById(tag);
    var fade = document.getElementById('fade');
    $("body").css("overflow", "auto");
    light.style.display = 'none';
    fade.style.display = 'none';
    $("#subreply_textarea").val(null);
}

function limitInput()
{
    var num = $("#subreply_textarea").val().length;

    if (num <= 140 && num != 0)
    {
        $("#rebutton").removeAttr("disabled");
        $("#limitNum").text("您还可以输入" + (140 - num) + "个字符");
    }
    else if (num == 0)
    {
        $("#limitNum").html("<font color='red'>&lt;字符不能为空&gt;</font>");
        return false;
    }
    else
    {
        $("#rebutton").attr("disabled", "true");
        $("#limitNum").html("&lt;限定140个字符&gt;");
        return false;
    }
}

window.onscroll = function()
{
    window.onscroll = function()
    {
        //scrollTop指代内层元素超过外层元素的内容，即需要滚动拖动显示的那部分内容
        //页面具有 DTD，或者说指定了 DOCTYPE 时，使用 document.documentElement
        //页面不具有 DTD，或者说没有指定了 DOCTYPE，时，使用 document.body

        if ($(document).scrollTop() > 360)
        {
            $("#to_top").css({"position" : "fixed"});
            $("#to_top").css({"display" : "block"});
        }
        else
        {
            $("#to_top").css({"position": "absolute"});
            $("#to_top").css({"display" : "none"});
        }

        if ($(document).scrollTop() > $('div[id = blogtextarea]').height() - 655)
        {
            $("#parent_reply_div").fadeIn(2000);
        }
        else
        {
            $("#parent_reply_div").fadeOut(1000);
        }

        if ($(document).scrollTop() > $('div[id = blogtextarea]').height() - 400)
        {
            $("#allreplydiv").fadeIn(3500);
        }
        else
        {
            $("#allreplydiv").fadeOut(1000);
        }
    };

    $("#to_top").click(function()
    {
        document.documentElement.scrollTop = document.body.scrollTop = 0;
    });
};

function ajaxToAdmire(articleId, requestToken)
{
    $.post("${pageContext.request.contextPath}/admire.action",

        {"articleId" :  articleId, "requestToken" : requestToken},

        function()
        {
            $("button[id = myadmire]").attr("disabled", "disabled");
            $("#buttonfont").html("<font color='red'>已赞</font>");
            $("#plusone").css({"opacity": 1});

            setTimeout(function () {
                $("#plusone").css({"opacity": 0});
            }, 1000);
        }
    );
}
