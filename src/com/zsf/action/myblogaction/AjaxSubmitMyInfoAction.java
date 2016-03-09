package com.zsf.action.myblogaction;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.zsf.dbUtils.UpdateHelper;
import com.zsf.javabean.MyInfo;
import com.zsf.utils.MD5;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.json.annotations.JSON;

/**
 * Created on 2015/11/6.
 */
public class AjaxSubmitMyInfoAction extends ActionSupport implements ModelDriven<MyInfo>
{
    private MyInfo myInfo = new MyInfo();
    private boolean changeFlag = false;

    public boolean getChangeFlag()
    {
        return changeFlag;
    }

    @Override
    public String execute() throws Exception
    {
        if (checkInfoFormat())
        {
            ServletActionContext.getRequest().getSession().setAttribute("user", myInfo.getUsername());

            if ( myInfo.getPassword() != null && !"".equals(myInfo.getPassword()))
            {
                UpdateHelper.executeUpdate("update users set username = ?, password = ?, signname = ? where user_id = ?", myInfo.getUsername(), MD5.GetMD5Code(myInfo.getPassword().trim()), myInfo.getSignname(), ServletActionContext.getRequest().getSession().getAttribute("userId"));
            }
            else
            {
                UpdateHelper.executeUpdate("update users set username = ?, signname = ? where user_id = ?", myInfo.getUsername(), myInfo.getSignname(), ServletActionContext.getRequest().getSession().getAttribute("userId"));
            }

            this.changeFlag = true;
        }

        return SUCCESS;
    }

    //实现了ModelDriven后将成为值栈栈顶对象并且被返回，action的对象将失效
    @JSON(serialize = false)
    @Override
    public MyInfo getModel()
    {
        return myInfo;
    }

    public boolean checkInfoFormat()
    {
        return myInfo.getUsername() != null && !"".equals(myInfo.getUsername());

    }
}
