package com.zsf.action.myblogaction;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.zsf.dbUtils.QueryHelper;
import com.zsf.utils.FlushToRepeatSubmit;

import java.util.List;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action.myblogaction
 * @ 2015/10/21
 */
public class FindMyArticleAction extends ActionSupport
{
    private String articleId;

    public String getArticleId()
    {
        return articleId;
    }

    public void setArticleId(String articleId)
    {
        this.articleId = articleId;
    }

    @Override
    public String execute() throws Exception
    {
        toNum();
        List<String[]> list = QueryHelper.executeQuery("select article_id, title, content, tag from blogarticle where article_id = ?", this.articleId);
        ActionContext.getContext().getValueStack().set("myarticle", list);

        return SUCCESS;
    }

    public void toNum()
    {
        for (int i = 0; i < this.articleId.length(); i++)
        {
            if (!Character.isDigit(this.articleId.charAt(i)) || "".equals(this.articleId))
            {
                this.articleId = "1";
                break;
            }
        }
    }
}
