//设置背景图片自适应浏览器窗口宽高
$(document).ready(function(){
    $(".contentdiv").css( {"height" : $(document).height()});
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

$(function(){
    // 实例化
    var uploader = WebUploader.create({
        pick: {
            id: '#filePicker',
            compress: false
        },

        accept: {
            title: 'ImagesTypes',
            extensions: 'gif,jpg,jpeg,bmp,png',
            mimeTypes: 'image/*'
        },

        server: '${pageContext.request.contextPath}/uploadlifeimg.action',
        multiple: true,
        fileVal: 'lifeimg',
        swf: 'js/webuploaderjs/Uploader.swf',
        auto: true,                 //打开文件后自动上传
        disableGlobalDnd: true,  // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
        //     fileSizeLimit: 20 * 1024 * 1024,    // 上传文件总大小限制：20 M
        fileSingleSizeLimit: 2 * 1024 * 1024    // 单个文件上传大小限制：2 M
    });

    uploader.on( 'uploadSuccess', function(file, response) {

        //file对象必须写出来，不然默认参数为file(无法使用response获取服务器值) O__O"…
        $.post("${pageContext.request.contextPath}/showuploadimg.action?1",

            {"imgsrc": response.newFileName},

            function (data) {
                if (data.imgsrc != null) {
                    $img = $("<img/>");

                    chooseimgsize($img, data.imgsrc);
                    $img.on('dblclick', function () {

                        showPreview($(this).attr("src"));
                    });
                    $("#sharecontent").append($img);

                    $("#info").html("<font  style='color:red;font-size: 13px'>上传完成</font>");
                }
            }
        );
    });

    uploader.on('error', function(file){
        //显示上传失败信息
        $("#info").html("<font  style='color:red;font-size: 13px'>上传失败,请检查文件类型及大小</font>");
    });

    // 当有文件添加进来的时候
    uploader.on( 'fileQueued', function( file ) {

        $("#info").html("<font  style='color:red;font-size: 13px'>正在上传,请耐心等候...</font>");

    });
});

var flag = false;
function mytoggle()
{
    if (flag)
    {
        $("#editdiv").hide();
        $("#sign").show();
        flag = false;
    }
    else
    {
        $("#editdiv").show();
        $("#sign").hide();
        flag = true;
    }
}

function checkInfoFormat(privilegeflag)
{
    var title = $("#title").val().replace(/(^\s*)|(\s*$)/g,"");
    var lead = $("#lead").val().replace(/(^\s*)|(\s*$)/g,"");
    var sharecontent = $("#sharecontent").html();

    $("#mysharecontent").val(sharecontent);

    if (title == "" || lead == "" || sharecontent == "" || sharecontent == "<br>")
    {
        $("#info").html("<font style='color: red'>请将信息填写完整</font>");
        return false
    }

    if (title.length > 45)
    {
        $("#info").html("<font style='color: red'>标题过长</font>");
        return false;
    }

    $("#privilegeflag").val(privilegeflag);

    return true;
}

function submitlifeblog(privilegeflag)
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

function showPreview(imgsrc)
{
    $realimg = $('<img />');
    $realimg.attr("src", imgsrc);

    var imgWidth;//真实的宽度
    var imgHeight;//真实的高度

    $realimg.load(function(){

        imgWidth = this.width;
        imgHeight = this.height;

        document.documentElement.scrollTop = document.body.scrollTop = 0;
        $('img[id = preimg]').attr("src", imgsrc);

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
}

function hideimg()
{
    document.documentElement.scrollTop = document.body.scrollTop = $(document).height();
    $("#previewdiv").css( "display", "none");
}

function chooseimgsize(img, imgsrc)
{
    var realWidth;
    var realHeight;

    img.attr("src", "sharelifeimg/" + imgsrc);

    img.load(function(){

        realWidth = this.width;
        realHeight = this.height;

        if (realWidth > 420 && realHeight > 285)
        {
            img.attr( {"width" : "420px", "height" : "285px"});
        }
        else if (realWidth > 420 && realHeight < 285)
        {
            img.attr( {"width" : "420px", "height" : realHeight});
        }
        else if (realWidth < 420 && realHeight > 285)
        {
            img.attr( {"width" : realWidth, "height" : "285px"});
        }
        else
        {
            img.attr( {"width" : realWidth, "height" : realHeight});
        }
    });
}
