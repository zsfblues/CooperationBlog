package com.zsf.action;

import com.opensymphony.xwork2.ActionSupport;
import com.zsf.utils.DeleteDir;
import org.apache.struts2.ServletActionContext;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action
 * @ 2015/10/17
 */
public class LogoutAction extends ActionSupport
{
    @Override
    public String execute() throws Exception
    {
        DeleteDir.checkTempDir();
        ServletActionContext.getRequest().getSession().invalidate();

        return SUCCESS;
    }
}
