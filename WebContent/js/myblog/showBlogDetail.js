function editarticle()
{
    $("div[id = blogtextarea]").attr('contenteditable', true);
    $("input[name = blogtitle]").removeAttr("readonly");
    $("input[name = tag]").removeAttr("readonly");
    $("button[id = savebtn]").attr("disabled", false);
    $("button[name = tag]").removeAttr("readonly");
}

function drawArc()
{
    var canvas = $("canvas[id = mycanvas]");
    var context = canvas.get(0).getContext("2d");

    if (canvas == null)
        return false;

    canvas.attr("width", $(document).width());
    canvas.attr("height", "768px");

    //i作为每个新圆的半径
    for (var i = 0; i < 10; i++)
    {
        context.beginPath();
        context.arc(i * 25, i * 45, i * 10, 0, Math.PI * 2, true);

        context.fillStyle = 'rgba(170, 170, 170, 0.35)';
        context.fill();
    }

    for (var j = 0; j < 10; j++)
    {
        context.beginPath();
        context.arc($(document).width()+10 -  j * 25, j * 45, j * 10, 0, Math.PI * 2, true);

        context.fillStyle = 'rgba(170, 170, 170, 0.35)';
        context.fill();
    }
}

$(function(){

    drawArc();

});

function ajaxToSaveBlog(articleId)
{
    var blogtitle = $("#blogtitle").val().replace(/(^\s*)|(\s*$)/g,"");
    var blogcontent = $("#blogtextarea").html().replace(/(^\s*)|(\s*$)/g,"");

    if (blogcontent == "" || blogtitle == "")
    {
        $("#tips").html("<font> 内容不能为空</font>");
    }

    $.post( "${pageContext.request.contextPath}/savablog.action",
        {
            "articleId" : articleId,
            "blogtitle" : blogtitle,
            "blogtextarea" : blogcontent,
            "tag" : $("#tag").val()
        },
        function()
        {
            $("#blogtitle").attr("readonly", true);
            $("#blogtextarea").attr("contenteditable", false);
            $("#tag").attr("readonly", true);

            $("#messagediv").css( {"display" : "block", "left" : $(document).width() / 3} );
            $("#messagediv").fadeOut(3500);
        }
    );
}
