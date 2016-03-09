package com.zsf.action;

import com.opensymphony.xwork2.ActionSupport;
import com.zsf.dbUtils.QueryHelper;
import org.apache.struts2.ServletActionContext;

import java.util.List;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action
 * @ 2015/10/17
 */
public class UnregistedEmailAction extends ActionSupport
{
    private boolean isExist;

    public boolean getIsExist()
    {
        return isExist;
    }

    @Override
    public String execute() throws Exception
    {
        List<String[]> list = QueryHelper.executeQuery("select email from users where email = ?", ServletActionContext.getRequest().getParameter("emailtxt"));

        if (list.size() == 0)
        {
            isExist = false;
        }
        else
        {
            isExist = true;
        }

        return SUCCESS;
    }
}
