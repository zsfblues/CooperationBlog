<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>科技新闻</title>

    <link rel=stylesheet type=text/css href="${pageContext.request.contextPath}/css/indexcss/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/buttons.css">

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/sign.png" />

    <script type=text/javascript src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/js.min.js"></script>
    <script type=text/javascript src="${pageContext.request.contextPath}/js/tabs.js"></script>

    <script type=text/javascript>
        $(function(){$(".lavaLamp").lavaLamp({ fx: "backout", speed: 600 })});
    </script>

    <style>
        body
        {
            overflow-x:hidden;
            font-family: "Microsoft YaHei", Tahoma, Verdana, SimSun, monospace;
            background-color: whitesmoke;
        }

        #to_top
        {
            position: absolute;
            z-index: 4;
            left: 32cm;
            top: 14cm;
            opacity: 0.8;
            cursor:pointer;
            display:none;
        }

        #wrapper
        {
            position: absolute;
            z-index: 4;
            left: 15%;
            top: 29px;
            opacity: 0.6;
        }

        a
        {
            color: #88DDFF;
            outline: none;
            text-decoration: none
        }

        a:hover
        {
            color: #FFFF99;
            text-decoration: underline
        }

        #it_news a
        {
            font-weight: bolder;
            color: #2b9fff;
            background-color: white;
        }

        #news_box1
        {
            margin-top: 20px;
            border: 1px solid #666666;
            background: #444444;
            color: #FFFFFF;
            opacity: 0.7;
        }

        #news_box2, #news_box3, #news_box4, #news_box5, #news_box6
        {
            margin-top: 60px;
            border: 1px solid #666666;
            background: #444444;
            color: #FFFFFF;
            opacity: 0.7;
        }

        #news_box1 .publish_date, #news_box2 .publish_date, #news_box3 .publish_date, #news_box4 .publish_date, #news_box5 .publish_date, #news_box6 .publish_date
        {
            margin-top: 10px;
            color: #88DDFF;
            font-size: 11px;
            font-weight: bold;
        }

        #news_box1 .text_area, #news_box2 .text_area, #news_box3 .text_area, #news_box4 .text_area, #news_box5 .text_area, #news_box6 .text_area
        {
            margin: 0 auto;
            padding: 10px;
            width: 860px;
        }

        #news_box1 .post_title, #news_box2 .post_title, #news_box3 .post_title, #news_box4 .post_title, #news_box5 .post_title, #news_box6 .post_title
        {
            padding: 5px;
            background: url("${pageContext.request.contextPath}/images/post_title_bg.gif");
            font-size: 12px;
            font-weight: bold;
            color: #CCCCCC;
        }

        .it_content
        {
            position: absolute;
            z-index: 2;
            width: 960px;
            min-height: 400px;
            height: auto;
            background-color: #ffffef;
            top: 90px;
            left: 15%;
        }

        #footer
        {
            position: absolute;
            z-index: 2;
            left: 40%;
            font-size: medium;
            color: #00DFFF;
        }

    </style>
</head>

<script>
    //设置背景图片自适应浏览器窗口宽高
    $(document).ready(function(){
        $("#footer").css("top", $(document).height() + 50);
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

</script>
<body>

<div id="wrapper">
    <ul class=lavaLamp>
        <li id="homepage"> <a href='${pageContext.request.contextPath}/showlastblog.action'> 首页</a></li>
        <li id="fame"> <a href='${pageContext.request.contextPath}/showfame.action'> 红人馆</a></li>
        <li id="it_news"> <a href='${pageContext.request.contextPath}/myitnews.action'> 科技新闻</a></li>
        <li id="dynamic_message"> <a href='${pageContext.request.contextPath}/Myindex.jsp?idname=dynamic_message'> 最新动态</a></li>
        <li id="myblog"> <a href="${pageContext.request.contextPath}/myblog.action"> 我的博客 </a></li>
        <li id="photots"> <a href="${pageContext.request.contextPath}/uploadfiles.action"> 相册 </a></li>
        <li> <a href='${pageContext.request.contextPath}/recordmylife.action'> 捕捉生活</a></li>
    </ul>
</div>

<div class="it_content">
    <div id="news_box1" align="justify">
        <div class="post_title">News One</div>
        <div class="text_area">
            <span style="font-size: 20px;color: #ffffef">01 |</span>&nbsp;&nbsp;&nbsp; Windows三十岁：蓝屏、死机但依然伟大
            <div class="publish_date">
                Post Date: 2015-11-21 | <a href="http://tech.sina.com.cn/it/2015-11-21/doc-ifxkwuwv3522102.shtml" target="_blank">全文</a>
            </div>
        </div>
    </div>

    <div id="news_box2" align="justify">
        <div class="post_title">News Two</div>
        <div class="text_area">
            <span style="font-size: 20px;color: #ffffef">02 |</span>&nbsp;&nbsp;&nbsp;网站缓存技术总结 (ehcache memcache redis)
            <div class="publish_date">
                Post Date: 2014-12-4 | <a href="http://www.xuetimes.com/archives/325" target="_blank">全文</a>
            </div>
        </div>
    </div>

    <div id="news_box3" align="justify">
        <div class="post_title">News Three</div>
        <div class="text_area">
            <span style="font-size: 20px;color: #ffffef">03 |</span>&nbsp;&nbsp;&nbsp;外媒:谷歌明年将重返中国市场
            <div class="publish_date">
                Post Date: 2015-11-20 | <a href="http://tech.sina.cn/i/usstock/2015-11-20/detail-ifxkwuwy7032518.d.html" target="_blank">全文</a>
            </div>
        </div>
    </div>

    <div id="news_box4" align="justify">
        <div class="post_title">News Four</div>
        <div class="text_area">
            <span style="font-size: 20px;color: #ffffef">04 |</span>&nbsp;&nbsp;&nbsp;2016年百度校招小结：我做技术面试官的一些思考
            <div class="publish_date">
                Post Date: 2015-11-17 | <a href="http://blog.jobbole.com/94565/" target="_blank">全文</a>
            </div>
        </div>
    </div>

    <div id="news_box5" align="justify">
        <div class="post_title">News Five</div>
        <div class="text_area">
            <span style="font-size: 20px;color: #ffffef">05 |</span>&nbsp;&nbsp;&nbsp;来看看高大上的Brillo物联网操作系统
            <div class="publish_date">
                Post Date: 2015-11-17 | <a href="http://www.linuxstory.org/android-based-brillo-iot-os-arrives-with-hacker-sbc-support/" target="_blank">全文</a>
            </div>
        </div>
    </div>

    <div id="news_box6" align="justify">
        <div class="post_title">News Six</div>
        <div class="text_area">
            <span style="font-size: 20px;color: #ffffef">06 |</span>&nbsp;&nbsp;&nbsp;思科将以7亿美元收购协同软件公司Acano(协同博客呢？)
            <div class="publish_date">
                Post Date: 2015-11-21 | <a href="http://tech.sina.com.cn/t/2015-11-21/doc-ifxkwuwy7035369.shtml" target="_blank">全文</a>
            </div>
        </div>
    </div>
</div>

<div id="footer">Copyright © 2015-2016 协同博客.All rights reserved.</div>

<div id="to_top"> <img src="${pageContext.request.contextPath}/images/topback.gif"/> </div>
</body>
</html>
