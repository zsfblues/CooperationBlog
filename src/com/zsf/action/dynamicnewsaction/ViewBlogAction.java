package com.zsf.action.dynamicnewsaction;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.util.ValueStack;
import com.zsf.dbUtils.QueryHelper;
import com.zsf.dbUtils.UpdateHelper;
import com.zsf.javabean.Reply;
import com.zsf.utils.FlushToRepeatSubmit;

import java.util.List;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action.dynamicnewsaction
 * @ 2015/10/22
 */
public class ViewBlogAction extends ActionSupport implements ModelDriven<Reply>
{
    private Reply reply = new Reply();
    private String articleId;

    public void setArticleId(String articleId)
    {
        this.articleId = articleId;
    }

    public String getArticleId()
    {
        return articleId;
    }

    public Reply getReply()
    {
        return reply;
    }

    @Override
    public String execute() throws Exception
    {
        ValueStack valueStack = ActionContext.getContext().getValueStack();

        if (!"".equals(this.articleId))
        {
            List<String[]> list = QueryHelper.executeQuery("select article_id, title, content, tag from blogarticle where article_id = ?", this.articleId);

            valueStack.set("article", list);
            valueStack.set("articleId", this.articleId);
        }

        UpdateHelper.executeUpdate("update blogarticle set views = views + 1 where article_id = ?", this.articleId);

        return SUCCESS;
    }

    @Override
    public Reply getModel()
    {
        return reply;
    }
}
