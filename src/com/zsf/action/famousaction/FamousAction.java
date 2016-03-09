package com.zsf.action.famousaction;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.util.ValueStack;
import com.zsf.dbUtils.QueryHelper;
import com.zsf.utils.DeleteDir;

import java.util.List;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action.famousaction
 * @ 2015/10/27
 */
public class FamousAction extends ActionSupport
{
    @Override
    public String execute() throws Exception
    {
        DeleteDir.checkTempDir();

        ValueStack valueStack = ActionContext.getContext().getValueStack();

        List<String[]> list = QueryHelper.executeQuery("SELECT users.user_id, username, popularity, article_id, title FROM users, blogarticle WHERE pub_time = (SELECT max(pub_time) FROM blogarticle WHERE users.user_id = blogarticle.user_id AND privilegeflag = 1 GROUP BY email) ORDER BY popularity DESC LIMIT 0, 15");

        valueStack.set("popularitylist", list);
        return SUCCESS;
    }
}
