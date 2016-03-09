package com.zsf.action.myblogaction;

import com.opensymphony.xwork2.ActionSupport;
import com.zsf.dbUtils.QueryHelper;
import com.zsf.utils.MD5;

import java.util.List;

/**
 * Created on 2015/11/6.
 */
public class AjaxToCheckPassword extends ActionSupport
{
    private boolean isCorrectPassword;
    private String password;

    public void setPassword(String password)
    {
        this.password = password;
    }

    public boolean getIsCorrectPassword()
    {
        return isCorrectPassword;
    }

    @Override
    public String execute() throws Exception
    {
        if ( password != null && !"".equals(password))
        {
            List<String[]> list = QueryHelper.executeQuery("select password from users where password = ?", MD5.GetMD5Code(this.password));

            if (list.size() == 0)
            {
                isCorrectPassword = false;
            }
            else
            {
                isCorrectPassword = true;
            }
        }

        return SUCCESS;
    }
}
