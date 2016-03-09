package com.zsf.action.myblogaction;

import com.opensymphony.xwork2.ActionSupport;
import com.zsf.dbUtils.InsertHelper;
import com.zsf.dbUtils.QueryHelper;
import com.zsf.utils.FlushToRepeatSubmit;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpSession;
import java.util.List;

public class ConcernSomebodyAction extends ActionSupport
{
    private String userId;

    public void setUserId(String userId)
    {
        this.userId = userId;
    }

    @Override
    public String execute() throws Exception
    {
        HttpSession session = ServletActionContext.getRequest().getSession();
        if ( userId != null && !"".equals(userId) && isNum() && FlushToRepeatSubmit.checkToken())
        {
            if (!this.userId.equals(session.getAttribute("userId")))
            {
                List<String[]> list = QueryHelper.executeQuery("SELECT mfriend_id FROM friend WHERE friend_id = ? AND mfriend_id = ?", session.getAttribute("userId"), this.userId);

                if (list.size() == 0)
                {
                    InsertHelper.executeInsert("INSERT INTO friend VALUES(NULL, ?, ?)", session.getAttribute("userId"), this.userId);
                }
            }
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
