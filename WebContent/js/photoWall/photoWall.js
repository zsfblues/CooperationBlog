//设置背景图片自适应浏览器窗口宽高
$(document).ready(function(){
    $("#photodiv").css("height", $(document).height());
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

function show()
{
    $("#uploadimg").click();
    $("#uploadimg").change(function () {
        $("#uploadurl").val($("#uploadimg").val());
    });
}

function checkUploadType()
{
    var fname = $("#uploadurl").val();

    var i = fname.indexOf('.');
    var type = fname.substring(i + 1);

    if (type.toUpperCase() != 'JPG' &&
        type.toUpperCase() != 'PNG' &&
        type.toUpperCase() != 'GIF' &&
        type.toUpperCase() != 'BMP') {
        $("#typetips").html("<font style='color: red;font-size: 13px'>只支持图片上传</font>");
        return false;
    }

    return true;
}

function showPreview(imgsrc)
{
    var path = "uploadimg/" + imgsrc;
    var imgWidth;   //真实的宽度
    var imgHeight;  //真实的高度

    $('img[id = preimg]').attr("src", path);

    $('img[id = preimg]').load(function(){

        imgWidth = this.width;
        imgHeight = this.height;

        if (imgWidth > $(document).width())
        {
            if (imgHeight > $(document).height())
            {
                $("#previewdiv").css({"display": "block", "width": imgWidth, "height": imgHeight});
            }
            else
            {
                $("#previewdiv").css({"display": "block", "width": imgWidth, "height": $(document).height()});
            }
        }
        else
        {
            if (imgHeight > $(document).height())
            {
                $("#previewdiv").css({"display": "block", "width" : "100%", "height": imgHeight});
            }
            else
            {
                $("#previewdiv").css({"display": "block", "width": "100%", "height": $(document).height()});
            }
        }
    });

    $("#previewdiv").css( {"display" : "block", "height" : $(document).height()});
}

function hideimg()
{
    $("#previewdiv").css( "display", "none");
}

function showlastimg(src, title)
{
    setTimeout(function(){

        $("#lastimg").attr("src", "${pageContext.request.contextPath}/uploadimg/" + src);
        $("#lastimg").attr({"title" : "上传者：" + title, "width" : "200px", "height" : "120px"});

        $("#menu").css("display", "block");
    }, 5000);
}
