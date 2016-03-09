package com.zsf.action.myblogaction;

import com.opensymphony.xwork2.ActionSupport;
import com.zsf.dbUtils.QueryHelper;

import java.util.List;

public class AjaxToGetFriendInfo extends ActionSupport
{
    private String condition;

    private String email;
    private String username;
    private String signname;
    private String userId;

    public String getEmail()
    {
        return email;
    }

    public String getUsername()
    {
        return username;
    }

    public String getSignname()
    {
        return signname;
    }

    public String getUserId()
    {
        return userId;
    }

    public void setCondition(String condition)
    {
        this.condition = condition;
    }

    @Override
    public String execute() throws Exception
    {
        if (condition != null && !"".equals(condition))
        {
            List<String[]> list = QueryHelper.executeQuery("SELECT email, username, signname, user_id FROM users WHERE email LIKE '%" + condition + "%' OR username LIKE '%" + condition + "%' ORDER BY popularity DESC LIMIT 1");

            email = list.get(0)[0];
            username = list.get(0)[1];
            signname = list.get(0)[2];
            userId = list.get(0)[3];
        }

        return SUCCESS;
    }
}
