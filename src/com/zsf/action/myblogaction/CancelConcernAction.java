package com.zsf.action.myblogaction;

import com.opensymphony.xwork2.ActionSupport;
import com.zsf.dbUtils.DeleteHelper;
import org.apache.struts2.ServletActionContext;

public class CancelConcernAction extends ActionSupport
{
    private String userId;

    public void setUserId(String userId)
    {
        this.userId = userId;
    }

    @Override
    public String execute() throws Exception
    {
        if ( userId != null && !"".equals(userId) && isNum())
        {
            DeleteHelper.executeDelete("DELETE FROM friend WHERE friend_id = ? AND mfriend_id = ?", ServletActionContext.getRequest().getSession().getAttribute("userId"), this.userId);
        }

        return SUCCESS;
    }

    public boolean isNum()
    {
        for (int i = 0; i < this.userId.length(); i++)
        {
            if (!Character.isDigit(this.userId.charAt(i)))
            {
                return false;
            }
        }

        return true;
    }
}
