package com.zsf.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.util.ValueStack;
import com.zsf.dbUtils.QueryHelper;

import java.util.List;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action
 * @ 2015/11/6
 */
public class SearchByDateAction extends ActionSupport
{
    private String datetxt;

    public void setDatetxt(String datetxt)
    {
        this.datetxt = datetxt;
    }

    @Override
    public String execute() throws Exception
    {
        ValueStack valueStack = ActionContext.getContext().getValueStack();

        if ( datetxt != null && !"".equals(datetxt))
        {
            List<String[]> list = QueryHelper.executeQuery("select typeflag, article_id, views, title, leadword, content, tag, pub_time, users.username from blogarticle, users where users.user_id = blogarticle.user_id AND privilegeflag = 1 AND date_format(pub_time, '%Y-%c') LIKE '" + this.datetxt + "'");

            valueStack.set("searchlist", list);
        }

        valueStack.set("condition", this.datetxt);

        return SUCCESS;
    }
}
