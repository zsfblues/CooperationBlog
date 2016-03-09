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
 * @ 2015/11/5
 */
public class UserSearchAction extends ActionSupport
{
    private String searchtxt;

    public void setSearchtxt(String searchtxt)
    {
        this.searchtxt = searchtxt;
    }

    @Override
    public String execute() throws Exception
    {
        if ( !"".equals(searchtxt.trim()))
        {
            String[] conditionArray = getConditionArray();
            ValueStack valueStack = ActionContext.getContext().getValueStack();
            if (conditionArray.length == 1)
            {
                List<String[]> list = QueryHelper.executeQuery("select typeflag, article_id, views, title, leadword, content, tag, pub_time, users.username from blogarticle, users where users.user_id = blogarticle.user_id AND privilegeflag = 1 AND concat(title, users.username) LIKE '%" + this.searchtxt + "%' ");
                valueStack.set("searchlist", list);
            }
            else if (conditionArray.length == 2)
            {
                List<String[]> list = QueryHelper.executeQuery("select typeflag, article_id, views, title, leadword, content, tag, pub_time, users.username from blogarticle, users where users.user_id = blogarticle.user_id AND privilegeflag = 1 AND concat(title, users.username) LIKE '%" + conditionArray[0] + "%' AND concat(title, users.username) LIKE '%" + conditionArray[1] + "%'");

                valueStack.set("searchlist", list);
            }


            valueStack.set("condition", this.searchtxt);
        }

        return SUCCESS;
    }

    public String[] getConditionArray()
    {
        //移除多余的空格以及首尾空格，强大的正则表达式
        this.searchtxt = this.searchtxt.trim().replaceAll("\\s{2,}", " ");

        String[] str = this.searchtxt.split(" ");
        return str;
    }
}
