package com.zsf.action.myblogaction;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.zsf.dbUtils.UpdateHelper;
import com.zsf.javabean.BlogInfo;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action.myblogaction
 * @ 2015/10/26
 */
public class SaveBlogAction extends ActionSupport implements ModelDriven<BlogInfo>
{
    private BlogInfo blogInfo = new BlogInfo();

    @Override
    public String execute() throws Exception
    {
        if ( !"".equals(blogInfo.getBlogtitle().trim()) && !"".equals(blogInfo.getBlogtextarea()))
        {
            UpdateHelper.executeUpdate("update blogarticle set pub_time = now(), title = ?, content = ?, tag = ? where article_id = ?", blogInfo.getBlogtitle(), blogInfo.getBlogtextarea(), blogInfo.getTag(), blogInfo.getArticleId());
        }
        return SUCCESS;
    }

    @Override
    public BlogInfo getModel()
    {
        return blogInfo;
    }
}
