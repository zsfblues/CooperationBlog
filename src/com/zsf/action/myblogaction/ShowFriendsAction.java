package com.zsf.action.myblogaction;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.util.ValueStack;
import com.zsf.dbUtils.QueryHelper;
import org.apache.struts2.ServletActionContext;

import java.util.List;

public class ShowFriendsAction extends ActionSupport
{
    @Override
    public String execute() throws Exception
    {
        ValueStack valueStack = ActionContext.getContext().getValueStack();

        List<String[]> list = QueryHelper.executeQuery("SELECT users.user_id, username, signname, article_id, title FROM friend INNER JOIN users ON mfriend_id = user_id INNER JOIN blogarticle ON pub_time = (SELECT max(pub_time) FROM blogarticle WHERE mfriend_id = blogarticle.user_id AND privilegeflag = 1) WHERE friend_id = ?", ServletActionContext.getRequest().getSession().getAttribute("userId"));

        valueStack.set("friendlist", list);
        return SUCCESS;
    }
}
