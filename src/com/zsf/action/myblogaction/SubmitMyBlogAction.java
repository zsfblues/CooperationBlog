package com.zsf.action.myblogaction;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import com.zsf.dao.BlogSubmitImp;
import com.zsf.dao.SubmitContext;
import com.zsf.dbUtils.InsertHelper;
import com.zsf.javabean.BlogInfo;


/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action.myblogaction
 * @ 2015/10/19
 */
public class SubmitMyBlogAction extends ActionSupport implements ModelDriven<BlogInfo>
{
    private BlogInfo blogInfo = new BlogInfo();

    @Override
    public String execute() throws Exception
    {
        SubmitContext<BlogInfo> submitContext = new SubmitContext<>(new BlogSubmitImp(), blogInfo);

        if ( !"".equals(blogInfo.getBlogtitle().trim()) && !"".equals(blogInfo.getBlogtextarea().trim()) &&submitContext.ContextSubmit("blog_repeat_submit"))
        {
            InsertHelper.executeInsert("insert into blogarticle(article_id, pub_time, content, user_id, title, tag, privilegeflag, views, typeflag) values(null, now(), ?, ?, ?, ?, ?, 0, 'N')", changeContentStyle(), blogInfo.getUserId(), blogInfo.getBlogtitle(), blogInfo.getTag(), blogInfo.getPrivilegeflag());
        }

        ActionContext.getContext().getValueStack().set("userId", blogInfo.getUserId());

        return SUCCESS;
    }

    @Override
    public BlogInfo getModel()
    {
        return blogInfo;
    }

    public String changeContentStyle()
    {
        String str[] = blogInfo.getBlogtextarea().split("\n");
        StringBuilder stringBuilder = new StringBuilder();

        for (int i = 0; i < str.length; i++)
        {
            stringBuilder.append(str[i]).append("<br />");
        }

        return stringBuilder.toString();
    }
}
