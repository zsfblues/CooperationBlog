package com.zsf.javabean;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.javabean
 * @ 2015/10/19
 */
public class BlogInfo
{
    private String blogtitle;
    private String blogtextarea;
    private String tag;
    private String userId;
    private String privilegeflag;
    private String articleId;

    public String getArticleId()
    {
        return articleId;
    }

    public void setArticleId(String articleId)
    {
        this.articleId = articleId;
    }

    public String getPrivilegeflag()
    {
        return privilegeflag;
    }

    public void setPrivilegeflag(String privilegeflag)
    {
        this.privilegeflag = privilegeflag;
    }

    public String getUserId()
    {
        return userId;
    }

    public void setUserId(String userId)
    {
        this.userId = userId;
    }

    public String getBlogtitle()
    {
        return blogtitle;
    }

    public String getBlogtextarea()
    {
        return blogtextarea;
    }

    public void setBlogtextarea(String blogtextarea)
    {
        this.blogtextarea = blogtextarea;
    }

    public String getTag()
    {
        return tag;
    }

    public void setTag(String tag)
    {
        this.tag = tag;
    }

    public void setBlogtitle(String blogtitle)
    {
        this.blogtitle = blogtitle;
    }
}
