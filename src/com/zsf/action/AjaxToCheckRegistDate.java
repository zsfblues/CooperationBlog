package com.zsf.action;

import com.opensymphony.xwork2.ActionSupport;
import com.zsf.dbUtils.QueryHelper;

import java.util.List;

/**
 * Created on 2015/11/7.
 */
public class AjaxToCheckRegistDate extends ActionSupport
{
    private String registDate;
    private String email;
    private boolean isCorrect = false;

    public void setEmail(String email)
    {
        this.email = email;
    }

    public boolean getIsCorrect()
    {
        return isCorrect;
    }

    public void setRegistDate(String registDate)
    {
        this.registDate = registDate;
    }

    @Override
    public String execute() throws Exception
    {
        if (email != null && !"".equals(email))
        {
            List<String[]> list = QueryHelper.executeQuery("select regist_time from users where email = ? and date_format(regist_time, '%Y-%m-%d') LIKE '" + this.registDate + "'", this.email.trim());

            if (list.size() != 0)
            {
                this.isCorrect = true;
            }
        }

        return SUCCESS;
    }
}
