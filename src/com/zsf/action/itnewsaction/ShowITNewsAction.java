package com.zsf.action.itnewsaction;

import com.opensymphony.xwork2.ActionSupport;
import com.zsf.utils.DeleteDir;

public class ShowITNewsAction extends ActionSupport
{
    @Override
    public String execute() throws Exception
    {
        DeleteDir.checkTempDir();

        return SUCCESS;
    }
}
