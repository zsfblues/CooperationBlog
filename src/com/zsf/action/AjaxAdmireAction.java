package com.zsf.action;

import com.zsf.dbUtils.InsertHelper;
import com.zsf.utils.FlushToRepeatSubmit;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action
 * @ 2015/10/17
 */
public class AjaxAdmireAction
{
    private String articleId;

    public void setArticleId(String articleId)
    {
        this.articleId = articleId;
    }

    public void getAdmire() throws Exception
    {
        if (FlushToRepeatSubmit.checkToken())
        {
            InsertHelper.executeInsert("update users, blogarticle set users.popularity = users.popularity + 1 where blogarticle.user_id = users.user_id and blogarticle.article_id = ?", this.articleId);
        }
    }
}
