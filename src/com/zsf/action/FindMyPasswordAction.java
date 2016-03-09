package com.zsf.action;

import com.opensymphony.xwork2.ActionSupport;
import com.zsf.dbUtils.UpdateHelper;
import com.zsf.utils.MD5;

/**
 * Created on 2015/11/7.
 */
public class FindMyPasswordAction extends ActionSupport
{
    private String findemail;
    private String newpassword;

    public void setFindemail(String findemail)
    {
        this.findemail = findemail;
    }

    public void setNewpassword(String newpassword)
    {
        this.newpassword = newpassword;
    }

    @Override
    public String execute() throws Exception
    {
        if ( this.newpassword != null && this.findemail != null && !"".equals(findemail) && !"".equals(newpassword))
        {
            UpdateHelper.executeUpdate("update users set password = ? where email = ?", MD5.GetMD5Code(this.newpassword.trim()), this.findemail.trim());
        }

        return SUCCESS;
    }
}
