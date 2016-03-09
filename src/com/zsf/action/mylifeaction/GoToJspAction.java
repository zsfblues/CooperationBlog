package com.zsf.action.mylifeaction;

import com.opensymphony.xwork2.ActionSupport;
import com.zsf.utils.DeleteDir;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpSession;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action.mylifeaction
 * @ 2015/11/2
 */
public class GoToJspAction extends ActionSupport
{
    @Override
    public String execute() throws Exception
    {
        DeleteDir.checkTempDir();

        return SUCCESS;
    }
}
